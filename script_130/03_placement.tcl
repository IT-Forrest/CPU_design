##############
#  Checking  #
##############

if {![info exists script_path]} {
set script_path  "../script_130"
source ${script_path}/all_common.tcl
}

 ## Report Timing & Constraints
set_zero_interconnect_delay_mode true
report_timing
report_constraint -all

 ## Load Scan Chain (Optional)
set_zero_interconnect_delay_mode false
#report_power

 ## Load SAIF File (Optional)
#read_saif -input

##############
# Placement  #
##############

 ## Placement With High Area Concern
check_physical_design –stage pre_place_opt
place_opt -effort high -area_recovery

report_congestion -grc_based
report_timing

 ## Power Connections In Case Additional Cells Added
derive_pg_connection -power_net {VDD} -ground_net {VSS} -power_pin {VDD} -ground_pin {VSS}
derive_pg_connection -power_net {DVDD} -ground_net {DVSS} -power_pin {DVDD} -ground_pin {DVSS}

report_timing
 ## In Case of Congestion
#place_opt -effor high -congestion -area_recovery
 ## Leave report_constraint -all to CTS

 ## Add Tie Cells (Optional)
#connect_tie_cells -max_wirelength 200  -tie_high_lib_cell TIEHI -tie_low_lib_cell TIELO -max_fanout 5 -obj_type cell_inst -objects [get_cells -hier *]

 ## Refine ##
#refine_placement -congestion_effort high -perturbation_level max
 ## Physical Opt ##
#psynopt -area_recovery -power
 
 ## Report ##
report_timing > ${icc_rpt_dir}/timing_after_place.rpt
report_placement_utilization > ${icc_rpt_dir}/placement_utilization.rpt

###########
# Help Me #
###########
save_mw_cel  -design "${my_design}"
save_mw_cel  -design "${my_design}" -as "placement"

