# F2 — Layer scaling laws on STM32G474

This figure shows how the computing time of the main control layers changes with `N` on the STM32G474.

Bubble sorting grows as `O(N²)`, so it becomes expensive quickly. Merge sorting improves the scaling to `O(N log N)`. The ±1-module rule is lighter because it behaves close to `O(N)`. The decentralized consensus curve stays almost constant per node because each submodule uses only local and neighbor information.

**Simple conclusion:** reducing the sorting cost helps, but a centralized architecture can still be limited by acquisition and communication.
