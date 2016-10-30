onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider sram
add wave -noupdate /SCPU_SRAM_8BIT_ALU_SPI_TOP_MUX_VG_TEST/scpu_sram_alu/CLK
add wave -noupdate /SCPU_SRAM_8BIT_ALU_SPI_TOP_MUX_VG_TEST/scpu_sram_alu/RST_N
add wave -noupdate /SCPU_SRAM_8BIT_ALU_SPI_TOP_MUX_VG_TEST/scpu_sram_alu/sram/CLK
add wave -noupdate /SCPU_SRAM_8BIT_ALU_SPI_TOP_MUX_VG_TEST/scpu_sram_alu/sram/CEN
add wave -noupdate /SCPU_SRAM_8BIT_ALU_SPI_TOP_MUX_VG_TEST/scpu_sram_alu/sram/WEN
add wave -noupdate /SCPU_SRAM_8BIT_ALU_SPI_TOP_MUX_VG_TEST/scpu_sram_alu/sram/Q
add wave -noupdate /SCPU_SRAM_8BIT_ALU_SPI_TOP_MUX_VG_TEST/scpu_sram_alu/sram/A
add wave -noupdate /SCPU_SRAM_8BIT_ALU_SPI_TOP_MUX_VG_TEST/scpu_sram_alu/sram/D
add wave -noupdate -divider spi_module
add wave -noupdate /SCPU_SRAM_8BIT_ALU_SPI_TOP_MUX_VG_TEST/CPU_BGN
add wave -noupdate /SCPU_SRAM_8BIT_ALU_SPI_TOP_MUX_VG_TEST/coe_ctrl_bgn_export
add wave -noupdate /SCPU_SRAM_8BIT_ALU_SPI_TOP_MUX_VG_TEST/coe_ctrl_load_export
add wave -noupdate /SCPU_SRAM_8BIT_ALU_SPI_TOP_MUX_VG_TEST/coe_ctrl_si_export
add wave -noupdate /SCPU_SRAM_8BIT_ALU_SPI_TOP_MUX_VG_TEST/coe_ctrl_rdy_export
add wave -noupdate /SCPU_SRAM_8BIT_ALU_SPI_TOP_MUX_VG_TEST/FOUT
add wave -noupdate /SCPU_SRAM_8BIT_ALU_SPI_TOP_MUX_VG_TEST/CFSA_FOUT
add wave -noupdate /SCPU_SRAM_8BIT_ALU_SPI_TOP_MUX_VG_TEST/LAT_dly
add wave -noupdate /SCPU_SRAM_8BIT_ALU_SPI_TOP_MUX_VG_TEST/SCLK1_dly
add wave -noupdate /SCPU_SRAM_8BIT_ALU_SPI_TOP_MUX_VG_TEST/SCLK2_dly
add wave -noupdate /SCPU_SRAM_8BIT_ALU_SPI_TOP_MUX_VG_TEST/SPI_SO_dly
add wave -noupdate -divider ctrl_logic
add wave -noupdate /SCPU_SRAM_8BIT_ALU_SPI_TOP_MUX_VG_TEST/fpga/csi_clk
add wave -noupdate /SCPU_SRAM_8BIT_ALU_SPI_TOP_MUX_VG_TEST/fpga/CTRL_SO
add wave -noupdate -radix unsigned /SCPU_SRAM_8BIT_ALU_SPI_TOP_MUX_VG_TEST/fpga/cnt_bit_load
add wave -noupdate /SCPU_SRAM_8BIT_ALU_SPI_TOP_MUX_VG_TEST/fpga/reg_sram_all
add wave -noupdate /SCPU_SRAM_8BIT_ALU_SPI_TOP_MUX_VG_TEST/fpga/reg_LOAD
add wave -noupdate /SCPU_SRAM_8BIT_ALU_SPI_TOP_MUX_VG_TEST/fpga/reg_ctrl_mode
add wave -noupdate /SCPU_SRAM_8BIT_ALU_SPI_TOP_MUX_VG_TEST/fpga/reg_sram_addr
add wave -noupdate /SCPU_SRAM_8BIT_ALU_SPI_TOP_MUX_VG_TEST/fpga/reg_sram_data
add wave -noupdate /SCPU_SRAM_8BIT_ALU_SPI_TOP_MUX_VG_TEST/fpga/reg_ctrl_bgn_dly
add wave -noupdate /SCPU_SRAM_8BIT_ALU_SPI_TOP_MUX_VG_TEST/fpga/is_LOAD
add wave -noupdate /SCPU_SRAM_8BIT_ALU_SPI_TOP_MUX_VG_TEST/fpga/is_load2_ctrl
add wave -noupdate /SCPU_SRAM_8BIT_ALU_SPI_TOP_MUX_VG_TEST/fpga/is_rfrom_ctrl
add wave -noupdate -divider uut_cpu
add wave -noupdate /SCPU_SRAM_8BIT_ALU_SPI_TOP_MUX_VG_TEST/ADC_PI
add wave -noupdate /SCPU_SRAM_8BIT_ALU_SPI_TOP_MUX_VG_TEST/scpu_sram_alu/scpu_ctrl_spi/ALU_01/X_IN
add wave -noupdate /SCPU_SRAM_8BIT_ALU_SPI_TOP_MUX_VG_TEST/scpu_sram_alu/scpu_ctrl_spi/ALU_01/Y_IN
add wave -noupdate /SCPU_SRAM_8BIT_ALU_SPI_TOP_MUX_VG_TEST/scpu_sram_alu/scpu_ctrl_spi/uut/state
add wave -noupdate /SCPU_SRAM_8BIT_ALU_SPI_TOP_MUX_VG_TEST/scpu_sram_alu/scpu_ctrl_spi/uut/pc
add wave -noupdate /SCPU_SRAM_8BIT_ALU_SPI_TOP_MUX_VG_TEST/scpu_sram_alu/scpu_ctrl_spi/uut/reg_C
add wave -noupdate {/SCPU_SRAM_8BIT_ALU_SPI_TOP_MUX_VG_TEST/scpu_sram_alu/scpu_ctrl_spi/uut/nxt[1]}
add wave -noupdate {/SCPU_SRAM_8BIT_ALU_SPI_TOP_MUX_VG_TEST/scpu_sram_alu/scpu_ctrl_spi/uut/nxt[0]}
add wave -noupdate /SCPU_SRAM_8BIT_ALU_SPI_TOP_MUX_VG_TEST/scpu_sram_alu/scpu_ctrl_spi/put/SCLK1
add wave -noupdate /SCPU_SRAM_8BIT_ALU_SPI_TOP_MUX_VG_TEST/scpu_sram_alu/scpu_ctrl_spi/put/SCLK2
add wave -noupdate /SCPU_SRAM_8BIT_ALU_SPI_TOP_MUX_VG_TEST/scpu_sram_alu/scpu_ctrl_spi/put/LAT
add wave -noupdate /SCPU_SRAM_8BIT_ALU_SPI_TOP_MUX_VG_TEST/scpu_sram_alu/scpu_ctrl_spi/put/SPI_SO
add wave -noupdate /SCPU_SRAM_8BIT_ALU_SPI_TOP_MUX_VG_TEST/scpu_sram_alu/scpu_ctrl_spi/ALU_01/FOUT
add wave -noupdate -radix binary /SCPU_SRAM_8BIT_ALU_SPI_TOP_MUX_VG_TEST/scpu_sram_alu/scpu_ctrl_spi/Q_from_SRAM
add wave -noupdate -radix binary /SCPU_SRAM_8BIT_ALU_SPI_TOP_MUX_VG_TEST/scpu_sram_alu/scpu_ctrl_spi/io_status
add wave -noupdate -radix binary /SCPU_SRAM_8BIT_ALU_SPI_TOP_MUX_VG_TEST/scpu_sram_alu/scpu_ctrl_spi/io_datainA
add wave -noupdate -radix binary /SCPU_SRAM_8BIT_ALU_SPI_TOP_MUX_VG_TEST/scpu_sram_alu/scpu_ctrl_spi/io_datainB
add wave -noupdate -radix binary /SCPU_SRAM_8BIT_ALU_SPI_TOP_MUX_VG_TEST/scpu_sram_alu/scpu_ctrl_spi/i_pc
add wave -noupdate -radix binary /SCPU_SRAM_8BIT_ALU_SPI_TOP_MUX_VG_TEST/scpu_sram_alu/scpu_ctrl_spi/i_reg_C
add wave -noupdate /SCPU_SRAM_8BIT_ALU_SPI_TOP_MUX_VG_TEST/scpu_sram_alu/scpu_ctrl_spi/ALU_01/alu_is_done
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 2} {1238064722 ps} 0} {{Cursor 2} {58125447 ps} 0}
quietly wave cursor active 2
configure wave -namecolwidth 318
configure wave -valuecolwidth 142
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
WaveRestoreZoom {54759159 ps} {62140659 ps}
