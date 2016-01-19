//+FHDR****************************************************************
// ECE department, TAMU
// --------------------------------------------------------------------
// FILE NAME    : PCPU_MEM_SA_TOP.v
// AUTHER       : Jiafan Wang
// DATE         : 01/15/2016
// VERSION      : 1.0
// PURPOSE      : simulate the CPU could work with SA module
// --------------------------------------------------------------------
// ABSTRACT: simulation time 85 us given each time period 20ns
// --------------------------------------------------------------------
`timescale 1ns / 1ps
`include "../DEFINE_CPU.v"
`include "../PIPE_CPU.v"
`include "../I_MEMORY.v"
`include "../D_MEMORY.v"
`include "../SHARE_SUPERALU.v"
`include "../CTRL_LOGIC.v"
`include "../SA_4D_DEFINE_418.v"
`include "../SA_4D_CTRL_PATH_418.v"
`include "../SA_4D_DATA_PATH_418.v"
`include "../SA_4D_TOP_LEVEL_418.v"
`include "../PIPE_CPU_SA_TOP.v"

module PCPU_MEM_SA_TOP;

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

    // Inputs
    reg CLK;
    reg RST_N;
    reg [CADC_WIDTH-1:0]    ADC;
    reg ADC_RDY;

    reg TEST_MUX;
    reg TRG_TEST;
    reg TRDY_TEST;
    reg NXT_TEST;
    
    reg FLAG4D;
    reg RAND_GROUP;
    reg [ANA_WIDTH-1:0]     SS_THRESHOLD;
    reg [CADC_WIDTH-1:0]    OFFSET;
    reg [TUNEREG_WIDTH-1:0] INIT_TUNE_BITS;
    reg [ITER_WIDTH-1:0]    MAX_SA_ITERATION;
    reg [ITER_WIDTH-1:0]    MAX_SS_ITERATION;
    reg [MAX_T_WIDTH-1:0]   INITIAL_T_VALUE;
    reg [2:0]               STEP_T_VALUE;
    reg OPT_MODE;
    
    // Wires
    wire [ANA_WIDTH-1:0]    ANA_BITS;
    wire SRC;
    wire OSCD;
    wire [1:0]   FS;
    wire PHS;
    wire CLRN;
    wire CLK_ADC;
    wire RSTN_ADC;
    wire [TUNEREG_WIDTH-1:0] TUNE_BITS;

    integer i;
    
    // Instantiate the Unit Under Test (UUT)
    PIPE_CPU_SA_TOP eva00(
        // Input
        .CLK(CLK),
        .RST_N(RST_N),
        .ADC(ADC),
        .ADC_RDY(ADC_RDY),
        .ANA_BITS_IN(ANA_BITS),// to do this is to take the ana_bits to SC
        .ANA_BITS_OUT(ANA_BITS),//output

        // For Debug
        .TEST_MUX(TEST_MUX),
        .TRG_TEST(TRG_TEST),
        .TRDY_TEST(TRDY_TEST),
        .NXT_TEST(NXT_TEST),

        // configuration
        .FLAG4D(FLAG4D),
        .RAND_GROUP(RAND_GROUP),
        .SS_THRESHOLD(SS_THRESHOLD),
        .OFFSET(OFFSET),
        .INIT_TUNE_BITS(INIT_TUNE_BITS),
        .MAX_SA_ITERATION(MAX_SA_ITERATION),
        .MAX_SS_ITERATION(MAX_SS_ITERATION),
        .INITIAL_T_VALUE(INITIAL_T_VALUE), 
        .STEP_T_VALUE(STEP_T_VALUE),
        .OPT_MODE(OPT_MODE),

        // Output
        .SRC(SRC),
        .OSCD(OSCD),
        .FS(FS),
        .PHS(PHS),
        .CLRN(CLRN),
        .CLK_ADC(CLK_ADC),
        .RSTN_ADC(RSTN_ADC),
        .TUNE_BITS(TUNE_BITS)
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

    initial begin
        // Initialize Inputs
        CLK = 0;
        RST_N = 0;
        // enable = 0;
        #(CLKPERIOD*5);// Wait 100 ns for global rst_n to finish

        // Set parameters for the SA module
        ADC = 612;
        ADC_RDY = 1'b1;
        TEST_MUX = 1'b0;
        TRG_TEST = 1'b0;
        TRDY_TEST = 1'b0;
        NXT_TEST = 1'b0;
        
        FLAG4D = 1'b0;
        RAND_GROUP = 1'b0;
        SS_THRESHOLD = 100;
        OFFSET = 512;
        INIT_TUNE_BITS = 20'b01111011110111101110;
        MAX_SA_ITERATION = 11'd150;//16;
        MAX_SS_ITERATION = 11'd8;
        INITIAL_T_VALUE = 8'd32;
        STEP_T_VALUE = 3'd3;
        OPT_MODE = 1'd1;//1'b0
        
        // Add monitor here
        $display("pc  :       id_ir      :reg_A :reg_B :reg_C : da :  dd  : w : reC1 :  gr1 :  gr2 :  gr3 : zf: nf: cf");
        $monitor("%3d : %b : %h : %h : %h : %h : %h : %b : %h : %h : %h : %h : %b : %b : %b", 
            eva00.uut.pc, eva00.uut.id_ir, eva00.uut.reg_A, eva00.uut.reg_B, eva00.uut.reg_C,
            eva00.d_addr, eva00.d_dataout, eva00.d_we, eva00.uut.reg_C1, eva00.uut.gr[1], eva00.uut.gr[2], eva00.uut.gr[3],
            eva00.uut.zf, eva00.uut.nf, eva00.uut.cf);

        // Manually set instruction set memory here; later by scan chain
        eva00.i_mem.I_RAM[  0] = {`SET, `gr1, 4'b0000, 4'b0000};// init IO control bits
        eva00.i_mem.I_RAM[  1] = {`SET, `gr7, 4'b0000, 4'b0000};// init frequency point#, eg. max=4 BPF
        eva00.i_mem.I_RAM[  2] = {`SET, `gr6, 4'b0000, 4'b0011};// init IQ phase#, eg. max=3 when no OSCD
        eva00.i_mem.I_RAM[  3] = {`SET, `gr4, 4'b0000, 4'b0010};// save IO status bits: PLL_is_done
        eva00.i_mem.I_RAM[  4] = {`ADDI, `gr1, 4'b0100, 4'b0000};// set IO control bits, start PLL waiting
        eva00.i_mem.I_RAM[  5] = {`LIOS, `gr3, 4'b0000, 4'b0000};//load status for comparision
        eva00.i_mem.I_RAM[  6] = {`NOP, 11'b000_0000_0000};
        eva00.i_mem.I_RAM[  7] = {`NOP, 11'b000_0000_0000};
        eva00.i_mem.I_RAM[  8] = {`NOP, 11'b000_0000_0000};
        eva00.i_mem.I_RAM[  9] = {`CMP, 4'b0000, `gr3, 1'b0, `gr4};
        eva00.i_mem.I_RAM[ 10] = {`NOP, 11'b000_0000_0000};
        eva00.i_mem.I_RAM[ 11] = {`NOP, 11'b000_0000_0000};
        eva00.i_mem.I_RAM[ 12] = {`NOP, 11'b000_0000_0000};
        eva00.i_mem.I_RAM[ 13] = {`BNZ, `gr0, 8'd5};//if (`gr3 != `gr4) go to I_RAM[ 5]; (if 0==PLL_is_done; loop)
        eva00.i_mem.I_RAM[ 14] = {`NOP, 11'b000_0000_0000};
        eva00.i_mem.I_RAM[ 15] = {`NOP, 11'b000_0000_0000};
        eva00.i_mem.I_RAM[ 16] = {`NOP, 11'b000_0000_0000};
        eva00.i_mem.I_RAM[ 17] = {`SUBI, `gr1, 4'b0100, 4'b0000};// set IO status bits: clear PLL_start
        eva00.i_mem.I_RAM[ 18] = {`SET, `gr5, 4'b0000, 4'b0010};// set ADC average# e.g. 2 for debug
        eva00.i_mem.I_RAM[ 19] = {`SET, `gr2, 4'b0000, 4'b0000};// initialize `gr2
        eva00.i_mem.I_RAM[ 20] = {`SET, `gr4, 4'b0000, 4'b0100};// save IO status bits: Meas_is_done
        eva00.i_mem.I_RAM[ 21] = {`ADDI, `gr1, 4'b1000, 4'b0000};// set IO status bits: start Meas_ADC
        eva00.i_mem.I_RAM[ 22] = {`LIOS, `gr3, 4'b0000, 4'b0000};//load status for comparision
        eva00.i_mem.I_RAM[ 23] = {`NOP, 11'b000_0000_0000};
        eva00.i_mem.I_RAM[ 24] = {`NOP, 11'b000_0000_0000};
        eva00.i_mem.I_RAM[ 25] = {`NOP, 11'b000_0000_0000};
        eva00.i_mem.I_RAM[ 26] = {`CMP, 4'b0000, `gr3, 1'b0, `gr4};
        eva00.i_mem.I_RAM[ 27] = {`NOP, 11'b000_0000_0000};
        eva00.i_mem.I_RAM[ 28] = {`NOP, 11'b000_0000_0000};
        eva00.i_mem.I_RAM[ 29] = {`NOP, 11'b000_0000_0000};
        eva00.i_mem.I_RAM[ 30] = {`BNZ, `gr0, 8'd22};//if (`gr3 != `gr4) go to I_RAM[ 22]; (if 0==Meas_is_done; loop)
        eva00.i_mem.I_RAM[ 31] = {`NOP, 11'b000_0000_0000};
        eva00.i_mem.I_RAM[ 32] = {`NOP, 11'b000_0000_0000};
        eva00.i_mem.I_RAM[ 33] = {`NOP, 11'b000_0000_0000};
        eva00.i_mem.I_RAM[ 34] = {`LIOA, `gr3, 4'b0000, 4'b0000};//load inputA for ADC computation(overwrite gr2)
        eva00.i_mem.I_RAM[ 35] = {`SUBI, `gr1, 4'b1000, 4'b0000};// set IO status bits: clear Meas_ADC
        eva00.i_mem.I_RAM[ 36] = {`NOP, 11'b000_0000_0000};
        eva00.i_mem.I_RAM[ 37] = {`NOP, 11'b000_0000_0000};
        eva00.i_mem.I_RAM[ 38] = {`ADD, `gr2, 1'b0,`gr2, 1'b0, `gr3};//`gr2+=`gr3;
        eva00.i_mem.I_RAM[ 39] = {`SUBI, `gr5, 4'b0000, 4'b0001};//`gr5--;
        eva00.i_mem.I_RAM[ 40] = {`NOP, 11'b000_0000_0000};
        eva00.i_mem.I_RAM[ 41] = {`NOP, 11'b000_0000_0000};
        eva00.i_mem.I_RAM[ 42] = {`NOP, 11'b000_0000_0000};
        eva00.i_mem.I_RAM[ 43] = {`BNZ, `gr0, 8'd21};//if (`gr5 != 0) go to I_RAM[ 21];
        eva00.i_mem.I_RAM[ 44] = {`NOP, 11'b000_0000_0000};
        eva00.i_mem.I_RAM[ 45] = {`NOP, 11'b000_0000_0000};
        eva00.i_mem.I_RAM[ 46] = {`NOP, 11'b000_0000_0000};
        eva00.i_mem.I_RAM[ 47] = {`SRL, `gr2, 1'b0, `gr2, 4'd1};//(`gr2>>1);
        eva00.i_mem.I_RAM[ 48] = {`NOP, 11'b000_0000_0000};
        eva00.i_mem.I_RAM[ 49] = {`NOP, 11'b000_0000_0000};
        eva00.i_mem.I_RAM[ 50] = {`NOP, 11'b000_0000_0000};
        eva00.i_mem.I_RAM[ 51] = {`STORE, `gr2, 1'b0, `gr6, 4'd0};//m[`gr6+4'd0]=`gr2;
        eva00.i_mem.I_RAM[ 52] = {`CMP, 4'b0000, `gr6, 1'b0, `gr0};
        eva00.i_mem.I_RAM[ 53] = {`NOP, 11'b000_0000_0000};
        eva00.i_mem.I_RAM[ 54] = {`NOP, 11'b000_0000_0000};
        eva00.i_mem.I_RAM[ 55] = {`NOP, 11'b000_0000_0000};
        eva00.i_mem.I_RAM[ 56] = {`BZ, `gr0, 8'd66};//if (`gr6 == 0) go to I_RAM[ 66]; finish IQ phases of one frequency
        eva00.i_mem.I_RAM[ 57] = {`NOP, 11'b000_0000_0000};
        eva00.i_mem.I_RAM[ 58] = {`NOP, 11'b000_0000_0000};
        eva00.i_mem.I_RAM[ 59] = {`NOP, 11'b000_0000_0000};
        eva00.i_mem.I_RAM[ 60] = {`SUBI, `gr6, 4'b0000, 4'b0001};
        eva00.i_mem.I_RAM[ 61] = {`LDIH, `gr1, 4'b0000, 4'b0010};// set PHS & SRC bit
        eva00.i_mem.I_RAM[ 62] = {`JUMP, 3'b000, 8'd18};// go to I_RAM[ 18]; keep on IQ phase 
        eva00.i_mem.I_RAM[ 63] = {`NOP, 11'b000_0000_0000};
        eva00.i_mem.I_RAM[ 64] = {`NOP, 11'b000_0000_0000};
        eva00.i_mem.I_RAM[ 65] = {`NOP, 11'b000_0000_0000};//division preparation is based on `gr6 is zero
        eva00.i_mem.I_RAM[ 66] = {`SUIH, `gr1, 4'b0000, 4'b0110};// I_RAM[ 66]; set IO control bits: clear SRC & PHS bits
        eva00.i_mem.I_RAM[ 67] = {`LOAD, `gr2, 1'b0, `gr6, 4'd1};// set operand_A
        eva00.i_mem.I_RAM[ 68] = {`LOAD, `gr3, 1'b0, `gr6, 4'd0};// set operand_B
        eva00.i_mem.I_RAM[ 69] = {`SET, `gr4, 4'b0000, 4'b0001};// save IO status bits: ALU_is_done
        eva00.i_mem.I_RAM[ 70] = {`ADDI, `gr1, 4'b0010, 4'b0100};// set ALU_start and ALU_SQRTPOWS
        eva00.i_mem.I_RAM[ 71] = {`LIOS, `gr5, 4'b0000, 4'b0000};//load status for comparision
        eva00.i_mem.I_RAM[ 72] = {`NOP, 11'b000_0000_0000};
        eva00.i_mem.I_RAM[ 73] = {`NOP, 11'b000_0000_0000};
        eva00.i_mem.I_RAM[ 74] = {`NOP, 11'b000_0000_0000};
        eva00.i_mem.I_RAM[ 75] = {`CMP, 4'b0000, `gr5, 1'b0, `gr4};
        eva00.i_mem.I_RAM[ 76] = {`NOP, 11'b000_0000_0000};
        eva00.i_mem.I_RAM[ 77] = {`NOP, 11'b000_0000_0000};
        eva00.i_mem.I_RAM[ 78] = {`NOP, 11'b000_0000_0000};
        eva00.i_mem.I_RAM[ 79] = {`BNZ, `gr0, 8'd71};//if (`gr5 != `gr4) go to I_RAM[ 71]; (if 0==ALU_is_done; loop)
        eva00.i_mem.I_RAM[ 80] = {`NOP, 11'b000_0000_0000};
        eva00.i_mem.I_RAM[ 81] = {`NOP, 11'b000_0000_0000};
        eva00.i_mem.I_RAM[ 82] = {`NOP, 11'b000_0000_0000};
        eva00.i_mem.I_RAM[ 83] = {`LIOA, `gr2, 4'b0000, 4'b0000};//load inputA for ADC computation(overwrite gr2)
        eva00.i_mem.I_RAM[ 84] = {`SET, `gr5, 4'b0000, 4'b0010};// stopping criteria 2
        eva00.i_mem.I_RAM[ 85] = {`SUBI, `gr1, 4'b0010, 4'b0100};//clear IO control bits: ALU_SQRTPOWS //= {`LIOB, `gr3, 4'b0000, 4'b0000};//load inputB for futher computation(overwrite gr1)
        eva00.i_mem.I_RAM[ 86] = {`NOP, 11'b000_0000_0000};
        eva00.i_mem.I_RAM[ 87] = {`STORE, `gr2, 1'b0, `gr6, 4'd1};// save outputA
        eva00.i_mem.I_RAM[ 88] = {`CMP, 4'b0000, `gr6, 1'b0, `gr5};//`gr6+=2 to get another operand for division
        eva00.i_mem.I_RAM[ 89] = {`NOP, 11'b000_0000_0000};
        eva00.i_mem.I_RAM[ 90] = {`NOP, 11'b000_0000_0000};
        eva00.i_mem.I_RAM[ 91] = {`NOP, 11'b000_0000_0000};
        eva00.i_mem.I_RAM[ 92] = {`BZ, `gr0, 8'd101};//if (`gr6 == 2) go to I_RAM[101]; finish division preparation
        eva00.i_mem.I_RAM[ 93] = {`NOP, 11'b000_0000_0000};
        eva00.i_mem.I_RAM[ 94] = {`NOP, 11'b000_0000_0000};
        eva00.i_mem.I_RAM[ 95] = {`NOP, 11'b000_0000_0000};
        eva00.i_mem.I_RAM[ 96] = {`SET, `gr6, 4'b0000, 4'b0010};// reuse `gr6 as flag; set it == 2
        eva00.i_mem.I_RAM[ 97] = {`JUMP, 3'b000, 8'd67};// go to I_RAM[ 67] and keep on division preparation
        eva00.i_mem.I_RAM[ 98] = {`NOP, 11'b000_0000_0000};
        eva00.i_mem.I_RAM[ 99] = {`NOP, 11'b000_0000_0000};
        eva00.i_mem.I_RAM[100] = {`NOP, 11'b000_0000_0000};
        eva00.i_mem.I_RAM[101] = {`LOAD, `gr2, 1'b0, `gr0, 4'd3};// I_RAM[101] set operand_A 
        eva00.i_mem.I_RAM[102] = {`LOAD, `gr3, 1'b0, `gr0, 4'd1};// set operand_B
        eva00.i_mem.I_RAM[103] = {`SET, `gr4, 4'b0000, 4'b0001};// save IO status bits: ALU_is_done
        eva00.i_mem.I_RAM[104] = {`ADDI, `gr1, 4'b0010, 4'b1001};// set ALU_start and ALU_DIVISION
        eva00.i_mem.I_RAM[105] = {`LIOS, `gr5, 4'b0000, 4'b0000};//load status for comparision
        eva00.i_mem.I_RAM[106] = {`NOP, 11'b000_0000_0000};
        eva00.i_mem.I_RAM[107] = {`NOP, 11'b000_0000_0000};
        eva00.i_mem.I_RAM[108] = {`NOP, 11'b000_0000_0000};
        eva00.i_mem.I_RAM[109] = {`CMP, 4'b0000, `gr5, 1'b0, `gr4};
        eva00.i_mem.I_RAM[110] = {`NOP, 11'b000_0000_0000};
        eva00.i_mem.I_RAM[111] = {`NOP, 11'b000_0000_0000};
        eva00.i_mem.I_RAM[112] = {`NOP, 11'b000_0000_0000};
        eva00.i_mem.I_RAM[113] = {`BNZ, `gr0, 8'd105};//if (`gr5 != `gr4) go to I_RAM[105]; (if 0==ALU_is_done; loop)
        eva00.i_mem.I_RAM[114] = {`NOP, 11'b000_0000_0000};
        eva00.i_mem.I_RAM[115] = {`NOP, 11'b000_0000_0000};
        eva00.i_mem.I_RAM[116] = {`NOP, 11'b000_0000_0000};
        eva00.i_mem.I_RAM[117] = {`LIOA, `gr2, 4'b0000, 4'b0000};//load inputA for ADC computation(overwrite gr2)
        eva00.i_mem.I_RAM[118] = {`SET, `gr5, 4'b0000, 4'b0011};// stopping criteria 3
        eva00.i_mem.I_RAM[119] = {`SUBI, `gr1, 4'b0010, 4'b1001};//clear IO control bits
        eva00.i_mem.I_RAM[120] = {`NOP, 11'b000_0000_0000};
        eva00.i_mem.I_RAM[121] = {`STORE, `gr2, 1'b0, `gr7, 4'd4};// save outputA as gain
        eva00.i_mem.I_RAM[122] = {`CMP, 4'b0000, `gr7, 1'b0, `gr5};
        eva00.i_mem.I_RAM[123] = {`NOP, 11'b000_0000_0000};
        eva00.i_mem.I_RAM[124] = {`NOP, 11'b000_0000_0000};
        eva00.i_mem.I_RAM[125] = {`NOP, 11'b000_0000_0000};
        eva00.i_mem.I_RAM[126] = {`BZ, `gr0, 8'd136};//if (`gr7 == 3) go to I_RAM[136] finish frequency loop;
        eva00.i_mem.I_RAM[127] = {`NOP, 11'b000_0000_0000};
        eva00.i_mem.I_RAM[128] = {`NOP, 11'b000_0000_0000};
        eva00.i_mem.I_RAM[129] = {`NOP, 11'b000_0000_0000};
        eva00.i_mem.I_RAM[130] = {`LDIH, `gr1, 4'b0000, 4'b1000};//IO control bits: update frequency loop#
        eva00.i_mem.I_RAM[131] = {`ADDI, `gr7, 4'b0000, 4'b0001};//update `gr7 and keep on loop
        eva00.i_mem.I_RAM[132] = {`JUMP, 3'b000, 8'd2};// go to I_RAM[  2] and keep on frequency loop
        eva00.i_mem.I_RAM[133] = {`NOP, 11'b000_0000_0000};
        eva00.i_mem.I_RAM[134] = {`NOP, 11'b000_0000_0000};
        eva00.i_mem.I_RAM[135] = {`NOP, 11'b000_0000_0000};
        eva00.i_mem.I_RAM[136] = {`SET, `gr1, 4'b0000, 4'b0000};//I_RAM[136] clear IO control bits; finish control logic
        eva00.i_mem.I_RAM[137] = {`NOP, 11'b000_0000_0000};
        eva00.i_mem.I_RAM[138] = {`NOP, 11'b000_0000_0000};
        eva00.i_mem.I_RAM[139] = {`NOP, 11'b000_0000_0000};
        eva00.i_mem.I_RAM[140] = {`HALT, 11'b000_0000_0000};//due to the pipeline, we need to add many `NOP to the instruction set
        eva00.i_mem.I_RAM[141] = {`NOP, 11'b000_0000_0000};
        eva00.i_mem.I_RAM[142] = {`NOP, 11'b000_0000_0000};
        eva00.i_mem.I_RAM[143] = {`NOP, 11'b000_0000_0000};
        /// Final cost function calculation is implemented in another testbench;
        /// after CPU is depipelined.

        /// the D_MEM is arranged as follow: at least 8x16 bits
        // --------------    --------------    --------------    -------------- 
        // |   Qi_n     |    |            |    |            |    |   Gain 1*  | 
        // --------------    --------------    --------------    -------------- 
        // |   Ii_n     |    |   Ampi n   |    |            |    |            | 
        // --------------    --------------    --------------    -------------- 
        // |   Qo_n     |    |            |    |            |    |            | 
        // --------------    --------------    --------------    -------------- 
        // |   Io_n     |    |   Ampo n   |    |            |    |   Gain 4*  | 
        // -------------- => -------------- => -------------- => -------------- 
        // |            |    |            |    |   Gain 1   |    |   Gain 1   | 
        // --------------    --------------    --------------    -------------- 
        // |            |    |            |    |   Gain 2   |    |   Gain 2   | 
        // --------------    --------------    --------------    -------------- 
        // |            |    |            |    |   Gain 3   |    |   Gain 3   | 
        // --------------    --------------    --------------    -------------- 
        // |            |    |            |    |   Gain 4   |    |   Gain 4   | 
        // --------------    --------------    --------------    -------------- 
        // eva00.d_mem.D_RAM[0] = 16'h00AB;
        // eva00.d_mem.D_RAM[1] = 16'h3C00;
        // eva00.d_mem.D_RAM[2] = 16'h0000;
        // eva00.uut.gr[2] = 240;// input X_IN for ALU
        // eva00.uut.gr[3] = 106;// input Y_IN for ALU
        #CLKPERIOD  force eva00.NXT = 1'b0;

        // Start simulation
        #CLKPERIOD RST_N = 0;
        #CLKPERIOD RST_N = 1;
        for (i=0; i<40000; i=i+1)// wait pll needs 4000 cycles; one meas needs 900 cycles
            #CLKPERIOD;
        //#CLKPERIOD  release eva00.NXT;

        $stop();
    end
    
    always #(CLKPERIOD/2)
        CLK = ~CLK;
      
endmodule

