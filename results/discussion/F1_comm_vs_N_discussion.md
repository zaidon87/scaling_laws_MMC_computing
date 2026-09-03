# F1 — Centralized acquisition time versus N

This figure compares the centralized acquisition time for different communication protocols as the number of submodules per arm increases.

The main point is simple: centralized communication grows with `N` because the controller must collect measurements from many submodules. Slow protocols such as CAN and FDCAN become impractical quickly. SPI 20M is better, but it can still reach the control-period limit when `N` becomes moderate. Aurora has the lowest acquisition time.

**Simple conclusion:** in a centralized MMC controller, the communication path can become the first bottleneck before the computation itself.
