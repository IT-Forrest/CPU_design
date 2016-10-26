##+FHDR****************************************************************
## ECE department, TAMU
## --------------------------------------------------------------------
## FILE NAME    : AT_compile_all.do
## AUTHER       : Jiafan Wang
## DATE         : 07/04/2016
## VERSION      : 1.0
## PURPOSE      : compile verilog files & testbench for Automated Test
## --------------------------------------------------------------------
## ABSTRACT: ModelSim simulation time 6us given each time period 10ns
## --------------------------------------------------------------------

# Usage: do AT_compile_all.do

# Compile the verilog files
vlog -work work DEFINE_CPU.v
vlog -work work D_MEMORY.v
vlog -work work I_MEMORY.v
vlog -work work I_MEMORY_8bit.v
vlog -work work RA1SHD_IBM512X8.v
vlog -work work RA1SHD_IBM1024X8.v
vlog -work work SERIAL_CPU_8bit.v
vlog -work work SHARE_SUPERALU.v
vlog -work work SRAM_IO_CTRL.v
vlog -work work SRAM_IO_CTRL_LOGIC.v
vlog -work work PSEUDO_SPI_INTF.v
vlog -work work SCPU_8BIT_ALU_CTRL_SPI.v
vlog -work work iogpil_cmrf8sf_rvt.v
vlog -work work SCPU_SRAM_8BIT_ALU_SPI_TOP.v
vlog -work work SCPU_SRAM_8BIT_ALU_SPI_TOP_VG.v

# Set & Compile testbench files
set testcases   [list\
SHARE_SUPERALU_MULT_TEST\
SHARE_SUPERALU_DIV_TEST\
SHARE_SUPERALU_CORDIC_TEST\
PSEUDO_SPI_INTF_RA1SHD_TEST\
PSEUDO_SPI_INTF_SCAN_TEST\
PSEUDO_SPI_INTF_TEST\
SCPU_MEM_INST_END_8BIT_TEST\
SCPU_MEM_LOOP_8BIT_TEST\
SCPU_MEM_LOOP_TEST\
SRAM_IO_CTRL_RA1SHD_SCPU_8BIT_TEST\
SRAM_IO_CTRL_RA1SHD_TEST\
SRAM_IO_CTRL_LOGIC_TEST\
SRAM_IO_CTRL_TEST\
SCPU_SRAM_8BIT_ALU_SPI_TOP_TEST\
SYS_SHARE_SUPERALU_CORDIC_TEST\
SYS_SHARE_SUPERALU_MULT_TEST\
SYS_PSEUDO_SPI_INTF_SCAN_TEST\
SYS_PSEUDO_SPI_INTF_SCAN_VG_TEST\
]

foreach case $testcases {
    vlog -work work ./sim/$case.v
}