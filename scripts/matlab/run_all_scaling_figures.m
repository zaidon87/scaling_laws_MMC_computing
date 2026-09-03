%RUN_ALL_SCALING_FIGURES Execute the MMC scaling-law analysis from repo root.
%
% Usage from MATLAB:
%   run('scripts/matlab/run_all_scaling_figures.m')

repoRoot = fileparts(fileparts(fileparts(mfilename('fullpath'))));
scriptPath = fullfile(repoRoot, 'scripts', 'matlab', 'mmc_scaling_analysis.m');

assert(isfile(scriptPath), 'Missing MATLAB scaling analysis script.');

currentFolder = pwd;
cleanupObj = onCleanup(@() cd(currentFolder));
cd(repoRoot);

fprintf('Running MMC scaling-law analysis from: %s\n', repoRoot);
run(scriptPath);
fprintf('Finished MMC scaling-law analysis.\n');
