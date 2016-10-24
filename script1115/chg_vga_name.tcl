#!/usr/bin/tclsh

# set MODULE name & path
if {[info exists my_design]} {
set module_name ${my_design}
set module_path ${icc_nlst_dir} 
} else {
set module_name "SCPU_SRAM_8BIT_ALU_SPI_TOP"
set module_path "."
}

# cat SCPU_SRAM_8BIT_ALU_SPI_TOP.vg | grep "^module" | awk '{print $2}' > chg_list 
set chg_file ${module_path}/list_chg
# set output file "SCPU_SRAM_8BIT_ALU_SPI_TOP_VG.v"
set syn_file ${module_path}/${module_name}.vga
set sed_file ${module_path}/${module_name}_VGA.v
exec cp ${syn_file} ${sed_file}

set fp_chg [open $chg_file r]
#set fp_sed [open $sed_file w+]

while {[gets $fp_chg data] >= 0} {
    puts $data
    exec sed -i "s/$data /${data}_VGA /g" $sed_file 
}


