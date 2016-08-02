###################################
#     Single Module P&R Script    #
#         For IC Compiler         #
###################################
# Author:	Jiafan Wang           #
# Update:	2016-05               #
###################################

 ## Setup Environment ##
if {![info exists script_path]} {
set script_path  "../script815"
#set script_path  "../script"
source ${script_path}/all_common.tcl
}

############
# ICC Flow #
############

source ${script_path}/01_design_setup.tcl
source ${script_path}/02_design_planning.tcl
source ${script_path}/03_placement.tcl
source ${script_path}/04_cts.tcl
source ${script_path}/05_route.tcl
source ${script_path}/06_dfm.tcl
source ${script_path}/07_streamout.tcl
#source ../scripts/08_outputfile.tcl


