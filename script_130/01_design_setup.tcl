###################################
#     Single Module P&R Script    #
#      For Design Compiler        #
###################################
# Author:	Jiafan Wang           #
# Update:	2016-05               #
###################################

 ## User-defined Paths ##
#set library_path "/disk/amsc/TSMC_PDK/TSMCHOME/digital/Front_End"
set library_path "/disk/amsc/IBM_PDK/cmrf8sf/digital/RVt/aci/sc-x"
set synopsys_db_path ${library_path}/synopsys
set synopsys_sdb_path ${library_path}/symbols/synopsys
set synopsys_max_db_name scx3_cmos8rf_rvt_ss_1p08v_125c
set synopsys_min_db_name scx3_cmos8rf_rvt_ff_1p32v_m40c
set synopsys_typ_db_name scx3_cmos8rf_rvt_tt_1p2v_25c

set iopad_path  "/disk/amsc/IBM_PDK/cmrf8sf/digital/RVt/aci/io"
set iopad_db_path   ${iopad_path}/synopsys
set iopad_sdb_path  ${iopad_path}/symbols/synopsys
set iopad_max_db_name iogpil_cmrf8sf_rvt_ss_1p08v_2p3v_125c  
set iopad_min_db_name iogpil_cmrf8sf_rvt_ff_1p32v_2p7v_m40c
set iopad_typ_db_name iogpil_cmrf8sf_rvt_tt_1p2v_2p5v_25c

set macro_db_path "./macros"
set ibm_sram_max_db_name RA1SHD_IBM512X8_ss_1p08v_125c_syn
set ibm_sram_min_db_name RA1SHD_IBM512X8_ff_1p32v_m40c_syn
set ibm_sram_typ_db_name RA1SHD_IBM512X8_tt_1p2v_25c_syn

# icc library_path
set apollo_path ${library_path}/astro
set icc_tech_file ${apollo_path}/tf/ibm13_8lm_2thick_3rf.tf
set icc_ref_lib /homes/grad/scytulip/digital/ibm130/ibm13rfrvt_fram_update
set icc_pad_dir /disk/amsc/IBM_PDK/cmrf8sf/digital/RVt/aci/io/apollo
set icc_pad_lib ${icc_pad_dir}/iogpil_cmrf8sf_rvt_M2_3_3

set icc_tech_dir /disk/amsc/IBM_PDK/cmrf8sf/digital/tech/cmos8rf_synopsys_20100416/synopsys/v.20100416
set icc_maxtlu_file ${icc_tech_dir}/tluplus/cmos8rf_8MA_32_FuncCmax.tluplus
set icc_mintlu_file ${icc_tech_dir}/tluplus/cmos8rf_8MA_32_FuncCmin.tluplus
set icc_tlu_map ${icc_tech_dir}/tluplus/cmos8rf_8MA_32.icc_maskname.map

# Path Configuration
set search_path [list . ${synopsys_root}/libraries/syn ${synopsys_root}/dw/sim_ver ${synopsys_db_path} ${iopad_db_path} ${macro_db_path}]
set target_library  [list ${synopsys_typ_db_name}.db ${synopsys_max_db_name}.db ${iopad_typ_db_name}.db ${iopad_max_db_name}.db ${ibm_sram_typ_db_name}.db ${ibm_sram_max_db_name}.db]
set symbol_library  [list ${synopsys_sdb_path}/ibm13rfrvt.sdb ${iopad_sdb_path}/iogpil_cmrf8sf_rvt.sdb]
set synthetic_library  ""
set link_library "* $target_library $synthetic_library"

 ## Set Dual TA Library
set_min_library ${synopsys_max_db_name}.db -min_version ${synopsys_min_db_name}.db
set_min_library ${iopad_max_db_name}.db -min_version ${iopad_min_db_name}.db
set_min_library ${ibm_sram_max_db_name}.db -min_version ${ibm_sram_min_db_name}.db

 ## Create the SRAM Library 
# create_mw_lib  -technology ${icc_tech_file} -bus_naming_style {[%d]} -open SRAM
# invoke Milkyway to convert lef to CEL & FRAM

create_mw_lib  -technology ${icc_tech_file} -mw_reference_library [list ${icc_ref_lib} ${icc_pad_lib} ./SRAM] -bus_naming_style {[%d]}  -open CHIP

# create_mw_lib  -technology /disk/amsc/IBM_PDK/cmrf8sf/digital/RVt/aci/sc-x/astrotf/ibm13_8lm_2thick_3rf.tf 
# -mw_reference_library [list /homes/grad/scytulip/digital/ibm130/ibm13rfrvt_fram_update
# /disk/amsc/IBM_PDK/cmrf8sf/digital/RVt/aci/io/apollo/iogpil_cmrf8sf_rvt_M2_3_3] -bus_naming_style {[%d]}  -open CHIP

#create_mw_lib  -technology ../tech/NangateOpenCellLibrary.tf -mw_reference_library {../physical_lib/NangateOpenCellLibrary ../physical_lib/RF_2P_ADV64_16 ../physical_lib/tpz} -bus_naming_style {[%d]}  -open  CHIP
#open_mw_lib ../run/CHIP
import_designs -format verilog -top SCPU_SRAM_8BIT_ALU_TOP -cel SCPU_SRAM_8BIT_ALU_TOP {../syn/netlist/SCPU_SRAM_8BIT_ALU_TOP.vg}
#set_tlu_plus_files -max_tluplus ../tluplus/NangateOpenCellLibrary.tluplus -tech2itf_map  ../tluplus/NangateOpenCellLibrary.map
set_tlu_plus_files -max_tluplus ${icc_maxtlu_file} -min_tluplus ${icc_mintlu_file}  -tech2itf_map  ${icc_tlu_map}
read_sdc  -version 1.8 "../syn/database/SCPU_SRAM_8BIT_ALU_TOP.sdc"
save_mw_cel  -design "CHIP"
save_mw_cel  -design "CHIP" -as "design_setup"
