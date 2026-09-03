# F5 — Gantt chart at N = 15

This image shows the timing sequence at the reference point `N = 15`. The fast `T1` layer is dominated by measurement acquisition and CVB computation. The energy and grid tasks are much smaller and fit into the remaining slack.

With shared SPI20M, the acquisition block is too large for the 100 µs fast period. With dual-bus DMA, the acquisition time is reduced and the centralized case becomes schedulable.

**Simple result:** the reference centralized case needs careful acquisition design; otherwise the measurement-to-actuation path misses the deadline.