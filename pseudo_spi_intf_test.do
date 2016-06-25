onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /PSEUDO_SPI_INTF_TEST/put/CLK
add wave -noupdate /PSEUDO_SPI_INTF_TEST/put/BGN
add wave -noupdate -radix hexadecimal /PSEUDO_SPI_INTF_TEST/put/ADDR_BGN
add wave -noupdate -radix unsigned /PSEUDO_SPI_INTF_TEST/put/DATA_LEN
add wave -noupdate /PSEUDO_SPI_INTF_TEST/put/PI
add wave -noupdate /PSEUDO_SPI_INTF_TEST/put/SCLK1
add wave -noupdate /PSEUDO_SPI_INTF_TEST/put/SCLK2
add wave -noupdate /PSEUDO_SPI_INTF_TEST/put/LAT
add wave -noupdate /PSEUDO_SPI_INTF_TEST/put/SPI_SO
add wave -noupdate -radix unsigned /PSEUDO_SPI_INTF_TEST/put/A
add wave -noupdate /PSEUDO_SPI_INTF_TEST/put/D_WE
add wave -noupdate /PSEUDO_SPI_INTF_TEST/put/spi_is_done
add wave -noupdate /PSEUDO_SPI_INTF_TEST/put/CEN
add wave -noupdate -divider spi_state
add wave -noupdate /PSEUDO_SPI_INTF_TEST/put/spi_state
add wave -noupdate -radix unsigned /PSEUDO_SPI_INTF_TEST/put/cnt_state
add wave -noupdate -radix unsigned /PSEUDO_SPI_INTF_TEST/put/cnt_bit_sent
add wave -noupdate -radix unsigned /PSEUDO_SPI_INTF_TEST/put/cnt_addr_len
add wave -noupdate /PSEUDO_SPI_INTF_TEST/m_dataout
add wave -noupdate /PSEUDO_SPI_INTF_TEST/m_addr
add wave -noupdate /PSEUDO_SPI_INTF_TEST/rst_n
add wave -noupdate -divider MEM
add wave -noupdate /PSEUDO_SPI_INTF_TEST/i_mem/addr
add wave -noupdate /PSEUDO_SPI_INTF_TEST/i_mem/dataout
add wave -noupdate /PSEUDO_SPI_INTF_TEST/i_mem/rst_n
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {7051937 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 218
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
WaveRestoreZoom {6948085 ps} {7155789 ps}
