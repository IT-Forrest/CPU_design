`timescale 1ns / 1ps
`include "../DEFINE_CPU.v"
`include "../SERIAL_CPU_8bit.v"


module SCPU_SINGLE_8BIT_TOP;

    // Inputs
    reg clk;
    //reg enable;
    reg rst_n;
    reg start;
    reg [7:0] i_datain;
    reg [7:0] d_datain;
    reg [15:0]  tmpi_datain;
    reg [15:0]  tmpd_datain;
    reg select_y;
    
    // Outputs
    wire [8:0] i_addr;
    wire [8:0] d_addr;
    wire d_we;
    reg  [15:0] tmp_dataout;
    wire [7:0] d_dataout;

    // Instantiate the Unit Under Test (UUT)
    SERIAL_CPU_8BIT uut (
        .clk(clk), 
        //.enable(enable), 
        .rst_n(rst_n), 
        .start(start), 
        .i_datain(i_datain), 
        .d_datain(d_datain), 
        .i_addr(i_addr), 
        .d_addr(d_addr), 
        .d_we(d_we), 
        .d_dataout(d_dataout)
    );

    defparam    uut.DEFAULT_PC_ADDR = 0;
    
    initial begin
        // Initialize Inputs
        clk = 0;
        //enable = 0;
        rst_n = 1;
        start = 0;
        i_datain = 0;
        d_datain = 0;
        select_y = 0;

        // Wait 100 ns for global rst_n to finish
        #100;
        
        // Add stimulus here
        $display("pc  :     id_ir      : reg_A : reg_B : reg_C : da : dd : w : reg_C : gr1 : gr2 : gr3 : zf : nf : cf");
        $monitor("%3d : %b : %h : %h : %h : %h : %h : %b : %h : %h : %h : %h: %b: %b: %b", 
            uut.pc, uut.id_ir, uut.reg_A, uut.reg_B, uut.reg_C,
            d_addr, d_dataout, d_we, uut.reg_C, uut.gr[1], uut.gr[2], uut.gr[3],
            uut.zf, uut.nf, uut.cf);
        
        //enable = 1; 
        start = 0; i_datain = 0; d_datain = 0; select_y = 0;

        #10 rst_n = 0;
        #10 rst_n = 1;
        //#10 enable = 1;
        #10 start = 1;
        #10 start = 0;
            tmpi_datain = {`LOAD, `gr1, 1'b0, `gr0, 4'b0000};
            i_datain = tmpi_datain[7:0];
        #10 i_datain = tmpi_datain[15:8];
        #40 tmpd_datain = 16'h10AB;  // 3 clk later from LOAD
        #10 d_datain = tmpd_datain[7:0];
        #10 d_datain = tmpd_datain[15:8];
        #10 tmpi_datain = {`LOAD, `gr2, 1'b0, `gr0, 4'b0001};
            i_datain = tmpi_datain[7:0];
        #10 i_datain = tmpi_datain[15:8];
        #40 tmpd_datain = 16'h3C00;  // 3 clk later from LOAD
        #10 d_datain = tmpd_datain[7:0];
        #10 d_datain = tmpd_datain[15:8];
        #10 tmpi_datain = {`ADD, `gr3, 1'b0, `gr1, 1'b0, `gr2};
            i_datain = tmpi_datain[7:0];
        #10 i_datain = tmpi_datain[15:8];
        #50 tmpi_datain = {`STORE, `gr3, 1'b0, `gr0, 4'b0010};
        #10 i_datain = tmpi_datain[7:0];
        #10 i_datain = tmpi_datain[15:8];
        #50 tmpi_datain = {`CMP, 4'b0000, `gr1, 1'b0, `gr2};
        #10 i_datain = tmpi_datain[7:0];
        #10 i_datain = tmpi_datain[15:8];
        // #70 tmpi_datain = {`BNZ, `gr1, 8'b00100001};// 4 clk later from CMP
            // i_datain = tmpi_datain[7:0];
        // #10 i_datain = tmpi_datain[15:8];
        #50 tmpi_datain = {`HALT, 11'b000_0000_0000};
        #10 i_datain = tmpi_datain[7:0];
        #10 i_datain = tmpi_datain[15:8];
        #100;
        
        /*  print the inner instructions */ 
        if (16'h4CAB == uut.gr[3])
            $display("\tTest Passed!");
        else begin
            $display("\tTest Failed!");
        end
        $stop();
    end
    
    always #5
        clk = ~clk;
      
endmodule

