###################
# Constraint File #
###################

 ## Specify the clock attribute ##
create_clock -period ${ck_period} -waveform "0 [expr ${ck_period}/2]" -name ${ck_port} [get_ports ${ck_port}]

set_clock_uncertainty ${ck_uncertainty} [get_clocks ${ck_port}]
set_clock_transition ${ck_tran} [get_clocks ${ck_port}]
set_clock_latency ${ck_latency_max} -max [get_clocks ${ck_port}]
set_clock_latency ${ck_latency_min} -min [get_clocks ${ck_port}]

 ## Specify port attribute ##
set_input_delay ${in_delay} -clock ${ck_port} [remove_from_collection [all_inputs] ${ck_port}]

set_output_delay ${out_delay} -clock ${ck_port} [all_outputs]

 ## Specify ideal network ##
set_ideal_network [get_ports ${ideal_net}]
#set_max_delay
#set_min_delay

 ## Specify false paths ##
#set_false_path -from [get_ports ${fs_path_from}]
#set_false_path -to [get_ports ${fs_path_to}]

 ## Define the drving cell
#set_driving_cell -library ${synopsys_typ_db_name} -lib_cel ${drv_cell} -pin ${drv_cell_pin} [remove_from_collection [all_inputs] [get_ports ${ideal_net}]]

 ## Define the output load
set_load ${out_load} [all_outputs]

 ## Define global constraint ##
set_max_fanout ${glb_max_fan} $my_design
set_max_transition ${glb_max_tran} $my_design
#set_max_capacitance ${glb_max_cap} $my_design
#set_max_capacitance 2 SCPU_8BIT_ALU_CTRL
#set_operating_conditions ${glb_op_con}
set_min_library ${synopsys_max_db_name}.db -min_version ${synopsys_min_db_name}.db
set_min_library ${ibm_sram_max_db_name}.db -min_version ${ibm_sram_min_db_name}.db
set_min_library ${iopad_max_db_name}.db -min_version ${iopad_min_db_name}.db
set_operating_conditions -min_library ${ibm_sram_min_db_name}.db:RA1SHD_IBM512X8 -min ff_1p32v_m40c -max_library ${ibm_sram_max_db_name}.db:RA1SHD_IBM512X8 -max ss_1p08v_125c -analysis_type on_chip_variation
set_wire_load_mode top
set auto_wire_load_selection "true"

