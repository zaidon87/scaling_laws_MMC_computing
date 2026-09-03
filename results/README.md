# Results

This folder contains result discussions and placeholders for exact MATLAB-exported figures from the MMC computing scaling-law study.

## Current decision

The approximate SVG figures that were previously added to `results/figures/` were removed because they were not exact exports from MATLAB and therefore were not sufficiently accurate for a scientific repository.

The repository should keep only figures generated directly from:

```text
scripts/matlab/mmc_scaling_analysis.m
```

or exported from the validated MATLAB `.fig` files.

## Expected final figure set

| Figure | Exact image to add later | Short discussion |
|---|---|---|
| F1 | `figures/F1_comm_vs_N.png` | `discussion/F1_comm_vs_N_discussion.md` |
| F2 | `figures/F2_scaling_laws.png` | `discussion/F2_scaling_laws_discussion.md` |
| F3 | `figures/F3_utilization.png` | `discussion/F3_utilization_discussion.md` |
| F4 | `figures/F4_feasibility_heatmap.png` | `discussion/F4_feasibility_heatmap_discussion.md` |
| F5 | `figures/F5_gantt.png` | `discussion/F5_gantt_discussion.md` |

## Deduplication rule

The uploaded MATLAB `.fig` files contained six files but only five unique results. `2.fig` and `6.fig` both correspond to `F3 U(N)`. Only one validated `F3_utilization` figure should be kept after exact export.

## Reproducibility

To regenerate the exact figures locally, run from MATLAB at the repository root:

```matlab
run('scripts/matlab/run_all_scaling_figures.m')
```

Then add only the exact exported PNG/PDF/SVG files produced by MATLAB. Do not add manually redrawn or approximate figures to this folder.
