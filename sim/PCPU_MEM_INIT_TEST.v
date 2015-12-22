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
        .addr(i_addr),
        .d_we(),//d_we
        .datain(),//i_addr
        .dataout(i_datain)
    );
    D_MEMORY d_mem (
        .clk(clk),
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
        $display("pc :               id_ir                :reg_A :reg_B :reg_C\
: da  :  dd  : w : reC1 :  gr1  :  gr2  :  gr3   :zf :nf:cf");
        $monitor("%h : %b : %h : %h : %h : %h : %h : %b : %h : %h : %h : %h : %b : %b : %b", 
            uut.pc, uut.id_ir, uut.reg_A, uut.reg_B, uut.reg_C,
            d_addr, d_dataout, d_we, uut.reg_C1, uut.gr[1], uut.gr[2], uut.gr[3],
            uut.zf, uut.nf, uut.cf);

        i_mem.RAM[0] <= {`LOAD, `gr1, 1'b0, `gr0, 4'b0000};
        i_mem.RAM[1] <= {`LOAD, `gr2, 1'b0, `gr0, 4'b0001};
        i_mem.RAM[2] <= {`NOP, 11'b000_0000_0000};
        i_mem.RAM[3] <= {`NOP, 11'b000_0000_0000};
        i_mem.RAM[4] <= {`NOP, 11'b000_0000_0000};
        i_mem.RAM[5] <= {`ADD, `gr3, 1'b0, `gr1, 1'b0, `gr2};
        i_mem.RAM[6] <= {`NOP, 11'b000_0000_0000};
        i_mem.RAM[7] <= {`NOP, 11'b000_0000_0000};
        i_mem.RAM[8] <= {`NOP, 11'b000_0000_0000};
        i_mem.RAM[9] <= {`STORE, `gr3, 1'b0, `gr0, 4'b0010};
        i_mem.RAM[10] <= {`BNZ, `gr1, 8'b0001_0000};
        i_mem.RAM[11] <= {`NOP, 11'b000_0000_0000};
        i_mem.RAM[12] <= {`NOP, 11'b000_0000_0000};
        i_mem.RAM[13] <= {`NOP, 11'b000_0000_0000};
        i_mem.RAM[187] <= {`CMP, 4'b0000, `gr1, 1'b0, `gr2};
        i_mem.RAM[188] <= {`HALT, 11'b000_0000_0000};
        
        
        d_mem.RAM[0] <= 16'h00AB;
        d_mem.RAM[1] <= 16'h3C00;
        d_mem.RAM[2] <= 16'h0000;

        #10 rst_n <= 0;
        #10 rst_n <= 1;
        #10 enable <= 1;
        #10 start <=1;
        #10 start <= 0;
    end
    
    always #5
        clk = ~clk;
      
endmodule

