###################################
#  Formality Verification Script  #
#      After Design Compiler      #
###################################
# Author:	Jiafan Wang       #
# Version:	1.0               #
# Update:	2016-10-27        #
###################################

 ## Setup Environment ##
set src_path    "../src1115"
set script_path "../script1115"
#source ./script/common.tcl
#source ./script/common_scan.tcl
source ${script_path}/all_common.tcl

set hdlin_warn_on_mismatch_message "FMR_VHDL-1002 FMR_VHDL-1027 FMR_VHDL-1014 FMR_ELAB-146 FMR_ELAB-147 FMR_ELAB-149 FMR_ELAB-130 FMR_ELAB-117 FMR_ELAB-034 FMR_ELAB-261 FMR_VLOG-079 FMR_VLOG-087"

set verification_inversion_push true

##############
# Load Files #
##############

 ## Load SVF Files ##
set_svf -append ${syn_db_dir}/${my_design}.svf

 ## Load Reference ##
#set all_verilog [ls ./src/*.v]
#set all_verilog [ls ${src_path}/*.v]
set all_verilog [list \
    ${src_path}/ibm13rfrvt_neg.v \
    ${src_path}/DEFINE_CPU.v \
    ${src_path}/SERIAL_CPU_8bit.v \
    ${src_path}/SRAM_IO_CTRL.v \
    ${src_path}/SHARE_SUPERALU.v \
    ${src_path}/PSEUDO_SPI_INTF.v \
    ${src_path}/SCPU_8BIT_ALU_CTRL_SPI.v \
    ${src_path}/SCPU_SRAM_8BIT_ALU_SPI_TOP.v \
]
###redirect -tee ${syn_rpt_dir}/read_files.report {read_verilog ${all_verilog}}
#    ${src_path}/RA1SHD_IBM1024X8.v \
#redirect -tee ${syn_rpt_dir}/read_files.report {read_verilog ${src_path}/DEFINE_CPU.v}
#redirect -tee ${syn_rpt_dir}/read_files.report {read_verilog ${src_path}/SERIAL_CPU_8bit.v}
#redirect -tee ${syn_rpt_dir}/read_files.report {read_verilog ${src_path}/SRAM_IO_CTRL.v}
#redirect -tee ${syn_rpt_dir}/read_files.report {read_verilog ${src_path}/SHARE_SUPERALU.v}
#redirect -tee ${syn_rpt_dir}/read_files.report {read_verilog ${src_path}/PSEUDO_SPI_INTF.v}
#redirect -tee ${syn_rpt_dir}/read_files.report {read_verilog ${src_path}/SCPU_8BIT_ALU_CTRL_SPI.v}
#redirect -tee ${syn_rpt_dir}/read_files.report {read_verilog ${src_path}/SCPU_SRAM_8BIT_ALU_SPI_TOP.v}
#

redirect -tee ${fm_rpt_dir}/pre_ref.report {read_verilog -container r -libname WORK -01 ${all_verilog}}

read_db ${ibm_sram_typ_db_name}.db
read_db ${iopad_typ_db_name}.db
#read_db { /home/grads/j/jiafan0420/ECEN468/CPU_design/macros/RA1SHD_IBM1024X8_ss_1p08v_125c_syn.db /home/grads/j/jiafan0420/ECEN468/CPU_design/macros/RA1SHD_IBM1024X8_tt_1p2v_25c_syn.db }

set_top r:/WORK/${my_design} 

 ## Load Implementation
read_ddc -container i ${syn_db_dir}/${my_design}.ddc

read_db ${synopsys_typ_db_name}.db

set_top i:/WORK/${my_design}

##########
# Verify #
##########

redirect -tee ${fm_rpt_dir}/pre_match_brief.report {match}
redirect -tee ${fm_rpt_dir}/pre_verify_brief.report {verify}
report_matched > ${fm_rpt_dir}/pre_matched.report
redirect -tee ${fm_rpt_dir}/pre_unmatched.report {report_unmatched}
redirect -tee ${fm_rpt_dir}/pre_failing.report {report_failing}

 ## Save Session ##
save_session -replace ${fm_db_dir}/${my_design}.fss

