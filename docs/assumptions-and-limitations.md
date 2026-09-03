# Assumptions and Limitations

## Main assumptions

- The MMC arm is represented by a variable number of submodules `N`.
- Centralized control requires communication with all relevant submodules.
- Local Consensus control uses only neighbor or local submodule information per node.
- Task periods are harmonic: 100 us, 1 ms, and 10 ms.
- CPU cycle counts in the MATLAB model are design estimates until target measurements are added.

## Known limitations

- The model is analytical and does not replace EMT simulation.
- Communication overhead may differ depending on protocol stack, DMA configuration, and interrupt behavior.
- FPGA estimates require synthesis validation.
- Local Consensus has constant per-node cost, but global convergence may scale with topology.
- Thermal, EMI, protection, and converter-level failure modes are outside the current model.

## How to report limits

Use precise wording:

```text
The per-node computational cost is O(1), but the global convergence time is topology-dependent.
```

Avoid claiming that decentralized control is unlimited. The repository compares different limiting mechanisms, not only asymptotic operation counts.
