# F3 — Schedulability utilization U(N)

This image gives the scheduling view. For centralized methods, utilization increases with `N` because computation and communication both grow. For Local Consensus, the per-node workload stays nearly flat.

The harmonic task set uses `T1 = 100 µs`, `T2 = 1 ms`, and `T3 = 10 ms`, so the theoretical RMS utilization bound can be treated as `U ≤ 1`. A practical design should still keep margin for DMA, interrupts, and measurement jitter.

**Simple result:** Local Consensus is locally schedulable; its real scaling limit is convergence around the ring.