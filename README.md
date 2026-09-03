# Scaling Laws for MMC Computing

Scientific repository for the study of **computational, communication, and schedulability scaling laws** in Modular Multilevel Converter (MMC) control architectures.

The repository packages the manuscript, MATLAB analytical model, Excel timing workbooks, and editable figures used to compare three implementation strategies:

1. **Centralized MCU control** with bubble sorting.
2. **Centralized FPGA control** with Bitonic sorting networks.
3. **Decentralized / Local Consensus control** with per-submodule computation.

## Research question

How does the maximum feasible number of submodules per arm, `N_max`, change when MMC control moves from centralized MCU sorting, to FPGA sorting networks, and then to decentralized consensus-style computation?

## Repository structure

```text
scaling_laws_MMC_computing
├── .github/ISSUE_TEMPLATE/          GitHub issue templates
├── .github/workflows/               Static repository checks
├── .vscode/                         VS Code workspace settings
├── data/workbooks/                  Excel timing and scaling workbooks
├── docs/                            Scientific documentation and methodology
├── figures/drawio/                  Editable DrawIO diagrams
├── figures/previews/                PNG previews of figure assets
├── manuscript/draft/                Draft manuscript copy
├── manuscript/final/                Final/clean manuscript copy
├── results/                         Generated outputs, kept mostly empty in Git
├── scripts/matlab/                  MATLAB scaling-law code
├── scripts/python/                  Optional helper scripts placeholder
├── tests/matlab/                    MATLAB static/smoke checks
├── CITATION.cff
├── LICENSE
└── README.md
```

## Main MATLAB entry point

```text
scripts/matlab/mmc_scaling_analysis.m
```

This script generates the main analytical figures:

- communication time versus `N`,
- computing time of control layers versus `N`,
- schedulability utilization `U(N)`,
- feasibility heat map,
- Gantt chart for a selected configuration.

## Quick start

From MATLAB, open the repository root and run:

```matlab
run('scripts/matlab/run_all_scaling_figures.m')
```

The script uses local functions inside `mmc_scaling_analysis.m`, including CPU, communication, technique, utilization, and Gantt helper models.

## Core analytical idea

Centralized architectures usually scale poorly because the communication path grows with the number of submodules:

```text
T_comm,centralized(N) = 2N · t_frame(payload)
```

In a distributed / Local Consensus architecture, the per-node communication is constant:

```text
T_comm,local(N) = 2 · t_frame(payload)
```

The computational layer is compared across:

```text
Bubble sorting:      O(N²)
Merge sorting:       O(N log N)
±1-module rule:      O(N)
FPGA Bitonic:        O(log² N) latency, resource-limited area
Local Consensus:     O(1) per node, convergence-limited globally
```

## Included source material

The repository includes:

- Word manuscript files in `manuscript/`,
- Excel workbooks in `data/workbooks/`,
- MATLAB analytical model in `scripts/matlab/`,
- DrawIO editable diagrams in `figures/drawio/`,
- PNG preview figures in `figures/previews/`.

See:

```text
docs/data-inventory.md
docs/figure-catalog.md
docs/reproducibility.md
```

## Validation status

The repository is structured and packaged. MATLAB execution and formula recalculation were not performed in this environment. Treat the numerical values as research artifacts to be revalidated locally before submission or publication.

## Citation

Use `CITATION.cff` as the starting citation metadata and update it with the final paper/thesis title before public release.
