//+FHDR****************************************************************
// ECE department, TAMU
// --------------------------------------------------------------------
// FILE NAME    : SCPU_MEM_INST_END_8BIT_TEST.v
// AUTHER       : Jiafan Wang
// DATE         : 07/08/2016
// VERSION      : 1.0
// PURPOSE      : SCPU's feature of reload instruction to SRAM
// --------------------------------------------------------------------
// ABSTRACT: ModelSim simulation time 6us given each time period 10ns
// --------------------------------------------------------------------
`timescale 1ns / 1ps
`include "../DEFINE_CPU.v"
`include "../SERIAL_CPU_8bit.v"
`include "../I_MEMORY_8bit.v"

module SCPU_MEM_INST_END_8BIT_TEST;

   parameter    MEMORY_DATA_WIDTH   = 8,
                MEMORY_ADDR_WIDTH   = 10;

    // Inputs
    reg clk;
    reg enable;
    reg rst_n;
    reg start;
    reg cpu_halt;
    
    // Wires
    wire is_i_addr;
    wire [1:0]  nxt;
    wire [7:0]  i_datain;
    wire [7:0]  d_datain;
    wire [7:0]  d_dataout;
    wire [7:0]  m_datain;

    wire [7:0]  m_dataout;
    wire [MEMORY_ADDR_WIDTH-1:0]  m_addr;
    wire [MEMORY_ADDR_WIDTH-1:0]  i_addr;
    wire [MEMORY_ADDR_WIDTH-1:0]  d_addr;
    wire d_we;

    integer i,j;
    reg  [15:0] tmpi_datain;
    
    // Instantiate the Unit Under Test (UUT)
    SERIAL_CPU_8BIT uut (
        .clk(clk), 
        .enable(enable), 
        .rst_n(rst_n), 
        .start(start),
        .i_datain(i_datain), 
        .d_datain(d_datain), 
        // output
        .is_i_addr(is_i_addr),
        .nxt(nxt),
        .i_addr(i_addr), 
        .d_addr(d_addr), 
        .d_we(d_we), 
        .d_dataout(d_dataout)
    );
    I_MEMORY_8BIT i_mem (
        .clk(clk),
        .rst_n(rst_n), 
        .addr(m_addr),
        .d_we(d_we),// need a seperate control signal; or instruction set will be overwritten when d_we=1
        .datain(m_datain),//i_instruct
        .dataout(m_dataout)
    );

    parameter   DEFAULT_PC_ADDR = 250;
    
    assign  m_addr = (is_i_addr)?i_addr:d_addr;
    assign  m_datain = d_dataout;
    assign  i_datain = (is_i_addr)?m_dataout:0;
    assign  d_datain = (is_i_addr)?0:m_dataout;
    
    initial begin
        // Initialize Inputs
        clk = 0;
        enable = 0;
        rst_n = 1;
        start = 0;
        cpu_halt = 0;
        #100;

        /* (0) pre-setting */
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

        // Jump to the ADD instruction: addr = DEFAULT_PC_ADDR + 2;
        tmpi_datain = {`BNZ, `gr0, 4'b1111, 4'b1100};
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
        
        i = 0;
        tmpi_datain = {`JMPR, `gr0, 4'b1111, 4'b1010};//sum += `gr7
        i_mem.I_RAM[ i] = tmpi_datain[7:0];  i = 1;
        i_mem.I_RAM[ i] = tmpi_datain[15:8]; i = 2;
        tmpi_datain = 16'h3C00;
        i_mem.I_RAM[ i] = tmpi_datain[7:0];  i = 3;
        i_mem.I_RAM[ i] = tmpi_datain[15:8]; i = 4;
        tmpi_datain = 16'h0000;
        i_mem.I_RAM[ i] = tmpi_datain[7:0];  i = 5;
        i_mem.I_RAM[ i] = tmpi_datain[15:8]; i = 6;
        // i_mem.D_RAM[0] = `JMPR; // instruction
        // i_mem.D_RAM[1] = 16'h3C00;
        // i_mem.D_RAM[2] = 16'h000A;
        // i_mem.D_RAM[2] = 16'h3C0A;
        #10;// setting breakpoint 

        /* (1) Activate CPU & run instructions */
        #10 rst_n = 0;
        #10 rst_n = 1;
        #10 enable = 1;

        #10 start = 1;
        #10 start = 0;
        // for (j=1; j<40; j=j+1)
            // #100;
        #1000;
        
        /* (2) Detect instructions exhaust & reload new instructions */
        begin: detect_nxt_signals_1st
        forever begin
            #10;
            // program is finish
            if (nxt[0]) begin
                cpu_halt = 1;
                disable detect_nxt_signals_1st;
            end
            
            // replace old instructions with the new ones;
            if (nxt[1]) begin
        i= DEFAULT_PC_ADDR*2;
        tmpi_datain = {`LOAD, `gr2, 1'b0, `gr0, 4'b0001};//load data from 0x02~0x03
        i_mem.I_RAM[ i] = tmpi_datain[7:0];  i = 1 + DEFAULT_PC_ADDR*2;
        i_mem.I_RAM[ i] = tmpi_datain[15:8]; i = 2 + DEFAULT_PC_ADDR*2;
        tmpi_datain = {`ADD, `gr1, 1'b0, `gr1, 1'b0, `gr2};
        i_mem.I_RAM[ i] = tmpi_datain[7:0];  i = 3 + DEFAULT_PC_ADDR*2;
        i_mem.I_RAM[ i] = tmpi_datain[15:8]; i = 4 + DEFAULT_PC_ADDR*2;
        tmpi_datain = {`STORE, `gr1, 1'b0, `gr0, 4'b0011};
        i_mem.I_RAM[ i] = tmpi_datain[7:0];  i = 5+ DEFAULT_PC_ADDR*2;
        i_mem.I_RAM[ i] = tmpi_datain[15:8]; i = 6+ DEFAULT_PC_ADDR*2;
        tmpi_datain = {`HALT, 11'b000_0000_0000};// set the finish instruction
        i_mem.I_RAM[ i] = tmpi_datain[7:0];  i = 7 + DEFAULT_PC_ADDR*2;
        i_mem.I_RAM[ i] = tmpi_datain[15:8]; i = 8 + DEFAULT_PC_ADDR*2;
                disable detect_nxt_signals_1st;
            end
        end
        end
        
        #10;// setting breakpoint  
        /* (3) Activate CPU again & wait for nxt signal */
        if (!cpu_halt) begin
            #10 start = 1;
            #10 start = 0;
            begin: detect_nxt_signals_2nd
            forever begin
                #10;
                // program is finish
                if (nxt[0]) begin
                    cpu_halt = 1;
                    disable detect_nxt_signals_2nd;
                end
            end
            end
        end
        
        /* (4) Check final result */
        if (({i_mem.I_RAM[3], i_mem.I_RAM[2]} == 16'h3C00)
            && ({i_mem.I_RAM[5], i_mem.I_RAM[4]} == 16'h000A)
            && ({i_mem.I_RAM[7], i_mem.I_RAM[6]} == 16'h3C0A)) begin
            $write("\tSum = 0x%x\n", {i_mem.I_RAM[7], i_mem.I_RAM[6]});
            $display("Test Passed!");
        end
        else begin
            $write("\tSum = 0x%x\n", {i_mem.I_RAM[7], i_mem.I_RAM[6]});
            $display("Test Failed!");
        end
        #20 $stop();//
    end
    
    always #5
        clk = ~clk;
      
endmodule

