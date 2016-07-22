onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_TEST/scpu_sram_alu/scpu_ctrl_spi/uut/io_datainA
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_TEST/scpu_sram_alu/scpu_ctrl_spi/uut/io_datainB
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_TEST/scpu_sram_alu/scpu_ctrl_spi/uut/nxt
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_TEST/scpu_sram_alu/scpu_ctrl_spi/uut/cpu_suspend
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_TEST/scpu_sram_alu/scpu_ctrl_spi/uut/cpu_restore
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_TEST/scpu_sram_alu/scpu_ctrl_spi/uut/start
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_TEST/scpu_sram_alu/scpu_ctrl_spi/uut/io_status
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_TEST/scpu_sram_alu/scpu_ctrl_spi/uut/io_control
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_TEST/scpu_sram_alu/scpu_ctrl_spi/uut/clk
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_TEST/scpu_sram_alu/scpu_ctrl_spi/uut/code_type
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_TEST/scpu_sram_alu/scpu_ctrl_spi/uut/id_ir
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_TEST/scpu_sram_alu/scpu_ctrl_spi/uut/pc
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_TEST/scpu_sram_alu/scpu_ctrl_spi/uut/io_dataoutA
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_TEST/scpu_sram_alu/scpu_ctrl_spi/uut/io_dataoutB
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_TEST/scpu_sram_alu/scpu_ctrl_spi/uut/oper1_r1
add wave -noupdate -divider sram
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_TEST/fpga/csi_clk
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_TEST/scpu_sram_alu/sram/CEN
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_TEST/scpu_sram_alu/scpu_ctrl_spi/cct/PI
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_TEST/scpu_sram_alu/sram/Q
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_TEST/scpu_sram_alu/sram/A
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_TEST/scpu_sram_alu/sram/D
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_TEST/scpu_sram_alu/scpu_ctrl_spi/cct/RDY
add wave -noupdate -radix unsigned /SYS_PSEUDO_SPI_INTF_SCAN_TEST/scpu_sram_alu/scpu_ctrl_spi/cct/cnt_bit_load
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_TEST/scpu_sram_alu/scpu_ctrl_spi/cct/reg_bits
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_TEST/scpu_sram_alu/scpu_ctrl_spi/cct/is_LOAD
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_TEST/fpga/CTRL_SO
add wave -noupdate -radix unsigned /SYS_PSEUDO_SPI_INTF_SCAN_TEST/fpga/cnt_bit_load
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_TEST/fpga/reg_sram_all
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_TEST/fpga/reg_LOAD
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_TEST/scpu_sram_alu/scpu_ctrl_spi/CLK
add wave -noupdate -divider spi_module
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_TEST/scpu_sram_alu/scpu_ctrl_spi/put/PI
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_TEST/scpu_sram_alu/scpu_ctrl_spi/put/BGN
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_TEST/scpu_sram_alu/scpu_ctrl_spi/put/sram_addr
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_TEST/scpu_sram_alu/scpu_ctrl_spi/put/sram_regs
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_TEST/scpu_sram_alu/scpu_ctrl_spi/put/spi_state
add wave -noupdate -radix unsigned /SYS_PSEUDO_SPI_INTF_SCAN_TEST/scpu_sram_alu/scpu_ctrl_spi/put/cnt_state
add wave -noupdate -radix unsigned /SYS_PSEUDO_SPI_INTF_SCAN_TEST/scpu_sram_alu/scpu_ctrl_spi/put/cnt_bit_sent
add wave -noupdate -radix unsigned /SYS_PSEUDO_SPI_INTF_SCAN_TEST/scpu_sram_alu/scpu_ctrl_spi/put/cnt_addr_len
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_TEST/scpu_sram_alu/scpu_ctrl_spi/ALU_01/alu_start
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_TEST/scpu_sram_alu/scpu_ctrl_spi/ALU_01/alu_is_done
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_TEST/scpu_sram_alu/scpu_ctrl_spi/ALU_01/FOUT
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_TEST/FOUT
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_TEST/CFSA_FOUT
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_TEST/LAT_dly
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_TEST/SCLK1_dly
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_TEST/SCLK2_dly
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_TEST/scpu_sram_alu/scpu_ctrl_spi/put/spi_MUX
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_TEST/SPI_SO_dly
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_TEST/SPI_SO
add wave -noupdate -radix unsigned /SYS_PSEUDO_SPI_INTF_SCAN_TEST/scpu_sram_alu/scpu_ctrl_spi/put/ADDR_BGN
add wave -noupdate -radix unsigned /SYS_PSEUDO_SPI_INTF_SCAN_TEST/scpu_sram_alu/scpu_ctrl_spi/put/DATA_LEN
add wave -noupdate -divider scpu_ctrl_spi_top
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_TEST/scpu_sram_alu/scpu_ctrl_spi/CTRL_BGN
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_TEST/scpu_sram_alu/scpu_ctrl_spi/CEN_after_mux
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_TEST/scpu_sram_alu/scpu_ctrl_spi/LOAD_MUX
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_TEST/scpu_sram_alu/scpu_ctrl_spi/CEN
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_TEST/scpu_sram_alu/scpu_ctrl_spi/CEN_from_SPI
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_TEST/scpu_sram_alu/scpu_ctrl_spi/spi_start
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_TEST/scpu_sram_alu/scpu_ctrl_spi/CEN_spi
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 2} {1238064722 ps} 0} {{Cursor 2} {14298003 ps} 0}
quietly wave cursor active 2
configure wave -namecolwidth 276
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
WaveRestoreZoom {14173842 ps} {14448158 ps}
