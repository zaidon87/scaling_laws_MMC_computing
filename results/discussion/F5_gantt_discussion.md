# F5 — Gantt chart at N = 15

This figure shows the timing sequence for `N = 15` with centralized bubble sorting on STM32G474 and SPI 20M.

The CVB computation is about `17.1 µs`, but the communication block is about `108 µs`. This means the acquisition path alone can exceed the fast control period of `100 µs` when using one shared SPI bus. The timing problem therefore comes mainly from communication, not from the sorting calculation.

**Simple conclusion:** at `N = 15`, centralized acquisition is the critical timing problem. A dual-bus or parallel acquisition structure is needed to recover timing margin.
