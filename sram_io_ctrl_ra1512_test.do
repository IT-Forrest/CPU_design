onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /SRAM_IO_CTRL_RA1512_TOP/CEN
add wave -noupdate /SRAM_IO_CTRL_RA1512_TOP/SO
add wave -noupdate /SRAM_IO_CTRL_RA1512_TOP/RDY
add wave -noupdate /SRAM_IO_CTRL_RA1512_TOP/enable
add wave -noupdate /SRAM_IO_CTRL_RA1512_TOP/clk
add wave -noupdate /SRAM_IO_CTRL_RA1512_TOP/SI
add wave -noupdate /SRAM_IO_CTRL_RA1512_TOP/LOAD_N
add wave -noupdate /SRAM_IO_CTRL_RA1512_TOP/cct/ctrl_state
add wave -noupdate /SRAM_IO_CTRL_RA1512_TOP/m_datain
add wave -noupdate /SRAM_IO_CTRL_RA1512_TOP/m_dataout
add wave -noupdate /SRAM_IO_CTRL_RA1512_TOP/m_addr
add wave -noupdate /SRAM_IO_CTRL_RA1512_TOP/d_we
add wave -noupdate -radix unsigned /SRAM_IO_CTRL_RA1512_TOP/cct/cnt_bit_load
add wave -noupdate /SRAM_IO_CTRL_RA1512_TOP/j
add wave -noupdate -divider {SRAM I/O}
add wave -noupdate /SRAM_IO_CTRL_RA1512_TOP/sram/Q
add wave -noupdate /SRAM_IO_CTRL_RA1512_TOP/sram/CLK
add wave -noupdate /SRAM_IO_CTRL_RA1512_TOP/sram/CEN
add wave -noupdate /SRAM_IO_CTRL_RA1512_TOP/sram/WEN
add wave -noupdate -radix hexadecimal /SRAM_IO_CTRL_RA1512_TOP/sram/A
add wave -noupdate /SRAM_IO_CTRL_RA1512_TOP/sram/D
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1185000 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 190
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
WaveRestoreZoom {0 ps} {8599500 ps}
