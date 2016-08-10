onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider sram
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_VG_TEST/scpu_sram_alu/CLK
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_VG_TEST/scpu_sram_alu/sram/CLK
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_VG_TEST/scpu_sram_alu/SCPU_CTRL_SPI_CEN
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_VG_TEST/scpu_sram_alu/sram/CEN
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_VG_TEST/scpu_sram_alu/sram/WEN
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_VG_TEST/scpu_sram_alu/sram/Q
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_VG_TEST/scpu_sram_alu/sram/A
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_VG_TEST/scpu_sram_alu/sram/D
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_VG_TEST/scpu_sram_alu/SCPU_CTRL_SPI_D_DATAOUT
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_VG_TEST/scpu_sram_alu/SCPU_CTRL_SPI_D_WE
add wave -noupdate -divider spi_module
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_VG_TEST/coe_ctrl_bgn_export
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_VG_TEST/coe_ctrl_load_export
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_VG_TEST/coe_ctrl_si_export
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_VG_TEST/coe_ctrl_rdy_export
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_VG_TEST/CFSA_FOUT
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_VG_TEST/LAT_dly
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_VG_TEST/SCLK1_dly
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_VG_TEST/SCLK2_dly
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_VG_TEST/SPI_SO_dly
add wave -noupdate -divider ctrl_logic
add wave -noupdate -radix unsigned /SYS_PSEUDO_SPI_INTF_SCAN_VG_TEST/fpga/cnt_bit_load
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_VG_TEST/fpga/reg_sram_all
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_VG_TEST/fpga/CTRL_SO
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_VG_TEST/fpga/reg_LOAD
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_VG_TEST/fpga/reg_ctrl_mode
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_VG_TEST/CPU_BGN
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_VG_TEST/scpu_sram_alu/RST_N
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_VG_TEST/fpga/reg_sram_addr
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_VG_TEST/fpga/reg_sram_data
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_VG_TEST/fpga/is_LOAD
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_VG_TEST/fpga/is_load2_ctrl
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_VG_TEST/fpga/is_rfrom_ctrl
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_VG_TEST/fpga/csi_clk
add wave -noupdate {/SYS_PSEUDO_SPI_INTF_SCAN_VG_TEST/scpu_sram_alu/\scpu_ctrl_spi/cct/ctrl_state_reg[1] /CK}
add wave -noupdate {/SYS_PSEUDO_SPI_INTF_SCAN_VG_TEST/scpu_sram_alu/\scpu_ctrl_spi/cct/reg_bits_reg[0] /Q}
add wave -noupdate -expand -group SCPU_CTRL_SPI_CCT_REG_BITS {/SYS_PSEUDO_SPI_INTF_SCAN_VG_TEST/scpu_sram_alu/\SCPU_CTRL_SPI_CCT_REG_BITS[1] }
add wave -noupdate -expand -group SCPU_CTRL_SPI_CCT_REG_BITS {/SYS_PSEUDO_SPI_INTF_SCAN_VG_TEST/scpu_sram_alu/\SCPU_CTRL_SPI_CCT_REG_BITS[2] }
add wave -noupdate -expand -group SCPU_CTRL_SPI_CCT_REG_BITS {/SYS_PSEUDO_SPI_INTF_SCAN_VG_TEST/scpu_sram_alu/\SCPU_CTRL_SPI_CCT_REG_BITS[3] }
add wave -noupdate -expand -group SCPU_CTRL_SPI_CCT_REG_BITS {/SYS_PSEUDO_SPI_INTF_SCAN_VG_TEST/scpu_sram_alu/\SCPU_CTRL_SPI_CCT_REG_BITS[4] }
add wave -noupdate -expand -group SCPU_CTRL_SPI_CCT_REG_BITS {/SYS_PSEUDO_SPI_INTF_SCAN_VG_TEST/scpu_sram_alu/\SCPU_CTRL_SPI_CCT_REG_BITS[5] }
add wave -noupdate -expand -group SCPU_CTRL_SPI_CCT_REG_BITS {/SYS_PSEUDO_SPI_INTF_SCAN_VG_TEST/scpu_sram_alu/\SCPU_CTRL_SPI_CCT_REG_BITS[6] }
add wave -noupdate -expand -group SCPU_CTRL_SPI_CCT_REG_BITS {/SYS_PSEUDO_SPI_INTF_SCAN_VG_TEST/scpu_sram_alu/\SCPU_CTRL_SPI_CCT_REG_BITS[7] }
add wave -noupdate -expand -group SCPU_CTRL_SPI_CCT_REG_BITS {/SYS_PSEUDO_SPI_INTF_SCAN_VG_TEST/scpu_sram_alu/\SCPU_CTRL_SPI_CCT_REG_BITS[8] }
add wave -noupdate -expand -group SCPU_CTRL_SPI_CCT_REG_BITS {/SYS_PSEUDO_SPI_INTF_SCAN_VG_TEST/scpu_sram_alu/\SCPU_CTRL_SPI_CCT_REG_BITS[9] }
add wave -noupdate -expand -group SCPU_CTRL_SPI_CCT_REG_BITS {/SYS_PSEUDO_SPI_INTF_SCAN_VG_TEST/scpu_sram_alu/\SCPU_CTRL_SPI_CCT_REG_BITS[10] }
add wave -noupdate -expand -group SCPU_CTRL_SPI_CCT_REG_BITS {/SYS_PSEUDO_SPI_INTF_SCAN_VG_TEST/scpu_sram_alu/\SCPU_CTRL_SPI_CCT_REG_BITS[11] }
add wave -noupdate -expand -group SCPU_CTRL_SPI_CCT_REG_BITS {/SYS_PSEUDO_SPI_INTF_SCAN_VG_TEST/scpu_sram_alu/\SCPU_CTRL_SPI_CCT_REG_BITS[12] }
add wave -noupdate -expand -group SCPU_CTRL_SPI_CCT_REG_BITS {/SYS_PSEUDO_SPI_INTF_SCAN_VG_TEST/scpu_sram_alu/\SCPU_CTRL_SPI_CCT_REG_BITS[13] }
add wave -noupdate -expand -group SCPU_CTRL_SPI_CCT_REG_BITS {/SYS_PSEUDO_SPI_INTF_SCAN_VG_TEST/scpu_sram_alu/\SCPU_CTRL_SPI_CCT_REG_BITS[14] }
add wave -noupdate -expand -group SCPU_CTRL_SPI_CCT_REG_BITS {/SYS_PSEUDO_SPI_INTF_SCAN_VG_TEST/scpu_sram_alu/\SCPU_CTRL_SPI_CCT_REG_BITS[15] }
add wave -noupdate -expand -group SCPU_CTRL_SPI_CCT_REG_BITS {/SYS_PSEUDO_SPI_INTF_SCAN_VG_TEST/scpu_sram_alu/\SCPU_CTRL_SPI_CCT_REG_BITS[16] }
add wave -noupdate {/SYS_PSEUDO_SPI_INTF_SCAN_VG_TEST/scpu_sram_alu/\scpu_ctrl_spi/cct/is_shift_reg /QN}
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_VG_TEST/scpu_sram_alu/I_CTRL_SI
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_VG_TEST/scpu_sram_alu/I_CLK
add wave -noupdate {/SYS_PSEUDO_SPI_INTF_SCAN_VG_TEST/scpu_sram_alu/\scpu_ctrl_spi/cct/CEN_reg /Q}
add wave -noupdate {/SYS_PSEUDO_SPI_INTF_SCAN_VG_TEST/scpu_sram_alu/\scpu_ctrl_spi/cct/ctrl_state_reg[1] /Q}
add wave -noupdate {/SYS_PSEUDO_SPI_INTF_SCAN_VG_TEST/scpu_sram_alu/\scpu_ctrl_spi/cct/ctrl_state_reg[0] /Q}
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_VG_TEST/scpu_sram_alu/I_CTRL_BGN
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_VG_TEST/scpu_sram_alu/I_LOAD_N
add wave -noupdate {/SYS_PSEUDO_SPI_INTF_SCAN_VG_TEST/scpu_sram_alu/\scpu_ctrl_spi/cct/cnt_bit_load_reg[0] /Q}
add wave -noupdate {/SYS_PSEUDO_SPI_INTF_SCAN_VG_TEST/scpu_sram_alu/\scpu_ctrl_spi/cct/cnt_bit_load_reg[1] /Q}
add wave -noupdate {/SYS_PSEUDO_SPI_INTF_SCAN_VG_TEST/scpu_sram_alu/\scpu_ctrl_spi/cct/cnt_bit_load_reg[2] /Q}
add wave -noupdate {/SYS_PSEUDO_SPI_INTF_SCAN_VG_TEST/scpu_sram_alu/\scpu_ctrl_spi/cct/cnt_bit_load_reg[3] /Q}
add wave -noupdate {/SYS_PSEUDO_SPI_INTF_SCAN_VG_TEST/scpu_sram_alu/\scpu_ctrl_spi/cct/cnt_bit_load_reg[4] /Q}
add wave -noupdate {/SYS_PSEUDO_SPI_INTF_SCAN_VG_TEST/scpu_sram_alu/\scpu_ctrl_spi/cct/cnt_bit_load_reg[5] /Q}
add wave -noupdate {/SYS_PSEUDO_SPI_INTF_SCAN_VG_TEST/scpu_sram_alu/\scpu_ctrl_spi/cct/cnt_bit_load_reg[6] /Q}
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_VG_TEST/scpu_sram_alu/I_CTRL_MODE
add wave -noupdate /SYS_PSEUDO_SPI_INTF_SCAN_VG_TEST/scpu_sram_alu/Q_FROM_SRAM
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 2} {66461146 ps} 0} {{Cursor 2} {1779304 ps} 0}
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
WaveRestoreZoom {66171450 ps} {66750842 ps}
