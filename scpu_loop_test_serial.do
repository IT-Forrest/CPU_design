onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /SCPU_MEM_LOOP_TOP/uut/rst_n
add wave -noupdate /SCPU_MEM_LOOP_TOP/uut/start
add wave -noupdate /SCPU_MEM_LOOP_TOP/uut/enable
add wave -noupdate /SCPU_MEM_LOOP_TOP/uut/clk
add wave -noupdate -radix hexadecimal /SCPU_MEM_LOOP_TOP/uut/i_datain
add wave -noupdate -radix hexadecimal /SCPU_MEM_LOOP_TOP/uut/d_datain
add wave -noupdate -radix unsigned /SCPU_MEM_LOOP_TOP/uut/i_addr
add wave -noupdate /SCPU_MEM_LOOP_TOP/uut/d_addr
add wave -noupdate /SCPU_MEM_LOOP_TOP/uut/d_we
add wave -noupdate /SCPU_MEM_LOOP_TOP/uut/state
add wave -noupdate /SCPU_MEM_LOOP_TOP/uut/next_state
add wave -noupdate -radix hexadecimal /SCPU_MEM_LOOP_TOP/uut/d_dataout
add wave -noupdate /SCPU_MEM_LOOP_TOP/uut/reg_C
add wave -noupdate -radix unsigned /SCPU_MEM_LOOP_TOP/uut/code_type
add wave -noupdate /SCPU_MEM_LOOP_TOP/uut/oper1_r1
add wave -noupdate /SCPU_MEM_LOOP_TOP/uut/oper2_is_val
add wave -noupdate /SCPU_MEM_LOOP_TOP/uut/oper2_r2
add wave -noupdate /SCPU_MEM_LOOP_TOP/uut/oper3_is_val
add wave -noupdate /SCPU_MEM_LOOP_TOP/uut/oper3_r3
add wave -noupdate -divider {SCPU internal}
add wave -noupdate /SCPU_MEM_LOOP_TOP/uut/cf_buf
add wave -noupdate -radix hexadecimal /SCPU_MEM_LOOP_TOP/uut/ALUo
add wave -noupdate /SCPU_MEM_LOOP_TOP/uut/zf
add wave -noupdate /SCPU_MEM_LOOP_TOP/uut/nf
add wave -noupdate /SCPU_MEM_LOOP_TOP/uut/cf
add wave -noupdate /SCPU_MEM_LOOP_TOP/uut/dw
add wave -noupdate -radix unsigned /SCPU_MEM_LOOP_TOP/uut/pc
add wave -noupdate -radix hexadecimal /SCPU_MEM_LOOP_TOP/uut/id_ir
add wave -noupdate -radix hexadecimal /SCPU_MEM_LOOP_TOP/uut/reg_A
add wave -noupdate -radix hexadecimal /SCPU_MEM_LOOP_TOP/uut/reg_B
add wave -noupdate -radix hexadecimal /SCPU_MEM_LOOP_TOP/uut/reg_C
add wave -noupdate /SCPU_MEM_LOOP_TOP/uut/branch_flag
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {392244 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 227
configure wave -valuecolwidth 200
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
WaveRestoreZoom {64096 ps} {694096 ps}
