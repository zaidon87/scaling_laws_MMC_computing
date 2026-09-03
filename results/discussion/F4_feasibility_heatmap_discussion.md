# F4 — Feasibility heat map

This image summarizes the feasible `N_max` values by platform and control method. The MCU cases are bounded mainly by communication and then by sequential computation. The FPGA Bitonic option removes most timing pressure, but the limit moves to LUT resources. The Local Consensus option keeps local work constant, so the limit is not local CPU time.

**Simple result:** each architecture fails for a different reason: bus time for MCU, LUT resources for FPGA, and convergence bandwidth for Local Consensus.