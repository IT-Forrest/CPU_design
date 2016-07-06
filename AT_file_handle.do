##+FHDR****************************************************************
## ECE department, TAMU
## --------------------------------------------------------------------
## FILE NAME    : AT_file_handle.do
## AUTHER       : Jiafan Wang
## DATE         : 07/04/2016
## VERSION      : 1.0
## PURPOSE      : compile verilog files & testbench for Automated Test
## --------------------------------------------------------------------
## ABSTRACT: ModelSim simulation time 6us given each time period 10ns
## --------------------------------------------------------------------

# Usage: do AT_compile_all.do

# (1) Open the log file
set fname "vsim_070516_2232.log"
set fp [open $fname r]

# (2) Write/Read 
#puts $fp "test"
#set file_data [read $fp]

# loop read each line
set err_cnt 0
while {[gets $fp data] >= 0} {
    #puts $data;
    #regexp {Failed} $data fullmatch submatch
    
    #for greedy match, * instead of .*
    if {[string match "*Passed*" $data] == 1} {
        incr err_cnt
    }
}

puts "err_cnt = [expr $err_cnt + 0]"
# Two equivalent expressions
puts "err_cnt = $err_cnt"

# (3) Close the file
close $fp
