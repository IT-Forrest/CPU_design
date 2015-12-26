`timescale 1ns / 1ps
`include "../DEFINE_CPU.v"
`include "../PIPE_CPU.v"
`include "../I_MEMORY.v"
`include "../D_MEMORY.v"


module PCPU_MEM_RST_TOP;

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
        .rst(rst),
        .addr(i_addr),
        .d_we(1'b0),
        .datain(16'b0000_0000_0000_0000),
        .dataout(i_datain)
    );
    D_MEMORY d_mem (
        .clk(clk),
        .rst(rst),
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
        $monitor("%3d : %b : %h : %h : %h : %h : %h : %b : %h : %h : %h : %h : %b : %b : %b", 
            uut.pc, uut.id_ir, uut.reg_A, uut.reg_B, uut.reg_C,
            d_addr, d_dataout, d_we, uut.reg_C1, uut.gr[1], uut.gr[2], uut.gr[3],
            uut.zf, uut.nf, uut.cf);

        #10 rst_n = 0;
        #10 rst_n = 1;
        #10 enable = 1;
        #10 start =1;
        #10 start = 0;
        #200 $stop();
    end
    
    always #5
        clk = ~clk;
      
endmodule

