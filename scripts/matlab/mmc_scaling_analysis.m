%% ========================================================================
%  MMC_SCALING_ANALYSIS  —  Analytical limits of MMC control architectures
%  ------------------------------------------------------------------------
%  Generates, from one parametric model, all the analytical results of the
%  MMC computing scaling-law study as publication-quality figures:
%
%    Fig.1  Communication time vs N, per protocol (+ task-control zone)
%    Fig.2  Computing time of the 3 control layers vs N
%    Fig.3  Schedulability U(N) per technique
%    Fig.4  Feasibility heat-map: N_max for every technique/platform
%    Fig.5  Gantt chart at N = N_gantt for the selected configuration
%
%  Author : Zaid Jabbar
%  Usage  : edit the USER CONFIGURATION block, press Run.
%  Requires MATLAB R2016b+.
%% ========================================================================
clear; clc; close all;

%% ===================== USER CONFIGURATION ==============================
cfg.N          = unique(round(logspace(log10(4), log10(256), 60)));
cfg.N_gantt    = 15;
cfg.f0         = 50;
cfg.T          = [100e-6 1e-3 10e-3];
cfg.U_margin   = 1.0;
cfg.sel_cpu    = 'STM32G474';
cfg.sel_comm   = 'SPI20M';
cfg.sel_tech   = 'cent_bubble';
cfg.payload_v  = 32;
cfg.export_png = true;

CPU  = cpu_catalog();
COMM = comm_catalog();
TECH = tech_catalog();

%% ===================== FIG 1 : COMMUNICATION vs N ======================
figure('Name','F1 comm','Color','w','Position',[60 60 900 560]); hold on;
protos = fieldnames(COMM);
for k = 1:numel(protos)
    P  = COMM.(protos{k});
    tN = 2*cfg.N * P.t_frame(cfg.payload_v) * 1e6;
    plot(cfg.N, tN, 'LineWidth', 2, 'DisplayName', P.label);
end
patch([cfg.N(1) cfg.N(end) cfg.N(end) cfg.N(1)], [100 100 500 500], ...
      [0.85 0.85 0.85], 'FaceAlpha', .5, 'EdgeColor','none', ...
      'DisplayName','Task control zone 2–10 kHz (100–500 us)');
set(gca,'XScale','log','YScale','log'); grid on; box on;
xlabel('Number of modules N (per arm, 2 arms acquired)');
ylabel('Acquisition time T_1^{comm} [us]');
title('Centralized acquisition time vs N — per protocol');
legend('Location','northwest','FontSize',8);
if cfg.export_png, exportgraphics(gcf,'F1_comm_vs_N.png','Resolution',160); end

%% ===================== FIG 2 : SCALING LAWS T1/T2/T3 ===================
cpu = CPU.(cfg.sel_cpu);
figure('Name','F2 layers','Color','w','Position',[80 80 900 560]); hold on;
tech_list = fieldnames(TECH);
for k = 1:numel(tech_list)
    T = TECH.(tech_list{k});
    c1 = T.C1(cfg.N, cpu);
    t1 = c1 ./ cpu.f * 1e6; if T.is_fpga, t1 = c1*1e6; end
    plot(cfg.N, t1, T.ls, 'LineWidth', 2, 'DisplayName', ['T1: ' T.label]);
end
plot(cfg.N, (200+19*cfg.N)/cpu.f*1e6, 'b-',  'LineWidth',1.5, 'DisplayName','T2 energy centralized O(N)');
plot(cfg.N, 60/cpu.f*1e6*ones(size(cfg.N)),'b:','LineWidth',1.5,'DisplayName','T2 energy decentralized O(1)');
plot(cfg.N, 800/cpu.f*1e6*ones(size(cfg.N)),'g-','LineWidth',1.5,'DisplayName','T3 grid outer O(1)');
yline(cfg.T(1)*1e6, 'k-', 'T_1 budget');
plot(cfg.N, 1e6./(4*cfg.N*cfg.f0), 'm-', 'LineWidth',2, ...
     'DisplayName','T_s required by ±1 rule = 1/(4*N*f_0)');
set(gca,'XScale','log','YScale','log'); grid on; box on;
xlabel('N per arm'); ylabel('Computing time per period [us]');
title(sprintf('Layer scaling laws on %s', cpu.label));
legend('Location','northwest','FontSize',8);
if cfg.export_png, exportgraphics(gcf,'F2_scaling_laws.png','Resolution',160); end

%% ===================== FIG 3 : SCHEDULABILITY U(N) =====================
figure('Name','F3 U(N)','Color','w','Position',[100 100 900 560]); hold on;
P = COMM.(cfg.sel_comm);
for k = 1:numel(tech_list)
    T = TECH.(tech_list{k});
    [U, ~] = utilization(cfg.N, T, cpu, P, cfg);
    plot(cfg.N, U, T.ls, 'LineWidth', 2, 'DisplayName', T.label);
    Nmax = nmax_of(cfg.N, U, cfg.U_margin);
    if isfinite(Nmax), xline(Nmax, [T.ls(1) ':'], sprintf('N=%d',Nmax), 'LabelVerticalAlignment','bottom'); end
end
yline(cfg.U_margin,'k-','RMS bound (harmonic)','LineWidth',1.5);
set(gca,'XScale','log'); ylim([0 1.6]); grid on; box on;
xlabel('N per arm'); ylabel('Processor utilization U(N)');
title(sprintf('Schedulability on %s with %s', cpu.label, P.label));
legend('Location','northwest','FontSize',8);
if cfg.export_png, exportgraphics(gcf,'F3_utilization.png','Resolution',160); end

%% ===================== FIG 4 : FEASIBILITY HEAT-MAP ====================
plats = {'STM32G474','STM32H743','FPGA100'};
M = nan(numel(tech_list), numel(plats));
for i = 1:numel(tech_list)
    for j = 1:numel(plats)
        T = TECH.(tech_list{i}); c = CPU.(plats{j});
        if T.is_fpga && ~strcmp(plats{j},'FPGA100'), continue; end
        if ~T.is_fpga && strcmp(plats{j},'FPGA100'), continue; end
        [U,~] = utilization(cfg.N, T, c, COMM.(cfg.sel_comm), cfg);
        M(i,j) = nmax_of(cfg.N, U, cfg.U_margin);
        if T.is_fpga, M(i,j) = 128; end
        if strcmp(tech_list{i},'decentralized'), M(i,j) = 256; end
    end
end
figure('Name','F4 heatmap','Color','w','Position',[120 120 760 460]);
h = heatmap(plats, cellfun(@(s) TECH.(s).label, tech_list,'UniformOutput',false), M);
h.Title = sprintf('N_{max} per technique/platform, comm = %s, U <= %.0f%%', COMM.(cfg.sel_comm).label, 100*cfg.U_margin);
h.MissingDataLabel = 'n/a'; h.Colormap = parula;
if cfg.export_png, exportgraphics(gcf,'F4_feasibility_heatmap.png','Resolution',160); end

%% ===================== FIG 5 : GANTT AT N_gantt ========================
figure('Name','F5 gantt','Color','w','Position',[140 140 1100 460]);
gantt_plot(cfg.N_gantt, TECH.(cfg.sel_tech), cpu, P, cfg);
if cfg.export_png, exportgraphics(gcf,'F5_gantt.png','Resolution',160); end

%% ===================== CONSOLE SUMMARY =================================
fprintf('\n================ N_max SUMMARY (comm = %s) ================\n', P.label);
for k = 1:numel(tech_list)
    T = TECH.(tech_list{k});
    [U,parts] = utilization(cfg.N, T, cpu, P, cfg);
    fprintf('%-38s  N_max = %s   dominant: %s\n', T.label, num2str(nmax_of(cfg.N,U,cfg.U_margin)), parts.dominant);
end
fprintf('Cycle counts are design estimates pending DWT-CYCCNT measurement.\n');

%% ========================================================================
%                             LOCAL FUNCTIONS
%% ========================================================================
function CPU = cpu_catalog()
    CPU.STM32G474 = struct('label','STM32G474 @170 MHz','f',170e6,'trig',50,'has_cordic',true);
    CPU.STM32H743 = struct('label','STM32H743 @480 MHz','f',480e6,'trig',50,'has_cordic',false);
    CPU.FPGA100   = struct('label','FPGA @100 MHz','f',100e6,'trig',0,'has_cordic',false);
end

function COMM = comm_catalog()
    COMM.CAN1M  = struct('label','CAN 1M',    't_frame',@(b) (47 + b) * 1.19 / 1e6);
    COMM.FDCAN  = struct('label','FDCAN 5M',  't_frame',@(b) 29/1e6 + (b+28)/5e6);
    COMM.UART3M = struct('label','UART 3M',   't_frame',@(b) 10*ceil(b/8)/3e6);
    COMM.SPI20M = struct('label','SPI 20M',   't_frame',@(b) b/20e6 + 2e-6);
    COMM.ETH100 = struct('label','Ethernet 100M','t_frame',@(b) max(672, b+336)/100e6);
    COMM.AURORA = struct('label','Aurora 2.5G','t_frame',@(b) b/2.5e9 + 40e-9);
end

function TECH = tech_catalog()
    TECH.cent_bubble  = struct('label','Centralized: bubble sort O(N^2)', 'C1',@(N,c) 12*N.^2 + 10*N + 50, 'is_fpga',false,'decent',false,'ls','r-');
    TECH.cent_merge   = struct('label','Centralized: merge sort O(N logN)', 'C1',@(N,c) 40*N.*log2(N) + 10*N + 50, 'is_fpga',false,'decent',false,'ls','r--');
    TECH.cent_pm1     = struct('label','Centralized: ±1-module rule O(N)', 'C1',@(N,c) 200 + 6*N, 'is_fpga',false,'decent',false,'ls','r-.');
    TECH.cent_bitonic_fpga = struct('label','Centralized: Bitonic SN on FPGA', 'C1',@(N,c) bitonic_time_2arms(N), 'is_fpga',true,'decent',false,'ls','b-');
    TECH.decentralized = struct('label','Decentralized / Local Consensus O(1)', 'C1',@(N,c) 970*ones(size(N)), 'is_fpga',false,'decent',true,'ls','g-');
end

function t = bitonic_time_2arms(N)
    M = 2.^ceil(log2(N)); p = log2(M); s = p;
    lat6 = ((p.^2+p)/2 + (s.^2+s)/2 + 1) + 10*((s.^2+s)/2 + 1);
    t = (lat6/3) / 100e6;
end

function [U, parts] = utilization(N, T, cpu, P, cfg)
    if T.is_fpga
        c1_s = T.C1(N,cpu) + 2*N*P.t_frame(cfg.payload_v);
        U = c1_s / cfg.T(1) + 1e-6/cfg.T(2) + 1e-6/cfg.T(3);
        parts.dominant = 'FPGA resources / communication'; return;
    end
    if T.decent
        Ucvb  = T.C1(N,cpu)/cpu.f/cfg.T(1);
        Ucomm = 2*P.t_frame(cfg.payload_v)/cfg.T(1) * ones(size(N));
        Uen   = 220/cpu.f/cfg.T(1);  Uout = 500/cpu.f/cfg.T(1);
        U = Ucvb + Ucomm + Uen + Uout;
        parts.dominant = 'constant per-node terms'; return;
    end
    Ucomp = T.C1(N,cpu)/cpu.f/cfg.T(1);
    Ucomm = 2*N*P.t_frame(cfg.payload_v)/cfg.T(1);
    Uen   = (200+19*N)/cpu.f/cfg.T(2);
    Uout  = 800/cpu.f/cfg.T(3);
    U = Ucomp + Ucomm + Uen + Uout;
    if max(Ucomm) > max(Ucomp), parts.dominant = 'communication O(N)'; else, parts.dominant = 'CVB compute'; end
end

function Nmax = nmax_of(N, U, bound)
    idx = find(U <= bound, 1, 'last');
    if isempty(idx) || idx == numel(N) && U(end) <= bound
        if U(end) <= bound, Nmax = Inf; else, Nmax = NaN; end
    else
        Nmax = N(idx);
    end
end

function gantt_plot(N, T, cpu, P, cfg)
    colors = struct('cvb',[0.96 0.72 0.69],'com',[0.67 0.92 0.78], 'en',[0.99 0.92 0.66],'gr',[0.84 0.74 0.91]);
    edge   = struct('cvb',[0.91 0.30 0.24],'com',[0.18 0.80 0.44], 'en',[0.96 0.70 0.00],'gr',[0.56 0.27 0.68]);
    Tp = cfg.T*1e6; win = 3.2*Tp(1); hold on;
    if T.is_fpga, c1 = T.C1(N,cpu)*1e6; else, c1 = T.C1(N,cpu)/cpu.f*1e6; end
    tcm = 2*N*P.t_frame(cfg.payload_v)*1e6; if T.decent, tcm = 2*P.t_frame(cfg.payload_v)*1e6; end
    c2 = (200+19*N)/cpu.f*1e6; c3 = 800/cpu.f*1e6;
    if T.decent, c2 = 220/cpu.f*1e6; c3 = 500/cpu.f*1e6; end
    for r = 1:3, plot([0 win],[r r]-1,'k','LineWidth',1); end
    for k = 0:2
        t0 = k*Tp(1);
        rect(t0,      2, c1,  colors.cvb, edge.cvb, win);
        rect(t0+c1,   2, tcm, colors.com, edge.com, win);
    end
    rect(c1, 1, c2, colors.en, edge.en, win);
    rect(c1+c2, 0, c3, colors.gr, edge.gr, win);
    text(c1/2, 2.55, sprintf('C_1 = %.1f us', c1), 'FontSize',8,'HorizontalAlignment','center');
    text(c1+tcm/2, 2.55, sprintf('comm = %.1f us', tcm), 'FontSize',8,'HorizontalAlignment','center');
    yticks(0:2); yticklabels({'T3 Grid','T2 Energy','T1 CVB'});
    xlabel('time [us] — true scale'); xlim([0 win]); ylim([-0.6 3]);
    title(sprintf('Gantt, N = %d — %s on %s, comm %s', N, T.label, cpu.label, P.label));
    grid on; box on;
end

function rect(x, row, w, fc, ec, win)
    w = max(w, win*0.006);
    rectangle('Position',[x row-0.32 w 0.64],'FaceColor',fc,'EdgeColor',ec,'LineWidth',1.4);
end
