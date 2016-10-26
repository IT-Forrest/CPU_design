//+FHDR****************************************************************
// ECE department, TAMU
// --------------------------------------------------------------------
// FILE NAME    : SCPU_IO_CTRL_RA1SHD_TEST.v
// AUTHER       : Jiafan Wang
// DATE         : 10/26/2016
// VERSION      : 1.0
// PURPOSE      : RA1SHD SRAM and ctrl module tester
// --------------------------------------------------------------------
// ABSTRACT: ModelSim simulation time 6us given each time period 10ns
// --------------------------------------------------------------------
`timescale 1ns / 1ps
`include "../DEFINE_CPU.v"
`include "../SRAM_IO_CTRL.v"
`include "../RA1SHD_IBM1024X8.v"
//`include "../RA1SHD_IBM512X8.v"
`include "../I_MEMORY_8bit.v"

module SRAM_IO_CTRL_RA1SHD_TEST;

   parameter    MEMORY_DATA_WIDTH   = 8,
                MEMORY_ADDR_WIDTH   = 10,
                REG_BITS_WIDTH = MEMORY_ADDR_WIDTH + MEMORY_DATA_WIDTH;

    // Inputs
    reg clk;
    reg CTRL_BGN;// enable signal for CTRL_SRAM
    reg rst_n;//no use here
    reg start;// enable signal for SERIAL_CPU_8bit
    reg [1:0]   CTRL_MODE;
    
    // Wires
    // wire is_i_addr;
    // wire [7:0]  i_datain;
    // wire [7:0]  d_datain;
    // wire [7:0]  d_dataout;
    wire [7:0]  m_datain;

    wire [7:0]  m_dataout;
    wire [MEMORY_ADDR_WIDTH-1:0]  m_addr;
    // wire [8:0]  i_addr;
    // wire [8:0]  d_addr;
    wire d_we;
    wire CEN;
    wire SO;
    wire RDY;
    
    integer i,j,k;
    reg  [15:0] tmpi_datain;
    reg  [REG_BITS_WIDTH-1:0]  tmpi_all;//addr+instruction
    reg  [MEMORY_ADDR_WIDTH-1:0]  tmpi_adder;
    reg  SI;
    reg  LOAD_N;
    integer error_cnt;
   
    // Instantiate the Unit Under Test (UUT)
    SRAM_IO_CTRL cct (
        .CLK(clk),
        .BGN(CTRL_BGN),
        .SI(SI),
        .LOAD_N(LOAD_N),
        .CTRL(CTRL_MODE),//2'b00
        .PI(m_dataout),
        .RDY(RDY),
        .D_WE(d_we),
        .CEN(CEN),
        .SO(SO),
        .A(m_addr),
        .PO(m_datain)
    );
    
    RA1SHD_IBM1024X8   sram (
        .CLK(clk),
        .CEN(CEN), 
        .A(m_addr),
        .WEN(d_we),// need a seperate control signal; or instruction set will be overwritten when d_we=1
        .D(m_datain),//i_instruct
        .Q(m_dataout)
    );

    // only used for testbench
    I_MEMORY_8BIT   i_mem(
        // .clk(clk),
        // .rst_n(CEN), 
        // .addr(m_addr),
        // .d_we(d_we),// need a seperate control signal; or instruction set will be overwritten when d_we=1
        // .datain(m_datain),//i_instruct
        // .dataout(m_dataout)
    );
    
    parameter   DEFAULT_PC_ADDR = 16;
    //defparam    uut.DEFAULT_PC_ADDR = DEFAULT_PC_ADDR;
    
    //assign  m_addr = (is_i_addr)?i_addr:d_addr;
    //assign  m_datain = d_dataout;
    //assign  i_datain = (is_i_addr)?m_dataout:0;
    //assign  d_datain = (is_i_addr)?0:m_dataout;
    
    initial begin
        // Initialize Inputs Signals
        clk = 0;
        rst_n = 0;
        CTRL_BGN = 0;
        start = 0;
        LOAD_N = 1;
        error_cnt = 0;
        CTRL_MODE = 2'b00;
        #50;
        // Wait 100 ns for global rst_n to finish

        /* (1) Add stimulus here: Using a pseudo memory to load instruction*/ 
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
        tmpi_datain = 16'h00AB;
        i_mem.I_RAM[ i] = tmpi_datain[7:0];  i = 1;
        i_mem.I_RAM[ i] = tmpi_datain[15:8]; i = 2;
        tmpi_datain = 16'h3C00;
        i_mem.I_RAM[ i] = tmpi_datain[7:0];  i = 3;
        i_mem.I_RAM[ i] = tmpi_datain[15:8]; i = 4;
        tmpi_datain = 16'h0000;
        i_mem.I_RAM[ i] = tmpi_datain[7:0];  i = 5;
        i_mem.I_RAM[ i] = tmpi_datain[15:8]; i = 6;
        // i_mem.D_RAM[0] = 16'h00AB;
        // i_mem.D_RAM[1] = 16'h3C00;
        // i_mem.D_RAM[2] = 16'h0000;

        #10 rst_n = 0;
        #10 rst_n = 1; 

        /* (2) Serially Input the address & Instruction to CTRL and then to SRAM */
        for (i = DEFAULT_PC_ADDR; i<7+ DEFAULT_PC_ADDR; i=i+1) begin
            for (k=2; k>=1; k=k-1) begin
                /** (a) load data to SRAM_IO_CTRL from PC **/
                // C code modify control word
                #10 CTRL_BGN = 1;
                #10 CTRL_MODE = 2'b00;
                tmpi_adder = (i<<1)+k-1;
                tmpi_all = {tmpi_adder, i_mem.I_RAM[tmpi_adder]};
                // C code triger FPGA gen Load signal
            
                begin
                    // FPGA send Load signal & data to CTRL
                    #10 LOAD_N = 0;
                    #10;//need to wait one more cycle for the delay
                    for (j = 0; j < REG_BITS_WIDTH; j=j+1) begin
                        #10 SI = tmpi_all[j];
                    end
                end
            
                // C code polling to do next
                begin: ctrl_module_load_ready
                forever begin
                    #10;
                    if (RDY) begin
                        disable ctrl_module_load_ready;
                    end
                end
                end
            
                // C code modify control word
                #10 CTRL_BGN = 0;
                #10 LOAD_N = 1;//this FPGA signal is related to CTRL_BGN
                begin: ctrl_module_load_finish
                forever begin
                    #10;
                    if (!RDY) begin
                        disable ctrl_module_load_finish;
                    end
                end
                end
            
                /** (b) notify SRAM_IO_CTRL to send data to SRAM **/
                // C code modify control word
                #10 CTRL_BGN = 1;
                #10 CTRL_MODE = 2'b11;
                // C code triger FPGA gen Load signal
                
                begin
                    // FPGA send Load signal & data to CTRL
                    #10 LOAD_N = 0;
                end
                
                // C code polling to do next
                begin: ctrl_module_write_ready
                forever begin
                    #10;
                    if (RDY) begin
                        disable ctrl_module_write_ready;
                    end
                end
                end
                
                // C code modify control word
                #10 CTRL_BGN = 0;
                #10 LOAD_N = 1;//this FPGA signal is related to CTRL_BGN
                begin: ctrl_module_write_finish
                forever begin
                    #10;
                    if (!RDY) begin
                        disable ctrl_module_write_finish;
                    end
                end
                end
            end
        end
        #3130;
        
        // (3) Read the inner instructions
        //force   CEN = 0;//enable RA1SHD_ibm512x8
        //force   d_we = 1;//read module
        for (i = DEFAULT_PC_ADDR; i<7+ DEFAULT_PC_ADDR; i=i+1) begin
            $write("%4x\t", (i<<1));
            for (k = 2; k >= 1; k=k-1) begin
                /** (a) load data to SRAM_IO_CTRL from PC **/
                // C code modify control word
                #10 CTRL_BGN = 1;
                #10 CTRL_MODE = 2'b00;
                tmpi_adder = (i<<1)+k-1;
                tmpi_all = {tmpi_adder, {MEMORY_DATA_WIDTH{1'b0}}};//i_mem.I_RAM[tmpi_adder]
                // C code triger FPGA gen Load signal
                
                begin
                    // FPGA send Load signal & data to CTRL
                    #10 LOAD_N = 0;
                    #10;//need to wait one more cycle for the delay
                    for (j = 0; j < REG_BITS_WIDTH; j=j+1) begin
                        #10 SI = tmpi_all[j];
                    end
                end
                
                // C code polling to do next
                begin: ctrl_module_load_ready_2nd
                forever begin
                    #10;
                    if (RDY) begin
                        disable ctrl_module_load_ready_2nd;
                    end
                end
                end
                
                // C code modify control word
                #10 CTRL_BGN = 0;
                #10 LOAD_N = 1;//this FPGA signal is related to CTRL_BGN
                begin: ctrl_module_load_finish_2nd
                forever begin
                    #10;
                    if (!RDY) begin
                        disable ctrl_module_load_finish_2nd;
                    end
                end
                end

                /** (b) notify SRAM_IO_CTRL to send data to SRAM **/
                // C code modify control word
                #10 CTRL_BGN = 1;
                #10 CTRL_MODE = 2'b01;
                // C code triger FPGA gen Load signal
                
                begin
                    // FPGA send Load signal & data to CTRL
                    #10 LOAD_N = 0;
                end
                
                // C code polling to do next
                begin: ctrl_module_read_ready
                forever begin
                    #10;
                    if (RDY) begin
                        disable ctrl_module_read_ready;
                    end
                end
                end
                
                // C code modify control word
                #10 CTRL_BGN = 0;
                #10 LOAD_N = 1;//this FPGA signal is related to CTRL_BGN
                begin: ctrl_module_read_finish
                forever begin
                    #10;
                    if (!RDY) begin
                        disable ctrl_module_read_finish;
                    end
                end
                end
                
                /** (c) Export SRAM data from SRAM_IO_CTRL**/
                $write("%8b ", cct.reg_bits[MEMORY_DATA_WIDTH-1:0]);
                if (k == 1)
                    tmpi_datain[MEMORY_DATA_WIDTH-1:0] = cct.reg_bits[MEMORY_DATA_WIDTH-1:0];
                else if (k == 2)
                    tmpi_datain[2*MEMORY_DATA_WIDTH-1:MEMORY_DATA_WIDTH] = cct.reg_bits[MEMORY_DATA_WIDTH-1:0];
            end
        
            if (tmpi_datain != {i_mem.I_RAM[(i<<1)+1],i_mem.I_RAM[i<<1]}) begin
                $write("<-- Data Wrong!");
                error_cnt = error_cnt + 1;
            end
            $display("");
        end
        
        // Judge Final Test Result
        if (error_cnt)
            $display("Test Failed!");
        else
            $display("Test Passed!");
        //#10 release CEN; release d_we;
        $stop();//
    end
    
    always #5
        clk = ~clk;
      
endmodule

