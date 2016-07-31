onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider sram
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_TEST/scpu_sram_alu/CLK
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_TEST/scpu_sram_alu/RST_N
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_TEST/scpu_sram_alu/sram/CLK
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_TEST/scpu_sram_alu/sram/CEN
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_TEST/scpu_sram_alu/sram/WEN
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_TEST/scpu_sram_alu/sram/Q
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_TEST/scpu_sram_alu/sram/A
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_TEST/scpu_sram_alu/sram/D
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_TEST/scpu_sram_alu/scpu_ctrl_spi/uut/state
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_TEST/scpu_sram_alu/scpu_ctrl_spi/uut/next_state
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_TEST/scpu_sram_alu/scpu_ctrl_spi/i_addr
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_TEST/scpu_sram_alu/scpu_ctrl_spi/d_addr
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_TEST/scpu_sram_alu/scpu_ctrl_spi/uut/is_i_addr
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_TEST/scpu_sram_alu/scpu_ctrl_spi/uut/pc
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_TEST/scpu_sram_alu/scpu_ctrl_spi/uut/reg_C
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_TEST/scpu_sram_alu/scpu_ctrl_spi/ADC_PI
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_TEST/scpu_sram_alu/scpu_ctrl_spi/uut/io_datainA
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_TEST/scpu_sram_alu/scpu_ctrl_spi/uut/ALUo
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_TEST/scpu_sram_alu/scpu_ctrl_spi/X_IN
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_TEST/scpu_sram_alu/scpu_ctrl_spi/Y_IN
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_TEST/scpu_sram_alu/scpu_ctrl_spi/uut/reg_A
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_TEST/scpu_sram_alu/scpu_ctrl_spi/uut/reg_B
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_TEST/scpu_sram_alu/scpu_ctrl_spi/uut/code_type
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_TEST/scpu_sram_alu/scpu_ctrl_spi/uut/i_datain
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_TEST/scpu_sram_alu/scpu_ctrl_spi/uut/id_ir
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_TEST/scpu_sram_alu/scpu_ctrl_spi/uut/gr
add wave -noupdate -divider spi_module
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_TEST/CPU_BGN
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_TEST/coe_ctrl_bgn_export
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_TEST/coe_ctrl_load_export
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_TEST/coe_ctrl_si_export
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_TEST/coe_ctrl_rdy_export
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_TEST/FOUT
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_TEST/CFSA_FOUT
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_TEST/LAT_dly
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_TEST/SCLK1_dly
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_TEST/SCLK2_dly
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_TEST/SPI_SO_dly
add wave -noupdate -divider ctrl_logic
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_TEST/fpga/csi_clk
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_TEST/fpga/CTRL_SO
add wave -noupdate -radix unsigned /SYS_PSEUDO_SPI_INTF_SCAN_TEST/fpga/cnt_bit_load
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_TEST/fpga/reg_sram_all
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_TEST/fpga/reg_LOAD
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_TEST/fpga/reg_ctrl_mode
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_TEST/fpga/reg_sram_addr
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_TEST/fpga/reg_sram_data
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_TEST/fpga/reg_ctrl_bgn_dly
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_TEST/fpga/is_LOAD
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_TEST/fpga/is_load2_ctrl
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_TEST/fpga/is_rfrom_ctrl
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_TEST/scpu_sram_alu/CPU_BGN
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_TEST/scpu_sram_alu/NXT
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_TEST/scpu_sram_alu/i_NXT
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_TEST/scpu_sram_alu/scpu_ctrl_spi/uut/nxt
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_TEST/scpu_sram_alu/scpu_ctrl_spi/uut/rst_n
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_TEST/scpu_sram_alu/scpu_ctrl_spi/uut/start
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_TEST/scpu_sram_alu/scpu_ctrl_spi/alu_is_done
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_TEST/scpu_sram_alu/scpu_ctrl_spi/alu_start
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_TEST/scpu_sram_alu/scpu_ctrl_spi/uut/start
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_TEST/scpu_sram_alu/scpu_ctrl_spi/uut/rst_n
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_TEST/CPU_BGN
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 2} {13493844 ps} 0} {{Cursor 2} {416837 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 318
configure wave -valuecolwidth 185
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
WaveRestoreZoom {14248090 ps} {14365890 ps}
