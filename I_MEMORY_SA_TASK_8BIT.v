//+FHDR****************************************************************
// ECE department, TAMU
// --------------------------------------------------------------------
// FILE NAME    : I_MEMORY_SA_TASK_8BIT.v
// AUTHER       : Jiafan Wang
// DATE         : 04/06/2017
// VERSION      : 1.0
// PURPOSE      : Use a seperate file to initialize the Pseudo SRAM 
// --------------------------------------------------------------------
// ABSTRACT: SRAM size 1024 X 8 bit length; Simulation under time period 20ns
// --------------------------------------------------------------------

//`timescale 1ns / 1ps
//`include "DEFINE_CPU.v"

`ifndef I_MEMORY_SA_TASK_8BIT_V
`define I_MEMORY_SA_TASK_8BIT_V

`include    "DEFINE_CPU.v"

module  I_MEMORY_SA_TASK_8BIT();
    // task convert;
    // input [7:0] temp_in;
    // output [7:0] temp_out;
        // begin
            // temp_out = (9/5) *( temp_in + 32);
        // end
    // endtask

    task init_1024x8bit;
        parameter   DEFAULT_PC_ADDR     = 16;
        parameter   MEMORY_DATA_WIDTH   = 8,
                    MEMORY_ADDR_WIDTH   = 10;

        output  [MEMORY_DATA_WIDTH-1:0] mem_out[(1<<MEMORY_ADDR_WIDTH)-1:0];
       
        integer i;
        reg     [(MEMORY_DATA_WIDTH << 1)-1:0] tmpi_datain;

        begin
            /* (0) Add initialization: Using a pseudo memory to load instruction*/ 
            i= DEFAULT_PC_ADDR*2;
            //Load I/O data_A to `gr2 as XIN
            tmpi_datain = {`LIOA, `gr2, 4'b0000, 4'b0000};
            mem_out[ i] = tmpi_datain[7:0];  i = 1 + DEFAULT_PC_ADDR*2;
            mem_out[ i] = tmpi_datain[15:8]; i = 2 + DEFAULT_PC_ADDR*2;
            //Load I/O data_A to `gr3 as YIN
            tmpi_datain = {`LIOA, `gr3, 4'b0000, 4'b0000};
            mem_out[ i] = tmpi_datain[7:0];  i = 3 + DEFAULT_PC_ADDR*2;
            mem_out[ i] = tmpi_datain[15:8]; i = 4 + DEFAULT_PC_ADDR*2;
            //set OFFSET as 0
            tmpi_datain = {`SUB, `gr4, 1'b0, `gr4, 1'b0, `gr4};
            mem_out[ i] = tmpi_datain[7:0];  i = 5 + DEFAULT_PC_ADDR*2;
            mem_out[ i] = tmpi_datain[15:8]; i = 6 + DEFAULT_PC_ADDR*2;
            //set the control reg for ALU
            tmpi_datain = {`SET, `gr1, 3'b001, 3'b100, 2'b01};
            mem_out[ i] = tmpi_datain[7:0];  i = 7 + DEFAULT_PC_ADDR*2;
            mem_out[ i] = tmpi_datain[15:8]; i = 8 + DEFAULT_PC_ADDR*2;

            //if (`gr3 != 0) go to I_RAM[ 9];
            // CPU is supposed to finish the loop automatically

            //Load I/O data_A to `gr2 as FOUT
            tmpi_datain = {`LIOA, `gr2, 4'b0000, 4'b0000};
            mem_out[ i] = tmpi_datain[7:0];  i = 9 + DEFAULT_PC_ADDR*2;
            mem_out[ i] = tmpi_datain[15:8]; i = 10+ DEFAULT_PC_ADDR*2;
            //Left Shift `gr2 and then save to SRAM
            tmpi_datain = {`SLL, `gr2, 1'b0, `gr2, 4'b0011};
            mem_out[ i] = tmpi_datain[7:0];  i = 11+ DEFAULT_PC_ADDR*2;
            mem_out[ i] = tmpi_datain[15:8]; i = 12+ DEFAULT_PC_ADDR*2;
            //reset the control reg for ALU
            tmpi_datain = {`SET, `gr1, 3'b000, 3'b000, 2'b00};
            mem_out[ i] = tmpi_datain[7:0];  i = 13+ DEFAULT_PC_ADDR*2;
            mem_out[ i] = tmpi_datain[15:8]; i = 14+ DEFAULT_PC_ADDR*2;
            //Save Multiplication to SRAM at 0x2;
            tmpi_datain = {`STORE, `gr2, 1'b0, `gr0, 4'b0010};
            mem_out[ i] = tmpi_datain[7:0];  i = 15+ DEFAULT_PC_ADDR*2;
            mem_out[ i] = tmpi_datain[15:8]; i = 16+ DEFAULT_PC_ADDR*2;

            //Clear OUT_A & Set SPI starting address;
            tmpi_datain = {`SUB, `gr2, 1'b0, `gr2, 1'b0, `gr2};
            mem_out[ i] = tmpi_datain[7:0];  i = 17 + DEFAULT_PC_ADDR*2;
            mem_out[ i] = tmpi_datain[15:8]; i = 18 + DEFAULT_PC_ADDR*2;
            tmpi_datain = {`SET, `gr2, 4'b0000, 4'b0011};
            mem_out[ i] = tmpi_datain[7:0];  i = 19 + DEFAULT_PC_ADDR*2;
            mem_out[ i] = tmpi_datain[15:8]; i = 20 + DEFAULT_PC_ADDR*2;

            //Clear OUT_B & Set SPI send data length;
            tmpi_datain = {`SUB, `gr3, 1'b0, `gr3, 1'b0, `gr3};
            mem_out[ i] = tmpi_datain[7:0];  i = 21 + DEFAULT_PC_ADDR*2;
            mem_out[ i] = tmpi_datain[15:8]; i = 22 + DEFAULT_PC_ADDR*2;
            tmpi_datain = {`SET, `gr3, 4'b0000, 4'b0010};
            mem_out[ i] = tmpi_datain[7:0];  i = 23 + DEFAULT_PC_ADDR*2;
            mem_out[ i] = tmpi_datain[15:8]; i = 24 + DEFAULT_PC_ADDR*2;

            //set the control reg for SPI
            tmpi_datain = {`SET, `gr1, 3'b010, 3'b000, 2'b00};
            mem_out[ i] = tmpi_datain[7:0];  i = 25 + DEFAULT_PC_ADDR*2;
            mem_out[ i] = tmpi_datain[15:8]; i = 26 + DEFAULT_PC_ADDR*2;

            // CPU is supposed to finish the loop automatically

            //reset the control reg for SPI
            tmpi_datain = {`SET, `gr1, 3'b000, 3'b000, 2'b00};
            mem_out[ i] = tmpi_datain[7:0];  i = 27 + DEFAULT_PC_ADDR*2;
            mem_out[ i] = tmpi_datain[15:8]; i = 28 + DEFAULT_PC_ADDR*2;

            //System finish
            tmpi_datain = {`HALT, 11'b000_0000_0000};
            mem_out[ i] = tmpi_datain[7:0];  i = 29 + DEFAULT_PC_ADDR*2;
            mem_out[ i] = tmpi_datain[15:8]; i = 30 + DEFAULT_PC_ADDR*2;

            i = 0;
            tmpi_datain = {`JUMP, 3'b000, 4'b0001, 4'b0000};// Jump to certain address
            mem_out[ i] = tmpi_datain[7:0];  i = 1;
            mem_out[ i] = tmpi_datain[15:8]; i = 2;
            tmpi_datain = 16'h3C00;
            mem_out[ i] = tmpi_datain[7:0];  i = 3;
            mem_out[ i] = tmpi_datain[15:8]; i = 4;
            tmpi_datain = 16'h0000;
            mem_out[ i] = tmpi_datain[7:0];  i = 5;
            mem_out[ i] = tmpi_datain[15:8]; i = 6;
            // i_mem.D_RAM[0] = 16'h00AB;
            // i_mem.D_RAM[1] = 16'h3C00;
            // i_mem.D_RAM[2] = 16'h0000;
        end
    endtask

endmodule
`endif//I_MEMORY_SA_TASK_8BIT_V