###################################
# Single Module Synthesize Script #
#      For Design Compiler        #
###################################
# Author:	Congyin Shi       #
# Version:	1.2               #
# Update:	2010-05-07        #
###################################

 ## Setup Environment ##
if {![info exists script_path]} {
set script_path  "../script_130"
#set script_path  "../script"
source ${script_path}/all_common.tcl
}

######################
# Pre-syn Processing #
######################

 ## Set SVF Report for Formality ##
set_svf ${syn_db_dir}/${my_design}.svf

 ## 2 Ways to Read Files ##
##set all_verilog [list \
##    ./src/DEFINE_CPU.v \
##    ./src/PIPE_CPU.v \
##    ./src/CTRL_LOGIC.v \
##    ./src/SHARE_SUPERALU.v \
##    ./src/SA_4D_DEFINE_418.v \
##    ./src/SA_4D_CTRL_PATH_418.v \
##    ./src/SA_4D_DATA_PATH_418.v \
##    ./src/SA_4D_TOP_LEVEL_418.v \
##    ./src/PCPU_SA_TOP_LEVEL.v \
##]
##redirect -tee ${syn_rpt_dir}/read_files.report {read_verilog ${all_verilog}}

redirect -tee ${syn_rpt_dir}/read_files.report {read_verilog ./src/DEFINE_CPU.v}
##redirect -tee ${syn_rpt_dir}/read_files.report {read_verilog ./src/PIPE_CPU.v}
redirect -tee ${syn_rpt_dir}/read_files.report {read_verilog ./src/SERIAL_CPU_8bit.v}
redirect -tee ${syn_rpt_dir}/read_files.report {read_verilog ./src/SRAM_IO_CTRL.v}
redirect -tee ${syn_rpt_dir}/read_files.report {read_verilog ./src/SHARE_SUPERALU.v}
redirect -tee ${syn_rpt_dir}/read_files.report {read_verilog ./src/CTRL_LOGIC.v}
redirect -tee ${syn_rpt_dir}/read_files.report {read_verilog ./src/SCPU_8BIT_ALU_CTRL.v}
redirect -tee ${syn_rpt_dir}/read_files.report {read_verilog ./src/SCPU_SRAM_8BIT_ALU_TOP.v}
#redirect -tee ${syn_rpt_dir}/read_files.report {read_verilog ./src/SA_4D_DEFINE_418.v}
#redirect -tee ${syn_rpt_dir}/read_files.report {read_verilog ./src/SA_4D_CTRL_PATH_418.v}
#redirect -tee ${syn_rpt_dir}/read_files.report {read_verilog ./src/SA_4D_DATA_PATH_418.v}
#redirect -tee ${syn_rpt_dir}/read_files.report {read_verilog ./src/SA_4D_TOP_LEVEL_418.v}
#redirect -tee ${syn_rpt_dir}/read_files.report {read_verilog ./src/PCPU_SA_TOP_LEVEL.v}


 ## Design Preprocess ##
current_design ${my_design}
redirect -tee ${syn_rpt_dir}/uniquify.report {uniquify}

#####################
# Timing Constraint #
#####################

##source ../script/BD_SPI.script
source ${script_path}/syn_constraint.tcl

##############
# Synthesize #
##############

set_wire_load_model -name ${wl_model}

 ## Avoid the generation of 'assign' or 'tran'
 ## statement in the Verilog netlist
set_fix_multiple_port_nets -feedthrough -output -buffer_constants

 ## Compile ##
redirect -tee ${syn_rpt_dir}/compile.report {compile_ultra}
#{compile_ultra}
#{compile}

###################
# Post-processing #
###################

 ## Write DDC Datebase ##
write -format ddc -hier -output ${syn_db_dir}/${my_design}.ddc

 ## Name Rule Translation ##
define_name_rules MYNAME_RULE -type port -allowed {A-Z0-9[]_} -equal_ports_nets -first_restricted "0-9_" -last_restricted "_" -max_length 256
define_name_rules MYNAME_RULE -type net -allowed {A-Z0-9[]_} -equal_ports_nets -first_restricted "0-9_" -last_restricted "_" -max_length 256
change_names -rule MYNAME_RULE -hierarchy

 ## Output Verilog Netlist ##
write -format verilog -hier -output ${syn_nlst_dir}/${my_design}.vg

 ## Output SDC File ##
write_sdc ${syn_db_dir}/${my_design}.sdc

 ## Output SDF File ##
write_sdf ${syn_db_dir}/${my_design}.sdf

 ## Generate reports ##
redirect -tee ${syn_rpt_dir}/check_design.report {check_design -one_level}
redirect -tee ${syn_rpt_dir}/check_timing.report {check_timing}
redirect -tee ${syn_rpt_dir}/constraint.report {report_constraints}
redirect -tee ${syn_rpt_dir}/violation.report {report_constraints -all_vio}
redirect -tee ${syn_rpt_dir}/area.report {report_area}
redirect -tee ${syn_rpt_dir}/timing.report {report_timing -path full -nets -input_pins -transition -nosplit -max_paths 10}

