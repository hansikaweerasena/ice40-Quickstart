#!/bin/bash
set -e

# TOP_MODULE="ProcessingElement" 
TOP_MODULE="PE_Array" 
# TOP_MODULE="PE_Matrix"
VERILOG_SOURCES="pe.v pe_array.v pe_matrix.v accumilator_tree.v"

# Synthesize the design with Yosys
yosys -p "synth_ice40 -top $TOP_MODULE -json output.json" $VERILOG_SOURCES

# Place and route with nextpnr
nextpnr-ice40 --hx8k --json output.json --pcf pin_cons.pcf --asc output.asc --package cb132 --pcf-allow-unconstrained

# Generate the binary bitstream
#icepack output.asc bitstream.bin

# Convert the ASCII description back to Verilog for simulation purposes
#icebox_vlog output.asc > output_chip.v

# Simulate the design (Assuming the testbench file is named 'testbench.v')
# iverilog -o testbench_sim output_chip.v testbench.v
# vvp -N ./testbench_sim

# Command to view waveform if needed (e.g., using GTKWave)
# gtkwave testbench.vcd
