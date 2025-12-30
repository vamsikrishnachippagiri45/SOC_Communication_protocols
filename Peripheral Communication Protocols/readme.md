# Peripheral Communication Protocols

## Introduction

In a System-on-Chip (SoC), **peripheral communication protocols** are used to interface the main processing system with **external or low-speed devices** such as sensors, memory chips, displays, and debugging interfaces.

Unlike high-performance on-chip interconnects, peripheral protocols prioritize:
- Simplicity
- Low power consumption
- Deterministic timing
- Ease of integration

These protocols play a critical role in embedded systems and are widely used in **microcontrollers, RISC-V SoCs, and FPGA-based designs**.

---

## Characteristics of Peripheral Communication Protocols

Peripheral communication protocols typically exhibit the following characteristics:

- Lower data rates compared to on-chip buses
- Simple master–slave communication model
- Minimal hardware complexity
- Bit-serial data transfer
- Strong dependence on finite state machine (FSM) control

Due to their simplicity, they are ideal for **learning protocol design and RTL implementation**.

---

## Common Peripheral Communication Protocols

### 1️⃣ UART (Universal Asynchronous Receiver Transmitter)

UART is an **asynchronous serial communication protocol** used mainly for debugging, logging, and console communication.

**Key Features:**
- No shared clock between transmitter and receiver
- Configurable baud rate
- Full-duplex communication
- Start and stop bit framing

**Typical Applications:**
- SoC debug console
- Bootloader communication
- Serial terminals

---

### 2️⃣ SPI (Serial Peripheral Interface)

SPI is a **synchronous, full-duplex protocol** commonly used for high-speed peripheral communication.

**Key Features:**
- Master-driven clock
- Full-duplex data transfer
- Configurable clock polarity (CPOL) and phase (CPHA)
- Multiple slave support using chip select signals

**Typical Applications:**
- Flash memory
- ADC/DAC interfaces
- Displays and sensors

---

### 3️⃣ I2C (Inter-Integrated Circuit)

I2C is a **two-wire, multi-drop serial protocol** designed for low-speed communication between multiple devices.

**Key Features:**
- Uses only SDA (data) and SCL (clock)
- Open-drain signaling
- Supports multiple masters and slaves
- Address-based device selection

**Typical Applications:**
- EEPROMs
- Sensors
- Power management ICs

---

## Scope of This Repository

In this repository, the following peripheral communication protocols are implemented in **synthesizable Verilog HDL**:

- UART (TX/RX)
- SPI (Master/Slave)
- I2C (Master)

Each protocol implementation focuses on:
- FSM-based control logic
- Protocol-compliant timing
- Parameterized and reusable RTL
- Testbench-based verification


