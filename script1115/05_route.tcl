#################
#  Clock Route  #
#################

report_timing

 ## Check Error
check_routeability -error_cell before_pns.err

 ## Redundant Via
set_route_zrt_common_options  -post_detail_route_redundant_via_insertion high -concurrent_redundant_via_mode insert_at_high_cost -concurrent_redundant_via_effort_level high

 ## Route Setup ##
#set_ignored_layers  -max_routing_layer MG
set_ignored_layers  -max_routing_layer M3
set_route_zrt_common_options  -concurrent_redundant_via_mode insert_at_high_cost -concurrent_redundant_via_effort_level high
set_route_zrt_global_options  -timing_driven true -crosstalk_driven true 
set_route_zrt_detail_options  -timing_driven true -optimize_wire_via_effort_level medium -insert_diodes_during_routing true
#set_net_routing_layer_constraints   {*}   -min_layer M1  -max_layer MG
set_net_routing_layer_constraints   {*}   -min_layer M1  -max_layer M3
 
 ## IBM130 Antenna Rules ##
#source ../tech/antenna_9lm_CIC.clf  
source ${script_path}/antenna_rules.tcl

 ## Clock Routing
route_zrt_group -all_clock_nets

verify_zrt_route
report_drc_error_types

################
#  Auto Route  #
################

 ## Set Routing Blockage
 #create_routing_blockage -layers {metal5Blockage via5Blockage metal6Blockage via6Blockage metal7Blockage via7Blockage metal8Blockage} -bbox {{397.000 575.400} {591.780 734.000}} {RB_161536 RB_161537 RB_161538 RB_161539 RB_161540 RB_161541 RB_161542}

 ## Generate Route Very Long Time
route_zrt_auto

verify_zrt_route
report_drc_error_types

 ## Manually Fix DRC Problem If Needed !!!

 ## In Case Antenna Problem
#source ${script_path}/antenna_rules.tcl
# Or #set_route_zrt_detail_options  -diode_libcell_names ANTENNA_X1 -insert_diodes_during_routing true
#set_route_zrt_detail_options  -diode_libcell_names ANTENNATF -insert_diodes_during_routing true
 
 ## Solve DRC Violation
route_opt  -incremental 
#route_opt  -incremental -size_only

 ## Solve Timing Violation Very Long Time (Might work)
route_zrt_detail -incremental true -initial_drc_from_input true

 ## To solve Max/Tran problems, try insert buffer to the net or size up/down the net/sink respectively

report_timing
report_constraint -all
 
 ## Power Connections In Case Additional Cells Added
derive_pg_connection -power_net {VDD} -ground_net {VSS} -power_pin {VDD} -ground_pin {VSS}
derive_pg_connection -power_net {DVDD} -ground_net {DVSS} -power_pin {DVDD} -ground_pin {DVSS}

 ## Route Report ##
report_design -physical > ${icc_rpt_dir}/design_report_phy.rpt
report_timing > ${icc_rpt_dir}/timing_after_route.rpt

###########
# Help Me #
###########
save_mw_cel  -design "${my_design}"
save_mw_cel  -design "${my_design}" -as "route"

