# UART (Universal Asynchronous Receiver and Transmitter)

## Overview

UART (Universal Asynchronous Receiver and Transmitter) is a **fundamental peripheral communication protocol** used for serial data exchange between digital systems such as microcontrollers, processors, FPGAs, and computers.

UART is widely used in embedded and SoC designs for:
- Debugging and console output
- Bootloader communication
- Configuration and logging

This module provides a **synthesizable Verilog implementation of UART**, suitable for FPGA and ASIC-oriented designs.

---

## What is UART?

UART is a hardware peripheral that enables **asynchronous serial communication**.

- **Universal** → Works across a wide range of systems  
- **Asynchronous** → No shared clock between transmitter and receiver  
- **Receiver/Transmitter** → Supports both data transmission and reception  

UART converts **parallel data** from a processor into a **serial data stream** for transmission and converts received serial data back into parallel form.

---

## Hardware Interface

UART communication requires only **two signal lines**:

- **TX (Transmit):** Sends serial data
- **RX (Receive):** Receives serial data

Connection rule:
- TX of one device → RX of the other device
- RX of one device → TX of the other device

The UART line remains in **logic High (Idle state)** when no transmission is occurring.

A commonly used electrical standard for UART communication is **RS-232**, which defines voltage levels and signal characteristics.

RS-232 (Recommended Standard-232) is a communication standard that defines the electrical, timing, and signal characteristics for serial data communication, most commonly used with UART-based interfaces.

In simple terms:

UART defines how data is framed and transferred.
RS-232 defines how those bits are electrically represented on wires.

---

## Baud Rate and Bit Time

### Baud Rate
- Defines the speed of communication
- Measured in **bits per second (bps)**
- Common values: 9600, 19200, 115200

### Bit Time
The time duration of one bit:

Bit Time (seconds) = 1 / Baud Rate (bits per second)


Example:
- Baud Rate = 9600 bps
- Bit Time ≈ 104.17 µs

Both transmitter and receiver must be configured with the **same baud rate** to ensure correct communication.

---

## Clocking and Oversampling

Since UART has no shared clock, timing is derived internally from the **system clock**.

### Transmitter Timing
The transmitter uses a counter to hold each bit for:

System Clock Cycles per Bit = System Clock Frequency / Baud Rate


Example:
- 50 MHz clock and 9600 baud → ~5208 clock cycles per bit

### Receiver Oversampling
To improve reliability, the receiver uses **16× oversampling**:
- RX line is sampled 16 times per bit
- The center of the bit period is used for data sampling

Oversampling improves:
- Noise immunity
- Timing tolerance
- Accurate start-bit detection

---

## UART Frame Format

Each UART transmission is sent as a **frame**:


### Start Bit
- Logic transition from **High (1) to Low (0)**
- Indicates the beginning of data transmission

### Data Bits
- Typically **8 bits**
- Can range from 5 to 9 bits
- Sent **Least Significant Bit (LSB) first**

### Parity Bit (Optional)
- Used for simple error detection
- Even or Odd parity

### Stop Bit(s)
- 1 or 2 bits
- Line returns to **High (1)**
- Marks the end of the frame

---

## UART Operation Flow

### Transmission
1. Parallel data loaded from the processor
2. Converted into serial format
3. Start, parity, and stop bits appended
4. Data transmitted via TX line

### Reception
1. Falling edge of start bit detected
2. RX line sampled using baud timing
3. Serial data extracted
4. Converted back into parallel data

---

## Key Features of This Implementation

- Full-duplex communication (TX and RX)
- Configurable baud rate
- FSM-based control logic
- Parameterized design
- Synthesizable Verilog HDL
- Suitable for FPGA and ASIC designs

---

## Applications

- SoC debug console
- Processor-to-PC communication
- Firmware and bootloader messaging
- Embedded system logging



