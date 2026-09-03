# Results

This folder contains the final result figures and simple discussion notes for the MMC computing scaling-law study.

## Final figure set

Only five final result figures are kept. No duplicated result is stored here.

| Figure | Image | Simple discussion |
|---|---|---|
| F1 | `figures/F1_comm_vs_N.png` | `discussion/F1_comm_vs_N_discussion.md` |
| F2 | `figures/F2_scaling_laws.png` | `discussion/F2_scaling_laws_discussion.md` |
| F3 | `figures/F3_utilization.png` | `discussion/F3_utilization_discussion.md` |
| F4 | `figures/F4_feasibility_heatmap.png` | `discussion/F4_feasibility_heatmap_discussion.md` |
| F5 | `figures/F5_gantt.png` | `discussion/F5_gantt_discussion.md` |

## Deduplication rule

The uploaded MATLAB `.fig` files contained six files but only five unique results. `2.fig` and `6.fig` both correspond to the same `F3 U(N)` figure. Therefore, only one final `F3_utilization` result is kept.

## Reproducibility

The figures should be regenerated from MATLAB using:

```matlab
run('scripts/matlab/run_all_scaling_figures.m')
```

The PNG files in `results/figures/` are the final exported images used for discussion. They must be exact exports from MATLAB or from validated `.fig` files, not manually redrawn approximations.
