//+FHDR****************************************************************
// ECE department, TAMU
// --------------------------------------------------------------------
// FILE NAME    : DEFINE_CPU.v
// AUTHER       : Jiafan Wang
// DATE         : 01/01/2016
// VERSION      : 1.0
// PURPOSE      : macros defined in the CPU design
// --------------------------------------------------------------------
// ABSTRACT: simulation time 1us given each time period 10ns
// --------------------------------------------------------------------
`timescale 1ns / 1ps
`include "../DEFINE_CPU.v"
`include "../PIPE_CPU.v"
`include "../I_MEMORY.v"
`include "../D_MEMORY.v"

module PCPU_MEM_INIT_TOP;

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
        .d_dataout(d_dataout)
    );
    I_MEMORY i_mem (
        .clk(clk),
        .rst_n(rst_n), 
        .addr(i_addr),
        .d_we(d_we),// need a seperate control signal; or instruction set will be overwritten when d_we=1
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
        // $monitor("%3d : %b : %h : %h : %h : %h : %h : %b : %h : %h : %h : %h : %b : %b : %b", 
            // uut.pc, uut.id_ir, uut.reg_A, uut.reg_B, uut.reg_C,
            // d_addr, d_dataout, d_we, uut.reg_C1, uut.gr[1], uut.gr[2], uut.gr[3],
            // uut.zf, uut.nf, uut.cf);

        i_mem.I_RAM[0] = {`LOAD, `gr1, 1'b0, `gr0, 4'b0000};
        i_mem.I_RAM[1] = {`LOAD, `gr2, 1'b0, `gr0, 4'b0001};
        i_mem.I_RAM[2] = {`NOP, 11'b000_0000_0000};
        i_mem.I_RAM[3] = {`NOP, 11'b000_0000_0000};
        i_mem.I_RAM[4] = {`NOP, 11'b000_0000_0000};
        i_mem.I_RAM[5] = {`ADD, `gr3, 1'b0, `gr1, 1'b0, `gr2};
        i_mem.I_RAM[6] = {`NOP, 11'b000_0000_0000};
        i_mem.I_RAM[7] = {`NOP, 11'b000_0000_0000};
        i_mem.I_RAM[8] = {`NOP, 11'b000_0000_0000};
        i_mem.I_RAM[9] = {`STORE, `gr3, 1'b0, `gr0, 4'b0010};
        i_mem.I_RAM[10] = {`BNZ, `gr1, 8'b0001_0000};
        i_mem.I_RAM[11] = {`NOP, 11'b000_0000_0000};
        i_mem.I_RAM[12] = {`NOP, 11'b000_0000_0000};
        i_mem.I_RAM[13] = {`NOP, 11'b000_0000_0000};
        i_mem.I_RAM[14] = {`SRL, `gr4, 1'b0, `gr3, 4'b0001};//if no jump from BNZ, then keep on this instruction 
        i_mem.I_RAM[15] = {`HALT, 11'b000_0000_0000};
        i_mem.I_RAM[187] = {`CMP, 4'b0000, `gr1, 1'b0, `gr2};
        i_mem.I_RAM[188] = {`HALT, 11'b000_0000_0000};
        
        d_mem.D_RAM[0] = 16'h00AB;
        d_mem.D_RAM[1] = 16'h3C00;
        d_mem.D_RAM[2] = 16'h0000;

        #10 rst_n = 0;
        #10 rst_n = 1;
        #10 enable = 1;
        #10 start =1;
        #10 start = 0;
        #250;
        if (d_mem.D_RAM[2] == 16'h3CAB) begin
            $write("\tSum = 0x%x\n", d_mem.D_RAM[2]);
            $display("Test Passed!");
        end
        else begin
            $write("\tSum = 0x%x\n", d_mem.D_RAM[2]);
            $display("Test Failed!");
        end
        $stop();
    end
    
    always #5
        clk = ~clk;
      
endmodule

