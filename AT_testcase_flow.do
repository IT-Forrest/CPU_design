#+FHDR****************************************************************
# ECE department, TAMU
# --------------------------------------------------------------------
# FILE NAME    : AT_testcase_flow.do
# AUTHER       : Jiafan Wang
# DATE         : 07/04/2016
# VERSION      : 1.0
# PURPOSE      : the complete testcase flow for Automated Test
# --------------------------------------------------------------------
# ABSTRACT: ModelSim simulation time 6us given each time period 10ns
# --------------------------------------------------------------------

# Usage: do AT_testcase_flow.do
# vsim -do AT_testcase_flow.do

# Write simulation log to file
.main clear
set systemTime [clock seconds]
vsim -l "vsim_[clock format $systemTime -format %m%d%y]_[clock format $systemTime -format %H%M].log"

# (1) Create the work library
vlib work
vmap work work

# (2) Compile the verilog files & testbench files
#vsim -do AT_compile_all.do
do AT_compile_all.do

# (3) Load design & Run
set i 1
foreach case $testcases {
    puts "BGN Test Case ($i): $case"
    vsim -lib work $case
    onbreak {
    resume
    }
    run -all
    quit -sim
    
    puts "END Test Case: $case\n\n"
    incr i
}

puts "\n\nAll $i Test Cases Finished"
