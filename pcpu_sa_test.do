onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /PCPU_MEM_SA_TOP/eva00/uut/rst_n
add wave -noupdate /PCPU_MEM_SA_TOP/eva00/uut/start
add wave -noupdate /PCPU_MEM_SA_TOP/eva00/uut/enable
add wave -noupdate /PCPU_MEM_SA_TOP/eva00/uut/clk
add wave -noupdate -radix hexadecimal /PCPU_MEM_SA_TOP/eva00/uut/i_datain
add wave -noupdate -radix hexadecimal /PCPU_MEM_SA_TOP/eva00/uut/d_datain
add wave -noupdate -radix unsigned /PCPU_MEM_SA_TOP/eva00/uut/i_addr
add wave -noupdate -radix unsigned /PCPU_MEM_SA_TOP/eva00/uut/d_addr
add wave -noupdate /PCPU_MEM_SA_TOP/eva00/uut/d_we
add wave -noupdate /PCPU_MEM_SA_TOP/eva00/uut/state
add wave -noupdate -radix hexadecimal /PCPU_MEM_SA_TOP/eva00/uut/d_dataout
add wave -noupdate -radix unsigned /PCPU_MEM_SA_TOP/eva00/uut/pc
add wave -noupdate -radix unsigned /PCPU_MEM_SA_TOP/eva00/uut/code_type
add wave -noupdate /PCPU_MEM_SA_TOP/eva00/uut/oper1_r1
add wave -noupdate /PCPU_MEM_SA_TOP/eva00/uut/oper2_is_val
add wave -noupdate /PCPU_MEM_SA_TOP/eva00/uut/oper2_r2
add wave -noupdate /PCPU_MEM_SA_TOP/eva00/uut/oper3_is_val
add wave -noupdate /PCPU_MEM_SA_TOP/eva00/uut/oper3_r3
add wave -noupdate /PCPU_MEM_SA_TOP/eva00/uut/zf
add wave -noupdate /PCPU_MEM_SA_TOP/eva00/uut/nf
add wave -noupdate /PCPU_MEM_SA_TOP/eva00/uut/cf
add wave -noupdate /PCPU_MEM_SA_TOP/eva00/uut/reg_A
add wave -noupdate /PCPU_MEM_SA_TOP/eva00/uut/reg_B
add wave -noupdate -divider PIPE_TOP_LEVEL
add wave -noupdate /PCPU_MEM_SA_TOP/eva00/ADC_RDY
add wave -noupdate /PCPU_MEM_SA_TOP/eva00/TEST_MUX
add wave -noupdate /PCPU_MEM_SA_TOP/eva00/NXT_after_mux
add wave -noupdate /PCPU_MEM_SA_TOP/eva00/RDY_after_mux
add wave -noupdate /PCPU_MEM_SA_TOP/eva00/STA_after_mux
add wave -noupdate /PCPU_MEM_SA_TOP/eva00/TUNE_READY
add wave -noupdate /PCPU_MEM_SA_TOP/eva00/NXT
add wave -noupdate /PCPU_MEM_SA_TOP/eva00/io_status
add wave -noupdate -radix binary /PCPU_MEM_SA_TOP/eva00/io_control
add wave -noupdate -radix unsigned /PCPU_MEM_SA_TOP/eva00/ANA_BITS_OUT
add wave -noupdate /PCPU_MEM_SA_TOP/eva00/SA02/TUNE_BITS
add wave -noupdate -radix binary /PCPU_MEM_SA_TOP/eva00/io_datainA
add wave -noupdate /PCPU_MEM_SA_TOP/eva00/io_datainB
add wave -noupdate /PCPU_MEM_SA_TOP/eva00/io_dataoutA
add wave -noupdate /PCPU_MEM_SA_TOP/eva00/io_dataoutB
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {893800520 ps} 0} {{Cursor 2} {158214225 ps} 0}
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
WaveRestoreZoom {104856950 ps} {1052775950 ps}
