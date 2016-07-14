onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider Interconnect
add wave -noupdate /SRAM_IO_CTRL_RA1512_TEST/CEN
add wave -noupdate /SRAM_IO_CTRL_RA1512_TEST/SO
add wave -noupdate /SRAM_IO_CTRL_RA1512_TEST/SI
add wave -noupdate /SRAM_IO_CTRL_RA1512_TEST/LOAD_N
add wave -noupdate /SRAM_IO_CTRL_RA1512_TEST/d_we
add wave -noupdate /SRAM_IO_CTRL_RA1512_TEST/RDY
add wave -noupdate /SRAM_IO_CTRL_RA1512_TEST/m_datain
add wave -noupdate /SRAM_IO_CTRL_RA1512_TEST/m_dataout
add wave -noupdate /SRAM_IO_CTRL_RA1512_TEST/m_addr
add wave -noupdate /SRAM_IO_CTRL_RA1512_TEST/CTRL_BGN
add wave -noupdate -divider {SRAM I/O}
add wave -noupdate /SRAM_IO_CTRL_RA1512_TEST/sram/Q
add wave -noupdate /SRAM_IO_CTRL_RA1512_TEST/sram/CLK
add wave -noupdate /SRAM_IO_CTRL_RA1512_TEST/sram/CEN
add wave -noupdate /SRAM_IO_CTRL_RA1512_TEST/sram/WEN
add wave -noupdate -radix hexadecimal /SRAM_IO_CTRL_RA1512_TEST/sram/A
add wave -noupdate /SRAM_IO_CTRL_RA1512_TEST/sram/D
add wave -noupdate -divider SRAM_CTRL
add wave -noupdate /SRAM_IO_CTRL_RA1512_TEST/cct/CTRL
add wave -noupdate -radix unsigned /SRAM_IO_CTRL_RA1512_TEST/cct/cnt_bit_load
add wave -noupdate /SRAM_IO_CTRL_RA1512_TEST/cct/ctrl_state
add wave -noupdate /SRAM_IO_CTRL_RA1512_TEST/clk
add wave -noupdate /SRAM_IO_CTRL_RA1512_TEST/cct/PI
add wave -noupdate -radix hexadecimal /SRAM_IO_CTRL_RA1512_TEST/cct/A
add wave -noupdate /SRAM_IO_CTRL_RA1512_TEST/cct/PO
add wave -noupdate /SRAM_IO_CTRL_RA1512_TEST/cct/reg_bits
add wave -noupdate /SRAM_IO_CTRL_RA1512_TEST/cct/BGN
add wave -noupdate /SRAM_IO_CTRL_RA1512_TEST/k
add wave -noupdate /SRAM_IO_CTRL_RA1512_TEST/cct/is_LOAD
add wave -noupdate /SRAM_IO_CTRL_RA1512_TEST/cct/CEN
add wave -noupdate /SRAM_IO_CTRL_RA1512_TEST/tmpi_datain
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {20282594 ps} 1} {{Cursor 2} {8442674 ps} 0}
quietly wave cursor active 2
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
WaveRestoreZoom {12483055 ps} {12585103 ps}
