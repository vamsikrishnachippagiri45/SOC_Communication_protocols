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

<img width="860" height="559" alt="image" src="https://github.com/user-attachments/assets/a1a9517b-b730-49ca-b144-cca2469facba" />

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


<img width="860" height="441" alt="image" src="https://github.com/user-attachments/assets/66dcad72-f519-48be-bfe1-4f5211e29584" />


---

## Baud Rate Generator 

### Purpose of the Baud Rate Generator

In UART communication, there is **no shared clock** between the transmitter and receiver.  
To ensure successful data transfer, both sides must operate at the **same baud rate**.

The **Baud Rate Generator** derives timing signals from the system clock and generates two enable pulses:

- **TX Enable**  
  A pulse that instructs the transmitter to shift out the next bit in the data frame.

- **RX Enable**  
  A pulse that instructs the receiver to sample the incoming RX line.  
  This signal is generated at a much higher rate than TX Enable to support **oversampling** and reliable data recovery.

### Design Assumptions

- System Clock Frequency: **50 MHz**
- Target Baud Rate: **9600 bps**
- Receiver Oversampling Factor: **16×**


### Transmitter (TX) Baud Rate Logic

The transmitter requires **one enable pulse per transmitted bit**.

#### Divider Calculation

System clock cycles per bit:

Divider Value = System Clock Frequency / Baud Rate

Divider Value = 50,000,000 / 9,600 ≈ 5208

### Implementation

- A **13-bit counter (`counter_tx`)** runs continuously
- The counter counts from **0 to 5208**
- When the counter reaches the terminal count:
  - It resets to zero
  - A **TX Enable pulse** is asserted for one clock cycle

This TX Enable pulse causes the UART transmitter to shift out the next bit.



### Receiver (RX) Baud Rate Logic

The receiver uses **16× oversampling** to improve noise tolerance and timing accuracy.

This means the RX line is sampled **16 times per transmitted bit**.

#### Divider Calculation

System clock cycles per oversampling tick:

Divider Value = System Clock Frequency / (Baud Rate × 16)

Divider Value = 50,000,000 / (9,600 × 16) ≈ 325

### Implementation

- A **10-bit counter (`counter_rx`)** runs continuously
- The counter counts from **0 to 325**
- When the counter reaches the terminal count:
  - It resets to zero
  - An **RX Enable pulse** is generated

Because RX Enable pulses occur **16× faster** than TX Enable pulses, the receiver can:
- Detect the start bit
- Count **8 RX Enable pulses** to reach the **center of the bit**
- Sample the data at the most stable point

This significantly improves reliability, especially in the presence of clock drift or noise.

### Summary

- **TX Enable** controls when the transmitter shifts bits
- **RX Enable** controls when the receiver samples data
- TX logic operates at **baud rate**
- RX logic operates at **16× baud rate**
- Both are derived from the same system clock using counters

---


