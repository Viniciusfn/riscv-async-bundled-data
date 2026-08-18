# RISC-V Asynchronous Bundled-Data Pipeline

A RISC-V processor based on an **asynchronous bundled-data pipeline**, also known as a **micropipeline** architecture. The project explores the implementation and evaluation of a RISC-V processor using asynchronous pipeline techniques instead of a conventional globally clocked design.

For a detailed description of the architecture, design methodology, implementation, and experimental results, see the documentation in [`docs/`](./docs/).

## Directory Structure

```text
.
├── coremark/       # CoreMark benchmark
├── dhrystone/      # Dhrystone benchmark
├── docs/           # Project documentation and thesis
├── logs/           # Simulation and execution logs
├── mem/            # Memory-related files
├── model/          # Processor model
├── reports/        # Generated reports
├── results/        # Experimental results
├── rtl/            # RTL implementation
├── scripts/        # Scripts for simulation and automation (includes Makefile)
├── srclists/       # Source file lists
├── structural/     # Structural implementation
├── timing/         # Timing-related files
└── workspace/      # Workspace and auxiliary files
```
