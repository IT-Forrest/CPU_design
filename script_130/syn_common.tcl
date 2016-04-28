###################################
#   Synopsys Tool Common Script   #
#      For Design Compiler        #
###################################
# Author:	Congyin Shi       #
# Version:	1.0 for IBM018    #
# Update:	2014-02-19        #
###################################

# Set Environment #

set link_force_case  "check_reference"

 ## User-defined Paths ##
#set library_path "/disk/amsc/TSMC_PDK/TSMCHOME/digital/Front_End"
set library_path "/disk/amsc/IBM_PDK/cmrf8sf/digital/RVt/aci/sc-x"
set synopsys_db_path ${library_path}/synopsys
set synopsys_sdb_path ${library_path}/symbols/synopsys
set synopsys_max_db_name scx3_cmos8rf_rvt_ss_1p08v_125c
set synopsys_min_db_name scx3_cmos8rf_rvt_ff_1p32v_m40c
set synopsys_typ_db_name scx3_cmos8rf_rvt_tt_1p2v_25c

set macro_db_path "./macros"
set ibm_sram_max_db_name RA1SHD_IBM512X8_ss_1p08v_125c_syn
set ibm_sram_min_db_name RA1SHD_IBM512X8_ff_1p32v_m40c_syn
set ibm_sram_typ_db_name RA1SHD_IBM512X8_tt_1p2v_25c_syn

set search_path [list . ${synopsys_root}/libraries/syn ${synopsys_root}/dw/sim_ver ${synopsys_db_path} ${macro_db_path}]

 ## Set libraries
set target_library  [list ${synopsys_db_path}/${synopsys_typ_db_name}.db ${synopsys_db_path}/${synopsys_max_db_name}.db ${synopsys_db_path}/${synopsys_min_db_name}.db ${ibm_sram_typ_db_name}.db ${ibm_sram_max_db_name}.db ${ibm_sram_min_db_name}.db]
set symbol_library  ${synopsys_sdb_path}/ibm13rfrvt.sdb
set synthetic_library  ""
set link_library "* $target_library $synthetic_library"
 
 ## Set wire load model
set wl_model ibm13_wl10

# Build Directory Structure #

 ## Set Directory Structure Environment ##
set syn_dir "./syn"
set syn_db_dir "./syn/database"
set syn_nlst_dir "./syn/netlist"
set syn_rpt_dir "./syn/report"

set icc_dir "./icc"
set icc_db_dir "./icc/database"
set icc_nlst_dir "./icc/netlist"
set icc_rpt_dir "./icc/report"

set fm_dir "./fm"
set fm_db_dir "./fm/database"
set fm_rpt_dir "./fm/report"

 ## Create Directories ##
if {![file exist $syn_dir]} {sh mkdir $syn_dir}
if {![file exist $syn_db_dir]} {sh mkdir $syn_db_dir}
if {![file exist $syn_nlst_dir]} {sh mkdir $syn_nlst_dir}
if {![file exist $syn_rpt_dir]} {sh mkdir $syn_rpt_dir}

if {![file exist $icc_dir]} {sh mkdir $icc_dir}
if {![file exist $icc_db_dir]} {sh mkdir $icc_db_dir}
if {![file exist $icc_nlst_dir]} {sh mkdir $icc_nlst_dir}
if {![file exist $icc_rpt_dir]} {sh mkdir $icc_rpt_dir}

if {![file exist $fm_dir]} {sh mkdir $fm_dir}
if {![file exist $fm_db_dir]} {sh mkdir $fm_db_dir}
if {![file exist $fm_rpt_dir]} {sh mkdir $fm_rpt_dir}

 ## My Design ##
#set my_design PCPU_SA_TOP_LEVEL
set my_design SCPU_SRAM_8BIT_ALU_TOP

##################################
# Parameters for Design Compiler #
##################################

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
set in_delay 1
set out_delay 1.9
 ## Set load ##
set drv_cell BUFX6TF
set drv_cell_pin Y
set out_load 0.8
 ## Set global constraint ##
set glb_max_fan 30
set glb_max_tran 1
# set glb_max_cap 0
set glb_op_con ${synopsys_typ_db_name}
#set glb_op_con scx3_cmos8rf_rvt_tt_1p2v_25c

##############################
# Parameters for IC Compiler #
##############################
set icc_tech_dir /disk/amsc/IBM_PDK/cmrf8sf/digital/tech/cmos8rf_synopsys_20100416/synopsys/v.20100416
set icc_max_lib ${synopsys_max_db_name}.db
set icc_min_lib ${synopsys_min_db_name}.db
set apollo_path ${library_path}/astro
set icc_tech_file ${apollo_path}/tf/ibm13_8lm_2thick_3rf.tf
set icc_plib_file ${apollo_path}/plib/ibm13_8lm_2thick_3rf.plib
#set icc_ref_lib ${apollo_path}/ibm13rfrvt_fram
set icc_ref_lib /homes/grad/scytulip/digital/ibm130/ibm13rfrvt_fram_update
set icc_tdf_file ./src/${my_design}.tdf
set icc_maxtlu_file ${icc_tech_dir}/tluplus/cmos8rf_8MA_32_FuncCmax.tluplus
set icc_mintlu_file ${icc_tech_dir}/tluplus/cmos8rf_8MA_32_FuncCmin.tluplus
set icc_tlu_map ${icc_tech_dir}/tluplus/cmos8rf_8MA_32.icc_maskname.map
set icc_gds_layermap ${apollo_path}/gds2OutLayer_8lm_2thick_3rf.map

#############
# ECO Usage #
#############
set pt_dir /softwares/Common/synopsys/PTStandalone_D-2009.12/amd64/syn/bin
set star_dir /softwares/Common/synopsys/StarRC_vD-2010.06/bin
set max_grd ${icc_tech_dir}/nxtgrd/cmos8rf_8MA_32_FuncCmax.nxtgrd
set min_grd ${icc_tech_dir}/nxtgrd/cmos8rf_8MA_32_FuncCmin.nxtgrd
set grd_map ${icc_tech_dir}/nxtgrd/cmos8rf_8MA_32.star.map


