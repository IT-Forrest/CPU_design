onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider sram
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_FPGA_TEST/fpga/scpu_sram_alu/CLK
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_FPGA_TEST/fpga/scpu_sram_alu/RST_N
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_FPGA_TEST/fpga/scpu_sram_alu/sram/CLK
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_FPGA_TEST/fpga/scpu_sram_alu/sram/CEN
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_FPGA_TEST/fpga/scpu_sram_alu/sram/WEN
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_FPGA_TEST/fpga/scpu_sram_alu/sram/Q
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_FPGA_TEST/fpga/scpu_sram_alu/sram/A
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_FPGA_TEST/fpga/scpu_sram_alu/sram/D
add wave -noupdate -divider spi_module
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_FPGA_TEST/CPU_BGN
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_FPGA_TEST/coe_ctrl_bgn_export
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_FPGA_TEST/coe_ctrl_load_export
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_FPGA_TEST/coe_ctrl_si_export
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_FPGA_TEST/coe_ctrl_rdy_export
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_FPGA_TEST/FOUT
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_FPGA_TEST/CFSA_FOUT
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_FPGA_TEST/LAT_dly
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_FPGA_TEST/SCLK1_dly
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_FPGA_TEST/SCLK2_dly
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_FPGA_TEST/SPI_SO_dly
add wave -noupdate -divider ctrl_logic
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_FPGA_TEST/fpga/csi_clk
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_FPGA_TEST/fpga/CTRL_SO
add wave -noupdate -radix unsigned /SYS_PSEUDO_SPI_INTF_SCAN_FPGA_TEST/fpga/cnt_bit_load
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_FPGA_TEST/fpga/reg_sram_all
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_FPGA_TEST/fpga/reg_LOAD
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_FPGA_TEST/fpga/reg_ctrl_mode
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_FPGA_TEST/fpga/reg_sram_addr
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_FPGA_TEST/fpga/reg_sram_data
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_FPGA_TEST/fpga/is_LOAD
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_FPGA_TEST/fpga/is_load2_ctrl
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_FPGA_TEST/fpga/is_rfrom_ctrl
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_FPGA_TEST/fpga/reg_RST
add wave -noupdate -divider fpga
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_FPGA_TEST/fpga/reg_CLK
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_FPGA_TEST/fpga/LOAD_N_dly
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_FPGA_TEST/fpga/reg_TEST_MUX
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 2} {1238064722 ps} 0} {{Cursor 2} {150833 ps} 0}
quietly wave cursor active 2
configure wave -namecolwidth 318
configure wave -valuecolwidth 89
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
WaveRestoreZoom {0 ps} {273 ns}
