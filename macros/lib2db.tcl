#!/bin/bash

set SRAM_LIB "/homes/grad/jiafan0420/ECEN468/CPU_design/sram_lib/"

set str_match "lib"
set lib_name "RA1SHD_IBM512X8"

foreach varname [exec ls] {
    regexp {(\S+)\.(\S+)} $varname c1 c2 c3
    #regexp {(\S+)\.lib} $varname c1 c2 c3
    if {1 == [string equal $str_match $c3]} {
        #puts ${c2}.lib
        read_lib ${c2}.lib
        write_lib $lib_name -output ${c2}.db
    }
}







