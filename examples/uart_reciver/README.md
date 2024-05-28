# UART Receiver Example with LED Control

This example demonstrates a simple application of serial communication with an FPGA. It includes a UART receiver that interprets serial commands to control an LED. The system is designed to respond to simple commands sent over a UART interface.

## Example Overview

The example consists of several Verilog modules that together create a system capable of receiving and decode commands from a UART interface to control an LED on an FPGA board. The commands for controlling the LED are "ON" and "OFF," sent as single-byte ASCII characters.

### Modules Description

- **UART Receiver (`uart_rx.v`)**: This module is responsible for asynchronously receiving serial data transmitted to the FPGA at a predefined baud rate. It decodes the UART signals into usable data bytes.

- **LED Control (`led_controller.v`)**: This module takes the decoded data and checks if it matches predefined commands to turn an LED on or off. It reacts to "O" for ON and "F" for OFF.

- **Top Module (`top_module.v`)**: Integrates the UART receiver and LED control modules, managing signal routing and top-level input/output configurations.

- **Pin Constraints (`pin_cons.pcf`)**: Defines the FPGA pin assignments for the I/O elements used in the project, such as the UART input and LED output. Pin constraints are for Alchitry Cu featuring a Lattice iCE40 HX8K FPGA.

### Python script for sending serial commands

**commander.py** script is designed to send control commands to the FPGA board via the UART protocol. It allows for simple remote operation of the FPGA, such as turning an LED on or off. The script utilizes the `pyserial` library to establish serial communication with the FPGA. If its not already available you can install it using `pip` by `pip install pyserial`.

Make sure you modify `'/dev/tty.usbserial-FT4MG9OV1'` in commander.py to correct serial interface of the FPGA (for Alchitry Cu there will be two serial interface and choose the one with 1 at the end)


## Setup, Compilation and running

Follow these steps to compile and generate bit stream (refer main [README file](https://github.com/hansikaweerasena/ice40-Quickstart) for setup the environment.):

```bash
./run.sh
```

Then run the python script by

```
python commander.py 
```

The led will turn on and then turn off after 10 seconds.