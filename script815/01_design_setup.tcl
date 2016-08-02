###################################
#     Single Module P&R Script    #
#       For Design Compiler       #
###################################
# Author:	Jiafan Wang           #
# Update:	2016-05               #
###################################

if {![info exists script_path]} {
set script_path  "../script815"
source ${script_path}/all_common.tcl
}

 ## Create the SRAM Library (optional)
if {![file exist ${macro_db_path}/${sram_db_name}/CEL]} {
create_mw_lib  -technology ${icc_tech_file} -bus_naming_style {[%d]} -open ${macro_db_path}/${sram_db_name}
# invoke Milkyway to convert lef to CEL & FRAM
exec Milkyway -f ${macro_db_path}/lef2cel_new.tcl  &
# manually close Milkyway # menuQuit
}

 ## Create the CHIP Libaray if Not Exist
if {![file exist CHIP]} {create_mw_lib  -technology ${icc_tech_file} -mw_reference_library [list ${icc_ref_lib} ${icc_pad_lib} ${macro_db_path}/${sram_db_name}] -bus_naming_style {[%d]} -open CHIP}
open_mw_lib CHIP

 ## Load the design 
import_designs -format verilog -top ${my_design} -cel ${my_design} "${syn_nlst_dir}/${my_design}.vg"

 ## Configure Timing Constraints (Dual TA Library)
set_min_library ${synopsys_max_db_name}.db -min_version ${synopsys_min_db_name}.db
set_min_library ${iopad_max_db_name}.db    -min_version ${iopad_min_db_name}.db
set_min_library ${ibm_sram_max_db_name}.db -min_version ${ibm_sram_min_db_name}.db

set_min_library ${synopsys_max_db_name}.db -min_version ${synopsys_min_db_name}.db
set_min_library ${ibm_sram_max_db_name}.db -min_version ${ibm_sram_min_db_name}.db
set_min_library ${iopad_max_db_name}.db -min_version ${iopad_min_db_name}.db
set_operating_conditions -min_library ${ibm_sram_min_db_name}.db:${sram_db_name} -min ff_1p32v_m40c -max_library ${ibm_sram_max_db_name}.db:${sram_db_name} -max ss_1p08v_125c -analysis_type on_chip_variation

 ## Setup Power and Ground ##
set mw_logic1_net VDD
set mw_logic0_net VSS

 ## RC Extraction Files
set_tlu_plus_files -max_tluplus ${icc_maxtlu_file} -min_tluplus ${icc_mintlu_file}  -tech2itf_map  ${icc_tlu_map}
read_sdc  -version 1.8 "${syn_db_dir}/${my_design}.sdc"

###########
# Help Me #
###########
save_mw_cel  -design "${my_design}"
save_mw_cel  -design "${my_design}" -as "design_setup"
