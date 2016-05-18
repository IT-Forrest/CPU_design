##############
#  Checking  #
##############

 ## In Case Frequnecy Dividor Exists in Design (Optional)
#set cts_enable_clock_at_hierarchical_pin true
#set power_cg_auto_identify true

check_physical_design -stage pre_clock_opt
report_constraint -all
report_timing

 ## Remove Clock Tree
remove_clock_tree
remove_clock_uncertainty [all_clocks]
check_clock_tree

 ## Set Delay Calculation
set_delay_calculation -arnoldi
update_timing

report_timing
 ## In Case of Back-Annotated Info (Optional)
#remove_annotated_delay -all 

################
#  Clock Tree  #
################

clock_opt -no_clock_route -only_cts
 
report_timing
report_constraint -all
 
 ## Solve Max cap/trans Violation
clock_opt -no_clock_route -only_psyn
#clock_opt -fix_hold_all_clocks -no_clock_route

 ## Solve Max Faout Violation (Optional)
# set_max_fanout 55 [current_design] 
# clock_opt -no_clock_route -only_psyn

 ## Power Connections In Case Additional Cells Added
derive_pg_connection -power_net {VDD} -ground_net {VSS} -power_pin {VDD} -ground_pin {VSS}
derive_pg_connection -power_net {DVDD} -ground_net {DVSS} -power_pin {DVDD} -ground_pin {DVSS}

report_timing
report_constraint -all

 ## Report Clock Tree ##
write_sdc -nosplit ./cts.sdc
report_clock_tree > ${icc_rpt_dir}/clock_tree.rpt
report_clock_timing -type summary > ${icc_rpt_dir}/clock_timing.rpt

###########
# Help Me #
###########
save_mw_cel  -design "${my_design}"
save_mw_cel  -design "${my_design}" -as "cts"


