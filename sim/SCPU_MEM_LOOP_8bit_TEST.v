//+FHDR****************************************************************
// ECE department, TAMU
// --------------------------------------------------------------------
// FILE NAME    : SCPU_MEM_LOOP_8bit_TEST.v
// AUTHER       : Jiafan Wang
// DATE         : 03/12/2016
// VERSION      : 1.0
// PURPOSE      : the SCPU test with self-created SRAM (1024X8 SRAM)
// --------------------------------------------------------------------
// ABSTRACT: ModelSim simulation time 6us given each time period 10ns
// --------------------------------------------------------------------
`timescale 1ns / 1ps
`include "../DEFINE_CPU.v"
`include "../SERIAL_CPU_8bit.v"
`include "../I_MEMORY_8bit.v"

module SCPU_MEM_LOOP_8BIT_TEST;
    parameter   MEMORY_DATA_WIDTH   = 8,
                MEMORY_ADDR_WIDTH   = 10;
    
    // Inputs
    reg clk;
    reg enable;
    reg rst_n;
    reg start;
    reg select_y;
    reg CPU_WAIT;
    
    // Wires
    wire is_i_addr;
    wire [7:0]  i_datain;
    wire [7:0]  d_datain;
    wire [7:0]  d_dataout;
    wire [7:0]  m_datain;

    wire [7:0]  m_dataout;
    wire [MEMORY_ADDR_WIDTH-1:0]  m_addr;//8
    wire [MEMORY_ADDR_WIDTH-1:0]  i_addr;
    wire [MEMORY_ADDR_WIDTH-1:0]  d_addr;
    wire d_we;

    integer i,j;
    reg  [15:0] tmpi_datain;
    
    // Instantiate the Unit Under Test (UUT)
    SERIAL_CPU_8BIT uut (
        .clk(clk_dly), 
        .enable(enable), 
        .rst_n(rst_n), 
        .start(CPU_BGN_dly), 
        .i_datain(i_datain), 
        .d_datain(d_datain), 
        .CPU_WAIT(CPU_WAIT),
        // output
        .is_i_addr(is_i_addr),
        .i_addr(i_addr), 
        .d_addr(d_addr), 
        .d_we(d_we), 
        .d_dataout(d_dataout)
    );
    I_MEMORY_8BIT i_mem (
        .clk(clk_dly),
        .rst_n(rst_n), 
        .addr(m_addr),
        .d_we(d_we),// need a seperate control signal; or instruction set will be overwritten when d_we=1
        .datain(m_datain),//i_instruct
        .dataout(m_dataout)
    );

    parameter   VIRTUAL_DLY = 2;
    parameter   DEFAULT_PC_ADDR = 16;
    defparam    uut.DEFAULT_PC_ADDR = DEFAULT_PC_ADDR;
    
    assign  m_addr = (is_i_addr)?i_addr:d_addr;
    assign  m_datain = d_dataout;
    assign  i_datain = (is_i_addr)?m_dataout:0;
    assign  d_datain = (is_i_addr)?0:m_dataout;
    
    assign  #VIRTUAL_DLY    CPU_BGN_dly = start;
    assign  #VIRTUAL_DLY    clk_dly = clk;
    
    initial begin
        // Initialize Inputs
        clk = 0;
        enable = 0;
        rst_n = 1;
        start = 0;
        select_y = 0;
        CPU_WAIT = 0;

        // Wait 100 ns for global rst_n to finish
        #100;
        
        // Add stimulus here
        $display("pc  :               id_ir                :reg_A :reg_B :reg_C\
            : da  :  dd  : w :  gr1  :  gr2  :  gr3   :zf :nf:cf");
        // $monitor("%3d : %b : %h : %h : %h : %h : %h : %b : %h : %h : %h : %b : %b : %b", 
            // uut.pc, uut.id_ir, uut.reg_A, uut.reg_B, uut.reg_C,
            // d_addr, d_dataout, d_we, uut.gr[1], uut.gr[2], uut.gr[3],
            // uut.zf, uut.nf, uut.cf);

        i= DEFAULT_PC_ADDR*2;
        tmpi_datain = {`SET, `gr3, 4'b0000, 4'b0100};//reset the loop controller `gr7
        i_mem.I_RAM[ i] = tmpi_datain[7:0];  i = 1 + DEFAULT_PC_ADDR*2;
        i_mem.I_RAM[ i] = tmpi_datain[15:8]; i = 2 + DEFAULT_PC_ADDR*2;
        tmpi_datain = {`SET, `gr1, 4'b0000, 4'b0000};//reset the sum value
        i_mem.I_RAM[ i] = tmpi_datain[7:0];  i = 3 + DEFAULT_PC_ADDR*2;
        i_mem.I_RAM[ i] = tmpi_datain[15:8]; i = 4 + DEFAULT_PC_ADDR*2;
        // i_mem.I_RAM[ 2] = {`NOP, 11'b000_0000_0000};
        // i_mem.I_RAM[ 3] = {`NOP, 11'b000_0000_0000};
        // i_mem.I_RAM[ 4] = {`NOP, 11'b000_0000_0000};
        tmpi_datain = {`ADD, `gr1, 1'b0, `gr1, 1'b0, `gr3};//set the loop controller `gr7 = 25
        i_mem.I_RAM[ i] = tmpi_datain[7:0];  i = 5 + DEFAULT_PC_ADDR*2;
        i_mem.I_RAM[ i] = tmpi_datain[15:8]; i = 6 + DEFAULT_PC_ADDR*2;
        // i_mem.I_RAM[ 7] = {`NOP, 11'b000_0000_0000};
        // i_mem.I_RAM[ 8] = {`NOP, 11'b000_0000_0000};
        tmpi_datain = {`SUBI, `gr3, 4'b0000, 4'b0001};//sum += `gr7
        i_mem.I_RAM[ i] = tmpi_datain[7:0];  i = 7 + DEFAULT_PC_ADDR*2;
        i_mem.I_RAM[ i] = tmpi_datain[15:8]; i = 8 + DEFAULT_PC_ADDR*2;
        
        //if (`gr3 != 0) go to I_RAM[ 9];
        //make sure to include the offset for DATA SRAM
        tmpi_datain = {`BNZ, `gr0, 4'b0001, 4'b0010};
        
        i_mem.I_RAM[ i] = tmpi_datain[7:0];  i = 9 + DEFAULT_PC_ADDR*2;
        i_mem.I_RAM[ i] = tmpi_datain[15:8]; i = 10+ DEFAULT_PC_ADDR*2;
        // i_mem.I_RAM[11] = {`NOP, 11'b000_0000_0000};
        // i_mem.I_RAM[12] = {`NOP, 11'b000_0000_0000};
        // i_mem.I_RAM[13] = {`NOP, 11'b000_0000_0000};
        tmpi_datain = {`STORE, `gr1, 1'b0, `gr0, 4'b0010};//if (`gr7 != 0) go to I_RAM[ 9];
        i_mem.I_RAM[ i] = tmpi_datain[7:0];  i = 11+ DEFAULT_PC_ADDR*2;
        i_mem.I_RAM[ i] = tmpi_datain[15:8]; i = 12+ DEFAULT_PC_ADDR*2;
        // i_mem.I_RAM[15] = {`NOP, 11'b000_0000_0000};
        // i_mem.I_RAM[16] = {`NOP, 11'b000_0000_0000};
        // i_mem.I_RAM[17] = {`NOP, 11'b000_0000_0000};
        tmpi_datain = {`HALT, 11'b000_0000_0000};//due to the pipeline, we need to add many `NOP to the instruction set
        i_mem.I_RAM[ i] = tmpi_datain[7:0];  i = 13+ DEFAULT_PC_ADDR*2;
        i_mem.I_RAM[ i] = tmpi_datain[15:8]; i = 14+ DEFAULT_PC_ADDR*2;
        // i_mem.I_RAM[19] = {`NOP, 11'b000_0000_0000};
        // i_mem.I_RAM[20] = {`NOP, 11'b000_0000_0000};
        // i_mem.I_RAM[21] = {`NOP, 11'b000_0000_0000};
        
        i = 0;
        tmpi_datain = {`JUMP, 3'b000, 4'b0001, 4'b0000};// Jump to certain address
        i_mem.I_RAM[ i] = tmpi_datain[7:0];  i = 1;
        i_mem.I_RAM[ i] = tmpi_datain[15:8]; i = 2;
        tmpi_datain = 16'h00AB;
        i_mem.I_RAM[ i] = tmpi_datain[7:0];  i = 3;
        i_mem.I_RAM[ i] = tmpi_datain[15:8]; i = 4;
        tmpi_datain = 16'h3C00;
        i_mem.I_RAM[ i] = tmpi_datain[7:0];  i = 5;
        i_mem.I_RAM[ i] = tmpi_datain[15:8]; i = 6;
        // i_mem.D_RAM[0] = 16'h00AB;
        // i_mem.D_RAM[1] = 16'h3C00;
        // i_mem.D_RAM[2] = 16'h0000;

        #10 rst_n = 0;
        #10 rst_n = 1;
        #10 enable = 1;
        #10 start =1;
        #10 start = 0;
        // for (j=1; j<40; j=j+1)
            // #100;
        #3130;
        if ({i_mem.I_RAM[5], i_mem.I_RAM[4]} == 16'd10) begin
            $write("\tSum = %d\n", {i_mem.I_RAM[5], i_mem.I_RAM[4]});
            $display("Test Passed!");
        end
        else begin
            $write("\tSum = %d\n", {i_mem.I_RAM[5], i_mem.I_RAM[4]});
            $display("Test Failed!");
        end
        $stop();//
    end
    
    always #5
        clk = ~clk;
      
endmodule

