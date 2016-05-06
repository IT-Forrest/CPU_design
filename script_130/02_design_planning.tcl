source ../script_130/create_phy_cell.tcl
set_fp_pin_constraints -hard_constraints {layer location} -use_physical_constraints on -block_level
read_pin_pad_physical_constraints ../script_130/io.tdf

#initialize_floorplan -core_utilization 0.4 -flip_first_row -left_io2core 80 -bottom_io2core 80 -right_io2core 80 -top_io2core 80
initialize_floorplan -control_type width_and_height -core_width 360 -core_height 300 -flip_first_row -left_io2core 120 -bottom_io2core 120 -right_io2core 120 -top_io2core 120
#insert_pad_filler -cell {FILL64TF FILL32TF FILL16TF FILL8TF FILL4TF FILL2TF FILL1TF} -overlap_cell {FILL1TF}

derive_pg_connection -power_net {VDD} -ground_net {VSS} -power_pin {VDD} -ground_pin {VSS}
derive_pg_connection -power_net {DVDD} -ground_net {DVSS} -power_pin {DVDD} -ground_pin {DVSS}

insert_pad_filler -cell {PFILLH PFILLQ PFILL1} -overlap_cell {PFILL1}
derive_pg_connection -power_net {VDD} -ground_net {VSS} -power_pin {VDD} -ground_pin {VSS}

#write_floorplan ${icc_rpt_dir}/floorplan.rpt
#write_physical_constraints -output ${icc_rpt_dir}/floorplan_ctr.rpt
create_fp_placement

#set_fp_rail_constraints  -set_ring -nets  {VDD VSS VDD VSS VDD VSS}  -horizontal_ring_layer { LY } -vertical_ring_layer { MQ } -ring_offset 9 -extend_strap core_ring
set_fp_rail_constraints  -set_ring -nets  {VDD VSS VDD VSS VDD VSS}  -horizontal_ring_layer { E1 MG} -vertical_ring_layer { MA MQ } -ring_offset 9 -extend_strap core_ring

set_fp_rail_constraints -add_layer  -layer MQ -direction vertical -max_strap 12 -min_strap 5 -max_width 5 -min_width 5 -spacing minimum
set_fp_rail_constraints -add_layer  -layer MG -direction horizontal -max_strap 12 -min_strap 5 -max_width 5 -min_width 5 -spacing minimum

# SRAM has its own power ring
#set_fp_block_ring_constraints -add -horizontal_layer MG -horizontal_width 5.000 -horizontal_offset 1.000 -vertical_layer MQ -vertical_width 5.000 -vertical_offset 1.000 -block_type master  -block {RA1SHD_IBM512X8} -net  {VDD VSS}

set_pnet_options -complete "MG MQ"
create_fp_placement -incremental all
legalize_fp_placement

save_mw_cel
copy_mw_cel -from ${my_design} -to ${my_design}_floorplan

