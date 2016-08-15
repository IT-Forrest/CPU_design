onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /SCPU_MEM_LOOP_8BIT_TEST/uut/rst_n
add wave -noupdate /SCPU_MEM_LOOP_8BIT_TEST/uut/start
add wave -noupdate /SCPU_MEM_LOOP_8BIT_TEST/uut/enable
add wave -noupdate /SCPU_MEM_LOOP_8BIT_TEST/uut/clk
add wave -noupdate -radix hexadecimal /SCPU_MEM_LOOP_8BIT_TEST/uut/i_datain
add wave -noupdate -radix hexadecimal /SCPU_MEM_LOOP_8BIT_TEST/uut/d_datain
add wave -noupdate -radix unsigned /SCPU_MEM_LOOP_8BIT_TEST/uut/i_addr
add wave -noupdate /SCPU_MEM_LOOP_8BIT_TEST/uut/d_addr
add wave -noupdate /SCPU_MEM_LOOP_8BIT_TEST/uut/d_we
add wave -noupdate -radix binary /SCPU_MEM_LOOP_8BIT_TEST/uut/state
add wave -noupdate /SCPU_MEM_LOOP_8BIT_TEST/uut/next_state
add wave -noupdate -radix hexadecimal /SCPU_MEM_LOOP_8BIT_TEST/uut/d_dataout
add wave -noupdate /SCPU_MEM_LOOP_8BIT_TEST/uut/reg_C
add wave -noupdate -radix unsigned /SCPU_MEM_LOOP_8BIT_TEST/uut/code_type
add wave -noupdate /SCPU_MEM_LOOP_8BIT_TEST/uut/oper1_r1
add wave -noupdate /SCPU_MEM_LOOP_8BIT_TEST/uut/oper2_is_val
add wave -noupdate /SCPU_MEM_LOOP_8BIT_TEST/uut/oper2_r2
add wave -noupdate /SCPU_MEM_LOOP_8BIT_TEST/uut/oper3_is_val
add wave -noupdate /SCPU_MEM_LOOP_8BIT_TEST/uut/oper3_r3
add wave -noupdate -divider {SCPU internal}
add wave -noupdate /SCPU_MEM_LOOP_8BIT_TEST/uut/cf_buf
add wave -noupdate -radix hexadecimal -childformat {{{/SCPU_MEM_LOOP_8BIT_TEST/uut/ALUo[15]} -radix hexadecimal} {{/SCPU_MEM_LOOP_8BIT_TEST/uut/ALUo[14]} -radix hexadecimal} {{/SCPU_MEM_LOOP_8BIT_TEST/uut/ALUo[13]} -radix hexadecimal} {{/SCPU_MEM_LOOP_8BIT_TEST/uut/ALUo[12]} -radix hexadecimal} {{/SCPU_MEM_LOOP_8BIT_TEST/uut/ALUo[11]} -radix hexadecimal} {{/SCPU_MEM_LOOP_8BIT_TEST/uut/ALUo[10]} -radix hexadecimal} {{/SCPU_MEM_LOOP_8BIT_TEST/uut/ALUo[9]} -radix hexadecimal} {{/SCPU_MEM_LOOP_8BIT_TEST/uut/ALUo[8]} -radix hexadecimal} {{/SCPU_MEM_LOOP_8BIT_TEST/uut/ALUo[7]} -radix hexadecimal} {{/SCPU_MEM_LOOP_8BIT_TEST/uut/ALUo[6]} -radix hexadecimal} {{/SCPU_MEM_LOOP_8BIT_TEST/uut/ALUo[5]} -radix hexadecimal} {{/SCPU_MEM_LOOP_8BIT_TEST/uut/ALUo[4]} -radix hexadecimal} {{/SCPU_MEM_LOOP_8BIT_TEST/uut/ALUo[3]} -radix hexadecimal} {{/SCPU_MEM_LOOP_8BIT_TEST/uut/ALUo[2]} -radix hexadecimal} {{/SCPU_MEM_LOOP_8BIT_TEST/uut/ALUo[1]} -radix hexadecimal} {{/SCPU_MEM_LOOP_8BIT_TEST/uut/ALUo[0]} -radix hexadecimal}} -subitemconfig {{/SCPU_MEM_LOOP_8BIT_TEST/uut/ALUo[15]} {-height 15 -radix hexadecimal} {/SCPU_MEM_LOOP_8BIT_TEST/uut/ALUo[14]} {-height 15 -radix hexadecimal} {/SCPU_MEM_LOOP_8BIT_TEST/uut/ALUo[13]} {-height 15 -radix hexadecimal} {/SCPU_MEM_LOOP_8BIT_TEST/uut/ALUo[12]} {-height 15 -radix hexadecimal} {/SCPU_MEM_LOOP_8BIT_TEST/uut/ALUo[11]} {-height 15 -radix hexadecimal} {/SCPU_MEM_LOOP_8BIT_TEST/uut/ALUo[10]} {-height 15 -radix hexadecimal} {/SCPU_MEM_LOOP_8BIT_TEST/uut/ALUo[9]} {-height 15 -radix hexadecimal} {/SCPU_MEM_LOOP_8BIT_TEST/uut/ALUo[8]} {-height 15 -radix hexadecimal} {/SCPU_MEM_LOOP_8BIT_TEST/uut/ALUo[7]} {-height 15 -radix hexadecimal} {/SCPU_MEM_LOOP_8BIT_TEST/uut/ALUo[6]} {-height 15 -radix hexadecimal} {/SCPU_MEM_LOOP_8BIT_TEST/uut/ALUo[5]} {-height 15 -radix hexadecimal} {/SCPU_MEM_LOOP_8BIT_TEST/uut/ALUo[4]} {-height 15 -radix hexadecimal} {/SCPU_MEM_LOOP_8BIT_TEST/uut/ALUo[3]} {-height 15 -radix hexadecimal} {/SCPU_MEM_LOOP_8BIT_TEST/uut/ALUo[2]} {-height 15 -radix hexadecimal} {/SCPU_MEM_LOOP_8BIT_TEST/uut/ALUo[1]} {-height 15 -radix hexadecimal} {/SCPU_MEM_LOOP_8BIT_TEST/uut/ALUo[0]} {-height 15 -radix hexadecimal}} /SCPU_MEM_LOOP_8BIT_TEST/uut/ALUo
add wave -noupdate /SCPU_MEM_LOOP_8BIT_TEST/uut/zf
add wave -noupdate /SCPU_MEM_LOOP_8BIT_TEST/uut/nf
add wave -noupdate /SCPU_MEM_LOOP_8BIT_TEST/uut/cf
add wave -noupdate /SCPU_MEM_LOOP_8BIT_TEST/uut/dw
add wave -noupdate -radix unsigned /SCPU_MEM_LOOP_8BIT_TEST/uut/pc
add wave -noupdate -radix binary /SCPU_MEM_LOOP_8BIT_TEST/uut/id_ir
add wave -noupdate -radix hexadecimal /SCPU_MEM_LOOP_8BIT_TEST/uut/reg_A
add wave -noupdate -radix hexadecimal /SCPU_MEM_LOOP_8BIT_TEST/uut/reg_B
add wave -noupdate -radix hexadecimal /SCPU_MEM_LOOP_8BIT_TEST/uut/reg_C
add wave -noupdate /SCPU_MEM_LOOP_8BIT_TEST/uut/branch_flag
add wave -noupdate /SCPU_MEM_LOOP_8BIT_TEST/uut/lowest_bit
add wave -noupdate /SCPU_MEM_LOOP_8BIT_TEST/uut/is_i_addr
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {165902 ps} 0}
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
WaveRestoreZoom {0 ps} {430500 ps}
