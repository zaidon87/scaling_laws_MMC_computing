# Figure Catalog

## Curated result images

The repository stores the result figures as SVG images so GitHub can display them directly without relying on MATLAB binary `.fig` rendering.

| Figure | Result image | Discussion |
|---|---|---|
| F1 | `results/figures/F1_comm_vs_N.svg` | `results/discussion/F1_comm_vs_N_discussion.md` |
| F2 | `results/figures/F2_scaling_laws.svg` | `results/discussion/F2_scaling_laws_discussion.md` |
| F3 | `results/figures/F3_utilization.svg` | `results/discussion/F3_utilization_discussion.md` |
| F4 | `results/figures/F4_feasibility_heatmap.svg` | `results/discussion/F4_feasibility_heatmap_discussion.md` |
| F5 | `results/figures/F5_gantt.svg` | `results/discussion/F5_gantt_discussion.md` |

## Deduplication decision

Six MATLAB `.fig` files were uploaded, but only five unique final results are retained. The duplicate is handled as follows:

```text
1.fig -> F1_comm_vs_N
5.fig -> F2_scaling_laws
6.fig -> F3_utilization
3.fig -> F4_feasibility_heatmap
4.fig -> F5_gantt
2.fig -> skipped because it duplicates F3 U(N)
```

## Editable DrawIO figures

```text
figures/drawio/gantt_MCU_bubble_style.drawio
figures/drawio/gantt_FPGA_bitonic_style.drawio
figures/drawio/gantt_decentralized_style.drawio
```

## Rule for future updates

Do not place repeated plots in `results/figures`. If a figure is regenerated, replace the existing F-numbered image instead of adding another copy with a different name.
