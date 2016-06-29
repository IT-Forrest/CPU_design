onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /PSEUDO_SPI_INTF_SCAN_TEST/ADC
add wave -noupdate /PSEUDO_SPI_INTF_SCAN_TEST/CFSA_ADC
add wave -noupdate /PSEUDO_SPI_INTF_SCAN_TEST/LAT_B
add wave -noupdate /PSEUDO_SPI_INTF_SCAN_TEST/SCK1_B
add wave -noupdate /PSEUDO_SPI_INTF_SCAN_TEST/SCK2
add wave -noupdate /PSEUDO_SPI_INTF_SCAN_TEST/SEL_B
add wave -noupdate /PSEUDO_SPI_INTF_SCAN_TEST/SO_B
add wave -noupdate /PSEUDO_SPI_INTF_SCAN_TEST/SIN
add wave -noupdate -divider pseudo_intf
add wave -noupdate /PSEUDO_SPI_INTF_SCAN_TEST/put/CLK
add wave -noupdate /PSEUDO_SPI_INTF_SCAN_TEST/put/SPI_SO
add wave -noupdate /PSEUDO_SPI_INTF_SCAN_TEST/SCLK1
add wave -noupdate /PSEUDO_SPI_INTF_SCAN_TEST/SCLK2
add wave -noupdate /PSEUDO_SPI_INTF_SCAN_TEST/LAT
add wave -noupdate -divider {Scan Cell}
add wave -noupdate /PSEUDO_SPI_INTF_SCAN_TEST/CS208/SIN
add wave -noupdate /PSEUDO_SPI_INTF_SCAN_TEST/CS208/PIN
add wave -noupdate /PSEUDO_SPI_INTF_SCAN_TEST/CS208/SO
add wave -noupdate /PSEUDO_SPI_INTF_SCAN_TEST/CS208/PO
add wave -noupdate /PSEUDO_SPI_INTF_SCAN_TEST/CS208/SEL
add wave -noupdate /PSEUDO_SPI_INTF_SCAN_TEST/CS208/LAT
add wave -noupdate /PSEUDO_SPI_INTF_SCAN_TEST/CS208/BYP_N
add wave -noupdate /PSEUDO_SPI_INTF_SCAN_TEST/tmpi_datain
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {1186500 ps}
