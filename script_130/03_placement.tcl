#connect_tie_cells -max_wirelength 200  -tie_high_lib_cell TIEHI -tie_low_lib_cell TIELO -max_fanout 5 -obj_type cell_inst -objects [get_cells -hier *]

 ## Placement ##
place_opt -effort high -area_recovery
 
 ## Refine ##
refine_placement -congestion_effort high -perturbation_level max
 
 ## Physical Opt ##
psynopt -area_recovery -power
 
 ## Report ##
report_timing > ${icc_rpt_dir}/timing_after_place.rpt
report_placement_utilization > ${icc_rpt_dir}/placement_utilization.rpt

 ## Save ##
save_mw_cel
copy_mw_cel -from ${my_design} -to ${my_design}_placement

