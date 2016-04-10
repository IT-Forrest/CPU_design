onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider CPU_and_CTRL
add wave -noupdate /SRAM_IO_CTRL_RA1512_SCPU_8BIT_TOP/enable
add wave -noupdate /SRAM_IO_CTRL_RA1512_SCPU_8BIT_TOP/CEN
add wave -noupdate /SRAM_IO_CTRL_RA1512_SCPU_8BIT_TOP/SO
add wave -noupdate /SRAM_IO_CTRL_RA1512_SCPU_8BIT_TOP/RDY
add wave -noupdate /SRAM_IO_CTRL_RA1512_SCPU_8BIT_TOP/clk
add wave -noupdate /SRAM_IO_CTRL_RA1512_SCPU_8BIT_TOP/SI
add wave -noupdate /SRAM_IO_CTRL_RA1512_SCPU_8BIT_TOP/LOAD_N
add wave -noupdate /SRAM_IO_CTRL_RA1512_SCPU_8BIT_TOP/cct/ctrl_state
add wave -noupdate -radix hexadecimal /SRAM_IO_CTRL_RA1512_SCPU_8BIT_TOP/m_addr
add wave -noupdate /SRAM_IO_CTRL_RA1512_SCPU_8BIT_TOP/m_datain
add wave -noupdate /SRAM_IO_CTRL_RA1512_SCPU_8BIT_TOP/m_dataout
add wave -noupdate /SRAM_IO_CTRL_RA1512_SCPU_8BIT_TOP/uut/lowest_bit
add wave -noupdate /SRAM_IO_CTRL_RA1512_SCPU_8BIT_TOP/uut/state
add wave -noupdate /SRAM_IO_CTRL_RA1512_SCPU_8BIT_TOP/uut/next_state
add wave -noupdate /SRAM_IO_CTRL_RA1512_SCPU_8BIT_TOP/start
add wave -noupdate -radix hexadecimal /SRAM_IO_CTRL_RA1512_SCPU_8BIT_TOP/uut/reg_A
add wave -noupdate -radix hexadecimal /SRAM_IO_CTRL_RA1512_SCPU_8BIT_TOP/uut/reg_B
add wave -noupdate -radix hexadecimal /SRAM_IO_CTRL_RA1512_SCPU_8BIT_TOP/uut/reg_C
add wave -noupdate -radix hexadecimal /SRAM_IO_CTRL_RA1512_SCPU_8BIT_TOP/uut/pc
add wave -noupdate /SRAM_IO_CTRL_RA1512_SCPU_8BIT_TOP/uut/d_we
add wave -noupdate /SRAM_IO_CTRL_RA1512_SCPU_8BIT_TOP/uut/nxt
add wave -noupdate -divider Interconnect
add wave -noupdate /SRAM_IO_CTRL_RA1512_SCPU_8BIT_TOP/is_i_addr
add wave -noupdate -radix hexadecimal /SRAM_IO_CTRL_RA1512_SCPU_8BIT_TOP/A_after_mux
add wave -noupdate /SRAM_IO_CTRL_RA1512_SCPU_8BIT_TOP/D_after_mux
add wave -noupdate /SRAM_IO_CTRL_RA1512_SCPU_8BIT_TOP/CEN_after_mux
add wave -noupdate /SRAM_IO_CTRL_RA1512_SCPU_8BIT_TOP/WEN_after_mux
add wave -noupdate /SRAM_IO_CTRL_RA1512_SCPU_8BIT_TOP/LOAD_MUX
add wave -noupdate /SRAM_IO_CTRL_RA1512_SCPU_8BIT_TOP/uut/code_type
add wave -noupdate /SRAM_IO_CTRL_RA1512_SCPU_8BIT_TOP/uut/id_ir
add wave -noupdate -divider {SRAM I/O}
add wave -noupdate /SRAM_IO_CTRL_RA1512_SCPU_8BIT_TOP/sram/Q
add wave -noupdate /SRAM_IO_CTRL_RA1512_SCPU_8BIT_TOP/sram/CEN
add wave -noupdate /SRAM_IO_CTRL_RA1512_SCPU_8BIT_TOP/sram/WEN
add wave -noupdate -radix hexadecimal /SRAM_IO_CTRL_RA1512_SCPU_8BIT_TOP/sram/A
add wave -noupdate /SRAM_IO_CTRL_RA1512_SCPU_8BIT_TOP/sram/D
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {4850000 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 190
configure wave -valuecolwidth 69
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
WaveRestoreZoom {0 ps} {6825 ns}
