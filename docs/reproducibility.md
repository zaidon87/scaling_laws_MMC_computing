# Reproducibility

## MATLAB entry point

Run the full scaling-law analysis from the repository root:

```matlab
run('scripts/matlab/run_all_scaling_figures.m')
```

The wrapper changes MATLAB to the repository root, checks that the main script exists, and then runs:

```text
scripts/matlab/mmc_scaling_analysis.m
```

## Expected generated figures

The analysis script can export:

```text
F1_comm_vs_N.png
F2_scaling_laws.png
F3_utilization.png
F4_feasibility_heatmap.png
F5_gantt.png
```

These files are intentionally ignored by Git unless moved into `results/figures/` for a tagged release.

## Static check

Run:

```matlab
run('tests/matlab/static_repository_check.m')
```

This checks that the expected files exist and that Office temporary lock files were not committed.

## Required local validation

Before using the numerical results in a paper or thesis chapter:

1. Recalculate Excel workbooks.
2. Run the MATLAB script from a clean MATLAB session.
3. Compare generated figures with manuscript figures.
4. Confirm cycle-count assumptions by DWT-CYCCNT or equivalent target measurement.
5. Confirm FPGA area estimates with synthesis reports.
