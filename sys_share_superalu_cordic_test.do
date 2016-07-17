onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider cpu_info
add wave -noupdate /SYS_SHARE_SUPERALU_CORDIC_TEST/scpu_sram_alu/scpu_ctrl_spi/uut/state
add wave -noupdate /SYS_SHARE_SUPERALU_CORDIC_TEST/scpu_sram_alu/scpu_ctrl_spi/uut/next_state
add wave -noupdate /SYS_SHARE_SUPERALU_CORDIC_TEST/scpu_sram_alu/scpu_ctrl_spi/uut/io_datainA
add wave -noupdate /SYS_SHARE_SUPERALU_CORDIC_TEST/scpu_sram_alu/scpu_ctrl_spi/uut/io_datainB
add wave -noupdate /SYS_SHARE_SUPERALU_CORDIC_TEST/scpu_sram_alu/scpu_ctrl_spi/uut/nxt
add wave -noupdate /SYS_SHARE_SUPERALU_CORDIC_TEST/scpu_sram_alu/scpu_ctrl_spi/uut/cpu_suspend
add wave -noupdate /SYS_SHARE_SUPERALU_CORDIC_TEST/scpu_sram_alu/scpu_ctrl_spi/uut/cpu_restore
add wave -noupdate /SYS_SHARE_SUPERALU_CORDIC_TEST/scpu_sram_alu/scpu_ctrl_spi/uut/start
add wave -noupdate /SYS_SHARE_SUPERALU_CORDIC_TEST/scpu_sram_alu/scpu_ctrl_spi/uut/io_status
add wave -noupdate /SYS_SHARE_SUPERALU_CORDIC_TEST/scpu_sram_alu/scpu_ctrl_spi/uut/io_control
add wave -noupdate /SYS_SHARE_SUPERALU_CORDIC_TEST/scpu_sram_alu/scpu_ctrl_spi/uut/clk
add wave -noupdate /SYS_SHARE_SUPERALU_CORDIC_TEST/scpu_sram_alu/scpu_ctrl_spi/uut/code_type
add wave -noupdate /SYS_SHARE_SUPERALU_CORDIC_TEST/scpu_sram_alu/scpu_ctrl_spi/uut/pc
add wave -noupdate /SYS_SHARE_SUPERALU_CORDIC_TEST/scpu_sram_alu/scpu_ctrl_spi/uut/io_dataoutA
add wave -noupdate /SYS_SHARE_SUPERALU_CORDIC_TEST/scpu_sram_alu/scpu_ctrl_spi/uut/io_dataoutB
add wave -noupdate /SYS_SHARE_SUPERALU_CORDIC_TEST/scpu_sram_alu/scpu_ctrl_spi/uut/clk
add wave -noupdate /SYS_SHARE_SUPERALU_CORDIC_TEST/scpu_sram_alu/scpu_ctrl_spi/uut/reg_C
add wave -noupdate -divider sram
add wave -noupdate /SYS_SHARE_SUPERALU_CORDIC_TEST/scpu_sram_alu/sram/CEN
add wave -noupdate /SYS_SHARE_SUPERALU_CORDIC_TEST/scpu_sram_alu/sram/Q
add wave -noupdate /SYS_SHARE_SUPERALU_CORDIC_TEST/scpu_sram_alu/sram/A
add wave -noupdate /SYS_SHARE_SUPERALU_CORDIC_TEST/scpu_sram_alu/sram/D
add wave -noupdate -divider alu_module
add wave -noupdate /SYS_SHARE_SUPERALU_CORDIC_TEST/scpu_sram_alu/scpu_ctrl_spi/ALU_01/X_IN
add wave -noupdate /SYS_SHARE_SUPERALU_CORDIC_TEST/scpu_sram_alu/scpu_ctrl_spi/ALU_01/Y_IN
add wave -noupdate /SYS_SHARE_SUPERALU_CORDIC_TEST/scpu_sram_alu/scpu_ctrl_spi/ALU_01/alu_start
add wave -noupdate /SYS_SHARE_SUPERALU_CORDIC_TEST/scpu_sram_alu/scpu_ctrl_spi/ALU_01/alu_is_done
add wave -noupdate /SYS_SHARE_SUPERALU_CORDIC_TEST/scpu_sram_alu/scpu_ctrl_spi/ALU_01/OFFSET
add wave -noupdate /SYS_SHARE_SUPERALU_CORDIC_TEST/scpu_sram_alu/scpu_ctrl_spi/ALU_01/FOUT
add wave -noupdate /SYS_SHARE_SUPERALU_CORDIC_TEST/scpu_sram_alu/scpu_ctrl_spi/ALU_01/POUT
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {11106667 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 276
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
WaveRestoreZoom {10463200 ps} {12864200 ps}
