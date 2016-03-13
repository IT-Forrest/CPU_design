onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /SRAM_IO_CTRL_TOP/CEN
add wave -noupdate /SRAM_IO_CTRL_TOP/SO
add wave -noupdate /SRAM_IO_CTRL_TOP/RDY
add wave -noupdate /SRAM_IO_CTRL_TOP/enable
add wave -noupdate /SRAM_IO_CTRL_TOP/clk
add wave -noupdate /SRAM_IO_CTRL_TOP/SI
add wave -noupdate /SRAM_IO_CTRL_TOP/LOAD_N
add wave -noupdate /SRAM_IO_CTRL_TOP/cct/ctrl_state
add wave -noupdate /SRAM_IO_CTRL_TOP/m_datain
add wave -noupdate /SRAM_IO_CTRL_TOP/m_dataout
add wave -noupdate /SRAM_IO_CTRL_TOP/m_addr
add wave -noupdate /SRAM_IO_CTRL_TOP/d_we
add wave -noupdate -radix unsigned /SRAM_IO_CTRL_TOP/cct/cnt_bit_load
add wave -noupdate /SRAM_IO_CTRL_TOP/j
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {82150 ps} 0}
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
WaveRestoreZoom {60325 ps} {196825 ps}
