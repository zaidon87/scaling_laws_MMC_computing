# Validation Plan

## Goal

Validate the analytical conclusions before using the repository as evidence in a manuscript, thesis chapter, or presentation.

## 1. File validation

- Confirm the manuscript files open correctly.
- Confirm all Excel workbooks recalculate without broken formulas.
- Confirm all DrawIO files are editable.
- Confirm PNG previews correspond to the DrawIO sources.

## 2. MATLAB validation

- Run `scripts/matlab/run_all_scaling_figures.m`.
- Confirm that all five expected figures are generated.
- Check that the selected CPU, communication protocol, and technique match the intended scenario.
- Repeat with `U_margin = 0.7` for engineering margin.

## 3. Timing validation

- Replace estimated cycle counts with target measurements.
- Use DWT-CYCCNT or equivalent timer for MCU code.
- Measure communication overhead including framing, DMA setup, and interrupt latency.
- Separate blocking and overlapped communication cases.

## 4. FPGA validation

- Synthesize the Bitonic network for each representative N.
- Record LUT, FF, BRAM, timing, and maximum frequency.
- Check the power-of-two cost step when N is not a power of two.

## 5. Interpretation validation

- Make sure the paper does not claim that Local Consensus removes all global limits.
- State clearly that local computation is O(1) per node, while convergence or coordination bandwidth can still limit the complete arm.
