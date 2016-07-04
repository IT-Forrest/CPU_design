onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /SCPU_SRAM_8BIT_ALU_SPI_TOP_TEST/scpu_sram_alu/Q_from_SRAM
add wave -noupdate /SCPU_SRAM_8BIT_ALU_SPI_TOP_TEST/scpu_sram_alu/CLK
add wave -noupdate /SCPU_SRAM_8BIT_ALU_SPI_TOP_TEST/scpu_sram_alu/sram/Q
add wave -noupdate /SCPU_SRAM_8BIT_ALU_SPI_TOP_TEST/scpu_sram_alu/sram/CEN
add wave -noupdate /SCPU_SRAM_8BIT_ALU_SPI_TOP_TEST/scpu_sram_alu/sram/WEN
add wave -noupdate /SCPU_SRAM_8BIT_ALU_SPI_TOP_TEST/scpu_sram_alu/sram/A
add wave -noupdate /SCPU_SRAM_8BIT_ALU_SPI_TOP_TEST/scpu_sram_alu/sram/D
add wave -noupdate -divider SCPU
add wave -noupdate /SCPU_SRAM_8BIT_ALU_SPI_TOP_TEST/scpu_sram_alu/scpu_ctrl_spi/uut/enable
add wave -noupdate /SCPU_SRAM_8BIT_ALU_SPI_TOP_TEST/scpu_sram_alu/scpu_ctrl_spi/uut/start
add wave -noupdate /SCPU_SRAM_8BIT_ALU_SPI_TOP_TEST/scpu_sram_alu/scpu_ctrl_spi/uut/i_datain
add wave -noupdate /SCPU_SRAM_8BIT_ALU_SPI_TOP_TEST/scpu_sram_alu/scpu_ctrl_spi/uut/d_datain
add wave -noupdate /SCPU_SRAM_8BIT_ALU_SPI_TOP_TEST/scpu_sram_alu/scpu_ctrl_spi/uut/state
add wave -noupdate /SCPU_SRAM_8BIT_ALU_SPI_TOP_TEST/scpu_sram_alu/scpu_ctrl_spi/uut/next_state
add wave -noupdate /SCPU_SRAM_8BIT_ALU_SPI_TOP_TEST/scpu_sram_alu/scpu_ctrl_spi/uut/pc
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {19551000 ps} 0}
quietly wave cursor active 1
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
WaveRestoreZoom {18137880 ps} {20964120 ps}
