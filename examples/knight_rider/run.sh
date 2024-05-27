#!/bin/bash
set -ex
yosys -p 'synth_ice40 -top knight_rider -json temp.json' top_rtl.v
nextpnr-ice40 --hx8k --json temp.json --pcf pin_cons.pcf --asc temp.asc --package cb132
icepack temp.asc bitstream.bin
icebox_vlog temp.asc > temp_chip.v
iverilog -o tb temp_chip.v tb.v
vvp -N ./tb