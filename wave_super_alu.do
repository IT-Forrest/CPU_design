onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /SHARE_SUPERALU_TOP/ALU_01/CLK
add wave -noupdate /SHARE_SUPERALU_TOP/ALU_01/RST_N
add wave -noupdate -radix unsigned /SHARE_SUPERALU_TOP/ALU_01/X_IN
add wave -noupdate -radix unsigned /SHARE_SUPERALU_TOP/ALU_01/Y_IN
add wave -noupdate /SHARE_SUPERALU_TOP/ALU_01/alu_start
add wave -noupdate /SHARE_SUPERALU_TOP/ALU_01/alu_type
add wave -noupdate /SHARE_SUPERALU_TOP/ALU_01/mode_type
add wave -noupdate /SHARE_SUPERALU_TOP/ALU_01/FOUT
add wave -noupdate /SHARE_SUPERALU_TOP/ALU_01/alu_is_done
add wave -noupdate -divider memory
add wave -noupdate /SHARE_SUPERALU_TOP/ALU_01/xtemp
add wave -noupdate /SHARE_SUPERALU_TOP/ALU_01/ytemp
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
configure wave -namecolwidth 334
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
WaveRestoreZoom {0 ps} {13650 ns}
