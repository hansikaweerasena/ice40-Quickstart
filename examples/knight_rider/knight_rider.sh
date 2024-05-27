#!/bin/bash
set -ex
yosys -p 'synth_ice40 -top knight_ride -json knight_ride.json' knight_ride.v
nextpnr-ice40 --hx8k --json knight_ride.json --pcf knight_ride.pcf --asc knight_ride.asc --package cb132
icepack knight_ride.asc knight_ride.bin
icebox_vlog knight_ride.asc > knight_ride_chip.v
iverilog -o knight_ride_tb knight_ride_chip.v knight_ride_tb.v
vvp -N ./knight_ride_tb