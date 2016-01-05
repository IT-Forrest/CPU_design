//+FHDR****************************************************************
// ECE department, TAMU
// --------------------------------------------------------------------
// FILE NAME    : PCPU_MEM_ALU_TOP.v
// AUTHER       : Jiafan Wang
// DATE         : 01/01/2016
// VERSION      : 1.0
// PURPOSE      : simulate the CPU could control ALU
// --------------------------------------------------------------------
// ABSTRACT: simulation time XX given each time period 10ns
// --------------------------------------------------------------------
`timescale 1ns / 1ps
`include "../DEFINE_CPU.v"
`include "../PIPE_CPU.v"
`include "../I_MEMORY.v"
`include "../D_MEMORY.v"
`include "../SHARE_SUPERALU.v"

module PCPU_MEM_ALU_TOP;

    // Inputs
    reg clk;
    reg enable;
    reg rst_n;
    reg start;
    reg select_y;
    
    // Wires
    wire [15:0] i_datain;
    wire [15:0] d_datain;
    wire [7:0] i_addr;
    wire [7:0] d_addr;
    wire d_we;
    wire [15:0] d_dataout;

    integer i;

    parameter   GENERAL_REG_WIDTH = 16;
    parameter   IO_CTRL_STA         = 0,
                IO_CTRL_MODEL_END   = 1,
                IO_CTRL_MODEL_BGN   = 2,
                IO_CTRL_ALU_END     = 3,
                IO_CTRL_ALU_BGN     = 6;
    parameter   IO_STAT_ALU_DONE    = 0;

    wire    [GENERAL_REG_WIDTH-1:0] io_status;
    wire    [GENERAL_REG_WIDTH-1:0] io_control;
    wire    [GENERAL_REG_WIDTH-1:0] io_datainA;
    wire    [GENERAL_REG_WIDTH-1:0] io_datainB;
    wire    [GENERAL_REG_WIDTH-1:0] io_dataoutA;
    wire    [GENERAL_REG_WIDTH-1:0] io_dataoutB;
    
    // Instantiate the Unit Under Test (UUT)
    PIPE_CPU uut (
        .clk(clk), 
        .enable(enable), 
        .rst_n(rst_n), 
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
        .clk(clk),
        .rst_n(rst_n), 
        .addr(i_addr),
        .d_we(1'b0),// need a seperate control signal; or instruction set will be overwritten when d_we=1
        .datain(16'b0000_0000_0000_0000),//i_instruct
        .dataout(i_datain)
    );
    D_MEMORY d_mem (
        .clk(clk),
        .rst_n(rst_n), 
        .addr(d_addr),
        .d_we(d_we),
        .datain(d_dataout),
        .dataout(d_datain)
    );

    parameter   ALU_MULTIPLY    = 4'b1000,
                ALU_DIVISION    = 4'b0100,
                ALU_SQRTPOWS    = 4'b0010,
                ALU_UNKNOWN     = 4'b0001;
    parameter   MULTI_PURE      = 2'b00,// multiply a pure fraction
                MULTI_FRAC      = 2'b01,// multiply a fraction like 1.4
                MULTI_MAXM      = 2'b10;// multiply a fraction like 2.3, then bound to 2
    parameter   SA_DIV          = 2'b00,
                CF_T27          = 2'b01,
                CF_T36          = 2'b10;

    parameter   MAX_SQRT_WIDTH  = 13;
    wire    [MAX_SQRT_WIDTH-1:0]  X_IN, Y_IN;
    wire    [MAX_SQRT_WIDTH-1:0]  FOUT, POUT;
    wire    [3:0]   alu_type;
    wire    [1:0]   mode_type;
    wire    alu_start, alu_is_done;
    
    SHARE_SUPERALU   ALU_01(.CLK(clk),
                        .RST_N(rst_n),
                        .X_IN(X_IN),//multiplicand
                        .Y_IN(Y_IN),//multiplier
                        .alu_start(alu_start),//multiply_start || division_start || sqrt_pow_start
                        .alu_type(alu_type),
                        .mode_type(mode_type),
                        .OFFSET(10'd507),//OFFSET

                        .FOUT(FOUT),//multiplication
                        .POUT(POUT),
                        .alu_is_done(alu_is_done));
    
    // wire connections between ALU and CPU
    assign  X_IN = io_dataoutA[MAX_SQRT_WIDTH-1:0];
    assign  Y_IN = io_dataoutB[MAX_SQRT_WIDTH-1:0];
    assign  alu_start = io_control[IO_CTRL_STA];
    assign  alu_type = io_control[IO_CTRL_ALU_BGN:IO_CTRL_ALU_END];
    assign  mode_type = io_control[IO_CTRL_MODEL_BGN:IO_CTRL_MODEL_END];
    
    // wire connections between CTRL module and CPU
    assign  io_status = {{(GENERAL_REG_WIDTH-1){1'b0}}, alu_is_done};
    assign  io_datainA = {{(GENERAL_REG_WIDTH-MAX_SQRT_WIDTH){1'b0}},FOUT};
    assign  io_datainB = {{(GENERAL_REG_WIDTH-MAX_SQRT_WIDTH){1'b0}},POUT};
    
    initial begin
        // Initialize Inputs
        clk = 0;
        enable = 0;
        rst_n = 1;
        start = 0;
        select_y = 0;

        // Wait 100 ns for global rst_n to finish
        #100;
        
        // Add stimulus here
        $display("pc  :               id_ir                :reg_A :reg_B :reg_C\
            : da  :  dd  : w : reC1 :  gr1  :  gr2  :  gr3   :zf :nf:cf");
        $monitor("%3d : %b : %h : %h : %h : %h : %h : %b : %h : %h : %h : %h : %b : %b : %b", 
            uut.pc, uut.id_ir, uut.reg_A, uut.reg_B, uut.reg_C,
            d_addr, d_dataout, d_we, uut.reg_C1, uut.gr[1], uut.gr[2], uut.gr[3],
            uut.zf, uut.nf, uut.cf);

        // i_mem.I_RAM[ 0] = {`SUB, `gr7, 1'b0, `gr7, 1'b0, `gr7};//reset the loop controller `gr7
        // i_mem.I_RAM[ 1] = {`SUB, `gr6, 1'b0, `gr6, 1'b0, `gr6};//reset the loop controller `gr6
        // i_mem.I_RAM[ 2] = {`SUB, `gr5, 1'b0, `gr5, 1'b0, `gr5};//reset the loop controller `gr5
        // i_mem.I_RAM[ 3] = {`SUB, `gr1, 1'b0, `gr1, 1'b0, `gr1};//reset the loop controller `gr1
        i_mem.I_RAM[ 0] = {`SET, `gr7, 4'b0000, 4'b0000};//reset the loop controller `gr7
        i_mem.I_RAM[ 1] = {`SET, `gr6, 4'b0000, 4'b0000};//reset the loop controller `gr6
        i_mem.I_RAM[ 2] = {`SET, `gr5, 4'b0000, 4'b0000};//reset the loop controller `gr5
        i_mem.I_RAM[ 3] = {`SET, `gr1, 4'b0000, 4'b0000};//reset the loop controller `gr1
        i_mem.I_RAM[ 4] = {`NOP, 11'b000_0000_0000};
        i_mem.I_RAM[ 5] = {`NOP, 11'b000_0000_0000};
        i_mem.I_RAM[ 6] = {`NOP, 11'b000_0000_0000};
        i_mem.I_RAM[ 7] = {`ADDI, `gr7, 4'b0001, 4'b1001};//set the loop controller `gr7 = 25
        i_mem.I_RAM[ 8] = {`SET, `gr1, 1'b0, ALU_MULTIPLY, MULTI_FRAC, 1'b1};//IO control bits
        i_mem.I_RAM[ 9] = {`SET, `gr6, 4'b0000, 4'b0001};//save IO status bits
        i_mem.I_RAM[10] = {`LIOS, `gr5, 4'b0000, 4'b0000};//load status for comparision
        i_mem.I_RAM[11] = {`NOP, 11'b000_0000_0000};
        i_mem.I_RAM[12] = {`NOP, 11'b000_0000_0000};
        i_mem.I_RAM[13] = {`NOP, 11'b000_0000_0000};
        i_mem.I_RAM[14] = {`CMP, 4'b0000, `gr5, 1'b0, `gr6};
        i_mem.I_RAM[15] = {`NOP, 11'b000_0000_0000};
        i_mem.I_RAM[16] = {`NOP, 11'b000_0000_0000};
        i_mem.I_RAM[17] = {`NOP, 11'b000_0000_0000};
        i_mem.I_RAM[18] = {`BZ, `gr0, 4'b0001, 4'b1010};//if (`gr5 == `gr6) go to I_RAM[ 26]; (if alu_is_done; jump out)
        i_mem.I_RAM[19] = {`NOP, 11'b000_0000_0000};
        i_mem.I_RAM[20] = {`NOP, 11'b000_0000_0000};
        i_mem.I_RAM[21] = {`NOP, 11'b000_0000_0000};
        i_mem.I_RAM[22] = {`SUBI, `gr7, 4'b0000, 4'b0001};
        i_mem.I_RAM[23] = {`NOP, 11'b000_0000_0000};
        i_mem.I_RAM[24] = {`NOP, 11'b000_0000_0000};
        i_mem.I_RAM[25] = {`NOP, 11'b000_0000_0000};
        i_mem.I_RAM[26] = {`BNZ, `gr0, 4'b0000, 4'b1010};//if (`gr7 != 0) go to I_RAM[10];
        i_mem.I_RAM[27] = {`NOP, 11'b000_0000_0000};
        i_mem.I_RAM[28] = {`NOP, 11'b000_0000_0000};
        i_mem.I_RAM[29] = {`NOP, 11'b000_0000_0000};
        i_mem.I_RAM[30] = {`LIOA, `gr4, 4'b0000, 4'b0000};
        i_mem.I_RAM[31] = {`SET, `gr1, 4'b0000, 4'b0000};//IO control bits
        i_mem.I_RAM[32] = {`NOP, 11'b000_0000_0000};
        i_mem.I_RAM[33] = {`NOP, 11'b000_0000_0000};
        i_mem.I_RAM[34] = {`NOP, 11'b000_0000_0000};
        i_mem.I_RAM[35] = {`HALT, 11'b000_0000_0000};//due to the pipeline, we need to add many `NOP to the instruction set
        
        d_mem.D_RAM[0] = 16'h00AB;
        d_mem.D_RAM[1] = 16'h3C00;
        d_mem.D_RAM[2] = 16'h0000;

        #10 rst_n = 0;
        #10 rst_n = 1;
        uut.gr[2] = 240;
        uut.gr[3] = 106;
        // #CLKPERIOD  force NXT = 1'b1;
        // #(CLKPERIOD*2) release NXT;
        
        #10 enable = 1;
        #10 start =1;
        #10 start = 0;
        for (i=0; i<100; i=i+1)
            #10;
        $stop();
    end
    
    always #5
        clk = ~clk;
      
endmodule

