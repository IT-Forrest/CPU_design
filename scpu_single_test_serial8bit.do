onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider {SCPU I/O}
add wave -noupdate /SCPU_SINGLE_8BIT_TOP/uut/enable
add wave -noupdate -radix unsigned /SCPU_SINGLE_8BIT_TOP/uut/code_type
add wave -noupdate /SCPU_SINGLE_8BIT_TOP/uut/rst_n
add wave -noupdate /SCPU_SINGLE_8BIT_TOP/uut/clk
add wave -noupdate /SCPU_SINGLE_8BIT_TOP/uut/start
add wave -noupdate /SCPU_SINGLE_8BIT_TOP/uut/d_we
add wave -noupdate /SCPU_SINGLE_8BIT_TOP/uut/d_dataout
add wave -noupdate -radix hexadecimal -childformat {{{/SCPU_SINGLE_8BIT_TOP/uut/i_datain[7]} -radix hexadecimal} {{/SCPU_SINGLE_8BIT_TOP/uut/i_datain[6]} -radix hexadecimal} {{/SCPU_SINGLE_8BIT_TOP/uut/i_datain[5]} -radix hexadecimal} {{/SCPU_SINGLE_8BIT_TOP/uut/i_datain[4]} -radix hexadecimal} {{/SCPU_SINGLE_8BIT_TOP/uut/i_datain[3]} -radix hexadecimal} {{/SCPU_SINGLE_8BIT_TOP/uut/i_datain[2]} -radix hexadecimal} {{/SCPU_SINGLE_8BIT_TOP/uut/i_datain[1]} -radix hexadecimal} {{/SCPU_SINGLE_8BIT_TOP/uut/i_datain[0]} -radix hexadecimal}} -subitemconfig {{/SCPU_SINGLE_8BIT_TOP/uut/i_datain[7]} {-height 15 -radix hexadecimal} {/SCPU_SINGLE_8BIT_TOP/uut/i_datain[6]} {-height 15 -radix hexadecimal} {/SCPU_SINGLE_8BIT_TOP/uut/i_datain[5]} {-height 15 -radix hexadecimal} {/SCPU_SINGLE_8BIT_TOP/uut/i_datain[4]} {-height 15 -radix hexadecimal} {/SCPU_SINGLE_8BIT_TOP/uut/i_datain[3]} {-height 15 -radix hexadecimal} {/SCPU_SINGLE_8BIT_TOP/uut/i_datain[2]} {-height 15 -radix hexadecimal} {/SCPU_SINGLE_8BIT_TOP/uut/i_datain[1]} {-height 15 -radix hexadecimal} {/SCPU_SINGLE_8BIT_TOP/uut/i_datain[0]} {-height 15 -radix hexadecimal}} /SCPU_SINGLE_8BIT_TOP/uut/i_datain
add wave -noupdate -radix hexadecimal /SCPU_SINGLE_8BIT_TOP/uut/d_datain
add wave -noupdate -radix hexadecimal -childformat {{{/SCPU_SINGLE_8BIT_TOP/uut/i_addr[8]} -radix unsigned} {{/SCPU_SINGLE_8BIT_TOP/uut/i_addr[7]} -radix unsigned} {{/SCPU_SINGLE_8BIT_TOP/uut/i_addr[6]} -radix unsigned} {{/SCPU_SINGLE_8BIT_TOP/uut/i_addr[5]} -radix unsigned} {{/SCPU_SINGLE_8BIT_TOP/uut/i_addr[4]} -radix unsigned} {{/SCPU_SINGLE_8BIT_TOP/uut/i_addr[3]} -radix unsigned} {{/SCPU_SINGLE_8BIT_TOP/uut/i_addr[2]} -radix unsigned} {{/SCPU_SINGLE_8BIT_TOP/uut/i_addr[1]} -radix unsigned} {{/SCPU_SINGLE_8BIT_TOP/uut/i_addr[0]} -radix unsigned}} -subitemconfig {{/SCPU_SINGLE_8BIT_TOP/uut/i_addr[8]} {-height 15 -radix unsigned} {/SCPU_SINGLE_8BIT_TOP/uut/i_addr[7]} {-height 15 -radix unsigned} {/SCPU_SINGLE_8BIT_TOP/uut/i_addr[6]} {-height 15 -radix unsigned} {/SCPU_SINGLE_8BIT_TOP/uut/i_addr[5]} {-height 15 -radix unsigned} {/SCPU_SINGLE_8BIT_TOP/uut/i_addr[4]} {-height 15 -radix unsigned} {/SCPU_SINGLE_8BIT_TOP/uut/i_addr[3]} {-height 15 -radix unsigned} {/SCPU_SINGLE_8BIT_TOP/uut/i_addr[2]} {-height 15 -radix unsigned} {/SCPU_SINGLE_8BIT_TOP/uut/i_addr[1]} {-height 15 -radix unsigned} {/SCPU_SINGLE_8BIT_TOP/uut/i_addr[0]} {-height 15 -radix unsigned}} /SCPU_SINGLE_8BIT_TOP/uut/i_addr
add wave -noupdate -radix hexadecimal -childformat {{{/SCPU_SINGLE_8BIT_TOP/uut/d_addr[8]} -radix hexadecimal} {{/SCPU_SINGLE_8BIT_TOP/uut/d_addr[7]} -radix hexadecimal} {{/SCPU_SINGLE_8BIT_TOP/uut/d_addr[6]} -radix hexadecimal} {{/SCPU_SINGLE_8BIT_TOP/uut/d_addr[5]} -radix hexadecimal} {{/SCPU_SINGLE_8BIT_TOP/uut/d_addr[4]} -radix hexadecimal} {{/SCPU_SINGLE_8BIT_TOP/uut/d_addr[3]} -radix hexadecimal} {{/SCPU_SINGLE_8BIT_TOP/uut/d_addr[2]} -radix hexadecimal} {{/SCPU_SINGLE_8BIT_TOP/uut/d_addr[1]} -radix hexadecimal} {{/SCPU_SINGLE_8BIT_TOP/uut/d_addr[0]} -radix hexadecimal}} -subitemconfig {{/SCPU_SINGLE_8BIT_TOP/uut/d_addr[8]} {-height 15 -radix hexadecimal} {/SCPU_SINGLE_8BIT_TOP/uut/d_addr[7]} {-height 15 -radix hexadecimal} {/SCPU_SINGLE_8BIT_TOP/uut/d_addr[6]} {-height 15 -radix hexadecimal} {/SCPU_SINGLE_8BIT_TOP/uut/d_addr[5]} {-height 15 -radix hexadecimal} {/SCPU_SINGLE_8BIT_TOP/uut/d_addr[4]} {-height 15 -radix hexadecimal} {/SCPU_SINGLE_8BIT_TOP/uut/d_addr[3]} {-height 15 -radix hexadecimal} {/SCPU_SINGLE_8BIT_TOP/uut/d_addr[2]} {-height 15 -radix hexadecimal} {/SCPU_SINGLE_8BIT_TOP/uut/d_addr[1]} {-height 15 -radix hexadecimal} {/SCPU_SINGLE_8BIT_TOP/uut/d_addr[0]} {-height 15 -radix hexadecimal}} /SCPU_SINGLE_8BIT_TOP/uut/d_addr
add wave -noupdate -divider {SCPU Inner}
add wave -noupdate /SCPU_SINGLE_8BIT_TOP/uut/is_i_addr
add wave -noupdate /SCPU_SINGLE_8BIT_TOP/uut/code_type
add wave -noupdate /SCPU_SINGLE_8BIT_TOP/uut/oper1_r1
add wave -noupdate /SCPU_SINGLE_8BIT_TOP/uut/oper2_is_val
add wave -noupdate /SCPU_SINGLE_8BIT_TOP/uut/oper2_r2
add wave -noupdate /SCPU_SINGLE_8BIT_TOP/uut/oper3_is_val
add wave -noupdate /SCPU_SINGLE_8BIT_TOP/uut/oper3_r3
add wave -noupdate -radix hexadecimal /SCPU_SINGLE_8BIT_TOP/uut/ALUo
add wave -noupdate /SCPU_SINGLE_8BIT_TOP/uut/state
add wave -noupdate /SCPU_SINGLE_8BIT_TOP/uut/next_state
add wave -noupdate /SCPU_SINGLE_8BIT_TOP/uut/cf_buf
add wave -noupdate /SCPU_SINGLE_8BIT_TOP/uut/zf
add wave -noupdate /SCPU_SINGLE_8BIT_TOP/uut/nf
add wave -noupdate /SCPU_SINGLE_8BIT_TOP/uut/cf
add wave -noupdate /SCPU_SINGLE_8BIT_TOP/uut/dw
add wave -noupdate -radix unsigned /SCPU_SINGLE_8BIT_TOP/uut/pc
add wave -noupdate /SCPU_SINGLE_8BIT_TOP/uut/lowest_bit
add wave -noupdate -radix hexadecimal /SCPU_SINGLE_8BIT_TOP/uut/id_ir
add wave -noupdate -radix hexadecimal /SCPU_SINGLE_8BIT_TOP/uut/reg_A
add wave -noupdate -radix hexadecimal /SCPU_SINGLE_8BIT_TOP/uut/reg_B
add wave -noupdate -radix hexadecimal /SCPU_SINGLE_8BIT_TOP/uut/reg_C
add wave -noupdate /SCPU_SINGLE_8BIT_TOP/uut/branch_flag
add wave -noupdate -radix hexadecimal /SCPU_SINGLE_8BIT_TOP/uut/smdr
add wave -noupdate -radix hexadecimal /SCPU_SINGLE_8BIT_TOP/tmpi_datain
add wave -noupdate -radix hexadecimal /SCPU_SINGLE_8BIT_TOP/tmpd_datain
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {498157 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 227
configure wave -valuecolwidth 85
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
WaveRestoreZoom {448702 ps} {530078 ps}
