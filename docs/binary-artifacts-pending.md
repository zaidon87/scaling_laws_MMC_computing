# Binary Artifacts Pending Upload

The complete packaged repository ZIP and the later uploaded files contain additional binary research artifacts that are not stored in this GitHub repository yet because the current ChatGPT GitHub connector is optimized for UTF-8 text files and does not directly upload local `.docx`, `.xlsx`, `.png`, or MATLAB binary `.fig` files from the sandbox path.

## Manuscript files

```text
manuscript/draft/draft_architectural_Scaling_Laws_Physical_Limits.docx
manuscript/final/MMC_architectural_Scaling_Laws_Physical_Limits.docx
```

## Excel workbooks

```text
data/workbooks/MMC_timing.xlsx
data/workbooks/MMC_timing_appendix.xlsx
data/workbooks/U_and_LUT.xlsx
data/workbooks/figure5_U_and_LUT.xlsx
data/workbooks/scaling_laws.xlsx
data/workbooks/scaling_laws_figure.xlsx
```

## PNG previews

```text
figures/previews/gantt_FPGA_bitonic_style_preview.png
figures/previews/gantt_MCU_bubble_style_preview.png
figures/previews/gantt_decentralized_style_preview.png
```

## MATLAB `.fig` sources, deduplicated

Six `.fig` files were uploaded, but only five final result figures should be kept. The file `2.fig` is not listed below because it duplicates the `F3 U(N)` result also present in `6.fig`. The newer `6.fig` is the retained source.

```text
results/figures/F1_comm_vs_N.fig                  <- 1.fig
results/figures/F2_scaling_laws.fig               <- 5.fig
results/figures/F3_utilization.fig                <- 6.fig
results/figures/F4_feasibility_heatmap.fig        <- 3.fig
results/figures/F5_gantt.fig                      <- 4.fig
```

The decision is documented in:

```text
results/figures/matlab_figure_sources.md
```

## Recommended upload method

Use GitHub Desktop, MATLAB/Git, or the GitHub web interface to upload these binary artifacts from the packaged ZIP or from the files exported by MATLAB. The repository already contains the text structure, documentation, scripts, MATLAB code, and validation workflow.
