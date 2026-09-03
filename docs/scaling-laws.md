# Scaling Laws

## Communication

Centralized acquisition requires the controller to collect information from all submodules:

```text
T_comm,centralized(N) = 2N · t_frame(payload)
```

Local Consensus uses only neighbor-level exchange per submodule:

```text
T_comm,local(N) = 2 · t_frame(payload)
```

## Computation

| Technique | Complexity | Interpretation |
|---|---:|---|
| Bubble sorting | O(N²) | Simple but quickly becomes unsuitable for large N |
| Merge sorting | O(N log N) | Better centralized sorting baseline |
| ±1-module rule | O(N) | Linear centralized min/max-style rule |
| FPGA Bitonic sorting | O(log² N) latency | Good latency, but area grows with network size |
| Local Consensus | O(1) per node | Constant local computation; convergence is the global limit |

## Real-time utilization

For each implementation:

```text
U(N) = C1(N)/T1 + C2(N)/T2 + C3(N)/T3
```

An implementation is considered schedulable when:

```text
U(N) <= U_margin
```

The MATLAB model uses `U_margin = 1` by default for the harmonic task set. For engineering margin, use a lower value such as `0.7`.

## Interpretation

The key point is not only algorithmic complexity. In MMC control, communication and measurement acquisition can dominate computation. A theoretically fast algorithm may still fail if the centralized measurement path scales linearly with N and consumes the fast task period.
