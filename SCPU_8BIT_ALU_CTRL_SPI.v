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
    APP_DONE,
    ADC_PI,
    TEST_MUX,
    CPU_WAIT,
    // output
    CTRL_RDY,
    APP_START,
    CTRL_SO,
    //ANA_SO,
    NXT,
    //SEL,
    SCLK1,
    SCLK2,
    LAT,
    SPI_SO
    );

    parameter   MEMORY_DATA_WIDTH   = 8,
                MEMORY_ADDR_WIDTH   = 10,
                RESERVED_DATA_LEN   = 8;
    parameter   GENERAL_REG_WIDTH   = 16;

    // Inputs
    input   CLK;
    input   RST_N;
    input   [1:0]  CTRL_MODE;
    input   CTRL_BGN;
    input   CPU_BGN;
    input   LOAD_N;
    input   CTRL_SI;
    input   APP_DONE;
    input   [9:0]   ADC_PI;
    input   [2:0]   TEST_MUX;
    input   CPU_WAIT;
    
    // Output
    output  CTRL_RDY;
    output  APP_START;
    output  CTRL_SO;
    //output  ANA_SO;
    output  [1:0]   NXT;
    //output  SEL;
    output  SCLK1;
    output  SCLK2;
    output  LAT;
    output  SPI_SO;
    
    // I/O with SRAM
    output  CEN_after_mux;
    output  WEN_after_mux;
    output  [MEMORY_ADDR_WIDTH-1:0] A_after_mux;
    output  [MEMORY_DATA_WIDTH-1:0] D_after_mux;
    input   [MEMORY_DATA_WIDTH-1:0] Q_from_SRAM;
    
    // Wires
    wire [1:0] i_NXT;
    wire is_i_addr;
    wire enable;// enable signal for CTRL_SRAM
    wire [MEMORY_DATA_WIDTH-1:0]  i_datain;
    wire [MEMORY_DATA_WIDTH-1:0]  d_datain;
    wire [MEMORY_DATA_WIDTH-1:0]  d_dataout;
    wire [MEMORY_DATA_WIDTH-1:0]  m_datain;

    wire [MEMORY_DATA_WIDTH-1:0]  m_dataout;
    wire [MEMORY_ADDR_WIDTH-1:0]  m_addr;
    wire [MEMORY_ADDR_WIDTH-1:0]  i_addr;
    wire [MEMORY_ADDR_WIDTH-1:0]  d_addr;
    
    wire [MEMORY_DATA_WIDTH-1:0]  PI_from_SRAM;
    wire [MEMORY_ADDR_WIDTH-1:0]  A_from_CTRL;
    wire [MEMORY_DATA_WIDTH-1:0]  PO_from_CTRL;
   
    // Super ALU's connection
    parameter   IO_CTRL_MODEL_END   = 0,
                IO_CTRL_MODEL_BGN   = 1,
                IO_CTRL_ALU_END     = 2,
                IO_CTRL_ALU_BGN     = 4,
                IO_ALU_STA          = 5,
                IO_SPI_STA          = 6,
                IO_APP_STA          = 7;
    parameter   IO_STAT_ALU_DONE    = 0,
                IO_STAT_SPI_DONE    = 1,
                IO_STAT_APP_DONE    = 2;// exterior app is done
   
    wire    [GENERAL_REG_WIDTH-1:0] io_status;
    wire    [GENERAL_REG_WIDTH-1:0] io_control;
    wire    [GENERAL_REG_WIDTH-1:0] io_datainA;
    wire    [GENERAL_REG_WIDTH-1:0] io_datainB;
    wire    [GENERAL_REG_WIDTH-1:0] io_dataoutA;
    wire    [GENERAL_REG_WIDTH-1:0] io_dataoutB;
    wire    [GENERAL_REG_WIDTH-1:0] io_offset;
    // for debug
    wire    [5:0]   i_pc;
    wire    [5:0]   i_reg_C;
   
    // Instantiate the Unit Under Test (UUT)
    SERIAL_CPU_8BIT uut (
        .clk(CLK), 
        .enable(enable), 
        .rst_n(RST_N), 
        .start(CPU_BGN), 
        .i_datain(i_datain), 
        .d_datain(d_datain), 
        .CPU_WAIT(CPU_WAIT),
        // output
        .is_i_addr(is_i_addr),
        .nxt(i_NXT),
        .i_addr(i_addr), 
        .d_addr(d_addr), 
        .d_we(D_WE),
        .d_dataout(d_dataout),
        .io_status(io_status),
        .io_control(io_control),
        .io_datainA(io_datainA),
        .io_datainB(io_datainB),
        .io_dataoutA(io_dataoutA),
        .io_dataoutB(io_dataoutB),
        .io_offset(io_offset),
        .i_pc(i_pc),
        .i_reg_C(i_reg_C)
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
    
    parameter   ALU_MULTIPLY    = 3'b100,
                ALU_DIVISION    = 3'b010,
                ALU_SQRTPOWS    = 3'b001;
    parameter   MULTI_PURE      = 2'b00,// multiply a pure fraction
                MULTI_FRAC      = 2'b01,// multiply a fraction like 1.4
                MULTI_MAXM      = 2'b10;// multiply a fraction like 2.3, then bound to 2
    parameter   SA_DIV          = 2'b00,
                CF_T27          = 2'b01,
                CF_T36          = 2'b10;

    parameter   CADC_WIDTH      = 10,
                MAX_SQRT_WIDTH  = 13;
    wire    [MAX_SQRT_WIDTH-1:0]  X_IN, Y_IN;
    wire    [MAX_SQRT_WIDTH-1:0]  FOUT, POUT;
    wire    [2:0]   alu_type;
    wire    [1:0]   mode_type;
    wire    [CADC_WIDTH-1:0]      OFFSET;
    wire    alu_start, alu_is_done;
    
    SHARE_SUPERALU   ALU_01(.CLK(CLK),
                        .RST_N(RST_N),
                        .X_IN(X_IN),//multiplicand
                        .Y_IN(Y_IN),//multiplier
                        .alu_start(alu_start),//multiply_start || division_start || sqrt_pow_start
                        .alu_type(alu_type),
                        .mode_type(mode_type),
                        .OFFSET(OFFSET),//10'd0;//10'd507
                        //output
                        .FOUT(FOUT),//multiplication
                        .POUT(POUT),
                        .alu_is_done(alu_is_done));

    //// Exterior Analog Control Signal
    assign  APP_START = io_control[IO_APP_STA];
    
    //// Output Scan Chain Control Module
    wire    spi_start;
    wire    spi_is_done;
    wire    [MEMORY_ADDR_WIDTH-1:0] addr_end;
    wire    [RESERVED_DATA_LEN-1:0] data_len;
    wire    [MEMORY_ADDR_WIDTH-1:0] A_from_SPI;
    wire    [MEMORY_ADDR_WIDTH-1:0] A_spi;
    wire    i_SCLK1;
    wire    i_SCLK2;
    wire    i_LAT;
    wire    i_SPI_SO;
    
    PSEUDO_SPT_INTF     put(
        //input
        .CLK        (CLK        ),
        .BGN        (spi_start  ),
        .ADDR_BGN   (addr_end   ),
        .DATA_LEN   (data_len   ),
        //.FREQ_DIV   (freq_div   ),
        .PI         (m_dataout  ),
        //output
        .SCLK1      (i_SCLK1      ),
        .SCLK2      (i_SCLK2      ),
        .LAT        (i_LAT        ),//LAT for write; SEL for read
        .SPI_SO     (i_SPI_SO     ),
        .CEN        (CEN_spi    ),
        .A          (A_spi ),
        .D_WE       (d_we_spi   ),//memory read or write signal, 1: write
        .spi_MUX    (spi_MUX    ),
        .spi_is_done(spi_is_done)
    );
    
    // wire connections between ALU and CPU
    assign  X_IN = io_dataoutA[MAX_SQRT_WIDTH-1:0];
    assign  Y_IN = io_dataoutB[MAX_SQRT_WIDTH-1:0];
    assign  OFFSET    = io_offset[CADC_WIDTH-1:0];
    assign  alu_start = io_control[IO_ALU_STA];
    assign  alu_type  = io_control[IO_CTRL_ALU_BGN:IO_CTRL_ALU_END];
    assign  mode_type = io_control[IO_CTRL_MODEL_BGN:IO_CTRL_MODEL_END];
    
    // wire connections GPIO and CPU
    assign  io_status  = {{(GENERAL_REG_WIDTH-3){1'b0}}, APP_DONE, spi_is_done, alu_is_done};
    assign  io_datainA = (alu_start)?{{(GENERAL_REG_WIDTH-MAX_SQRT_WIDTH){1'b0}},FOUT}:
                                {{(GENERAL_REG_WIDTH-10){1'b0}},ADC_PI};
    assign  io_datainB = {{(GENERAL_REG_WIDTH-MAX_SQRT_WIDTH){1'b0}},POUT};

    // wire connections between SPI module and CPU
    assign  addr_end   = io_dataoutA[MEMORY_ADDR_WIDTH-1:0];
    assign  data_len   = io_dataoutB[RESERVED_DATA_LEN-1:0];
    assign  spi_start       = io_control[IO_SPI_STA];
    assign  CEN_from_SPI    = (spi_MUX)?CEN_spi:1'b0;//enable
    assign  A_from_SPI      = (spi_MUX)?A_spi:m_addr;
    assign  WEN_from_SPI    = (spi_MUX)?1'b1:(!D_WE);
    
    /* Mux & Demux from CTRL and CPU to SRAM */
    assign  LOAD_MUX = CTRL_BGN;
    assign  CEN_after_mux   = (LOAD_MUX)?CEN:CEN_from_SPI;
    assign  WEN_after_mux   = (LOAD_MUX)?WEN:WEN_from_SPI; //low active
    assign  A_after_mux     = (LOAD_MUX)?A_from_CTRL:A_from_SPI;
    assign  D_after_mux     = (LOAD_MUX)?PO_from_CTRL:m_datain;
    
    assign  PI_from_SRAM    = (LOAD_MUX)?Q_from_SRAM:0;
    assign  m_dataout       = (LOAD_MUX)?0:Q_from_SRAM;
    
    /* Mux & Demux for CPU's data and addr paths */
    assign  m_addr   = (is_i_addr)?i_addr:d_addr;
    assign  m_datain = d_dataout;
    assign  i_datain = (is_i_addr)?m_dataout:0;
    assign  d_datain = (is_i_addr)?0:m_dataout;
    
    /* Mux for CPU debug */
    assign  {NXT, SCLK1, SCLK2, LAT, SPI_SO} = 
        (TEST_MUX == 3'b000)? {i_NXT, i_SCLK1, i_SCLK2, i_LAT, i_SPI_SO}:
        (TEST_MUX == 3'b001)? FOUT[5:0]       :
        (TEST_MUX == 3'b010)? io_datainA[5:0] :
        (TEST_MUX == 3'b011)? io_datainB[5:0] :
        (TEST_MUX == 3'b100)? io_status[5:0]  :
        (TEST_MUX == 3'b101)? Q_from_SRAM[5:0]:
        (TEST_MUX == 3'b110)? i_pc: i_reg_C;//(TEST_MUX == 3'b111)? 
    
endmodule
`endif//SCPU_8BIT_ALU_CTRL_SPI_V
