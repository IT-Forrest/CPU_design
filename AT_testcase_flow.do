##+FHDR****************************************************************
## ECE department, TAMU
## --------------------------------------------------------------------
## FILE NAME    : AT_testcase_flow.do
## AUTHER       : Jiafan Wang
## DATE         : 07/04/2016
## VERSION      : 1.0
## PURPOSE      : the complete testcase flow for Automated Test
## --------------------------------------------------------------------
## ABSTRACT: ModelSim simulation time 6us given each time period 10ns
## --------------------------------------------------------------------

# Usage: do AT_testcase_flow.do
# vsim -do AT_testcase_flow.do

# Write simulation log to file
vsim -l vsim.log

# (1) Create the work library
vlib work
vmap work work

# (2) Compile the verilog files & testbench files
vsim -do AT_compile_all.do

# (3) Load design & Run
vsim -lib work SCPU_SRAM_8BIT_ALU_SPI_TOP_TEST
onbreak {
resume
}
run -all
quit -sim

vsim -lib work PSEUDO_SPI_INTF_RA1512_TEST
onbreak {
resume
}
run -all
quit -sim

