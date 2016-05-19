//+FHDR****************************************************************
// ECE department, TAMU
// --------------------------------------------------------------------
// FILE NAME    : PCPU_SA_TOP_LEVEL.v
// AUTHER       : Jiafan Wang
// DATE         : 01/07/2016
// VERSION      : 1.0
// PURPOSE      : the top level file of CPU and SA module
// --------------------------------------------------------------------
// ABSTRACT: simulation time 85 us given each time period 20ns
// --------------------------------------------------------------------

`timescale 1ns / 1ps
`include "DEFINE_CPU.v"
//`include "PIPE_CPU.v"
`include "SERIAL_CPU.v"
//`include "I_MEMORY.v"
//`include "D_MEMORY.v"
`include "SHARE_SUPERALU.v"
`include "CTRL_LOGIC.v"
`include "SA_4D_DEFINE_418.v"
`include "SA_4D_CTRL_PATH_418.v"
`include "SA_4D_DATA_PATH_418.v"
`include "SA_4D_TOP_LEVEL_418.v"


`ifndef PCPU_SA_TOP_LEVEL_V
`define PCPU_SA_TOP_LEVEL_V

module PCPU_SA_TOP_LEVEL(
    // Input
    CLK,
    RST_N,
    ADC,
    ADC_RDY,
    ANA_BITS_IN,//input: the reason to do this is to take the ana_bits to SC
    ANA_BITS_OUT,//output
    
    // For Debug
    TEST_MUX,
    TRG_TEST,
    TRDY_TEST,
    NXT_TEST,
    
    // configuration
    FLAG4D,
    RAND_GROUP,
    SS_THRESHOLD,
    OFFSET,
    INIT_TUNE_BITS,
    MAX_SA_ITERATION,
    MAX_SS_ITERATION,
    INITIAL_T_VALUE, 
    STEP_T_VALUE,
    OPT_MODE,
    
    // Output
    SRC,
    OSCD,
    FS,
    PHS,
    CLRN,
    CLK_ADC,
    RSTN_ADC,
    TUNE_BITS
);

    parameter   CADC_WIDTH      = 10,
                ANA_WIDTH       = 8,
                ITER_WIDTH      = 11,
                MAX_T_WIDTH     = 6,
                TUNEREG_WIDTH   = 20,
                CDIV_WIDTH      = 12,
                QUOTIENT_WIDTH  = 9;

    parameter   MULTIPLICAND_WIDTH  = 9,
                MULTIPLIER_WIDTH    = 8,
                MULTIPLICATION_WIDTH = 12,
                RANDOM_WIDTH        = 8;
                
    // Input
    input   CLK;
    input   RST_N;
    input   [CADC_WIDTH-1:0]    ADC;
    input   ADC_RDY;
    input   [ANA_WIDTH-1:0]     ANA_BITS_IN;//input: the reason to do this is to take the ana_bits to SC
    output  [ANA_WIDTH-1:0]     ANA_BITS_OUT;//output
    
    // For Debug
    input    TEST_MUX;
    input    TRG_TEST;
    input    TRDY_TEST;
    input    NXT_TEST;
    
    // configuration
    input   FLAG4D;
    input   RAND_GROUP;
    input   [ANA_WIDTH-1:0]     SS_THRESHOLD;
    input   [CADC_WIDTH-1:0]    OFFSET;
    input   [TUNEREG_WIDTH-1:0] INIT_TUNE_BITS;
    input   [ITER_WIDTH-1:0]    MAX_SA_ITERATION;
    input   [ITER_WIDTH-1:0]    MAX_SS_ITERATION;
    input   [MAX_T_WIDTH-1:0]   INITIAL_T_VALUE; 
    input   [2:0]               STEP_T_VALUE;
    input   OPT_MODE;
    
    output  SRC;
    output  OSCD;
    output  [1:0]   FS;
    output  PHS;
    output  CLRN;
    output  CLK_ADC;
    output  RSTN_ADC;
    output  [TUNEREG_WIDTH-1:0] TUNE_BITS;
    
    // Wires
    wire        start;
    wire [15:0] i_datain;
    wire [15:0] d_datain;
    wire [7:0]  i_addr;
    wire [7:0]  d_addr;
    wire        d_we;
    wire [15:0] d_dataout;

    integer i;

    parameter   GENERAL_REG_WIDTH = 16;
    parameter   IO_CTRL_MOD_END   = 0,
                IO_CTRL_MOD_BGN   = 1,
                IO_CTRL_ALU_END   = 2,
                IO_CTRL_ALU_BGN   = 4,
                IO_CTRL_ALU_STA   = 5,
                IO_CTRL_PLL_STA   = 6,
                IO_CTRL_MEAS_STA  = 7,
                IO_CTRL_ALG_SRC   = 8,
                IO_CTRL_ALG_OSCD  = 9,
                IO_CTRL_ALG_PHS   = 10,
                IO_CTRL_ALG_FS_END  = 11,
                IO_CTRL_ALG_FS_BGN  = 12;

    parameter   IO_STAT_ALU_DONE  = 0,
                IO_STAT_CTRL_DONE = 1;

    wire    [GENERAL_REG_WIDTH-1:0] io_status;
    wire    [GENERAL_REG_WIDTH-1:0] io_control;
    wire    [GENERAL_REG_WIDTH-1:0] io_datainA;
    wire    [GENERAL_REG_WIDTH-1:0] io_datainB;
    wire    [GENERAL_REG_WIDTH-1:0] io_dataoutA;
    wire    [GENERAL_REG_WIDTH-1:0] io_dataoutB;
    
    // Instantiate the Unit Under Test (UUT)
    // PIPE_CPU uut (
    SERIAL_CPU uut (
        .clk(CLK), 
        .enable(1'b1),// enable
        .rst_n(RST_N), 
        .start(start), 
        .i_datain(i_datain), 
        .d_datain(d_datain), 
        .i_addr(i_addr), 
        .d_addr(d_addr), 
        .d_we(d_we), 
        .d_dataout(d_dataout),
        .io_status(io_status),
        .io_control(io_control),
        .io_datainA(io_datainA),
        .io_datainB(io_datainB),
        .io_dataoutA(io_dataoutA),
        .io_dataoutB(io_dataoutB)
    );
    I_MEMORY i_mem (
        .clk(CLK),
        .rst_n(RST_N), 
        .addr(i_addr),
        .d_we(1'b0),// need a seperate control signal; or instruction set will be overwritten when d_we=1
        .datain(16'b0000_0000_0000_0000),//i_instruct
        .dataout(i_datain)
    );
    D_MEMORY d_mem (
        .clk(CLK),
        .rst_n(RST_N), 
        .addr(d_addr),
        .d_we(d_we),
        .datain(d_dataout),
        .dataout(d_datain)
    );

    parameter   CLKPERIOD       = 20;
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
    wire        [MAX_SQRT_WIDTH-1:0]    X_IN, Y_IN;
    wire        [MAX_SQRT_WIDTH-1:0]    FOUT, POUT;
    wire        [2:0]   alu_type;
    wire        [1:0]   mode_type;
    wire        alu_start, alu_is_done;
    
    wire        TUNE_READY;
    //wire        NXT;
    wire        NXT_after_mux;
    wire        RDY_after_mux;
    wire        STA_after_mux;
    wire        [MAX_T_WIDTH-1:0]   multiplicand_SA;
    wire        [RANDOM_WIDTH-1:0]  multiplier_SA;
    wire        [CDIV_WIDTH-1:0]    multiplication;
    wire        set_multiply_start_SA;
    wire        multiply_is_done;

    wire        [CDIV_WIDTH-1:0]    dividend_SA;
    wire        [CDIV_WIDTH-1:0]    dividor_SA;
    wire        [QUOTIENT_WIDTH-1:0]    signed_division;
    wire        set_division_start_SA;
    wire        division_is_done;
    
    SHARE_SUPERALU   ALU_01(.CLK(CLK),
                        .RST_N(RST_N),
                        .X_IN(X_IN),//multiplicand
                        .Y_IN(Y_IN),//multiplier
                        .alu_start(alu_start),//multiply_start || division_start || sqrt_pow_start
                        .alu_type(alu_type),
                        .mode_type(mode_type),
                        .OFFSET(OFFSET),//10'd507

                        .FOUT(FOUT),//multiplication
                        .POUT(POUT),
                        .alu_is_done(alu_is_done));
    
    CTRL_LOGIC  CTRL_02(
                    // Input
                    .CLK(CLK),
                    .set_wait_pll_start(pll_start),
                    .set_meas_adc_start(meas_start),
                    
                    // Output
                    .meas_adc_is_done(meas_is_done),
                    .wait_pll_is_done(pll_is_done),
                    .RSTN_ADC(RSTN_ADC),
                    .CLK_ADC(CLK_ADC),
                    .CLRN(CLRN));
    
    // wire connections between CTRL and CPU and SA
    assign  X_IN = set_multiply_start_SA? multiplicand_SA:
                    set_division_start_SA? dividend_SA:
                    io_dataoutA[MAX_SQRT_WIDTH-1:0];
    assign  Y_IN = set_multiply_start_SA? multiplier_SA:
                    set_division_start_SA? dividor_SA:
                    io_dataoutB[MAX_SQRT_WIDTH-1:0];
    assign  mode_type = (set_multiply_start_SA || set_division_start_SA)?
                    {2'b00}:// trick here since MULTI_FRAC and SA_DIV are all 2'b00 
                    io_control[IO_CTRL_MOD_BGN:IO_CTRL_MOD_END];
    assign  alu_type = (set_multiply_start_SA || set_division_start_SA)?
                    {set_multiply_start_SA, set_division_start_SA, 1'b0}:
                    io_control[IO_CTRL_ALU_BGN:IO_CTRL_ALU_END];
    assign  alu_start = (io_control[IO_CTRL_ALU_STA] || set_multiply_start_SA || set_division_start_SA);
    assign  pll_start = io_control[IO_CTRL_PLL_STA];
    assign  meas_start = io_control[IO_CTRL_MEAS_STA];
    
    // wire connections between CTRL module and CPU and 
    assign  io_status = {{(GENERAL_REG_WIDTH-3){1'b0}}, meas_is_done & ADC_RDY, pll_is_done, alu_is_done};
    assign  io_datainA = (alu_start)?{{(GENERAL_REG_WIDTH-MAX_SQRT_WIDTH){1'b0}},FOUT}:
                            {{(GENERAL_REG_WIDTH-CADC_WIDTH){1'b0}}, ADC};
    assign  io_datainB = {{(GENERAL_REG_WIDTH-MAX_SQRT_WIDTH){1'b0}},POUT};
    
    // wire connections between CPU and Analog
    assign  SRC     = io_control[IO_CTRL_ALG_SRC];
    assign  OSCD    = io_control[IO_CTRL_ALG_OSCD];
    assign  FS      = io_control[IO_CTRL_ALG_FS_BGN:IO_CTRL_ALG_FS_END];
    assign  PHS     = io_control[IO_CTRL_ALG_PHS];
    
    // wire connections between SA module and CPU
    assign  STA_after_mux = TEST_MUX? TRG_TEST : meas_start;
    assign  RDY_after_mux = TEST_MUX? TRDY_TEST: TUNE_READY;//From SA
    assign  NXT_after_mux = TEST_MUX? NXT_TEST : 1'b1;//NXT;//From CPU
    assign  multiply_is_done = alu_is_done;
    assign  division_is_done = alu_is_done;
    assign  multiplication  = FOUT[MULTIPLICATION_WIDTH-1:0];
    assign  signed_division = FOUT[QUOTIENT_WIDTH-1:0];
    
    SA_4D_TOP_LEVEL_418   SA02(
                    .CLK(CLK),
                    .RST_N(RST_N),
                    .NXT(NXT_after_mux),//NXT
                    
                    // Input
                    .INIT_TUNE_BITS(INIT_TUNE_BITS),
                    .MAX_SA_ITERATION(MAX_SA_ITERATION),
                    .MAX_SS_ITERATION(MAX_SS_ITERATION), 
                    .INITIAL_T_VALUE(INITIAL_T_VALUE),  
                    .STEP_T_VALUE(STEP_T_VALUE),
                    .OPT_MODE(OPT_MODE),
                    .FLAG4D(FLAG4D),
                    .RAND_GROUP(RAND_GROUP),
                    .SS_THRESHOLD(SS_THRESHOLD),
                    .ANA_BITS(ANA_BITS_IN),//ANA_BITS
                    //.div_mode(div_mode),
                    
                    // Output
                    .TUNE_READY(TUNE_READY),
                    .TUNE_BITS(TUNE_BITS),
                    
                    // share division
                    //output
                    .dividend(dividend_SA),
                    .dividor(dividor_SA),
                    .division_start(set_division_start_SA),
                    //Input
                    .signed_division(signed_division),
                    .division_done(division_is_done),
                    
                    //share multiply
                    //output
                    .multiplicand(multiplicand_SA),
                    .multiplier(multiplier_SA),
                    .multiply_start(set_multiply_start_SA),
                    //input
                    .multiplication(multiplication),
                    .multiply_done(multiply_is_done)
                    );
      
endmodule
`endif//PCPU_SA_TOP_LEVEL_V

