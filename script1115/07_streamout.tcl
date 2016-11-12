##############
#  Tape Out  #
##############

 ## make sure reconnected total 0 tie highs and 0 tie lows
derive_pg_connection -power_net {VDD} -ground_net {VSS} -power_pin {VDD} -ground_pin {VSS} -tie -create_ports top
derive_pg_connection -power_net {DVDD} -ground_net {DVSS} -power_pin {DVDD} -ground_pin {DVSS} -tie -create_ports top

 ## Automatic Sign-off ##
set_starrcxt_options -exec_dir $star_dir -max_nxtgrd_file $max_grd -min_nxtgrd_file $min_grd -map_file $grd_map
set_primetime_options -exec_dir $pt_dir -sdc_file ${syn_db_dir}/${my_design}.sdc

 ## Opt ## 
 # Do it manually #
# signoff_opt -effort low -num_iteration 0

 ## DRC Check ##
redirect -tee ${icc_rpt_dir}/drc.report {verify_drc}
 
 ## LVS Check ##
redirect -tee ${icc_rpt_dir}/lvs.report {verify_lvs -max_error 1000}

 ## Stream Out ##
set_write_stream_options -output_pin text -map_layer ${icc_gds_layermap} -child_depth 50 -ignore_layer_mapping_for_imported_cells
write_stream -format gds -cells ${my_design} ${icc_db_dir}/${my_design}.gds
return
 ## Name Rule Translation ##
define_name_rules MYNAME_RULE -type port -allowed {A-Z0-9[]_}
#define_name_rules MYNAME_RULE -type port -allowed {A-Z0-9[]_} -equal_ports_nets -first_restricted "0-9_" -last_restricted "_" -max_length 256
define_name_rules MYNAME_RULE -type net -allowed {A-Z0-9[]_}
#define_name_rules MYNAME_RULE -type net -allowed {A-Z0-9[]_} -equal_ports_nets -first_restricted "0-9_" -last_restricted "_" -max_length 256
change_names -rule MYNAME_RULE -hierarchy

 ## Verilog Out ##
write_verilog -pg -unconnected_ports -diode_ports -wire_declaration -no_pad_filler_cells -no_core_filler_cells -supply_statement all ${icc_nlst_dir}/${my_design}.vga
 ## change the file to VGA just for simulation
#write_verilog -pg -unconnected_ports -diode_ports -wire_declaration -no_pad_filler_cells -no_core_filler_cells -no_corner_pad_cells -supply_statement all ${icc_nlst_dir}/${my_design}.vga
#source ${icc_nlst_dir}/chg_vga_name.tcl
#source ${icc_nlst_dir}/remove_vddvss.tcl
 ## export the file without VSS/VDD supply
#write_verilog -no_cover_cells -no_unconnected_cells -no_pad_filler_cells -no_core_filler_cells -no_corner_pad_cells ${icc_nlst_dir}/${my_design}.vga
#source ${icc_nlst_dir}/chg_vga_name.tcl

####################
# Generate reports #
####################

redirect -tee ${icc_rpt_dir}/check_design.report {check_design -one_level}
redirect -tee ${icc_rpt_dir}/check_timing.report {check_timing}
redirect -tee ${icc_rpt_dir}/constraint.report {report_constraints}
redirect -tee ${icc_rpt_dir}/violation.report {report_constraints -all_vio}
redirect -tee ${icc_rpt_dir}/area.report {report_area}
redirect -tee ${icc_rpt_dir}/timing.report {report_timing -path full -nets -input_pins -transition -nosplit -max_paths 10}

 ## Write Database ##
write_def -output "${icc_db_dir}/${my_design}.def"
#write_parasitics -format spef ${icc_db_dir}/${my_design}.spef
write -format ddc -output ${icc_db_dir}/${my_design}.ddc
#write_sdf -version 1.0 -context verilog -load_delay net ${icc_db_dir}/${my_design}.sdf
write_sdf -version 2.1 -context verilog -load_delay net ${icc_db_dir}/${my_design}.sdf
###########
# Help Me #
###########
save_mw_cel  -design "${my_design}"
save_mw_cel  -design "${my_design}" -as "Finish"


