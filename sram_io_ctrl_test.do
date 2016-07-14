onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /SRAM_IO_CTRL_TEST/CEN
add wave -noupdate /SRAM_IO_CTRL_TEST/d_we
add wave -noupdate /SRAM_IO_CTRL_TEST/SO
add wave -noupdate /SRAM_IO_CTRL_TEST/RDY
add wave -noupdate /SRAM_IO_CTRL_TEST/clk
add wave -noupdate /SRAM_IO_CTRL_TEST/SI
add wave -noupdate /SRAM_IO_CTRL_TEST/LOAD_N
add wave -noupdate /SRAM_IO_CTRL_TEST/m_datain
add wave -noupdate /SRAM_IO_CTRL_TEST/m_dataout
add wave -noupdate /SRAM_IO_CTRL_TEST/tmpi_adder
add wave -noupdate /SRAM_IO_CTRL_TEST/m_addr
add wave -noupdate /SRAM_IO_CTRL_TEST/j
add wave -noupdate /SRAM_IO_CTRL_TEST/sram/rst_n
add wave -noupdate /SRAM_IO_CTRL_TEST/sram/d_we
add wave -noupdate -divider SRAM_CTRL
add wave -noupdate /SRAM_IO_CTRL_TEST/cct/ctrl_state
add wave -noupdate -radix unsigned /SRAM_IO_CTRL_TEST/cct/cnt_bit_load
add wave -noupdate /SRAM_IO_CTRL_TEST/cct/reg_bits
add wave -noupdate /SRAM_IO_CTRL_TEST/cct/RDY
add wave -noupdate /SRAM_IO_CTRL_TEST/cct/CTRL
add wave -noupdate /SRAM_IO_CTRL_TEST/cct/BGN
add wave -noupdate /SRAM_IO_CTRL_TEST/cct/LOAD_N
add wave -noupdate /SRAM_IO_CTRL_TEST/cct/SI
add wave -noupdate /SRAM_IO_CTRL_TEST/cct/cnt_bit_load
add wave -noupdate /SRAM_IO_CTRL_TEST/cct/A
add wave -noupdate /SRAM_IO_CTRL_TEST/cct/PO
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {265075 ps} 0} {{Cursor 2} {7663617 ps} 0}
quietly wave cursor active 2
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
WaveRestoreZoom {0 ps} {13114500 ps}
