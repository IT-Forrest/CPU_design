onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider sram
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_VG_TEST/scpu_sram_alu/CLK
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_VG_TEST/scpu_sram_alu/sram/CLK
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_VG_TEST/scpu_sram_alu/SCPU_CTRL_SPI_CEN
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_VG_TEST/scpu_sram_alu/sram/CEN
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_VG_TEST/scpu_sram_alu/sram/WEN
add wave -noupdate {/SYS_PSEUDO_SPI_INTF_SCAN_VG_TEST/scpu_sram_alu/\scpu_ctrl_spi/uut /IS_I_ADDR}
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_VG_TEST/scpu_sram_alu/sram/Q
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_VG_TEST/scpu_sram_alu/sram/A
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_VG_TEST/scpu_sram_alu/sram/D
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_VG_TEST/scpu_sram_alu/SCPU_CTRL_SPI_D_DATAOUT
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_VG_TEST/scpu_sram_alu/N103
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_VG_TEST/scpu_sram_alu/SCPU_CTRL_SPI_D_WE
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_VG_TEST/scpu_sram_alu/I_CTRL_BGN
add wave -noupdate {/SYS_PSEUDO_SPI_INTF_SCAN_VG_TEST/scpu_sram_alu/\scpu_ctrl_spi/uut /lowest_bit_reg/Q}
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_VG_TEST/scpu_sram_alu/N324
add wave -noupdate {/SYS_PSEUDO_SPI_INTF_SCAN_VG_TEST/scpu_sram_alu/\scpu_ctrl_spi/ALU_01 /RST_N}
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_VG_TEST/scpu_sram_alu/N191
add wave -noupdate {/SYS_PSEUDO_SPI_INTF_SCAN_VG_TEST/scpu_sram_alu/\scpu_ctrl_spi/uut /\pc_reg[0] /QN}
add wave -noupdate {/SYS_PSEUDO_SPI_INTF_SCAN_VG_TEST/scpu_sram_alu/\scpu_ctrl_spi/uut /\pc_reg[1] /QN}
add wave -noupdate {/SYS_PSEUDO_SPI_INTF_SCAN_VG_TEST/scpu_sram_alu/\scpu_ctrl_spi/uut /\pc_reg[2] /QN}
add wave -noupdate {/SYS_PSEUDO_SPI_INTF_SCAN_VG_TEST/scpu_sram_alu/\scpu_ctrl_spi/uut /\pc_reg[3] /QN}
add wave -noupdate {/SYS_PSEUDO_SPI_INTF_SCAN_VG_TEST/scpu_sram_alu/\scpu_ctrl_spi/uut /\pc_reg[4] /QN}
add wave -noupdate {/SYS_PSEUDO_SPI_INTF_SCAN_VG_TEST/scpu_sram_alu/\scpu_ctrl_spi/uut /\pc_reg[5] /QN}
add wave -noupdate {/SYS_PSEUDO_SPI_INTF_SCAN_VG_TEST/scpu_sram_alu/\scpu_ctrl_spi/uut /\pc_reg[6] /QN}
add wave -noupdate {/SYS_PSEUDO_SPI_INTF_SCAN_VG_TEST/scpu_sram_alu/\scpu_ctrl_spi/uut /\pc_reg[7] /QN}
add wave -noupdate -divider spi_module
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_VG_TEST/coe_ctrl_bgn_export
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_VG_TEST/coe_ctrl_load_export
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_VG_TEST/coe_ctrl_si_export
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_VG_TEST/coe_ctrl_rdy_export
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_VG_TEST/FOUT
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_VG_TEST/CFSA_FOUT
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_VG_TEST/LAT_dly
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_VG_TEST/SCLK1_dly
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_VG_TEST/SCLK2_dly
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_VG_TEST/SPI_SO_dly
add wave -noupdate {/SYS_PSEUDO_SPI_INTF_SCAN_VG_TEST/scpu_sram_alu/\scpu_ctrl_spi/uut /STATE}
add wave -noupdate {/SYS_PSEUDO_SPI_INTF_SCAN_VG_TEST/scpu_sram_alu/\scpu_ctrl_spi/uut /\state_reg[3] /QN}
add wave -noupdate {/SYS_PSEUDO_SPI_INTF_SCAN_VG_TEST/scpu_sram_alu/\scpu_ctrl_spi/uut /\state_reg[2] /Q}
add wave -noupdate {/SYS_PSEUDO_SPI_INTF_SCAN_VG_TEST/scpu_sram_alu/\scpu_ctrl_spi/uut /\state_reg[1] /Q}
add wave -noupdate {/SYS_PSEUDO_SPI_INTF_SCAN_VG_TEST/scpu_sram_alu/\scpu_ctrl_spi/uut /\state_reg[0] /Q}
add wave -noupdate {/SYS_PSEUDO_SPI_INTF_SCAN_VG_TEST/scpu_sram_alu/\scpu_ctrl_spi/uut /NEXT_STATE}
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_VG_TEST/fpga/csi_clk
add wave -noupdate {/SYS_PSEUDO_SPI_INTF_SCAN_VG_TEST/scpu_sram_alu/\scpu_ctrl_spi/cct/ctrl_state_reg[1] /CK}
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_VG_TEST/CPU_BGN
add wave -noupdate {/SYS_PSEUDO_SPI_INTF_SCAN_VG_TEST/scpu_sram_alu/\scpu_ctrl_spi/uut /START}
add wave -noupdate -divider ctrl_logic
add wave -noupdate -radix unsigned /SYS_PSEUDO_SPI_INTF_SCAN_VG_TEST/fpga/cnt_bit_load
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_VG_TEST/fpga/reg_sram_all
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_VG_TEST/fpga/CTRL_SO
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_VG_TEST/fpga/reg_LOAD
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_VG_TEST/fpga/reg_ctrl_mode
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_VG_TEST/scpu_sram_alu/RST_N
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_VG_TEST/fpga/reg_sram_addr
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_VG_TEST/fpga/reg_sram_data
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_VG_TEST/fpga/is_LOAD
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_VG_TEST/fpga/is_load2_ctrl
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_VG_TEST/fpga/is_rfrom_ctrl
add wave -noupdate {/SYS_PSEUDO_SPI_INTF_SCAN_VG_TEST/scpu_sram_alu/\scpu_ctrl_spi/cct/reg_bits_reg[0] /Q}
add wave -noupdate -group SCPU_CTRL_SPI_CCT_REG_BITS {/SYS_PSEUDO_SPI_INTF_SCAN_VG_TEST/scpu_sram_alu/\SCPU_CTRL_SPI_CCT_REG_BITS[1] }
add wave -noupdate -group SCPU_CTRL_SPI_CCT_REG_BITS {/SYS_PSEUDO_SPI_INTF_SCAN_VG_TEST/scpu_sram_alu/\SCPU_CTRL_SPI_CCT_REG_BITS[2] }
add wave -noupdate -group SCPU_CTRL_SPI_CCT_REG_BITS {/SYS_PSEUDO_SPI_INTF_SCAN_VG_TEST/scpu_sram_alu/\SCPU_CTRL_SPI_CCT_REG_BITS[3] }
add wave -noupdate -group SCPU_CTRL_SPI_CCT_REG_BITS {/SYS_PSEUDO_SPI_INTF_SCAN_VG_TEST/scpu_sram_alu/\SCPU_CTRL_SPI_CCT_REG_BITS[4] }
add wave -noupdate -group SCPU_CTRL_SPI_CCT_REG_BITS {/SYS_PSEUDO_SPI_INTF_SCAN_VG_TEST/scpu_sram_alu/\SCPU_CTRL_SPI_CCT_REG_BITS[5] }
add wave -noupdate -group SCPU_CTRL_SPI_CCT_REG_BITS {/SYS_PSEUDO_SPI_INTF_SCAN_VG_TEST/scpu_sram_alu/\SCPU_CTRL_SPI_CCT_REG_BITS[6] }
add wave -noupdate -group SCPU_CTRL_SPI_CCT_REG_BITS {/SYS_PSEUDO_SPI_INTF_SCAN_VG_TEST/scpu_sram_alu/\SCPU_CTRL_SPI_CCT_REG_BITS[7] }
add wave -noupdate -group SCPU_CTRL_SPI_CCT_REG_BITS {/SYS_PSEUDO_SPI_INTF_SCAN_VG_TEST/scpu_sram_alu/\SCPU_CTRL_SPI_CCT_REG_BITS[8] }
add wave -noupdate -group SCPU_CTRL_SPI_CCT_REG_BITS {/SYS_PSEUDO_SPI_INTF_SCAN_VG_TEST/scpu_sram_alu/\SCPU_CTRL_SPI_CCT_REG_BITS[9] }
add wave -noupdate -group SCPU_CTRL_SPI_CCT_REG_BITS {/SYS_PSEUDO_SPI_INTF_SCAN_VG_TEST/scpu_sram_alu/\SCPU_CTRL_SPI_CCT_REG_BITS[10] }
add wave -noupdate -group SCPU_CTRL_SPI_CCT_REG_BITS {/SYS_PSEUDO_SPI_INTF_SCAN_VG_TEST/scpu_sram_alu/\SCPU_CTRL_SPI_CCT_REG_BITS[11] }
add wave -noupdate -group SCPU_CTRL_SPI_CCT_REG_BITS {/SYS_PSEUDO_SPI_INTF_SCAN_VG_TEST/scpu_sram_alu/\SCPU_CTRL_SPI_CCT_REG_BITS[12] }
add wave -noupdate -group SCPU_CTRL_SPI_CCT_REG_BITS {/SYS_PSEUDO_SPI_INTF_SCAN_VG_TEST/scpu_sram_alu/\SCPU_CTRL_SPI_CCT_REG_BITS[13] }
add wave -noupdate -group SCPU_CTRL_SPI_CCT_REG_BITS {/SYS_PSEUDO_SPI_INTF_SCAN_VG_TEST/scpu_sram_alu/\SCPU_CTRL_SPI_CCT_REG_BITS[14] }
add wave -noupdate -group SCPU_CTRL_SPI_CCT_REG_BITS {/SYS_PSEUDO_SPI_INTF_SCAN_VG_TEST/scpu_sram_alu/\SCPU_CTRL_SPI_CCT_REG_BITS[15] }
add wave -noupdate -group SCPU_CTRL_SPI_CCT_REG_BITS {/SYS_PSEUDO_SPI_INTF_SCAN_VG_TEST/scpu_sram_alu/\SCPU_CTRL_SPI_CCT_REG_BITS[16] }
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_VG_TEST/scpu_sram_alu/I_CTRL_SI
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_VG_TEST/scpu_sram_alu/I_CLK
add wave -noupdate {/SYS_PSEUDO_SPI_INTF_SCAN_VG_TEST/scpu_sram_alu/\scpu_ctrl_spi/cct/CEN_reg /Q}
add wave -noupdate {/SYS_PSEUDO_SPI_INTF_SCAN_VG_TEST/scpu_sram_alu/\scpu_ctrl_spi/cct/ctrl_state_reg[1] /Q}
add wave -noupdate {/SYS_PSEUDO_SPI_INTF_SCAN_VG_TEST/scpu_sram_alu/\scpu_ctrl_spi/cct/ctrl_state_reg[0] /Q}
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_VG_TEST/scpu_sram_alu/I_CTRL_BGN
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_VG_TEST/scpu_sram_alu/I_LOAD_N
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_VG_TEST/scpu_sram_alu/I_CTRL_MODE
add wave -noupdate {/SYS_PSEUDO_SPI_INTF_SCAN_VG_TEST/scpu_sram_alu/\scpu_ctrl_spi/uut /\reg_C_reg[0] /Q}
add wave -noupdate {/SYS_PSEUDO_SPI_INTF_SCAN_VG_TEST/scpu_sram_alu/\scpu_ctrl_spi/uut /\reg_C_reg[1] /Q}
add wave -noupdate {/SYS_PSEUDO_SPI_INTF_SCAN_VG_TEST/scpu_sram_alu/\scpu_ctrl_spi/uut /\reg_C_reg[2] /Q}
add wave -noupdate {/SYS_PSEUDO_SPI_INTF_SCAN_VG_TEST/scpu_sram_alu/\scpu_ctrl_spi/uut /\reg_C_reg[3] /Q}
add wave -noupdate {/SYS_PSEUDO_SPI_INTF_SCAN_VG_TEST/scpu_sram_alu/\scpu_ctrl_spi/uut /\reg_C_reg[4] /Q}
add wave -noupdate {/SYS_PSEUDO_SPI_INTF_SCAN_VG_TEST/scpu_sram_alu/\scpu_ctrl_spi/uut /\reg_C_reg[5] /Q}
add wave -noupdate {/SYS_PSEUDO_SPI_INTF_SCAN_VG_TEST/scpu_sram_alu/\scpu_ctrl_spi/uut /\reg_C_reg[6] /Q}
add wave -noupdate {/SYS_PSEUDO_SPI_INTF_SCAN_VG_TEST/scpu_sram_alu/\scpu_ctrl_spi/uut /\reg_C_reg[7] /Q}
add wave -noupdate {/SYS_PSEUDO_SPI_INTF_SCAN_VG_TEST/scpu_sram_alu/\scpu_ctrl_spi/uut /\reg_C_reg[8] /Q}
add wave -noupdate {/SYS_PSEUDO_SPI_INTF_SCAN_VG_TEST/scpu_sram_alu/\scpu_ctrl_spi/uut /\reg_C_reg[9] /Q}
add wave -noupdate {/SYS_PSEUDO_SPI_INTF_SCAN_VG_TEST/scpu_sram_alu/\scpu_ctrl_spi/uut /\reg_C_reg[10] /Q}
add wave -noupdate {/SYS_PSEUDO_SPI_INTF_SCAN_VG_TEST/scpu_sram_alu/\scpu_ctrl_spi/uut /\reg_C_reg[11] /Q}
add wave -noupdate {/SYS_PSEUDO_SPI_INTF_SCAN_VG_TEST/scpu_sram_alu/\scpu_ctrl_spi/uut /\reg_C_reg[12] /Q}
add wave -noupdate {/SYS_PSEUDO_SPI_INTF_SCAN_VG_TEST/scpu_sram_alu/\scpu_ctrl_spi/uut /\reg_C_reg[13] /Q}
add wave -noupdate {/SYS_PSEUDO_SPI_INTF_SCAN_VG_TEST/scpu_sram_alu/\scpu_ctrl_spi/uut /\reg_C_reg[14] /Q}
add wave -noupdate {/SYS_PSEUDO_SPI_INTF_SCAN_VG_TEST/scpu_sram_alu/\scpu_ctrl_spi/uut /\reg_C_reg[15] /Q}
add wave -noupdate {/SYS_PSEUDO_SPI_INTF_SCAN_VG_TEST/scpu_sram_alu/\scpu_ctrl_spi/uut /\reg_A_reg[0] /Q}
add wave -noupdate {/SYS_PSEUDO_SPI_INTF_SCAN_VG_TEST/scpu_sram_alu/\scpu_ctrl_spi/uut /\reg_A_reg[1] /Q}
add wave -noupdate {/SYS_PSEUDO_SPI_INTF_SCAN_VG_TEST/scpu_sram_alu/\scpu_ctrl_spi/uut /\reg_A_reg[2] /Q}
add wave -noupdate {/SYS_PSEUDO_SPI_INTF_SCAN_VG_TEST/scpu_sram_alu/\scpu_ctrl_spi/uut /\reg_A_reg[3] /Q}
add wave -noupdate {/SYS_PSEUDO_SPI_INTF_SCAN_VG_TEST/scpu_sram_alu/\scpu_ctrl_spi/uut /\reg_A_reg[4] /Q}
add wave -noupdate {/SYS_PSEUDO_SPI_INTF_SCAN_VG_TEST/scpu_sram_alu/\scpu_ctrl_spi/uut /\reg_A_reg[5] /Q}
add wave -noupdate {/SYS_PSEUDO_SPI_INTF_SCAN_VG_TEST/scpu_sram_alu/\scpu_ctrl_spi/uut /\reg_A_reg[6] /Q}
add wave -noupdate {/SYS_PSEUDO_SPI_INTF_SCAN_VG_TEST/scpu_sram_alu/\scpu_ctrl_spi/uut /\reg_A_reg[7] /Q}
add wave -noupdate {/SYS_PSEUDO_SPI_INTF_SCAN_VG_TEST/scpu_sram_alu/\scpu_ctrl_spi/uut /\reg_A_reg[8] /Q}
add wave -noupdate {/SYS_PSEUDO_SPI_INTF_SCAN_VG_TEST/scpu_sram_alu/\scpu_ctrl_spi/uut /\reg_A_reg[9] /Q}
add wave -noupdate {/SYS_PSEUDO_SPI_INTF_SCAN_VG_TEST/scpu_sram_alu/\scpu_ctrl_spi/uut /\reg_A_reg[10] /Q}
add wave -noupdate {/SYS_PSEUDO_SPI_INTF_SCAN_VG_TEST/scpu_sram_alu/\scpu_ctrl_spi/uut /\reg_A_reg[11] /Q}
add wave -noupdate {/SYS_PSEUDO_SPI_INTF_SCAN_VG_TEST/scpu_sram_alu/\scpu_ctrl_spi/uut /\reg_A_reg[13] /Q}
add wave -noupdate {/SYS_PSEUDO_SPI_INTF_SCAN_VG_TEST/scpu_sram_alu/\scpu_ctrl_spi/uut /\reg_A_reg[14] /Q}
add wave -noupdate {/SYS_PSEUDO_SPI_INTF_SCAN_VG_TEST/scpu_sram_alu/\scpu_ctrl_spi/uut /\reg_A_reg[15] /Q}
add wave -noupdate {/SYS_PSEUDO_SPI_INTF_SCAN_VG_TEST/scpu_sram_alu/\scpu_ctrl_spi/uut /\reg_B_reg[0] /Q}
add wave -noupdate {/SYS_PSEUDO_SPI_INTF_SCAN_VG_TEST/scpu_sram_alu/\scpu_ctrl_spi/uut /\reg_B_reg[1] /Q}
add wave -noupdate {/SYS_PSEUDO_SPI_INTF_SCAN_VG_TEST/scpu_sram_alu/\scpu_ctrl_spi/uut /\reg_B_reg[2] /Q}
add wave -noupdate {/SYS_PSEUDO_SPI_INTF_SCAN_VG_TEST/scpu_sram_alu/\scpu_ctrl_spi/uut /\reg_B_reg[3] /Q}
add wave -noupdate {/SYS_PSEUDO_SPI_INTF_SCAN_VG_TEST/scpu_sram_alu/\scpu_ctrl_spi/uut /\reg_B_reg[4] /Q}
add wave -noupdate {/SYS_PSEUDO_SPI_INTF_SCAN_VG_TEST/scpu_sram_alu/\scpu_ctrl_spi/uut /\reg_B_reg[5] /Q}
add wave -noupdate {/SYS_PSEUDO_SPI_INTF_SCAN_VG_TEST/scpu_sram_alu/\scpu_ctrl_spi/uut /\reg_B_reg[6] /Q}
add wave -noupdate {/SYS_PSEUDO_SPI_INTF_SCAN_VG_TEST/scpu_sram_alu/\scpu_ctrl_spi/uut /\reg_B_reg[7] /Q}
add wave -noupdate {/SYS_PSEUDO_SPI_INTF_SCAN_VG_TEST/scpu_sram_alu/\scpu_ctrl_spi/uut /\reg_B_reg[8] /Q}
add wave -noupdate {/SYS_PSEUDO_SPI_INTF_SCAN_VG_TEST/scpu_sram_alu/\scpu_ctrl_spi/uut /\reg_B_reg[9] /Q}
add wave -noupdate {/SYS_PSEUDO_SPI_INTF_SCAN_VG_TEST/scpu_sram_alu/\scpu_ctrl_spi/uut /\reg_B_reg[10] /Q}
add wave -noupdate {/SYS_PSEUDO_SPI_INTF_SCAN_VG_TEST/scpu_sram_alu/\scpu_ctrl_spi/uut /\reg_B_reg[11] /Q}
add wave -noupdate {/SYS_PSEUDO_SPI_INTF_SCAN_VG_TEST/scpu_sram_alu/\scpu_ctrl_spi/uut /\reg_B_reg[12] /Q}
add wave -noupdate {/SYS_PSEUDO_SPI_INTF_SCAN_VG_TEST/scpu_sram_alu/\scpu_ctrl_spi/uut /\reg_B_reg[13] /Q}
add wave -noupdate {/SYS_PSEUDO_SPI_INTF_SCAN_VG_TEST/scpu_sram_alu/\scpu_ctrl_spi/uut /\reg_B_reg[14] /Q}
add wave -noupdate {/SYS_PSEUDO_SPI_INTF_SCAN_VG_TEST/scpu_sram_alu/\scpu_ctrl_spi/uut /\reg_B_reg[15] /Q}
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 2} {27538934 ps} 0} {{Cursor 2} {325703 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 318
configure wave -valuecolwidth 185
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
WaveRestoreZoom {27453703 ps} {27565595 ps}
