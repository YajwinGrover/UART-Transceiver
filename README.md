# UART Transceiver

A UART (Universal Asynchronous Receiver/Transmitter) transmitter and receiver implemented in Verilog, synthesized and verified on a Xilinx Spartan-7 FPGA at 115200 baud.

## Overview

This project implements a UART core capable of transmitting and receiving serial data over a standard asynchronous frame (start bit, 8 data bits, stop bit). The design was synthesized and tested against real hardware using a custom Python script communicating over USB.

## Design Highlights

- **Baud rate generator** — a clock divider generates the correct rate from the board's system clock to hit a target (115200) baud.
- **FSM-based TX/RX** — both the transmitter and receiver are built around FSM's that manage the data frame (start bit → data bits → stop bit) and control overall flow of the datapath.
- **Oversampling on RX** — the receiver samples the incoming line at clock speed (100 MHz) and captures data at the center of each bit period, rather than at the edge, to reduce race conditions.
- **Self-checking testbenches** — TX was verified using a python scrip, and RX was verified independently in simulation before being tested together, so bugs could be found in a rapid design cycle fashion rather than wait for synthetization and implementation runs.
- **Real hardware verification** — synthesized to a Spartan-7 FPGA and validated with a custom Python script over USB, showing the practicality of the design.

## Verification

- Self-checking testbenches for RX in Vivado simulator
- Waveform inspection to confirm correct framing and bit timing
- End-to-end test: Python script sends bytes over USB → FPGA receives and (echoes/processes) them → Display result on seven segment display for verification

## Tools

- Verilog (RTL)
- Vivado (synthesis, simulation, implementation)
- Spartan-7 FPGA
- Python (hardware test harness)
