##############
# Floor Plan #
##############

if {![info exists script_path]} {
set script_path  "../script1115"
source ${script_path}/all_common.tcl
}

 ## Create Pysical Pads
source  ${script_path}/create_phy_cell.tcl
#read_pin_pad_physical_constraints ./io.tdf
read_pin_pad_physical_constraints ./pad.con
#return
 ## Iteratively Configure Width/Height Based on Your Design (core_utilization 70%)
#create_floorplan -core_utilization 0.4 -flip_first_row -left_io2core 80 -bottom_io2core 80 -right_io2core 80 -top_io2core 80
#initialize_floorplan -core_aspect_ratio 0.7 -start_first_row -flip_first_row -left_io2core 130 -bottom_io2core 210 -right_io2core 130 -top_io2core 210
#initialize_floorplan -core_utilization 0.6 -core_aspect_ratio 0.772952 -start_first_row -flip_first_row -left_io2core 130 -bottom_io2core 210 -right_io2core 130 -top_io2core 210
#initialize_floorplan -start_first_row -flip_first_row -left_io2core 160 -bottom_io2core 220 -right_io2core 160 -top_io2core 220
#make sure to use -pad_limit to avoid gap between pads
#initialize_floorplan -start_first_row -flip_first_row -left_io2core 130 -bottom_io2core 200 -right_io2core 130 -top_io2core 200
#initialize_floorplan -left_io2core 160.0 -bottom_io2core 170.0 -right_io2core 160.0 -top_io2core 170.0 -pad_limit
#initialize_floorplan -core_utilization 0.0723061 -core_aspect_ratio 0.907872 -left_io2core 130 -bottom_io2core 160 -right_io2core 130 -top_io2core 160 -pin_snap
initialize_floorplan -core_utilization 0.464217 -core_aspect_ratio 0.946479 -start_first_row -flip_first_row -left_io2core 260 -bottom_io2core 270 -right_io2core 260 -top_io2core 270
#bigger core
#initialize_floorplan -core_utilization 0.386174 -core_aspect_ratio 0.950215 -start_first_row -flip_first_row -left_io2core 240 -bottom_io2core 250 -right_io2core 240 -top_io2core 250
#bigger core
#initialize_floorplan -core_utilization 0.353059 -core_aspect_ratio 0.955556 -start_first_row -flip_first_row -left_io2core 230 -bottom_io2core 240 -right_io2core 230 -top_io2core 240
#bigger core
#initialize_floorplan -core_utilization 0.324033 -core_aspect_ratio 0.960474 -start_first_row -flip_first_row -left_io2core 220 -bottom_io2core 230 -right_io2core 220 -top_io2core 230
#bigger core
#initialize_floorplan -core_utilization 0.60 -core_aspect_ratio 0.79 -start_first_row -flip_first_row -left_io2core 210 -bottom_io2core 220 -right_io2core 210 -top_io2core 220
#bigger core
#initialize_floorplan -control_type width_and_height -core_width 540 -core_height 540 -flip_first_row -left_io2core 220 -bottom_io2core 220 -right_io2core 220 -top_io2core 220 -pin_snap

 ## Insert Pad Filler In Case Gaps Exist
#insert_pad_filler -cell {PFILLH PFILLQ PFILL1} -overlap_cell {PFILL1}
#insert_pad_filler -cell {PFILLH PFILLQ PFILL1}
insert_pad_filler -cell {PFILL1}

 ## Generate Floorplan Report ##
write_floorplan ${icc_rpt_dir}/floorplan.rpt
write_physical_constraints -output ${icc_rpt_dir}/floorplan_ctr.rpt

save_mw_cel  -design "${my_design}"
save_mw_cel  -design "${my_design}" -as "die_init"

###############
#  Placement  #
###############

 ## Renew Tracks
remove_track -all
source ${script_path}/renew_track.tcl
report_track

 ## Place Macro & Standard Cells
create_fp_placement
#return
 ## Manually Adjust Macro Location (optional)
#change_selection [rotate_objects -by CW90 [get_cells sram]]
#move_objects -delta {196.800 81.800} [get_cells sram]
#move_objects -x 280 -y 280 [get_cells sram]
#move_objects -x 410.6 -y 556.6 [get_cells sram]
#move_objects -x 405 -y 555 [get_cells sram]
#align_objects -side Right [get_cells sram]
align_objects -side Left [get_cells sram]
align_objects -side Bottom [get_cells sram]
 
 ## Set Margin Around Macro
#set_keepout_margin  -type hard -all_macros -outer {20.0 20.0 20.0 20.0}
set_keepout_margin  -type hard -all_macros -outer {30.0 30.0 30.0 30.0}

 ## Fix Macro
set_dont_touch_placement [all_macro_cells]
#set_dont_touch_placement [get_cells sram]
 # might be a bug of set_dont_touch
#source ${script_path}/setcts_pads_fix.tcl

 ## Place Macro & Standard Cells Incrementally
create_fp_placement -incremental all
#legalize_fp_placement

report_congestion -grc_based

###########
# Help Me #
###########
save_mw_cel  -design "${my_design}"
save_mw_cel  -design "${my_design}" -as "before_pns"


####################################
#  Power Network Synthesize (PNS)  #
####################################

 ## Power Connections
derive_pg_connection -power_net {VDD} -ground_net {VSS} -power_pin {VDD} -ground_pin {VSS}
derive_pg_connection -power_net {DVDD} -ground_net {DVSS} -power_pin {DVDD} -ground_pin {DVSS}

 ## Configure Power Straps
set_fp_rail_constraints -add_layer  -layer E1 -direction horizontal -max_strap 20 -min_strap 10 -max_width 8 -min_width 8 -spacing minimum
set_fp_rail_constraints -add_layer  -layer LY -direction vertical -max_strap 20 -min_strap 10 -max_width 8 -min_width 8 -spacing minimum
#set_fp_rail_constraints -add_layer  -layer E1 -direction horizontal -max_strap 20 -min_strap 10 -max_width 4 -min_width 4 -spacing minimum
#set_fp_rail_constraints -add_layer  -layer LY -direction vertical -max_strap 20 -min_strap 10 -max_width 4 -min_width 4 -spacing minimum
#set_fp_rail_constraints -add_layer  -layer LY -direction vertical -max_pitch 22 -min_pitch 22 -max_width 4 -min_width 4 -spacing minimum
#set_fp_rail_constraints -add_layer  -layer E1 -direction horizontal -max_pitch 22 -min_pitch 22 -max_width 4 -min_width 4 -spacing minimum

 ## Configure Power Rings
set_fp_rail_constraints  -set_ring  -nets  {VDD VSS VDD VSS VDD VSS}  -horizontal_ring_layer { E1 } -vertical_ring_layer { MA } -ring_offset 9 -extend_strap core_ring
#set_fp_rail_constraints  -set_ring  -nets  {VDD VSS VDD VSS VDD VSS}  -horizontal_ring_layer { E1 } -vertical_ring_layer { MA } -ring_offset 9 -extend_strap core_ring
#set_fp_rail_constraints  -set_ring -nets  {VDD VSS VDD VSS VDD VSS}  -horizontal_ring_layer { E1 } -vertical_ring_layer { MA } -extend_strap region_boundary

 ## Global Constraints & Macro Ring Setting
set_fp_rail_constraints -set_global -no_routing_over_hard_macros
#set_fp_block_ring_constraints -add -horizontal_layer M3 -horizontal_width 4 -horizontal_offset 1 -vertical_layer M2 -vertical_width 4.000 -vertical_offset 1 -block_type master  -block ${sram_db_name} -net  {VDD VSS}
set_fp_block_ring_constraints -add -horizontal_layer M3 -horizontal_width 3 -horizontal_offset 1 -vertical_layer M2 -vertical_width 3 -vertical_offset 1 -block_type master  -block ${sram_db_name} -net  {VDD VSS}

 ## Iteratively PNS Synthesize
synthesize_fp_rail  -nets {VDD VSS} -voltage_supply 1.2 -synthesize_power_plan -power_budget 50
commit_fp_rail

 ## Remove Vias Between VDD(VSS) Pads and VDD(VSS) Straps (Optional)
#cut_row -within {{835 483} {940 515}}
#cut_row -within {{835 615} {940 640}}

# Connections among P/N, Macros and Pads
preroute_instances  -ignore_macros -ignore_cover_cells -primary_routing_layer specified -specified_horizontal_layer MG -specified_vertical_layer MQ -extend_for_multiple_connections -extension_gap 16
#preroute_instances  -ignore_macros -ignore_cover_cells -primary_routing_layer pin -extend_for_multiple_connections -extension_gap 16
preroute_instances  -ignore_pads -ignore_cover_cells -primary_routing_layer pin
preroute_standard_cells -extend_for_multiple_connections  -extension_gap 16 -connect horizontal  -remove_floating_pieces  -do_not_route_over_macros  -fill_empty_rows  -port_filter_mode off -cell_master_filter_mode off -cell_instance_filter_mode off -voltage_area_filter_mode off -route_type {P/G Std. Cell Pin Conn}

 ## Futher Constraints (optional)
set_pnet_options -partial "LY E1"
create_fp_placement  -incremental all

###########
# Help Me #
###########
save_mw_cel  -design "${my_design}"
save_mw_cel  -design "${my_design}" -as "design_planning"

