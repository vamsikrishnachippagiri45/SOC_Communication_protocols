# SOC_Communication_protocols
Synthesizable Verilog implementations of SoC communication protocols for FPGA and RISC-V based systems.


## Introduction

Modern System-on-Chip (SoC) designs consist of multiple functional blocks such as processors, memories, hardware accelerators, and peripheral controllers. To enable efficient and reliable data exchange between these blocks, **standardized communication protocols** are used.

A **communication protocol** defines a set of rules that govern how data is transferred between hardware modules, including:
- Signal timing and synchronization
- Handshaking mechanisms
- Data framing and ordering
- Control and status signaling

These protocols ensure **interoperability, scalability, and correctness** in complex SoC architectures.

## Types of SoC Communication Protocols

SoC communication protocols can be broadly classified into the following categories:

### 1. On-Chip Interconnect Protocols

These protocols are used for communication **within the chip**, typically between processors, accelerators, and memory-mapped peripherals. They emphasize high throughput, low latency, and scalability.

Examples:
- AXI4 / AXI4-Lite / AXI4-Stream (AMBA)
- AHB / APB
- Wishbone
- TileLink

In this repository, **AXI4-Lite and AXI4-Stream** are implemented, as they are widely used in modern RISC-V and FPGA-based accelerator designs.

### 2. Peripheral Communication Protocols

These protocols connect the SoC to **external or low-speed devices** such as sensors, EEPROMs, displays, and debugging interfaces. They are simpler than interconnect protocols but are critical for system functionality.

Examples:
- UART
- SPI
- I2C
- I2S
- CAN

This repository includes **UART, SPI, and I2C** implementations commonly used in embedded and SoC platforms.

### 3. High-Speed System Interfaces

High-speed interfaces are used for off-chip communication and high-bandwidth data transfer. These protocols are complex and typically implemented using vendor IPs.

Examples:
- DDR
- PCIe
- USB
- Ethernet

## Objective

The objective of this repository is to:
- Gain hands-on experience with widely used SoC communication protocols
- Design synthesizable, modular Verilog RTL
- Understand protocol-level timing and handshaking
- Build reusable interfaces for RISC-V based SoC and accelerator integration

This project is intended for **learning, research, and FPGA prototyping**, and reflects industry-relevant SoC design practices.





