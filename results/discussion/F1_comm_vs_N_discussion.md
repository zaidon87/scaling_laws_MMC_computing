# F1 — Communication time versus N

This image shows why centralized MMC acquisition becomes difficult as the number of submodules grows. The controller must collect `2N` voltage frames before making the balancing decision, so the communication time grows linearly with `N`.

At the reference point `N = 15`, a shared SPI20M acquisition path is about `108 µs`, which is already larger than the 100 µs fast control period. With one bus per arm, the acquisition block falls to about `54 µs`.

**Simple result:** in the centralized MCU case, the bus can become the first wall before the sorting algorithm itself.