# Async & Sync FIFO Design in Verilog
"Implementation of Synchronous and Asynchronous FIFOs in Verilog, featuring 2-stage synchronizers and Gray code conversion for Clock Domain Crossing (CDC) management."

## Project Overview
Implementation of Synchronous and Asynchronous FIFOs in Verilog, designed for reliable data transfer between different clock domains.

## Features
    Dual-Clock Support:** Asynchronous FIFO handling for disparate clock frequencies.
    Clock Domain Crossing (CDC):** Utilizes 2-stage synchronizers to mitigate metastability.
    *Gray Coding:** Pointer synchronization using Gray code to ensure 1-bit transition stability.
    Verification:** Simulated using Icarus Verilog and visualized via GTKWave.

## Files
   `afifo_cyc.v`: Asynchronous FIFO implementation.
   `sfifo.v`: Synchronous FIFO implementation.
   `tb.v`: Testbench for verification.
   `fifo.vcd` / `sfifo.vcd`: Simulation waveform files.

## Tools Used
  VS Code (Editor)
  Icarus Verilog (Compiler)
  GTKWave (Waveform Viewer)
