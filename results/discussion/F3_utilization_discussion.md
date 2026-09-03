# F3 — Schedulability utilization U(N)

This figure shows processor utilization versus `N` for the STM32G474 with SPI 20M. The horizontal line is the harmonic RMS schedulability limit `U = 1`.

The centralized techniques increase with `N` and approach the scheduling limit around small values of `N`. The decentralized consensus case remains almost flat because the work is distributed over the submodules. Each node executes a small local task instead of one central controller processing the whole arm.

**Simple conclusion:** decentralized consensus is easy to schedule locally; its main limit is not CPU utilization but convergence speed around the ring.
