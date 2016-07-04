##+FHDR****************************************************************
## ECE department, TAMU
## --------------------------------------------------------------------
## FILE NAME    : AT_try.do
## AUTHER       : Jiafan Wang
## DATE         : 07/04/2016
## VERSION      : 1.0
## PURPOSE      : Automated Test script
## --------------------------------------------------------------------
## ABSTRACT: ModelSim simulation time 6us given each time period 10ns
## --------------------------------------------------------------------

# Usage: in Modesim  do AT_try.do

# Write simulation log to file
vsim -l vsim.log 

# Create the work library
vlib work
vmap work work

# Compile the verilog files & testbench files
vlog -work work DEFINE_CPU.v
vlog -work work I_MEMORY_8bit.v
vlog -work work SERIAL_CPU_8bit.v
vlog -work work SHARE_SUPERALU.v
vlog -work work SRAM_IO_CTRL.v
vlog -work work PSEUDO_SPI_INTF.v
vlog -work work SCPU_8BIT_ALU_CTRL_SPI.v
vlog -work work SCPU_SRAM_8BIT_ALU_SPI_TOP.v

vlog -work work ./sim/SCPU_SRAM_8BIT_ALU_SPI_TOP_TEST.v

# Load design
#vsim work.SCPU_SRAM_8BIT_ALU_SPI_TOP_TEST
vsim -lib work SCPU_SRAM_8BIT_ALU_SPI_TOP_TEST

# Open the view windows & load signal list files
view wave
#do {F:/05. Code Battle/04. Verilog/CPU_design/scpu_io_ctrl_ra1512_serial8bit_alu_spi_top_test.do}
do ./scpu_io_ctrl_ra1512_serial8bit_alu_spi_top_test.do

# Execute till the $stop
run -all

# Manually Abort Simulation (quit VSIM(paused) prompt)
abort
