onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider sram
add wave -noupdate /SYC_PC_MEM_LOOP_8BIT_TEST/scpu_sram_alu/CLK
add wave -noupdate /SYC_PC_MEM_LOOP_8BIT_TEST/scpu_sram_alu/RST_N
add wave -noupdate /SYC_PC_MEM_LOOP_8BIT_TEST/scpu_sram_alu/sram/CLK
add wave -noupdate /SYC_PC_MEM_LOOP_8BIT_TEST/scpu_sram_alu/sram/CEN
add wave -noupdate /SYC_PC_MEM_LOOP_8BIT_TEST/scpu_sram_alu/sram/WEN
add wave -noupdate /SYC_PC_MEM_LOOP_8BIT_TEST/scpu_sram_alu/sram/Q
add wave -noupdate /SYC_PC_MEM_LOOP_8BIT_TEST/scpu_sram_alu/sram/A
add wave -noupdate /SYC_PC_MEM_LOOP_8BIT_TEST/scpu_sram_alu/sram/D
add wave -noupdate -divider spi_module
add wave -noupdate /SYC_PC_MEM_LOOP_8BIT_TEST/CPU_BGN
add wave -noupdate /SYC_PC_MEM_LOOP_8BIT_TEST/coe_cpu_bgn_export
add wave -noupdate /SYC_PC_MEM_LOOP_8BIT_TEST/coe_ctrl_bgn_export
add wave -noupdate /SYC_PC_MEM_LOOP_8BIT_TEST/coe_ctrl_load_export
add wave -noupdate /SYC_PC_MEM_LOOP_8BIT_TEST/coe_ctrl_si_export
add wave -noupdate /SYC_PC_MEM_LOOP_8BIT_TEST/coe_ctrl_rdy_export
add wave -noupdate /SYC_PC_MEM_LOOP_8BIT_TEST/coe_anag_lat_export
add wave -noupdate /SYC_PC_MEM_LOOP_8BIT_TEST/coe_anag_sclk1_export
add wave -noupdate /SYC_PC_MEM_LOOP_8BIT_TEST/coe_anag_sclk2_export
add wave -noupdate /SYC_PC_MEM_LOOP_8BIT_TEST/coe_anag_spi_so_export
add wave -noupdate /SYC_PC_MEM_LOOP_8BIT_TEST/coe_app_done_export
add wave -noupdate /SYC_PC_MEM_LOOP_8BIT_TEST/coe_app_start_export
add wave -noupdate /SYC_PC_MEM_LOOP_8BIT_TEST/ADC_PI_dly
add wave -noupdate /SYC_PC_MEM_LOOP_8BIT_TEST/scpu_sram_alu/scpu_ctrl_spi/ALU_01/FOUT
add wave -noupdate /SYC_PC_MEM_LOOP_8BIT_TEST/scpu_sram_alu/scpu_ctrl_spi/cct/reg_bits
add wave -noupdate -divider ctrl_logic
add wave -noupdate /SYC_PC_MEM_LOOP_8BIT_TEST/fpga/CFSA_FOUT
add wave -noupdate /SYC_PC_MEM_LOOP_8BIT_TEST/fpga/csi_clk
add wave -noupdate /SYC_PC_MEM_LOOP_8BIT_TEST/fpga/CTRL_SO
add wave -noupdate -radix unsigned /SYC_PC_MEM_LOOP_8BIT_TEST/fpga/cnt_bit_load
add wave -noupdate /SYC_PC_MEM_LOOP_8BIT_TEST/fpga/reg_sram_all
add wave -noupdate /SYC_PC_MEM_LOOP_8BIT_TEST/fpga/reg_LOAD
add wave -noupdate /SYC_PC_MEM_LOOP_8BIT_TEST/fpga/reg_ctrl_mode
add wave -noupdate /SYC_PC_MEM_LOOP_8BIT_TEST/fpga/reg_sram_addr
add wave -noupdate /SYC_PC_MEM_LOOP_8BIT_TEST/fpga/reg_sram_data
add wave -noupdate /SYC_PC_MEM_LOOP_8BIT_TEST/fpga/reg_ctrl_bgn_dly
add wave -noupdate /SYC_PC_MEM_LOOP_8BIT_TEST/fpga/is_LOAD
add wave -noupdate /SYC_PC_MEM_LOOP_8BIT_TEST/fpga/is_load2_ctrl
add wave -noupdate /SYC_PC_MEM_LOOP_8BIT_TEST/fpga/is_rfrom_ctrl
add wave -noupdate /SYC_PC_MEM_LOOP_8BIT_TEST/fpga/reg_cpu_bgn
add wave -noupdate /SYC_PC_MEM_LOOP_8BIT_TEST/fpga/csi_split_clk
add wave -noupdate /SYC_PC_MEM_LOOP_8BIT_TEST/fpga/coe_clk_export
add wave -noupdate /SYC_PC_MEM_LOOP_8BIT_TEST/fpga/cntsclk
add wave -noupdate /SYC_PC_MEM_LOOP_8BIT_TEST/fpga/reg_cpu_bgn_dly
add wave -noupdate -divider uut_cpu
add wave -noupdate {/SYC_PC_MEM_LOOP_8BIT_TEST/scpu_sram_alu/scpu_ctrl_spi/uut/nxt[1]}
add wave -noupdate {/SYC_PC_MEM_LOOP_8BIT_TEST/scpu_sram_alu/scpu_ctrl_spi/uut/nxt[0]}
add wave -noupdate /SYC_PC_MEM_LOOP_8BIT_TEST/scpu_sram_alu/scpu_ctrl_spi/uut/start
add wave -noupdate /SYC_PC_MEM_LOOP_8BIT_TEST/scpu_sram_alu/scpu_ctrl_spi/uut/clk
add wave -noupdate /SYC_PC_MEM_LOOP_8BIT_TEST/scpu_sram_alu/scpu_ctrl_spi/uut/state
add wave -noupdate /SYC_PC_MEM_LOOP_8BIT_TEST/scpu_sram_alu/scpu_ctrl_spi/ALU_01/FOUT
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {10000 ps} 0} {{Cursor 2} {272450000 ps} 0}
quietly wave cursor active 2
configure wave -namecolwidth 250
configure wave -valuecolwidth 102
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
WaveRestoreZoom {272005103 ps} {272894897 ps}
