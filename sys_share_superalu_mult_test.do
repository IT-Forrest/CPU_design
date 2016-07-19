onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /SYS_SHARE_SUPERALU_MULT_TEST/scpu_sram_alu/scpu_ctrl_spi/uut/io_datainA
add wave -noupdate /SYS_SHARE_SUPERALU_MULT_TEST/scpu_sram_alu/scpu_ctrl_spi/uut/io_datainB
add wave -noupdate /SYS_SHARE_SUPERALU_MULT_TEST/scpu_sram_alu/scpu_ctrl_spi/uut/nxt
add wave -noupdate /SYS_SHARE_SUPERALU_MULT_TEST/scpu_sram_alu/scpu_ctrl_spi/uut/cpu_suspend
add wave -noupdate /SYS_SHARE_SUPERALU_MULT_TEST/scpu_sram_alu/scpu_ctrl_spi/uut/cpu_restore
add wave -noupdate /SYS_SHARE_SUPERALU_MULT_TEST/scpu_sram_alu/scpu_ctrl_spi/uut/start
add wave -noupdate /SYS_SHARE_SUPERALU_MULT_TEST/scpu_sram_alu/scpu_ctrl_spi/uut/io_status
add wave -noupdate /SYS_SHARE_SUPERALU_MULT_TEST/scpu_sram_alu/scpu_ctrl_spi/uut/io_control
add wave -noupdate /SYS_SHARE_SUPERALU_MULT_TEST/scpu_sram_alu/scpu_ctrl_spi/uut/clk
add wave -noupdate /SYS_SHARE_SUPERALU_MULT_TEST/scpu_sram_alu/scpu_ctrl_spi/uut/code_type
add wave -noupdate /SYS_SHARE_SUPERALU_MULT_TEST/scpu_sram_alu/scpu_ctrl_spi/uut/pc
add wave -noupdate /SYS_SHARE_SUPERALU_MULT_TEST/scpu_sram_alu/scpu_ctrl_spi/uut/io_dataoutA
add wave -noupdate /SYS_SHARE_SUPERALU_MULT_TEST/scpu_sram_alu/scpu_ctrl_spi/uut/io_dataoutB
add wave -noupdate -divider sram
add wave -noupdate /SYS_SHARE_SUPERALU_MULT_TEST/scpu_sram_alu/sram/CEN
add wave -noupdate /SYS_SHARE_SUPERALU_MULT_TEST/scpu_sram_alu/scpu_ctrl_spi/cct/PI
add wave -noupdate /SYS_SHARE_SUPERALU_MULT_TEST/scpu_sram_alu/sram/Q
add wave -noupdate /SYS_SHARE_SUPERALU_MULT_TEST/scpu_sram_alu/sram/A
add wave -noupdate /SYS_SHARE_SUPERALU_MULT_TEST/scpu_sram_alu/sram/D
add wave -noupdate /SYS_SHARE_SUPERALU_MULT_TEST/scpu_sram_alu/scpu_ctrl_spi/cct/RDY
add wave -noupdate -radix unsigned /SYS_SHARE_SUPERALU_MULT_TEST/scpu_sram_alu/scpu_ctrl_spi/cct/cnt_bit_load
add wave -noupdate /SYS_SHARE_SUPERALU_MULT_TEST/scpu_sram_alu/scpu_ctrl_spi/cct/reg_bits
add wave -noupdate /SYS_SHARE_SUPERALU_MULT_TEST/scpu_sram_alu/scpu_ctrl_spi/cct/is_LOAD
add wave -noupdate /SYS_SHARE_SUPERALU_MULT_TEST/fpga/CTRL_SO
add wave -noupdate -radix unsigned /SYS_SHARE_SUPERALU_MULT_TEST/fpga/cnt_bit_load
add wave -noupdate /SYS_SHARE_SUPERALU_MULT_TEST/fpga/reg_sram_all
add wave -noupdate /SYS_SHARE_SUPERALU_MULT_TEST/fpga/is_LOAD
add wave -noupdate /SYS_SHARE_SUPERALU_MULT_TEST/fpga/csi_clk
add wave -noupdate /SYS_SHARE_SUPERALU_MULT_TEST/fpga/reg_LOAD
add wave -noupdate /SYS_SHARE_SUPERALU_MULT_TEST/CLK
add wave -noupdate /SYS_SHARE_SUPERALU_MULT_TEST/scpu_sram_alu/CLK
add wave -noupdate /SYS_SHARE_SUPERALU_MULT_TEST/scpu_sram_alu/scpu_ctrl_spi/CLK
add wave -noupdate -divider alu_module
add wave -noupdate /SYS_SHARE_SUPERALU_MULT_TEST/scpu_sram_alu/scpu_ctrl_spi/ALU_01/X_IN
add wave -noupdate /SYS_SHARE_SUPERALU_MULT_TEST/scpu_sram_alu/scpu_ctrl_spi/ALU_01/Y_IN
add wave -noupdate /SYS_SHARE_SUPERALU_MULT_TEST/scpu_sram_alu/scpu_ctrl_spi/ALU_01/alu_start
add wave -noupdate /SYS_SHARE_SUPERALU_MULT_TEST/scpu_sram_alu/scpu_ctrl_spi/ALU_01/alu_is_done
add wave -noupdate /SYS_SHARE_SUPERALU_MULT_TEST/scpu_sram_alu/scpu_ctrl_spi/ALU_01/FOUT
add wave -noupdate -divider scpu_ctrl_spi_top
add wave -noupdate /SYS_SHARE_SUPERALU_MULT_TEST/scpu_sram_alu/scpu_ctrl_spi/CTRL_BGN
add wave -noupdate /SYS_SHARE_SUPERALU_MULT_TEST/scpu_sram_alu/scpu_ctrl_spi/CEN_after_mux
add wave -noupdate /SYS_SHARE_SUPERALU_MULT_TEST/scpu_sram_alu/scpu_ctrl_spi/LOAD_MUX
add wave -noupdate /SYS_SHARE_SUPERALU_MULT_TEST/scpu_sram_alu/scpu_ctrl_spi/CEN
add wave -noupdate /SYS_SHARE_SUPERALU_MULT_TEST/scpu_sram_alu/scpu_ctrl_spi/CEN_from_SPI
add wave -noupdate /SYS_SHARE_SUPERALU_MULT_TEST/scpu_sram_alu/scpu_ctrl_spi/spi_start
add wave -noupdate /SYS_SHARE_SUPERALU_MULT_TEST/scpu_sram_alu/scpu_ctrl_spi/CEN_spi
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 2} {10087000 ps} 0} {{Cursor 2} {181794 ps} 0}
quietly wave cursor active 1
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
WaveRestoreZoom {10041759 ps} {10132241 ps}
