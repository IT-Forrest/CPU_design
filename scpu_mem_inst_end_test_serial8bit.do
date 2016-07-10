onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /SCPU_MEM_INST_END_8BIT_TEST/clk
add wave -noupdate /SCPU_MEM_INST_END_8BIT_TEST/start
add wave -noupdate /SCPU_MEM_INST_END_8BIT_TEST/nxt
add wave -noupdate /SCPU_MEM_INST_END_8BIT_TEST/m_addr
add wave -noupdate /SCPU_MEM_INST_END_8BIT_TEST/d_dataout
add wave -noupdate /SCPU_MEM_INST_END_8BIT_TEST/i_datain
add wave -noupdate /SCPU_MEM_INST_END_8BIT_TEST/d_datain
add wave -noupdate -divider SCPU
add wave -noupdate /SCPU_MEM_INST_END_8BIT_TEST/uut/code_type
add wave -noupdate /SCPU_MEM_INST_END_8BIT_TEST/uut/pc
add wave -noupdate /SCPU_MEM_INST_END_8BIT_TEST/uut/state
add wave -noupdate /SCPU_MEM_INST_END_8BIT_TEST/uut/next_state
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1879066 ps} 0}
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
WaveRestoreZoom {1773416 ps} {1896136 ps}
