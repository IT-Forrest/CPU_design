
#################
#  Verification #
#################

 ## DRC Check
verify_drc -read_cell_view

 ## Manually Fix DRC Problem If Needed !!!

 ## LVS Check (Ignore Floating Points)
verify_lvs

 ## Insert Standard Cell Fillers
insert_stdcell_filler  -cell_without_metal "FILL64TF FILL32TF FILL16TF FILL8TF FILL4TF FILL2TF FILL1TF"
 ## Make Sure No Fillers Exists Around Macros
#remove_stdcell_filler  -stdcell -bounding_box {{552.990 587.720} {786.640 771.530}}
remove_stdcell_filler  -stdcell -pad -bounding_box {{405.090 574.740} {616.340 734.410}}
#source ../scripts/addCoreFiller.cmd
#insert_metal_filler  -out self

 ## In Case DRC Violation
verify_zrt_route
#route_zrt_detail -incremental true -initial_drc_from_input true 

report_timing
report_constraint -all

 ## Power Connections In Case Additional Cells Added
derive_pg_connection -power_net {VDD} -ground_net {VSS} -power_pin {VDD} -ground_pin {VSS}
derive_pg_connection -power_net {DVDD} -ground_net {DVSS} -power_pin {DVDD} -ground_pin {DVSS}

 ## Manually Add IO Text to Power Rings and IO Pads 
#source ../scripts/add_io_text.tcl
#add_io_text metal7 5 portName

 ## Add Bondpads
#source ../scripts/createNplace_bondpads.tcl
#createNplace_bondpads 	-inline_pad_ref_name BONDINNER -stagger true -stagger_pad_ref_name BONDOUTER


###########
# Help Me #
###########
save_mw_cel  -design "${my_design}"
save_mw_cel  -design "${my_design}" -as "dfm"

