onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /PSEUDO_SPI_INTF_RA1512_TEST/CLK
add wave -noupdate /PSEUDO_SPI_INTF_RA1512_TEST/is_intf_flag
add wave -noupdate -radix unsigned /PSEUDO_SPI_INTF_RA1512_TEST/m_addr
add wave -noupdate /PSEUDO_SPI_INTF_RA1512_TEST/d_we
add wave -noupdate /PSEUDO_SPI_INTF_RA1512_TEST/CEN
add wave -noupdate /PSEUDO_SPI_INTF_RA1512_TEST/SPI_SO
add wave -noupdate -radix unsigned /PSEUDO_SPI_INTF_RA1512_TEST/error_cnt
add wave -noupdate -divider PSEUDO_INTF
add wave -noupdate /PSEUDO_SPI_INTF_RA1512_TEST/SPI_BGN
add wave -noupdate -radix unsigned /PSEUDO_SPI_INTF_RA1512_TEST/put/A
add wave -noupdate /PSEUDO_SPI_INTF_RA1512_TEST/SCLK1
add wave -noupdate /PSEUDO_SPI_INTF_RA1512_TEST/SCLK2
add wave -noupdate /PSEUDO_SPI_INTF_RA1512_TEST/LAT
add wave -noupdate /PSEUDO_SPI_INTF_RA1512_TEST/spi_is_done
add wave -noupdate -radix unsigned /PSEUDO_SPI_INTF_RA1512_TEST/put/sram_addr
add wave -noupdate /PSEUDO_SPI_INTF_RA1512_TEST/put/sram_regs
add wave -noupdate /PSEUDO_SPI_INTF_RA1512_TEST/put/spi_state
add wave -noupdate /PSEUDO_SPI_INTF_RA1512_TEST/put/cnt_state
add wave -noupdate -radix unsigned /PSEUDO_SPI_INTF_RA1512_TEST/put/cnt_bit_sent
add wave -noupdate -radix unsigned /PSEUDO_SPI_INTF_RA1512_TEST/put/cnt_addr_len
add wave -noupdate -divider SRAM
add wave -noupdate /PSEUDO_SPI_INTF_RA1512_TEST/sram/Q
add wave -noupdate /PSEUDO_SPI_INTF_RA1512_TEST/sram/CEN
add wave -noupdate /PSEUDO_SPI_INTF_RA1512_TEST/sram/WEN
add wave -noupdate -radix unsigned /PSEUDO_SPI_INTF_RA1512_TEST/sram/A
add wave -noupdate /PSEUDO_SPI_INTF_RA1512_TEST/sram/D
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {25805709 ps} 0}
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
WaveRestoreZoom {25753856 ps} {25859718 ps}
