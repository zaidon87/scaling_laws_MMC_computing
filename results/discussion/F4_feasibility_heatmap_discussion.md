# F4 — Feasibility heat map

This figure summarizes the maximum feasible number of submodules `N_max` for each technique and platform.

On microcontrollers, the centralized methods remain limited to low `N` values when the SPI 20M communication path is included. The FPGA Bitonic sorting network reaches a much higher value because the sorting is implemented in hardware. The decentralized consensus case gives the largest local scalability because every submodule computes its own local decision.

**Simple conclusion:** the architecture matters more than only changing the sorting algorithm. Moving from centralized control to distributed local computation changes the scaling behavior.
