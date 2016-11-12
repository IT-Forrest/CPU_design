###################################
#  Formality Verification Script  #
#        After IC Compiler        #
###################################
# Author:	Congyin Shi       #
# Version:	2.0               #
# Update:	2010-08-23        #
###################################

 ## Setup Environment ##
source ./script/common.tcl

set hdlin_warn_on_mismatch_message "FMR_VHDL-1002 FMR_VHDL-1027 FMR_VHDL-1014 FMR_ELAB-146 FMR_ELAB-147 FMR_ELAB-149 FMR_ELAB-130 FMR_ELAB-117 FMR_ELAB-034 FMR_ELAB-261 FMR_VLOG-079"

set verification_inversion_push true

##############
# Load Files #
##############

 ## Load SVF Files ##
set_svf -append ${syn_db_dir}/${my_design}.svf

 ## Load Reference ##
set all_verilog [ls ./src/*.v]

redirect -tee ${fm_rpt_dir}/post_ref.report {read_verilog -container r -libname WORK -01 ${all_verilog}}

set_top r:/WORK/${my_design} 

 ## Load Implementation
redirect -tee ${fm_rpt_dir}/post_vga.report {read_verilog -container i -libname WORK -01 ${icc_nlst_dir}/${my_design}.vga}

read_db ${synopsys_typ_db_name}.db

set_top i:/WORK/${my_design}

##########
# Verify #
##########

redirect -tee ${fm_rpt_dir}/post_match_brief.report {match}
redirect -tee ${fm_rpt_dir}/post_verify_brief.report {verify}
report_matched > ${fm_rpt_dir}/post_matched.report
redirect -tee ${fm_rpt_dir}/post_unmatched.report {report_unmatched}
redirect -tee ${fm_rpt_dir}/post_failing.report {report_failing}

 ## Save Session ##
save_session -replace ${fm_db_dir}/${my_design}_post.fss
