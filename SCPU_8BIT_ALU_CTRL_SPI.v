//+FHDR****************************************************************
// ECE department, TAMU
// --------------------------------------------------------------------
// FILE NAME    : SCPU_8BIT_ALU_CTRL_SPI.v
// AUTHER       : Jiafan Wang
// DATE         : 06/27/2016
// VERSION      : 1.0
// PURPOSE      : SCPU_8bit, ALU and 3 CTRL modules (SRAM_CTRL, LOGIC_CTRL, PSEUDO_SPI)
//                This module is isolated from SRAM and synthesized with standard cells
// --------------------------------------------------------------------
// ABSTRACT: ModelSim simulation time 6us given each time period 10ns
// --------------------------------------------------------------------
`timescale 1ns / 1ps
`include "DEFINE_CPU.v"
`include "SERIAL_CPU_8bit.v"
`include "SHARE_SUPERALU.v"
`include "SRAM_IO_CTRL.v"
`include "PSEUDO_SPI_INTF.v"

`ifndef SCPU_8BIT_ALU_CTRL_SPI_V
`define SCPU_8BIT_ALU_CTRL_SPI_V

module SCPU_8BIT_ALU_CTRL_SPI(
    // I/O with SRAM
    CEN_after_mux,
    WEN_after_mux,
    A_after_mux,
    D_after_mux,
    Q_from_SRAM,
    // input
    CLK,
    RST_N,
    CTRL_MODE,
    CTRL_BGN,
    CPU_BGN,
    LOAD_N,
    CTRL_SI,
    ANA_SI,
    // output
    CTRL_RDY,
    ANA_RDY,
    CTRL_SO,
    ANA_SO,
    NXT,
    SEL,
    SCLK1,
    SCLK2,
    LAT
    // CLRN,
    // CLK_ADC,
    // RSTN_ADC
    );

   parameter    MEMORY_DATA_WIDTH   = 8,
                MEMORY_ADDR_WIDTH   = 9,
                REG_BITS_WIDTH = MEMORY_ADDR_WIDTH + MEMORY_DATA_WIDTH;
   
    // Inputs
    input   CLK;
    input   RST_N;
    input   [1:0]  CTRL_MODE;
    input   CTRL_BGN;
    input   CPU_BGN;
    input   LOAD_N;
    input   CTRL_SI;
    input   ANA_SI;
    
    // Output
    output  CTRL_RDY;
    output  ANA_RDY;
    output  CTRL_SO;
    output  ANA_SO;
    output  [1:0]   NXT;
    output  SEL;
    output  SCLK1;
    output  SCLK2;
    output  LAT;
    // output  CLRN;
    // output  CLK_ADC;
    // output  RSTN_ADC;
    
    // I/O with SRAM
    output  CEN_after_mux;
    output  WEN_after_mux;
    output  [MEMORY_ADDR_WIDTH-1:0] A_after_mux;
    output  [MEMORY_DATA_WIDTH-1:0] D_after_mux;
    input   [MEMORY_DATA_WIDTH-1:0] Q_from_SRAM;
    
    // Wires
    // wire is_i_addr;
    wire enable;// enable signal for CTRL_SRAM
    wire [7:0]  i_datain;
    wire [7:0]  d_datain;
    wire [7:0]  d_dataout;
    wire [7:0]  m_datain;

    wire [7:0]  m_dataout;
    wire [8:0]  m_addr;
    wire [8:0]  i_addr;
    wire [8:0]  d_addr;
    
    wire [7:0]  PI_from_SRAM;
    wire [8:0]  A_from_CTRL;
    wire [7:0]  PO_from_CTRL;
   
    // Super ALU's connection
    parameter   GENERAL_REG_WIDTH = 16;
    parameter   IO_CTRL_MODEL_END   = 0,
                IO_CTRL_MODEL_BGN   = 1,
                IO_CTRL_ALU_END     = 2,
                IO_CTRL_ALU_BGN     = 4,
                IO_ALU_STA          = 5,
                IO_PLL_STA          = 6,
                IO_MEAS_STA         = 7;
    parameter   IO_STAT_ALU_DONE    = 0,
                IO_STAT_CTRL_DONE   = 1;
   
    wire    [GENERAL_REG_WIDTH-1:0] io_status;
    wire    [GENERAL_REG_WIDTH-1:0] io_control;
    wire    [GENERAL_REG_WIDTH-1:0] io_datainA;
    wire    [GENERAL_REG_WIDTH-1:0] io_datainB;
    wire    [GENERAL_REG_WIDTH-1:0] io_dataoutA;
    wire    [GENERAL_REG_WIDTH-1:0] io_dataoutB;   
   
    // Instantiate the Unit Under Test (UUT)
    SERIAL_CPU_8BIT uut (
        .clk(CLK), 
        .enable(enable), 
        .rst_n(RST_N), 
        .start(CPU_BGN), 
        .i_datain(i_datain), 
        .d_datain(d_datain), 
        // output
        .is_i_addr(is_i_addr),
        .nxt(NXT),
        .i_addr(i_addr), 
        .d_addr(d_addr), 
        .d_we(D_WE),
        .d_dataout(d_dataout),
        .io_status(io_status),
        .io_control(io_control),
        .io_datainA(io_datainA),
        .io_datainB(io_datainB),
        .io_dataoutA(io_dataoutA),
        .io_dataoutB(io_dataoutB)
    );
   
    // Instantiate the Control Unit Test (CUT)
    SRAM_IO_CTRL cct (
        .CLK(CLK),
        .BGN(CTRL_BGN),
        .SI(CTRL_SI),
        .LOAD_N(LOAD_N),
        .CTRL(CTRL_MODE),
        .PI(PI_from_SRAM),
        .RDY(CTRL_RDY),
        .D_WE(WEN),
        .CEN(CEN),
        .SO(CTRL_SO),
        .A(A_from_CTRL),
        .PO(PO_from_CTRL)
    );
    
    // RA1SHD_IBM512X8   sram (
        // .CLK(CLK),
        // .CEN(CEN_after_mux), 
        // .A(A_after_mux),
        // //need a seperate control signal; or instruction set will be overwritten when d_we=1
        // .WEN(WEN_after_mux),
        // .D(D_after_mux),//i_instruct
        // .Q(Q_from_SRAM)
    // );

    parameter   ALU_MULTIPLY    = 3'b100,
                ALU_DIVISION    = 3'b010,
                ALU_SQRTPOWS    = 3'b001;
    parameter   MULTI_PURE      = 2'b00,// multiply a pure fraction
                MULTI_FRAC      = 2'b01,// multiply a fraction like 1.4
                MULTI_MAXM      = 2'b10;// multiply a fraction like 2.3, then bound to 2
    parameter   SA_DIV          = 2'b00,
                CF_T27          = 2'b01,
                CF_T36          = 2'b10;

    parameter   MAX_SQRT_WIDTH  = 13;
    wire    [MAX_SQRT_WIDTH-1:0]  X_IN, Y_IN;
    wire    [MAX_SQRT_WIDTH-1:0]  FOUT, POUT;
    wire    [2:0]   alu_type;
    wire    [1:0]   mode_type;
    wire    alu_start, alu_is_done;
    
    SHARE_SUPERALU   ALU_01(.CLK(CLK),
                        .RST_N(RST_N),
                        .X_IN(X_IN),//multiplicand
                        .Y_IN(Y_IN),//multiplier
                        .alu_start(alu_start),//multiply_start || division_start || sqrt_pow_start
                        .alu_type(alu_type),
                        .mode_type(mode_type),
                        .OFFSET(10'd0),//OFFSET;//10'd507
                        //where to get offset??

                        .FOUT(FOUT),//multiplication
                        .POUT(POUT),
                        .alu_is_done(alu_is_done));

     /*CTRL_LOGIC  CTRL_02(
                    // Input
                    .CLK(CLK),
                    .set_wait_pll_start(pll_start),
                    .set_meas_adc_start(meas_start),
                    
                    // Output
                    .meas_adc_is_done(meas_is_done),
                    .wait_pll_is_done(pll_is_done),
                    .RSTN_ADC(RSTN_ADC),
                    .CLK_ADC(CLK_ADC),
                    .CLRN(CLRN)); */

    //// Analog Control Module
    PSEUDO_SPT_INTF     put(
        //input
        .CLK        (CLK        ),
        .BGN        (SPI_BGN    ),
        .ADDR_BGN   (addr_end   ),
        .DATA_LEN   (data_len   ),
        .FREQ_DIV   (freq_div   ),
        .PI         (m_dataout  ),
        //output
        .SCLK1      (SCLK1      ),
        .SCLK2      (SCLK2      ),
        .LAT        (LAT        ),//LAT for read; SEL for write
        .SPI_SO     (SPI_SO     ),
        .CEN        (CEN_put    ),
        .A          (m_addr_put ),
        .D_WE       (d_we_put   ),//memory read or write signal, 1: write
        .spi_is_done(spi_is_done)
    );
    
    // wire connections between ALU and CPU
    assign  X_IN = io_dataoutA[MAX_SQRT_WIDTH-1:0];
    assign  Y_IN = io_dataoutB[MAX_SQRT_WIDTH-1:0];
    assign  alu_start = io_control[IO_ALU_STA];
    assign  alu_type = io_control[IO_CTRL_ALU_BGN:IO_CTRL_ALU_END];
    assign  mode_type = io_control[IO_CTRL_MODEL_BGN:IO_CTRL_MODEL_END];
    assign  pll_start = io_control[IO_PLL_STA];
    assign  meas_start = io_control[IO_MEAS_STA];
    
    // wire connections between CTRL module and CPU
    assign  io_status = {{(GENERAL_REG_WIDTH-3){1'b0}}, meas_is_done, pll_is_done, alu_is_done};
    assign  io_datainA = {{(GENERAL_REG_WIDTH-MAX_SQRT_WIDTH){1'b0}},FOUT};
    assign  io_datainB = {{(GENERAL_REG_WIDTH-MAX_SQRT_WIDTH){1'b0}},POUT};
    // how to get the ADC value??????

    parameter   DEFAULT_PC_ADDR = 16;
    //defparam    uut.DEFAULT_PC_ADDR = DEFAULT_PC_ADDR;

    /* Mux & Demux from CTRL and CPU to SRAM */
    assign  LOAD_MUX = CTRL_BGN;
    assign  CEN_after_mux = (LOAD_MUX)?CEN:1'b0;//enable
    assign  WEN_after_mux = (LOAD_MUX)?WEN:(!D_WE); //low active
    assign  D_after_mux = (LOAD_MUX)?PO_from_CTRL:m_datain;
    assign  A_after_mux = (LOAD_MUX)?A_from_CTRL:m_addr;
    assign  PI_from_SRAM = (LOAD_MUX)?Q_from_SRAM:0;
    assign  m_dataout = (LOAD_MUX)?0:Q_from_SRAM;
    
    /* Mux & Demux for CPU's data and addr paths */
    assign  m_addr = (is_i_addr)?i_addr:d_addr;
    assign  m_datain = d_dataout;
    assign  i_datain = (is_i_addr)?m_dataout:0;
    assign  d_datain = (is_i_addr)?0:m_dataout;
     
endmodule
`endif//SCPU_8BIT_ALU_CTRL_SPI_V
