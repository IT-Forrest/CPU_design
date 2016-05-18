###################################
#  Constraint For Design Compiler #
###################################
# Author:	Congyin Shi       #
# Modify:	Jiafan Wang       #
# Version:	1.0 for IBM130    #
# Update:	2016-05-12        #
###################################

##############
# Parameters #
##############

 ## Set wire load model according to tech file
set wl_model ibm13_wl10

 ## Clock Attribute ##
set ck_port CLK
set ck_period 10
set ck_tran 0.5
set ck_latency_max 0
set ck_latency_min 0
set ck_uncertainty 0.2
 ## Set clock/reset/scan_enable/scan_mode network as ideal network ##
set rst_port RST_N
#set fs_path_from [list ${rst_port}]
#set fs_path_to [list i_addr d_addr d_we d_dataout]
#set ideal_net ${fs_path_from}
set ideal_net ${rst_port}
 ## Set port constraint ##
set in_delay 2
set out_delay 2
 ## Set load ##
set drv_cell BUFX6TF
set drv_cell_pin Y
set out_load 0.8
 ## Set global constraint ##
set glb_max_fan 10
set glb_max_tran 1
set glb_op_con ${synopsys_typ_db_name}
#set glb_op_con scx3_cmos8rf_rvt_tt_1p2v_25c

######################
# Constraint Setting #
######################

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
set_min_library ${iopad_max_db_name}.db    -min_version ${iopad_min_db_name}.db
set_min_library ${ibm_sram_max_db_name}.db -min_version ${ibm_sram_min_db_name}.db
set_operating_conditions -min_library ${ibm_sram_min_db_name}.db:RA1SHD_IBM512X8 -min ff_1p32v_m40c -max_library ${ibm_sram_max_db_name}.db:RA1SHD_IBM512X8 -max ss_1p08v_125c -analysis_type on_chip_variation
set_wire_load_mode top

set auto_wire_load_selection "true"

