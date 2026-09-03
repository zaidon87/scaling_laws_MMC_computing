# MATLAB Figure Source Files

This folder is reserved for unique MATLAB `.fig` source figures generated from the scaling-law analysis.

## Deduplication decision

Six `.fig` files were provided in the conversation. Static inspection of the MATLAB figure metadata showed the following mapping:

| Uploaded file | Figure name detected | Repository figure name | Decision |
|---|---|---|---|
| `1.fig` | `F1 comm` | `F1_comm_vs_N.fig` | keep |
| `5.fig` | `F2 layers` | `F2_scaling_laws.fig` | keep |
| `6.fig` | `F3 U(N)` | `F3_utilization.fig` | keep; newer duplicate candidate |
| `3.fig` | `F4 heatmap` | `F4_feasibility_heatmap.fig` | keep |
| `4.fig` | `F5 gantt` | `F5_gantt.fig` | keep |
| `2.fig` | `F3 U(N)` | duplicate of `F3_utilization.fig` | skip to avoid duplicated result |

## Intended paths

```text
results/figures/F1_comm_vs_N.fig
results/figures/F2_scaling_laws.fig
results/figures/F3_utilization.fig
results/figures/F4_feasibility_heatmap.fig
results/figures/F5_gantt.fig
```

## Reason

The repository should contain one editable MATLAB source figure per final result figure. Repeating two versions of the same `F3 U(N)` plot would make the results folder ambiguous. Therefore, only the newer `F3 U(N)` file is retained in the figure-source plan.

## Technical note

The `.fig` files are MATLAB v5 binary figure files. The current ChatGPT GitHub connector can commit UTF-8 text files directly, but cannot reliably stream local binary `.fig` objects into the repository contents API from the sandbox. The deduplication map above is committed so the upload target is unambiguous if these binary figure sources are later uploaded through GitHub Desktop or MATLAB/Git.
