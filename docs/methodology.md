# Methodology

## Study objective

This repository compares the scaling behavior of MMC control implementations when the number of submodules per arm increases.

The analysis separates three layers:

1. Communication and acquisition of submodule measurements.
2. Control computation, including capacitor-voltage balancing.
3. Real-time schedulability under periodic task deadlines.

## Compared architectures

| Architecture | Main scaling pressure |
|---|---|
| Centralized MCU with bubble sorting | Sorting cost and centralized communication |
| Centralized FPGA with Bitonic network | Logic-resource growth and power-of-two granularity |
| Decentralized / Local Consensus control | Local computation with global convergence limit |

## Task model

The analytical model uses a harmonic real-time task set:

```text
T1 = 100 us    capacitor-voltage balancing / fast switching layer
T2 = 1 ms      energy or arm-level correction layer
T3 = 10 ms     outer grid/control layer
```

The schedulability indicator is processor utilization:

```text
U = C1/T1 + C2/T2 + C3/T3
```

For a harmonic task set, the theoretical utilization bound can be taken as 1. A lower design margin can be used by changing the parameter `cfg.U_margin` in the MATLAB script.

## Communication model

The centralized communication path grows with the number of submodules:

```text
T_comm,centralized(N) = 2N · t_frame(payload)
```

The Local Consensus communication path is modeled as constant per node:

```text
T_comm,local(N) = 2 · t_frame(payload)
```

## Validation policy

All constants should be treated as model parameters. Before publication, the values must be checked against:

- measured CPU cycles on the target,
- actual communication frame format,
- measured DMA / SPI / UART / CAN overhead,
- FPGA synthesis reports,
- MATLAB and Excel consistency checks.
