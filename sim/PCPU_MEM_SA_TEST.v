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
    PIPE_CPU_SA_TOP eva01(
        // Input
        .CLK(CLK),
        .RST_N(RST_N),
        .ADC(ADC),
        .ADC_RDY(ADC_RDY),
        .ANA_BITS_IN(ANA_BITS),//input: the reason to do this is to take the ana_bits to SC
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
        //start = 0;

        // Wait 100 ns for global rst_n to finish
        #(CLKPERIOD*5);
        
        // Add stimulus here
        $display("pc  :       id_ir      :reg_A :reg_B :reg_C : da :  dd  : w : reC1 :  gr1 :  gr2 :  gr3 : zf: nf: cf");
        $monitor("%3d : %b : %h : %h : %h : %h : %h : %b : %h : %h : %h : %h : %b : %b : %b", 
            eva01.uut.pc, eva01.uut.id_ir, eva01.uut.reg_A, eva01.uut.reg_B, eva01.uut.reg_C,
            eva01.d_addr, eva01.d_dataout, eva01.d_we, eva01.uut.reg_C1, eva01.uut.gr[1], eva01.uut.gr[2], eva01.uut.gr[3],
            eva01.uut.zf, eva01.uut.nf, eva01.uut.cf);

        eva01.i_mem.I_RAM[ 0] = {`SET, `gr1, 3'b000, 5'b000_00};//IO control bits, init PLL waiting
        eva01.i_mem.I_RAM[ 1] = {`NOP, 11'b000_0000_0000};
        eva01.i_mem.I_RAM[ 2] = {`NOP, 11'b000_0000_0000};
        eva01.i_mem.I_RAM[ 3] = {`NOP, 11'b000_0000_0000};
        eva01.i_mem.I_RAM[ 4] = {`SET, `gr7, 4'b1111, 4'b0000};//set the loop controller `gr7 = 240 (16=3us, not enough for PLL waiting)
        eva01.i_mem.I_RAM[ 5] = {`SET, `gr6, 4'b0000, 4'b0010};//save IO status bits
        eva01.i_mem.I_RAM[ 6] = {`SET, `gr1, 3'b010, 5'b000_00};//IO control bits, start PLL waiting
        eva01.i_mem.I_RAM[ 7] = {`LIOS, `gr5, 4'b0000, 4'b0000};//load status for comparision
        eva01.i_mem.I_RAM[ 8] = {`NOP, 11'b000_0000_0000};
        eva01.i_mem.I_RAM[ 9] = {`NOP, 11'b000_0000_0000};
        eva01.i_mem.I_RAM[10] = {`NOP, 11'b000_0000_0000};
        eva01.i_mem.I_RAM[11] = {`CMP, 4'b0000, `gr5, 1'b0, `gr6};
        eva01.i_mem.I_RAM[12] = {`NOP, 11'b000_0000_0000};
        eva01.i_mem.I_RAM[13] = {`NOP, 11'b000_0000_0000};
        eva01.i_mem.I_RAM[14] = {`NOP, 11'b000_0000_0000};
        eva01.i_mem.I_RAM[15] = {`BZ, `gr0, 4'b0001, 4'b1011};//if (`gr5 == `gr6) go to I_RAM[27]; (if alu_is_done; jump out)
        eva01.i_mem.I_RAM[16] = {`NOP, 11'b000_0000_0000};
        eva01.i_mem.I_RAM[17] = {`NOP, 11'b000_0000_0000};
        eva01.i_mem.I_RAM[18] = {`NOP, 11'b000_0000_0000};
        eva01.i_mem.I_RAM[19] = {`SUBI, `gr7, 4'b0000, 4'b0001};
        eva01.i_mem.I_RAM[20] = {`NOP, 11'b000_0000_0000};
        eva01.i_mem.I_RAM[21] = {`NOP, 11'b000_0000_0000};
        eva01.i_mem.I_RAM[22] = {`NOP, 11'b000_0000_0000};
        eva01.i_mem.I_RAM[23] = {`BNZ, `gr0, 4'b0000, 4'b0111};//if (`gr7 != 0) go to I_RAM[ 7];
        eva01.i_mem.I_RAM[24] = {`NOP, 11'b000_0000_0000};
        eva01.i_mem.I_RAM[25] = {`NOP, 11'b000_0000_0000};
        eva01.i_mem.I_RAM[26] = {`NOP, 11'b000_0000_0000};
        eva01.i_mem.I_RAM[27] = {`SET, `gr1, 4'b0000, 4'b0000};//clear IO control bits
        // eva01.i_mem.I_RAM[23] = {`LIOA, `gr2, 4'b0000, 4'b0000};//load inputA for futher computation(overwrite gr2)
        // eva01.i_mem.I_RAM[24] = {`LIOB, `gr3, 4'b0000, 4'b0000};//load inputB for futher computation(overwrite gr3)
        // eva01.i_mem.I_RAM[25] = {`SET, `gr1, 4'b0000, 4'b0000};
        eva01.i_mem.I_RAM[28] = {`NOP, 11'b000_0000_0000};
        eva01.i_mem.I_RAM[29] = {`NOP, 11'b000_0000_0000};
        eva01.i_mem.I_RAM[30] = {`NOP, 11'b000_0000_0000};
        eva01.i_mem.I_RAM[31] = {`HALT, 11'b000_0000_0000};//due to the pipeline, we need to add many `NOP to the instruction set

        eva01.d_mem.D_RAM[0] = 16'h00AB;
        eva01.d_mem.D_RAM[1] = 16'h3C00;
        eva01.d_mem.D_RAM[2] = 16'h0000;

        #CLKPERIOD RST_N = 0;
        #CLKPERIOD RST_N = 1;
        
        ADC = 612;
        //eva01.uut.gr[2] = 240;// input X_IN for ALU
        //eva01.uut.gr[3] = 106;// input Y_IN for ALU
        // #CLKPERIOD  force NXT = 1'b1;
        // #(CLKPERIOD*2) release NXT;
        
        #CLKPERIOD RST_N = 1;
        for (i=0; i<4000; i=i+1)// wait pll needs 4000 cycles; one meas needs 900 cycles
            #CLKPERIOD;
        $stop();
    end
    
    always #(CLKPERIOD/2)
        CLK = ~CLK;
      
endmodule

