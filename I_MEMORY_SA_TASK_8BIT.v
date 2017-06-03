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
//      Simulated Annealing Algorithm
// --------------------------------------------------------------------

//`timescale 1ns / 1ps
//`include "DEFINE_CPU.v"

`ifndef I_MEMORY_SA_TASK_8BIT_V
`define I_MEMORY_SA_TASK_8BIT_V

`include    "DEFINE_CPU.v"

module  I_MEMORY_SA_TASK_8BIT(
    addr,
    mem_sa
);
    parameter   DEFAULT_PC_ADDR     = 30;
    parameter   MEMORY_DATA_WIDTH   = 8,
                MEMORY_ADDR_WIDTH   = 10;

    input   [MEMORY_ADDR_WIDTH-1:0] addr;
    output  [MEMORY_DATA_WIDTH-1:0] mem_sa;
   
    integer i;
    reg     [MEMORY_DATA_WIDTH-1:0] mem_out[0:(1<<MEMORY_ADDR_WIDTH)-1];
    reg     [(MEMORY_DATA_WIDTH << 1)-1:0] tmpi_datain;

    initial begin
        /* (0) Initialization: Jump + SA Configuration */ 
        i = 0;
        tmpi_datain = {`JUMP, 3'b000, 4'b0001, 4'b1110};// Jump to certain address
        mem_out[ i] = tmpi_datain[7:0];  i = 1;
        mem_out[ i] = tmpi_datain[15:8]; i = 2;

        tmpi_datain = {`NOP, 3'b000, 4'b0000, 4'b0000};// store A4 from CF
        mem_out[ i] = tmpi_datain[7:0];  i = 3;
        mem_out[ i] = tmpi_datain[15:8]; i = 4;

        tmpi_datain = {`NOP, 3'b000, 4'b0000, 4'b0000};// store A3 from CF
        mem_out[ i] = tmpi_datain[7:0];  i = 5;
        mem_out[ i] = tmpi_datain[15:8]; i = 6;
        
        tmpi_datain = {`NOP, 3'b000, 4'b0000, 4'b0000};// store A2 from CF
        mem_out[ i] = tmpi_datain[7:0];  i = 7;
        mem_out[ i] = tmpi_datain[15:8]; i = 8;

        tmpi_datain = {`NOP, 3'b000, 4'b0000, 4'b0000};// store A1 from CF
        mem_out[ i] = tmpi_datain[7:0];  i = 9;
        mem_out[ i] = tmpi_datain[15:8]; i = 10;

        tmpi_datain = {`NOP, 3'b000, 4'b0000, 4'b0000};// store Ana_new from CF
        mem_out[ i] = tmpi_datain[7:0];  i = 11;
        mem_out[ i] = tmpi_datain[15:8]; i = 12;

        tmpi_datain = {8'b0000_0000, 4'b1111, 4'b1111};// SA max iteration
        mem_out[ i] = tmpi_datain[7:0];  i = 13;
        mem_out[ i] = tmpi_datain[15:8]; i = 14;
        
        tmpi_datain = {8'b0000_0000, 4'b0010, 4'b0101};// LFSR random seed 37
        mem_out[ i] = tmpi_datain[7:0];  i = 15;
        mem_out[ i] = tmpi_datain[15:8]; i = 16;
        
        tmpi_datain = {8'b0000_0000, 4'b0010, 4'b0000};// Init Temperature = 32
        mem_out[ i] = tmpi_datain[7:0];  i = 17;
        mem_out[ i] = tmpi_datain[15:8]; i = 18;

        // The initial new Tune bits x_new, y_new (by default 15, 15)
        tmpi_datain = {8'b0000_1111, 4'b0000, 4'b1111};
        mem_out[ i] = tmpi_datain[7:0];  i = 19;
        mem_out[ i] = tmpi_datain[15:8]; i = 20;
        
        // The best Tune bits x_best and y_best (by default 15, 15)
        tmpi_datain = {8'b0000_1111, 4'b0000, 4'b1111};
        mem_out[ i] = tmpi_datain[7:0];  i = 21;
        mem_out[ i] = tmpi_datain[15:8]; i = 22;
        
        // The best Ana bits value from CF
        tmpi_datain = {8'b0000_0000, 4'b1111, 4'b1111};
        mem_out[ i] = tmpi_datain[7:0];  i = 23;
        mem_out[ i] = tmpi_datain[15:8]; i = 24;
        
        // The old Tune bits x_old and y_old (by default 15, 15)
        tmpi_datain = {8'b0000_0000, 4'b1111, 4'b1111};
        mem_out[ i] = tmpi_datain[7:0];  i = 25;
        mem_out[ i] = tmpi_datain[15:8]; i = 26;
        
        // The old Ana bits value from CF
        tmpi_datain = {8'b0000_0000, 4'b1111, 4'b1111};
        mem_out[ i] = tmpi_datain[7:0];  i = 27;
        mem_out[ i] = tmpi_datain[15:8]; i = 28;
        
        
    /* (1) Initialize SA & send tuning bits */ 
    i= DEFAULT_PC_ADDR*2;
    // Load the SA iteration to gr2 (only for the very first time)
    tmpi_datain = {`LOAD, `gr2, 1'b0, `gr0, 4'b0110};
    mem_out[ i] = tmpi_datain[7:0];  i = 161 + DEFAULT_PC_ADDR*2;
    mem_out[ i] = tmpi_datain[15:8]; i = 162 + DEFAULT_PC_ADDR*2;
    
    // Save the SA iteration (gr2) to SRAM, for the loop later
    tmpi_datain = {`STORE, `gr2, 1'b0, `gr0, 4'b0110};
    mem_out[ i] = tmpi_datain[7:0];  i = 161 + DEFAULT_PC_ADDR*2;
    mem_out[ i] = tmpi_datain[15:8]; i = 162 + DEFAULT_PC_ADDR*2;
    
    //Clear OUT_A & Set SPI starting address;
    tmpi_datain = {`SUB, `gr2, 1'b0, `gr2, 1'b0, `gr2};
    mem_out[ i] = tmpi_datain[7:0];  i = 17 + DEFAULT_PC_ADDR*2;
    mem_out[ i] = tmpi_datain[15:8]; i = 18 + DEFAULT_PC_ADDR*2;
    
    tmpi_datain = {`SET, `gr2, 4'b0001, 4'b0001};// Byte data starting addr
    mem_out[ i] = tmpi_datain[7:0];  i = 19 + DEFAULT_PC_ADDR*2;
    mem_out[ i] = tmpi_datain[15:8]; i = 20 + DEFAULT_PC_ADDR*2;

    //Clear OUT_B & Set SPI send data length;
    tmpi_datain = {`SUB, `gr3, 1'b0, `gr3, 1'b0, `gr3};
    mem_out[ i] = tmpi_datain[7:0];  i = 21 + DEFAULT_PC_ADDR*2;
    mem_out[ i] = tmpi_datain[15:8]; i = 22 + DEFAULT_PC_ADDR*2;
    
    tmpi_datain = {`SET, `gr3, 4'b0000, 4'b0010};//output 2 Bytes data
    mem_out[ i] = tmpi_datain[7:0];  i = 23 + DEFAULT_PC_ADDR*2;
    mem_out[ i] = tmpi_datain[15:8]; i = 24 + DEFAULT_PC_ADDR*2;

    //set the control reg for SPI to begin output
    tmpi_datain = {`SET, `gr1, 3'b010, 3'b000, 2'b00};
    mem_out[ i] = tmpi_datain[7:0];  i = 25 + DEFAULT_PC_ADDR*2;
    mem_out[ i] = tmpi_datain[15:8]; i = 26 + DEFAULT_PC_ADDR*2;
    
    //reset the control reg for SPI to end output
    tmpi_datain = {`SET, `gr1, 3'b010, 3'b000, 2'b00};
    mem_out[ i] = tmpi_datain[7:0];  i = 25 + DEFAULT_PC_ADDR*2;
    mem_out[ i] = tmpi_datain[15:8]; i = 26 + DEFAULT_PC_ADDR*2;
    
    /* (2) Invoke the CF instructions */
        /* (Step one) Sampling ADC data and do measurement*/ 
        //clear the value in gr7
        tmpi_datain = {`SUB, `gr7, 1'b0, `gr7, 1'b0, `gr7};
        mem_out[ i] = tmpi_datain[7:0];  i = 1 + DEFAULT_PC_ADDR*2;
        mem_out[ i] = tmpi_datain[15:8]; i = 2 + DEFAULT_PC_ADDR*2;
        
        //clear the value in gr6
        tmpi_datain = {`SUB, `gr6, 1'b0, `gr6, 1'b0, `gr6};
        mem_out[ i] = tmpi_datain[7:0];  i = 3 + DEFAULT_PC_ADDR*2;
        mem_out[ i] = tmpi_datain[15:8]; i = 4 + DEFAULT_PC_ADDR*2;

        //Initialzie the frequency index variable gr7
        tmpi_datain = {`SET, `gr7, 4'b0000, 4'b0100};
        mem_out[ i] = tmpi_datain[7:0];  i = 5 + DEFAULT_PC_ADDR*2;
        mem_out[ i] = tmpi_datain[15:8]; i = 6 + DEFAULT_PC_ADDR*2;

        //Initialzie the local index variable gr6
        tmpi_datain = {`SET, `gr6, 4'b0000, 4'b0010};
        mem_out[ i] = tmpi_datain[7:0];  i = 7 + DEFAULT_PC_ADDR*2;
        mem_out[ i] = tmpi_datain[15:8]; i = 8 + DEFAULT_PC_ADDR*2;
        
        //(a) Inform ADC to prepare data
        //CPU is supposed to finish the loop automatically
        tmpi_datain = {`SET, `gr1, 4'b1000, 4'b0000};
        mem_out[ i] = tmpi_datain[7:0];  i = 9 + DEFAULT_PC_ADDR*2;
        mem_out[ i] = tmpi_datain[15:8]; i = 10 + DEFAULT_PC_ADDR*2;

        //Load I/O data_A to `gr2 as I data
        tmpi_datain = {`LIOA, `gr2, 4'b0000, 4'b0000};
        mem_out[ i] = tmpi_datain[7:0];  i = 11 + DEFAULT_PC_ADDR*2;
        mem_out[ i] = tmpi_datain[15:8]; i = 12 + DEFAULT_PC_ADDR*2;
        
        //reset ADC bit flag
        tmpi_datain = {`SET, `gr1, 4'b0000, 4'b0000};
        mem_out[ i] = tmpi_datain[7:0];  i = 13 + DEFAULT_PC_ADDR*2;
        mem_out[ i] = tmpi_datain[15:8]; i = 14 + DEFAULT_PC_ADDR*2;

        //Inform ADC to prepare data
        tmpi_datain = {`SET, `gr1, 4'b1000, 4'b0000};
        mem_out[ i] = tmpi_datain[7:0];  i = 15 + DEFAULT_PC_ADDR*2;
        mem_out[ i] = tmpi_datain[15:8]; i = 16 + DEFAULT_PC_ADDR*2;
        
        //Load I/O data_A to `gr3 as Q data
        tmpi_datain = {`LIOA, `gr3, 4'b0000, 4'b0000};
        mem_out[ i] = tmpi_datain[7:0];  i = 17 + DEFAULT_PC_ADDR*2;
        mem_out[ i] = tmpi_datain[15:8]; i = 18 + DEFAULT_PC_ADDR*2;

        //reset ADC bit flag
        tmpi_datain = {`SET, `gr1, 4'b0000, 4'b0000};
        mem_out[ i] = tmpi_datain[7:0];  i = 19 + DEFAULT_PC_ADDR*2;
        mem_out[ i] = tmpi_datain[15:8]; i = 20 + DEFAULT_PC_ADDR*2;
        
        //clear the value in gr0
        tmpi_datain = {`SUB, `gr0, 1'b0, `gr0, 1'b0, `gr0};
        mem_out[ i] = tmpi_datain[7:0];  i = 21 + DEFAULT_PC_ADDR*2;
        mem_out[ i] = tmpi_datain[15:8]; i = 22 + DEFAULT_PC_ADDR*2;
            
        //Initialzie oper = 4 in gr0
        tmpi_datain = {`SET, `gr0, 4'b0000, 4'b0100};
        mem_out[ i] = tmpi_datain[7:0];  i = 23 + DEFAULT_PC_ADDR*2;
        mem_out[ i] = tmpi_datain[15:8]; i = 24 + DEFAULT_PC_ADDR*2;
            
        // compare gr7 and gr0 to find the oscd frequency
        tmpi_datain = {`CMP, 4'b0000, `gr7, 1'b0, `gr0};
        mem_out[ i] = tmpi_datain[7:0];  i = 25 + DEFAULT_PC_ADDR*2;
        mem_out[ i] = tmpi_datain[15:8]; i = 26 + DEFAULT_PC_ADDR*2;

        ////if (gr7 < gr0) do normal process: CORDIC + Division
        tmpi_datain = {`BN, `gr1, 4'b0100, 4'b0100};//gr1 must be all 0's
        mem_out[ i] = tmpi_datain[7:0];  i = 27 + DEFAULT_PC_ADDR*2;
        mem_out[ i] = tmpi_datain[15:8]; i = 28 + DEFAULT_PC_ADDR*2;

        tmpi_datain = {`SRL, `gr0, 1'b0, `gr0, 4'b0001};//(gr0 = gr0/2)
        mem_out[ i] = tmpi_datain[7:0];  i = 29 + DEFAULT_PC_ADDR*2;
        mem_out[ i] = tmpi_datain[15:8]; i = 30 + DEFAULT_PC_ADDR*2;
        
        ////else compare gr6 and gr0 to find the oscd phase
        tmpi_datain = {`CMP, 4'b0000, `gr6, 1'b0, `gr0};
        mem_out[ i] = tmpi_datain[7:0];  i = 31 + DEFAULT_PC_ADDR*2;
        mem_out[ i] = tmpi_datain[15:8]; i = 32 + DEFAULT_PC_ADDR*2;
            
        ////if (gr6 < gr0) do normal process: CORDIC + Division
        tmpi_datain = {`BN, `gr1, 4'b0100, 4'b0100};//gr1 must be all 0's
        mem_out[ i] = tmpi_datain[7:0];  i = 33 + DEFAULT_PC_ADDR*2;
        mem_out[ i] = tmpi_datain[15:8]; i = 34 + DEFAULT_PC_ADDR*2;
        
        // else then OSCD process
        //(keep the old pair of IQ data and read another pair of IQ data)
        //clear the value in gr4
        tmpi_datain = {`SUB, `gr4, 1'b0, `gr4, 1'b0, `gr4};
        mem_out[ i] = tmpi_datain[7:0];  i = 35 + DEFAULT_PC_ADDR*2;
        mem_out[ i] = tmpi_datain[15:8]; i = 36 + DEFAULT_PC_ADDR*2;
        
        //copy gr2 data to gr4 as the old I data
        tmpi_datain = {`ADD, `gr4, 1'b0, `gr2, 1'b0, `gr4};
        mem_out[ i] = tmpi_datain[7:0];  i = 37 + DEFAULT_PC_ADDR*2;
        mem_out[ i] = tmpi_datain[15:8]; i = 38 + DEFAULT_PC_ADDR*2;
        
        //clear the value in gr5
        tmpi_datain = {`SUB, `gr5, 1'b0, `gr5, 1'b0, `gr5};
        mem_out[ i] = tmpi_datain[7:0];  i = 39 + DEFAULT_PC_ADDR*2;
        mem_out[ i] = tmpi_datain[15:8]; i = 40 + DEFAULT_PC_ADDR*2;
        
        //copy gr3 data to gr5 as the old Q data
        tmpi_datain = {`ADD, `gr5, 1'b0, `gr3, 1'b0, `gr5};
        mem_out[ i] = tmpi_datain[7:0];  i = 41 + DEFAULT_PC_ADDR*2;
        mem_out[ i] = tmpi_datain[15:8]; i = 42 + DEFAULT_PC_ADDR*2;
        
        tmpi_datain = {`SET, `gr1, 4'b1000, 4'b0000};
        mem_out[ i] = tmpi_datain[7:0];  i = 43 + DEFAULT_PC_ADDR*2;
        mem_out[ i] = tmpi_datain[15:8]; i = 44 + DEFAULT_PC_ADDR*2;

        //Load I/O data_A to `gr2 as I data
        tmpi_datain = {`LIOA, `gr2, 4'b0000, 4'b0000};
        mem_out[ i] = tmpi_datain[7:0];  i = 45 + DEFAULT_PC_ADDR*2;
        mem_out[ i] = tmpi_datain[15:8]; i = 46 + DEFAULT_PC_ADDR*2;
        
        //reset ADC bit flag
        tmpi_datain = {`SET, `gr1, 4'b0000, 4'b0000};
        mem_out[ i] = tmpi_datain[7:0];  i = 47 + DEFAULT_PC_ADDR*2;
        mem_out[ i] = tmpi_datain[15:8]; i = 48 + DEFAULT_PC_ADDR*2;

        //Inform ADC to prepare data
        tmpi_datain = {`SET, `gr1, 4'b1000, 4'b0000};
        mem_out[ i] = tmpi_datain[7:0];  i = 49 + DEFAULT_PC_ADDR*2;
        mem_out[ i] = tmpi_datain[15:8]; i = 50 + DEFAULT_PC_ADDR*2;
        
        //Load I/O data_A to `gr3 as Q data
        tmpi_datain = {`LIOA, `gr3, 4'b0000, 4'b0000};
        mem_out[ i] = tmpi_datain[7:0];  i = 51 + DEFAULT_PC_ADDR*2;
        mem_out[ i] = tmpi_datain[15:8]; i = 52 + DEFAULT_PC_ADDR*2;

        //reset ADC bit flag
        tmpi_datain = {`SET, `gr1, 4'b0000, 4'b0000};
        mem_out[ i] = tmpi_datain[7:0];  i = 53 + DEFAULT_PC_ADDR*2;
        mem_out[ i] = tmpi_datain[15:8]; i = 54 + DEFAULT_PC_ADDR*2;
        
        tmpi_datain = {`SUB, `gr0, 1'b0, `gr0, 1'b0, `gr0};
        mem_out[ i] = tmpi_datain[7:0];  i = 55 + DEFAULT_PC_ADDR*2;
        mem_out[ i] = tmpi_datain[15:8]; i = 56 + DEFAULT_PC_ADDR*2;
        
        // calculate I_o - I_s, save to gr4
        tmpi_datain = {`SUB, `gr4, 1'b0, `gr2, 1'b0, `gr4};
        mem_out[ i] = tmpi_datain[7:0];  i = 57 + DEFAULT_PC_ADDR*2;
        mem_out[ i] = tmpi_datain[15:8]; i = 58 + DEFAULT_PC_ADDR*2;
        
        //if (I_o >= I_s) then jump to the next
        tmpi_datain = {`BNC, `gr0, 4'b0011, 4'b1101};
        mem_out[ i] = tmpi_datain[7:0];  i = 59 + DEFAULT_PC_ADDR*2;
        mem_out[ i] = tmpi_datain[15:8]; i = 60 + DEFAULT_PC_ADDR*2;
        
        //else use gr0 - (gr4) ..........  ABS will make this easier
        // the result is negative, revert it
        tmpi_datain = {`SUB, `gr4, 1'b0, `gr0, 1'b0, `gr4};
        mem_out[ i] = tmpi_datain[7:0];  i = 61 + DEFAULT_PC_ADDR*2;
        mem_out[ i] = tmpi_datain[15:8]; i = 62 + DEFAULT_PC_ADDR*2;

        // calculate Q_o - Q_s, save to gr5
        tmpi_datain = {`SUB, `gr5, 1'b0, `gr3, 1'b0, `gr5};
        mem_out[ i] = tmpi_datain[7:0];  i = 63 + DEFAULT_PC_ADDR*2;
        mem_out[ i] = tmpi_datain[15:8]; i = 64 + DEFAULT_PC_ADDR*2;
        
        //if (Q_o >= Q_s) then jump to the next
        tmpi_datain = {`BNC, `gr0, 4'b0100, 4'b0000};
        mem_out[ i] = tmpi_datain[7:0];  i = 65 + DEFAULT_PC_ADDR*2;
        mem_out[ i] = tmpi_datain[15:8]; i = 66 + DEFAULT_PC_ADDR*2;
        
        //else use gr0 - (gr5) ..........  ABS will make this easier
        // the result is negative, revert it
        tmpi_datain = {`SUB, `gr5, 1'b0, `gr0, 1'b0, `gr5};
        mem_out[ i] = tmpi_datain[7:0];  i = 67 + DEFAULT_PC_ADDR*2;
        mem_out[ i] = tmpi_datain[15:8]; i = 68 + DEFAULT_PC_ADDR*2;
        
        //set gr0 = TOL, by default = 18 or (63)
        tmpi_datain = {`SET, `gr0, 4'b0001, 4'b0010};
        mem_out[ i] = tmpi_datain[7:0];  i = 69 + DEFAULT_PC_ADDR*2;
        mem_out[ i] = tmpi_datain[15:8]; i = 70 + DEFAULT_PC_ADDR*2;
        
        //sum |Q_o - Q_s| and |I_o - I_s| to gr4
        tmpi_datain = {`ADD, `gr4, 1'b0, `gr4, 1'b0, `gr5};
        mem_out[ i] = tmpi_datain[7:0];  i = 71 + DEFAULT_PC_ADDR*2;
        mem_out[ i] = tmpi_datain[15:8]; i = 72 + DEFAULT_PC_ADDR*2;
        
        // calculate gr4 - gr0, save to gr5
        tmpi_datain = {`SUB, `gr5, 1'b0, `gr4, 1'b0, `gr0};
        mem_out[ i] = tmpi_datain[7:0];  i = 73 + DEFAULT_PC_ADDR*2;
        mem_out[ i] = tmpi_datain[15:8]; i = 74 + DEFAULT_PC_ADDR*2;
        
        //if (gr4 >= gr0) then jump to ANA = 255
        tmpi_datain = {`BNC, `gr1, 4'b0111, 4'b1111};
        mem_out[ i] = tmpi_datain[7:0];  i = 75 + DEFAULT_PC_ADDR*2;
        mem_out[ i] = tmpi_datain[15:8]; i = 76 + DEFAULT_PC_ADDR*2;
        
        //else reset gr0 and continue the CORDIC and Divsion
        tmpi_datain = {`SUB, `gr0, 1'b0, `gr0, 1'b0, `gr0};
        mem_out[ i] = tmpi_datain[7:0];  i = 77 + DEFAULT_PC_ADDR*2;
        mem_out[ i] = tmpi_datain[15:8]; i = 78 + DEFAULT_PC_ADDR*2;
    
        //(b) set ALU as Cordic module
        //make sure to include the offset for DATA SRAM
        tmpi_datain = {`SUB, `gr4, 1'b0, `gr4, 1'b0, `gr4};
        mem_out[ i] = tmpi_datain[7:0];  i = 79 + DEFAULT_PC_ADDR*2;
        mem_out[ i] = tmpi_datain[15:8]; i = 80 + DEFAULT_PC_ADDR*2;
        
        tmpi_datain = {`SET, `gr4, 4'b1000, 4'b0001};//129
        mem_out[ i] = tmpi_datain[7:0];  i = 81 + DEFAULT_PC_ADDR*2;
        mem_out[ i] = tmpi_datain[15:8]; i = 82 + DEFAULT_PC_ADDR*2;
        
        tmpi_datain = {`SLL, `gr4, 1'b0, `gr4, 4'b0010};//(129 << 2)
        mem_out[ i] = tmpi_datain[7:0];  i = 83 + DEFAULT_PC_ADDR*2;
        mem_out[ i] = tmpi_datain[15:8]; i = 84 + DEFAULT_PC_ADDR*2;
        
        tmpi_datain = {`SET, `gr1, 3'b001, 3'b001, 2'b00};
        mem_out[ i] = tmpi_datain[7:0];  i = 85 + DEFAULT_PC_ADDR*2;
        mem_out[ i] = tmpi_datain[15:8]; i = 86 + DEFAULT_PC_ADDR*2;
        
        tmpi_datain = {`SUBI, `gr6, 4'b0000, 4'b0001};//`gr6--
        mem_out[ i] = tmpi_datain[7:0];  i = 87 + DEFAULT_PC_ADDR*2;
        mem_out[ i] = tmpi_datain[15:8]; i = 88 + DEFAULT_PC_ADDR*2;
        
        //if (`gr6 == 0) finish the Cordic and jump to the division;
        tmpi_datain = {`BZ, `gr0, 4'b0100, 4'b1110};
        mem_out[ i] = tmpi_datain[7:0];  i = 89 + DEFAULT_PC_ADDR*2;
        mem_out[ i] = tmpi_datain[15:8]; i = 90 + DEFAULT_PC_ADDR*2;
        
        //else save the Cordic result of sqrt(Qo^2+Io^2) to gr5;
        //Load Amp data_A to (`gr5) as FOUT, this is the dividend
        tmpi_datain = {`LIOA, `gr5, 4'b0000, 4'b0000};
        mem_out[ i] = tmpi_datain[7:0];  i = 91 + DEFAULT_PC_ADDR*2;
        mem_out[ i] = tmpi_datain[15:8]; i = 92 + DEFAULT_PC_ADDR*2;
        
        //reset ALU bit flag
        tmpi_datain = {`SET, `gr1, 4'b0000, 4'b0000};
        mem_out[ i] = tmpi_datain[7:0];  i = 93 + DEFAULT_PC_ADDR*2;
        mem_out[ i] = tmpi_datain[15:8]; i = 94 + DEFAULT_PC_ADDR*2;
        
        //return back to load ADC data for Cordic
        tmpi_datain = {`JUMP, 3'b000, 4'b0010, 4'b0010};
        mem_out[ i] = tmpi_datain[7:0];  i = 95 + DEFAULT_PC_ADDR*2;
        mem_out[ i] = tmpi_datain[15:8]; i = 96 + DEFAULT_PC_ADDR*2;
        
        //(c) else branch (Load Amp data_A to (`gr3) as FOUT, this is the dividor)
        tmpi_datain = {`LIOA, `gr3, 4'b0000, 4'b0000};
        mem_out[ i] = tmpi_datain[7:0];  i = 97 + DEFAULT_PC_ADDR*2;
        mem_out[ i] = tmpi_datain[15:8]; i = 98 + DEFAULT_PC_ADDR*2;
        
        //reset ALU bit flag
        tmpi_datain = {`SET, `gr1, 4'b0000, 4'b0000};
        mem_out[ i] = tmpi_datain[7:0];  i = 99 + DEFAULT_PC_ADDR*2;
        mem_out[ i] = tmpi_datain[15:8]; i = 100 + DEFAULT_PC_ADDR*2;
        
        //clear gr2's data and then copy with gr5's data
        tmpi_datain = {`SUB, `gr2, 1'b0, `gr2, 1'b0, `gr2};
        mem_out[ i] = tmpi_datain[7:0];  i = 101 + DEFAULT_PC_ADDR*2;
        mem_out[ i] = tmpi_datain[15:8]; i = 102 + DEFAULT_PC_ADDR*2;

        //copy gr5 data to gr2 as dividend
        tmpi_datain = {`ADD, `gr2, 1'b0, `gr2, 1'b0, `gr5};
        mem_out[ i] = tmpi_datain[7:0];  i = 103 + DEFAULT_PC_ADDR*2;
        mem_out[ i] = tmpi_datain[15:8]; i = 104 + DEFAULT_PC_ADDR*2;
        
        //(d) start the division process; (div_mode == CF_T27)? 128(2'b01) : 64(2'b10);
        tmpi_datain = {`SET, `gr1, 3'b001, 3'b010, 2'b01};
        mem_out[ i] = tmpi_datain[7:0];  i = 105 + DEFAULT_PC_ADDR*2;
        mem_out[ i] = tmpi_datain[15:8]; i = 106 + DEFAULT_PC_ADDR*2;

        //Load division result data to gr5
        tmpi_datain = {`LIOA, `gr5, 4'b0000, 4'b0000};
        mem_out[ i] = tmpi_datain[7:0];  i = 107 + DEFAULT_PC_ADDR*2;
        mem_out[ i] = tmpi_datain[15:8]; i = 108 + DEFAULT_PC_ADDR*2;

        //reset ALU bit flag
        tmpi_datain = {`SET, `gr1, 3'b000, 3'b000, 2'b00};
        mem_out[ i] = tmpi_datain[7:0];  i = 109 + DEFAULT_PC_ADDR*2;
        mem_out[ i] = tmpi_datain[15:8]; i = 110 + DEFAULT_PC_ADDR*2;

        //relate the base address gr0 with gr7
        tmpi_datain = {`ADD, `gr0, 1'b0, `gr1, 1'b0, `gr7};//gr1 must be 0's
        mem_out[ i] = tmpi_datain[7:0];  i = 111 + DEFAULT_PC_ADDR*2;
        mem_out[ i] = tmpi_datain[15:8]; i = 112 + DEFAULT_PC_ADDR*2;
        
        //Save division result to SRAM and thus release registers
        tmpi_datain = {`STORE, `gr5, 1'b0, `gr0, 4'b0000};
        mem_out[ i] = tmpi_datain[7:0];  i = 113 + DEFAULT_PC_ADDR*2;
        mem_out[ i] = tmpi_datain[15:8]; i = 114 + DEFAULT_PC_ADDR*2;

        //restore tbe value of gr0
        tmpi_datain = {`SUB, `gr0, 1'b0, `gr0, 1'b0, `gr7};
        mem_out[ i] = tmpi_datain[7:0];  i = 115 + DEFAULT_PC_ADDR*2;
        mem_out[ i] = tmpi_datain[15:8]; i = 116 + DEFAULT_PC_ADDR*2;
        
        //(e) check if the frequency index is over
        tmpi_datain = {`SUBI, `gr7, 4'b0000, 4'b0001};//`gr7--
        mem_out[ i] = tmpi_datain[7:0];  i = 117 + DEFAULT_PC_ADDR*2;
        mem_out[ i] = tmpi_datain[15:8]; i = 118 + DEFAULT_PC_ADDR*2;

        //if (`gr7 != 0) return back to frequency sampling& calc
        tmpi_datain = {`BNZ, `gr0, 4'b0010, 4'b0001};
        mem_out[ i] = tmpi_datain[7:0];  i = 119 + DEFAULT_PC_ADDR*2;
        mem_out[ i] = tmpi_datain[15:8]; i = 120 + DEFAULT_PC_ADDR*2;
        //else start the summation and multiplication of costfunc;

    /* (Step two) Do multiplication and summation*/ 
        //(a) readback A_4 in gr2
        tmpi_datain = {`LOAD, `gr2, 1'b0, `gr0, 4'b0001};
        mem_out[ i] = tmpi_datain[7:0];  i = 121 + DEFAULT_PC_ADDR*2;
        mem_out[ i] = tmpi_datain[15:8]; i = 122 + DEFAULT_PC_ADDR*2;
        
        //clear the value in gr3
        tmpi_datain = {`SUB, `gr3, 1'b0, `gr3, 1'b0, `gr3};
        mem_out[ i] = tmpi_datain[7:0];  i = 123 + DEFAULT_PC_ADDR*2;
        mem_out[ i] = tmpi_datain[15:8]; i = 124 + DEFAULT_PC_ADDR*2;
        
        // set multiplier = 8'b01101011;//0.4140625 or 106 out of 256
        tmpi_datain = {`SET, `gr3, 8'b01101011};
        mem_out[ i] = tmpi_datain[7:0];  i = 125 + DEFAULT_PC_ADDR*2;
        mem_out[ i] = tmpi_datain[15:8]; i = 126 + DEFAULT_PC_ADDR*2;
        
        // start ALU as multiplier with mode_type = 2'b01;
        tmpi_datain = {`SET, `gr1, 3'b001, 3'b100, 2'b01};
        mem_out[ i] = tmpi_datain[7:0];  i = 127 + DEFAULT_PC_ADDR*2;
        mem_out[ i] = tmpi_datain[15:8]; i = 128 + DEFAULT_PC_ADDR*2;
        
        //Load sqrt(2)*A_4 data to gr6
        tmpi_datain = {`LIOA, `gr6, 4'b0000, 4'b0000};
        mem_out[ i] = tmpi_datain[7:0];  i = 129 + DEFAULT_PC_ADDR*2;
        mem_out[ i] = tmpi_datain[15:8]; i = 130 + DEFAULT_PC_ADDR*2;
        
        //reset ALU bit flag 
        tmpi_datain = {`SET, `gr1, 3'b000, 3'b000, 2'b00};
        mem_out[ i] = tmpi_datain[7:0];  i = 131 + DEFAULT_PC_ADDR*2;
        mem_out[ i] = tmpi_datain[15:8]; i = 132 + DEFAULT_PC_ADDR*2;
        
        //clear the value in gr5
        tmpi_datain = {`SUB, `gr5, 1'b0, `gr5, 1'b0, `gr5};
        mem_out[ i] = tmpi_datain[7:0];  i = 133 + DEFAULT_PC_ADDR*2;
        mem_out[ i] = tmpi_datain[15:8]; i = 134 + DEFAULT_PC_ADDR*2;
        
        //keep a copy of A_4 in gr5
        tmpi_datain = {`ADD, `gr5, 1'b0, `gr5, 1'b0, `gr2};
        mem_out[ i] = tmpi_datain[7:0];  i = 135 + DEFAULT_PC_ADDR*2;
        mem_out[ i] = tmpi_datain[15:8]; i = 136 + DEFAULT_PC_ADDR*2;
        
        // readback A_1 in gr2
        tmpi_datain = {`LOAD, `gr2, 1'b0, `gr0, 4'b0100};
        mem_out[ i] = tmpi_datain[7:0];  i = 137 + DEFAULT_PC_ADDR*2;
        mem_out[ i] = tmpi_datain[15:8]; i = 138 + DEFAULT_PC_ADDR*2;
        
        // start ALU as multiplier with mode_type = 2'b01;
        tmpi_datain = {`SET, `gr1, 3'b001, 3'b100, 2'b01};
        mem_out[ i] = tmpi_datain[7:0];  i = 139 + DEFAULT_PC_ADDR*2;
        mem_out[ i] = tmpi_datain[15:8]; i = 140 + DEFAULT_PC_ADDR*2;
        
        //Load sqrt(2)*A_1 data to gr4
        tmpi_datain = {`LIOA, `gr4, 4'b0000, 4'b0000};
        mem_out[ i] = tmpi_datain[7:0];  i = 141 + DEFAULT_PC_ADDR*2;
        mem_out[ i] = tmpi_datain[15:8]; i = 142 + DEFAULT_PC_ADDR*2;
        
        //reset ALU bit flag 
        tmpi_datain = {`SET, `gr1, 3'b000, 3'b000, 2'b00};
        mem_out[ i] = tmpi_datain[7:0];  i = 143 + DEFAULT_PC_ADDR*2;
        mem_out[ i] = tmpi_datain[15:8]; i = 144 + DEFAULT_PC_ADDR*2;
        
        // readback A_2 in gr3
        tmpi_datain = {`LOAD, `gr3, 1'b0, `gr0, 4'b0011};
        mem_out[ i] = tmpi_datain[7:0];  i = 145 + DEFAULT_PC_ADDR*2;
        mem_out[ i] = tmpi_datain[15:8]; i = 146 + DEFAULT_PC_ADDR*2;
        
        //(b) calculate the summation
        // calculate A_2 - sqrt(2)*A_1, save to gr7
        tmpi_datain = {`SUB, `gr7, 1'b0, `gr3, 1'b0, `gr4};
        mem_out[ i] = tmpi_datain[7:0];  i = 147 + DEFAULT_PC_ADDR*2;
        mem_out[ i] = tmpi_datain[15:8]; i = 148 + DEFAULT_PC_ADDR*2;

        //if (gr3 >= gr4) then jump to the next
        //else use gr0 - (gr7) ..........  ABS will make this easier
        tmpi_datain = {`BNC, `gr0, 4'b0110, 4'b1010};
        mem_out[ i] = tmpi_datain[7:0];  i = 149 + DEFAULT_PC_ADDR*2;
        mem_out[ i] = tmpi_datain[15:8]; i = 150 + DEFAULT_PC_ADDR*2;
        
        // the result is negative, revert it
        tmpi_datain = {`SUB, `gr7, 1'b0, `gr0, 1'b0, `gr7};
        mem_out[ i] = tmpi_datain[7:0];  i = 151 + DEFAULT_PC_ADDR*2;
        mem_out[ i] = tmpi_datain[15:8]; i = 152 + DEFAULT_PC_ADDR*2;
        
        // calculate A_1 - A_4, save to gr4
        tmpi_datain = {`SUB, `gr4, 1'b0, `gr2, 1'b0, `gr5};
        mem_out[ i] = tmpi_datain[7:0];  i = 153 + DEFAULT_PC_ADDR*2;
        mem_out[ i] = tmpi_datain[15:8]; i = 154 + DEFAULT_PC_ADDR*2;
        
        //if (gr2 >= gr5) then jump to the next
        //else use gr0 - (gr4) ..........  ABS will make this easier
        tmpi_datain = {`BNC, `gr0, 4'b0110, 4'b1101};
        mem_out[ i] = tmpi_datain[7:0];  i = 155 + DEFAULT_PC_ADDR*2;
        mem_out[ i] = tmpi_datain[15:8]; i = 156 + DEFAULT_PC_ADDR*2;

        // the result is negative, revert it
        tmpi_datain = {`SUB, `gr4, 1'b0, `gr0, 1'b0, `gr4};
        mem_out[ i] = tmpi_datain[7:0];  i = 157 + DEFAULT_PC_ADDR*2;
        mem_out[ i] = tmpi_datain[15:8]; i = 158 + DEFAULT_PC_ADDR*2;

        // add the sum to gr7
        tmpi_datain = {`ADD, `gr7, 1'b0, `gr7, 1'b0, `gr4};
        mem_out[ i] = tmpi_datain[7:0];  i = 159 + DEFAULT_PC_ADDR*2;
        mem_out[ i] = tmpi_datain[15:8]; i = 160 + DEFAULT_PC_ADDR*2;
        
        // (c) readback A_3 in gr5
        tmpi_datain = {`LOAD, `gr5, 1'b0, `gr0, 4'b0010};
        mem_out[ i] = tmpi_datain[7:0];  i = 161 + DEFAULT_PC_ADDR*2;
        mem_out[ i] = tmpi_datain[15:8]; i = 162 + DEFAULT_PC_ADDR*2;

        // calculate A_2 - A_3, save to gr2
        tmpi_datain = {`SUB, `gr2, 1'b0, `gr3, 1'b0, `gr5};
        mem_out[ i] = tmpi_datain[7:0];  i = 163 + DEFAULT_PC_ADDR*2;
        mem_out[ i] = tmpi_datain[15:8]; i = 164 + DEFAULT_PC_ADDR*2;
        
        //if (gr3 >= gr5) then jump to the next
        //else use gr0 - (gr2) ..........  ABS will make this easier
        tmpi_datain = {`BNC, `gr0, 4'b0111, 4'b0010};
        mem_out[ i] = tmpi_datain[7:0];  i = 165 + DEFAULT_PC_ADDR*2;
        mem_out[ i] = tmpi_datain[15:8]; i = 166 + DEFAULT_PC_ADDR*2;
        
        // the result is negative, revert it
        tmpi_datain = {`SUB, `gr2, 1'b0, `gr0, 1'b0, `gr2};
        mem_out[ i] = tmpi_datain[7:0];  i = 167 + DEFAULT_PC_ADDR*2;
        mem_out[ i] = tmpi_datain[15:8]; i = 168 + DEFAULT_PC_ADDR*2;
        
        // add the sum to gr7
        tmpi_datain = {`ADD, `gr7, 1'b0, `gr7, 1'b0, `gr2};
        mem_out[ i] = tmpi_datain[7:0];  i = 169 + DEFAULT_PC_ADDR*2;
        mem_out[ i] = tmpi_datain[15:8]; i = 170 + DEFAULT_PC_ADDR*2;
        
        // calculate A_3 - sqrt(2)*A_4, save to gr2
        tmpi_datain = {`SUB, `gr2, 1'b0, `gr5, 1'b0, `gr6};
        mem_out[ i] = tmpi_datain[7:0];  i = 171 + DEFAULT_PC_ADDR*2;
        mem_out[ i] = tmpi_datain[15:8]; i = 172 + DEFAULT_PC_ADDR*2;
        
        //if (gr5 >= gr6) then jump to the next
        //else use gr0 - (gr2) ..........  ABS will make this easier
        tmpi_datain = {`BNC, `gr0, 4'b0111, 4'b0110};
        mem_out[ i] = tmpi_datain[7:0];  i = 173 + DEFAULT_PC_ADDR*2;
        mem_out[ i] = tmpi_datain[15:8]; i = 174 + DEFAULT_PC_ADDR*2;
        
        // the result is negative, revert it
        tmpi_datain = {`SUB, `gr2, 1'b0, `gr0, 1'b0, `gr2};
        mem_out[ i] = tmpi_datain[7:0];  i = 175 + DEFAULT_PC_ADDR*2;
        mem_out[ i] = tmpi_datain[15:8]; i = 176 + DEFAULT_PC_ADDR*2;
        
        // add the sum to gr7
        tmpi_datain = {`ADD, `gr7, 1'b0, `gr7, 1'b0, `gr2};
        mem_out[ i] = tmpi_datain[7:0];  i = 177 + DEFAULT_PC_ADDR*2;
        mem_out[ i] = tmpi_datain[15:8]; i = 178 + DEFAULT_PC_ADDR*2;
        
        // compare A_2 with (div_mode == CF_T27)? 128(2'b01) : 64(2'b10); 
        tmpi_datain = {`SUB, `gr6, 1'b0, `gr6, 1'b0, `gr6};
        mem_out[ i] = tmpi_datain[7:0];  i = 179 + DEFAULT_PC_ADDR*2;
        mem_out[ i] = tmpi_datain[15:8]; i = 180 + DEFAULT_PC_ADDR*2;

        // ADC_TMP <= (div_mode == CF_T27)? 128(2'b01) : 64(2'b10);
        tmpi_datain = {`SET, `gr6, 8'b1000_0000};
        mem_out[ i] = tmpi_datain[7:0];  i = 181 + DEFAULT_PC_ADDR*2;
        mem_out[ i] = tmpi_datain[15:8]; i = 182 + DEFAULT_PC_ADDR*2;
        
        tmpi_datain = {`SUB, `gr2, 1'b0, `gr5, 1'b0, `gr6};
        mem_out[ i] = tmpi_datain[7:0];  i = 183 + DEFAULT_PC_ADDR*2;
        mem_out[ i] = tmpi_datain[15:8]; i = 184 + DEFAULT_PC_ADDR*2;
        
        //if (gr5 >= gr6) then jump to the next
        tmpi_datain = {`BNC, `gr0, 4'b0111, 4'b1100};
        mem_out[ i] = tmpi_datain[7:0];  i = 185 + DEFAULT_PC_ADDR*2;
        mem_out[ i] = tmpi_datain[15:8]; i = 186 + DEFAULT_PC_ADDR*2;
        
        //else use gr7 - (gr2) ..........  ABS will make this easier
        tmpi_datain = {`SUB, `gr7, 1'b0, `gr7, 1'b0, `gr2};
        mem_out[ i] = tmpi_datain[7:0];  i = 187 + DEFAULT_PC_ADDR*2;
        mem_out[ i] = tmpi_datain[15:8]; i = 188 + DEFAULT_PC_ADDR*2;
        
    /* (Step three) */
        //modify `gr6's value as the threshold = 255
        tmpi_datain = {`SET, `gr6, 4'b1111, 4'b1111};
        mem_out[ i] = tmpi_datain[7:0];  i = 189 + DEFAULT_PC_ADDR*2;
        mem_out[ i] = tmpi_datain[15:8]; i = 190 + DEFAULT_PC_ADDR*2;

        // compare the result with threshold 255
        tmpi_datain = {`CMP, 4'b0000, `gr6, 1'b0, `gr7};
        mem_out[ i] = tmpi_datain[7:0];  i = 191 + DEFAULT_PC_ADDR*2;
        mem_out[ i] = tmpi_datain[15:8]; i = 192 + DEFAULT_PC_ADDR*2;

        ////if (gr6 >= gr7) then simply use gr7
        ////else truncate gr7 as 255
        tmpi_datain = {`BNC, `gr0, 4'b1000, 4'b0001};
        mem_out[ i] = tmpi_datain[7:0];  i = 193 + DEFAULT_PC_ADDR*2;
        mem_out[ i] = tmpi_datain[15:8]; i = 194 + DEFAULT_PC_ADDR*2;

        tmpi_datain = {`SUB, `gr7, 1'b0, `gr7, 1'b0, `gr7};
        mem_out[ i] = tmpi_datain[7:0];  i = 195 + DEFAULT_PC_ADDR*2;
        mem_out[ i] = tmpi_datain[15:8]; i = 196 + DEFAULT_PC_ADDR*2;

        tmpi_datain = {`SET, `gr7, 8'b1111_1111};
        mem_out[ i] = tmpi_datain[7:0];  i = 197 + DEFAULT_PC_ADDR*2;
        mem_out[ i] = tmpi_datain[15:8]; i = 198 + DEFAULT_PC_ADDR*2;
        
        //finally save cost value to overwrite SRAM at 0x05;
        tmpi_datain = {`STORE, `gr7, 1'b0, `gr1, 4'b0101};//gr1 must be all 0's
        mem_out[ i] = tmpi_datain[7:0];  i = 199 + DEFAULT_PC_ADDR*2;
        mem_out[ i] = tmpi_datain[15:8]; i = 200 + DEFAULT_PC_ADDR*2;
    
        //CF System finish {`HALT, 11'b000_0000_0000};
    
    /* (3) Use Ana_new to Simulated Annealing */
    // clear gr0 since it might be used in CF above
    tmpi_datain = {`SUB, `gr0, 1'b0, `gr0, 1'b0, `gr0};
    mem_out[ i] = tmpi_datain[7:0];  i = 1 + DEFAULT_PC_ADDR*2;
    mem_out[ i] = tmpi_datain[15:8]; i = 2 + DEFAULT_PC_ADDR*2;

    // Load SA iteration at 0x06 to gr2
    tmpi_datain = {`LOAD, `gr2, 1'b0, `gr0, 4'b0110};
    mem_out[ i] = tmpi_datain[7:0];  i = 199 + DEFAULT_PC_ADDR*2;
    mem_out[ i] = tmpi_datain[15:8]; i = 200 + DEFAULT_PC_ADDR*2;

    // Compare SA iteration (gr2) to check if it's done (gr0)
    tmpi_datain = {`CMP, 4'b0000, `gr2, 1'b0, `gr0};
    mem_out[ i] = tmpi_datain[7:0];  i = 191 + DEFAULT_PC_ADDR*2;
    mem_out[ i] = tmpi_datain[15:8]; i = 192 + DEFAULT_PC_ADDR*2;

    // if (gr2 == gr0) Jump to Sensitivity Algorithm
    tmpi_datain = {`BZ, `gr0, 4'bXXXX, 4'b0001};
    mem_out[ i] = tmpi_datain[7:0];  i = 193 + DEFAULT_PC_ADDR*2;
    mem_out[ i] = tmpi_datain[15:8]; i = 194 + DEFAULT_PC_ADDR*2;
    // else start the Simulated Annealing process
    
    // load Ana_best to gr2 for comparison
    tmpi_datain = {`LOAD, `gr2, 1'b0, `gr0, 4'b1011};
    mem_out[ i] = tmpi_datain[7:0];  i = 161 + DEFAULT_PC_ADDR*2;
    mem_out[ i] = tmpi_datain[15:8]; i = 162 + DEFAULT_PC_ADDR*2;

    // Compare the Ana_best (gr2) with Ana_new (gr7)
    tmpi_datain = {`CMP, 4'b0000, `gr2, 1'b0, `gr7};
    mem_out[ i] = tmpi_datain[7:0];  i = 191 + DEFAULT_PC_ADDR*2;
    mem_out[ i] = tmpi_datain[15:8]; i = 192 + DEFAULT_PC_ADDR*2;

    // if (gr2 < gr7) Jump to judge with Ana_old
    tmpi_datain = {`BN, `gr0, 4'bXXXX, 4'b0001};
    mem_out[ i] = tmpi_datain[7:0];  i = 193 + DEFAULT_PC_ADDR*2;
    mem_out[ i] = tmpi_datain[15:8]; i = 194 + DEFAULT_PC_ADDR*2;

    // else (gr2 >= gr7) then update Ana_best with Ana_new (gr7)
    tmpi_datain = {`STORE, `gr7, 1'b0, `gr0, 4'b1011};
    mem_out[ i] = tmpi_datain[7:0];  i = 199 + DEFAULT_PC_ADDR*2;
    mem_out[ i] = tmpi_datain[15:8]; i = 200 + DEFAULT_PC_ADDR*2;

    // load X_new Y_new to gr3
    tmpi_datain = {`LOAD, `gr3, 1'b0, `gr0, 4'b1001};
    mem_out[ i] = tmpi_datain[7:0];  i = 161 + DEFAULT_PC_ADDR*2;
    mem_out[ i] = tmpi_datain[15:8]; i = 162 + DEFAULT_PC_ADDR*2;

    // Use X_new Y_new (gr3) to update X_best Y_best 
    tmpi_datain = {`STORE, `gr3, 1'b0, `gr0, 4'b1010};
    mem_out[ i] = tmpi_datain[7:0];  i = 199 + DEFAULT_PC_ADDR*2;
    mem_out[ i] = tmpi_datain[15:8]; i = 200 + DEFAULT_PC_ADDR*2;
    
    // Jump to update Ana_old with Ana_new (gr7)
    tmpi_datain = {`JUMP, 3'b000, 4'b0010, 4'b0010};
    mem_out[ i] = tmpi_datain[7:0];  i = 95 + DEFAULT_PC_ADDR*2;
    mem_out[ i] = tmpi_datain[15:8]; i = 96 + DEFAULT_PC_ADDR*2;
    
    // load Ana_old to gr4
    tmpi_datain = {`LOAD, `gr4, 1'b0, `gr0, 4'b1101};
    mem_out[ i] = tmpi_datain[7:0];  i = 161 + DEFAULT_PC_ADDR*2;
    mem_out[ i] = tmpi_datain[15:8]; i = 162 + DEFAULT_PC_ADDR*2;
    
    // Compare the Ana_old (gr4) with Ana_new (gr7)
    tmpi_datain = {`SUB, `gr5, 1'b0, `gr4, 1'b0, `gr7};
    mem_out[ i] = tmpi_datain[7:0];  i = 191 + DEFAULT_PC_ADDR*2;
    mem_out[ i] = tmpi_datain[15:8]; i = 192 + DEFAULT_PC_ADDR*2;
    
    // if (gr4 >= gr7) Jump to update Ana_old 
    tmpi_datain = {`BNC, `gr0, 4'bXXXX, 4'b0001};
    mem_out[ i] = tmpi_datain[7:0];  i = 193 + DEFAULT_PC_ADDR*2;
    mem_out[ i] = tmpi_datain[15:8]; i = 194 + DEFAULT_PC_ADDR*2;

    // needs to calculate probability
    // else gr4 < gr7 reverse the result in gr5
    tmpi_datain = {`SUB, `gr5, 1'b0, `gr0, 1'b0, `gr5};
    mem_out[ i] = tmpi_datain[7:0];  i = 191 + DEFAULT_PC_ADDR*2;
    mem_out[ i] = tmpi_datain[15:8]; i = 192 + DEFAULT_PC_ADDR*2;
        
    // Load current Temperature to gr6
    tmpi_datain = {`LOAD, `gr6, 1'b0, `gr0, 4'b1000};
    mem_out[ i] = tmpi_datain[7:0];  i = 161 + DEFAULT_PC_ADDR*2;
    mem_out[ i] = tmpi_datain[15:8]; i = 162 + DEFAULT_PC_ADDR*2;
    
    // Compare the delta_Ana (gr5) with T (gr6)
    tmpi_datain = {`CMP, 4'b0000, `gr5, 1'b0, `gr6};
    mem_out[ i] = tmpi_datain[7:0];  i = 191 + DEFAULT_PC_ADDR*2;
    mem_out[ i] = tmpi_datain[15:8]; i = 192 + DEFAULT_PC_ADDR*2;

    // if (gr5 >= gr6) Jump to Update T, SA counter and Neighbour
    tmpi_datain = {`BNC, `gr0, 4'bXXXX, 4'b0001};
    mem_out[ i] = tmpi_datain[7:0];  i = 193 + DEFAULT_PC_ADDR*2;
    mem_out[ i] = tmpi_datain[15:8]; i = 194 + DEFAULT_PC_ADDR*2;

    // else (gr5 < gr6) Activate the Division (delta_Ana)/T
    // start division process; (div_mode == CF_T27)? 128(2'b01) : 64(2'b10);
    tmpi_datain = {`SET, `gr1, 3'b001, 3'b010, 2'b01};
    mem_out[ i] = tmpi_datain[7:0];  i = 105 + DEFAULT_PC_ADDR*2;
    mem_out[ i] = tmpi_datain[15:8]; i = 106 + DEFAULT_PC_ADDR*2;

    // Load division result data (delta_Ana/T) to gr
    tmpi_datain = {`LIOA, `gr, 4'b0000, 4'b0000};
    mem_out[ i] = tmpi_datain[7:0];  i = 107 + DEFAULT_PC_ADDR*2;
    mem_out[ i] = tmpi_datain[15:8]; i = 108 + DEFAULT_PC_ADDR*2;

    // clear gr5 for the probability calculation
    tmpi_datain = {`SUB, `gr5, 1'b0, `gr5, 1'b0, `gr5};
    mem_out[ i] = tmpi_datain[7:0];  i = 191 + DEFAULT_PC_ADDR*2;
    mem_out[ i] = tmpi_datain[15:8]; i = 192 + DEFAULT_PC_ADDR*2;

    // set gr5 = 128 or 64; (div_mode == CF_T27)? 128(2'b01) : 64(2'b10);
    tmpi_datain = {`SET, `gr5, 4'b1000, 4'b0000};
    mem_out[ i] = tmpi_datain[7:0];  i = 191 + DEFAULT_PC_ADDR*2;
    mem_out[ i] = tmpi_datain[15:8]; i = 192 + DEFAULT_PC_ADDR*2;

    // calculate the probability [1 - (delta_Ana/T)] save in gr5
    tmpi_datain = {`SUB, `gr5, 1'b0, `gr5, 1'b0, `gr};
    mem_out[ i] = tmpi_datain[7:0];  i = 191 + DEFAULT_PC_ADDR*2;
    mem_out[ i] = tmpi_datain[15:8]; i = 192 + DEFAULT_PC_ADDR*2;
    
    // Left Shift `gr5 to make it enlarged 256 times
    tmpi_datain = {`SLL, `gr5, 1'b0, `gr5, 4'b0001};
    mem_out[ i] = tmpi_datain[7:0];  i = 19 + DEFAULT_PC_ADDR*2;
    mem_out[ i] = tmpi_datain[15:8]; i = 20 + DEFAULT_PC_ADDR*2;
    
    // Load LFSR value to gr6 (which is enlarged 256 times)
    tmpi_datain = {`LOAD, `gr6, 1'b0, `gr0, 4'b0111};
    mem_out[ i] = tmpi_datain[7:0];  i = 161 + DEFAULT_PC_ADDR*2;
    mem_out[ i] = tmpi_datain[15:8]; i = 162 + DEFAULT_PC_ADDR*2;

    // Generate a random data via LFSR
    tmpi_datain = {`LFSR, `gr6, 4'b0000, 1'b0, `gr6};//`gr6 = LFSR[`gr6];
    mem_out[ i] = tmpi_datain[7:0];  i = 17+ DEFAULT_PC_ADDR*2;
    mem_out[ i] = tmpi_datain[15:8]; i = 18+ DEFAULT_PC_ADDR*2;

    // Compare the probability (gr5) with random number (gr6)
    tmpi_datain = {`CMP, 4'b0000, `gr5, 1'b0, `gr6};
    mem_out[ i] = tmpi_datain[7:0];  i = 191 + DEFAULT_PC_ADDR*2;
    mem_out[ i] = tmpi_datain[15:8]; i = 192 + DEFAULT_PC_ADDR*2;
    
    // if (gr5 < gr6) Jump to Update T, SA counter and Neighbour
    tmpi_datain = {`BN, `gr0, 4'bXXXX, 4'b0001};
    mem_out[ i] = tmpi_datain[7:0];  i = 193 + DEFAULT_PC_ADDR*2;
    mem_out[ i] = tmpi_datain[15:8]; i = 194 + DEFAULT_PC_ADDR*2;
    
    // else (gr5 >= gr6) Use Ana_new (gr7) to update Ana_old
    tmpi_datain = {`STORE, `gr7, 1'b0, `gr0, 4'b1101};
    mem_out[ i] = tmpi_datain[7:0];  i = 199 + DEFAULT_PC_ADDR*2;
    mem_out[ i] = tmpi_datain[15:8]; i = 200 + DEFAULT_PC_ADDR*2;
    
    // load X_new Y_new to gr3
    tmpi_datain = {`LOAD, `gr3, 1'b0, `gr0, 4'b1001};
    mem_out[ i] = tmpi_datain[7:0];  i = 161 + DEFAULT_PC_ADDR*2;
    mem_out[ i] = tmpi_datain[15:8]; i = 162 + DEFAULT_PC_ADDR*2;
    
    // Use X_new Y_new (gr3) to update X_old Y_old
    tmpi_datain = {`STORE, `gr3, 1'b0, `gr0, 4'b1100};
    mem_out[ i] = tmpi_datain[7:0];  i = 199 + DEFAULT_PC_ADDR*2;
    mem_out[ i] = tmpi_datain[15:8]; i = 200 + DEFAULT_PC_ADDR*2;
    
    /* (4) Update Neighbour */
    
    
    
    /* (5) Update SA current Temperature to gr5 */
    tmpi_datain = {`LOAD, `gr5, 1'b0, `gr0, 4'b1000};
    mem_out[ i] = tmpi_datain[7:0];  i = 161 + DEFAULT_PC_ADDR*2;
    mem_out[ i] = tmpi_datain[15:8]; i = 162 + DEFAULT_PC_ADDR*2;
    
    // Update the Temperature (gr5) linearly 
    tmpi_datain = {`SUBI, `gr5, 4'b0000, 4'b0010};//`gr5 = gr5 - 2
    mem_out[ i] = tmpi_datain[7:0];  i = 117 + DEFAULT_PC_ADDR*2;
    mem_out[ i] = tmpi_datain[15:8]; i = 118 + DEFAULT_PC_ADDR*2;

    // if (gr5 >= 0) go to the next and save gr5 directly
    tmpi_datain = {`BNN, `gr0, 4'b0010, 4'b0001};
    mem_out[ i] = tmpi_datain[7:0];  i = 119 + DEFAULT_PC_ADDR*2;
    mem_out[ i] = tmpi_datain[15:8]; i = 120 + DEFAULT_PC_ADDR*2;

    // else (gr5 < 0) reset Temperature as 0
    tmpi_datain = {`SUB, `gr5, 1'b0, `gr5, 1'b0, `gr5};
    mem_out[ i] = tmpi_datain[7:0];  i = 1 + DEFAULT_PC_ADDR*2;
    mem_out[ i] = tmpi_datain[15:8]; i = 2 + DEFAULT_PC_ADDR*2;
    
    // Save Temperature (gr5) back to SRAM
    tmpi_datain = {`STORE, `gr5, 1'b0, `gr0, 4'b1000};
    mem_out[ i] = tmpi_datain[7:0];  i = 199 + DEFAULT_PC_ADDR*2;
    mem_out[ i] = tmpi_datain[15:8]; i = 200 + DEFAULT_PC_ADDR*2;
    
    /* (6) Update max SA iteration counter with gr2 */
    tmpi_datain = {`LOAD, `gr2, 1'b0, `gr0, 4'b0110};
    mem_out[ i] = tmpi_datain[7:0];  i = 161 + DEFAULT_PC_ADDR*2;
    mem_out[ i] = tmpi_datain[15:8]; i = 162 + DEFAULT_PC_ADDR*2;

    // Count down SA iteration # one each time
    tmpi_datain = {`SUBI, `gr2, 4'b0000, 4'b0001};//`gr2--
    mem_out[ i] = tmpi_datain[7:0];  i = 117 + DEFAULT_PC_ADDR*2;
    mem_out[ i] = tmpi_datain[15:8]; i = 118 + DEFAULT_PC_ADDR*2;
    
    //if (`gr2 != 0) return back to (1), save iteration# and keep on SA
    tmpi_datain = {`BNZ, `gr0, 4'b0010, 4'b0001};
    mem_out[ i] = tmpi_datain[7:0];  i = 119 + DEFAULT_PC_ADDR*2;
    mem_out[ i] = tmpi_datain[15:8]; i = 120 + DEFAULT_PC_ADDR*2;
    
    // Save SA iteration (gr2) to SA max iteration at 0x06
    tmpi_datain = {`STORE, `gr2, 1'b0, `gr0, 4'b0110};
    mem_out[ i] = tmpi_datain[7:0];  i = 199 + DEFAULT_PC_ADDR*2;
    mem_out[ i] = tmpi_datain[15:8]; i = 200 + DEFAULT_PC_ADDR*2;
    
    //else Update the Ana_best to Ana_old; X_new Y_new to X_old Y_old
    tmpi_datain = {`LOAD, `gr7, 1'b0, `gr0, 4'b1011};// Ana_best
    mem_out[ i] = tmpi_datain[7:0];  i = 161 + DEFAULT_PC_ADDR*2;
    mem_out[ i] = tmpi_datain[15:8]; i = 162 + DEFAULT_PC_ADDR*2;
    
    // Save Ana_best (gr7) to Ana_old at 0x0D
    tmpi_datain = {`STORE, `gr7, 1'b0, `gr0, 4'b1101};
    mem_out[ i] = tmpi_datain[7:0];  i = 199 + DEFAULT_PC_ADDR*2;
    mem_out[ i] = tmpi_datain[15:8]; i = 200 + DEFAULT_PC_ADDR*2;
    
    // Load X_best Y_best to gr6
    tmpi_datain = {`LOAD, `gr6, 1'b0, `gr0, 4'b1010};// X_best Y_best
    mem_out[ i] = tmpi_datain[7:0];  i = 161 + DEFAULT_PC_ADDR*2;
    mem_out[ i] = tmpi_datain[15:8]; i = 162 + DEFAULT_PC_ADDR*2;
    
    // Save X_best Y_best (gr6) to X_old Y_old
    tmpi_datain = {`STORE, `gr6, 1'b0, `gr0, 4'b1100};
    mem_out[ i] = tmpi_datain[7:0];  i = 199 + DEFAULT_PC_ADDR*2;
    mem_out[ i] = tmpi_datain[15:8]; i = 200 + DEFAULT_PC_ADDR*2;
    
    // Save X_best Y_best (gr6) to X_new Y_new
    tmpi_datain = {`STORE, `gr6, 1'b0, `gr0, 4'b1001};
    mem_out[ i] = tmpi_datain[7:0];  i = 199 + DEFAULT_PC_ADDR*2;
    mem_out[ i] = tmpi_datain[15:8]; i = 200 + DEFAULT_PC_ADDR*2;

    // (7) start the Sensitivity Algorithm
    

        //Clear OUT_A & Set SPI starting address;
        tmpi_datain = {`SUB, `gr2, 1'b0, `gr2, 1'b0, `gr2};
        mem_out[ i] = tmpi_datain[7:0];  i = 17 + DEFAULT_PC_ADDR*2;
        mem_out[ i] = tmpi_datain[15:8]; i = 18 + DEFAULT_PC_ADDR*2;
        tmpi_datain = {`SET, `gr2, 4'b0001, 4'b0001};
        mem_out[ i] = tmpi_datain[7:0];  i = 19 + DEFAULT_PC_ADDR*2;
        mem_out[ i] = tmpi_datain[15:8]; i = 20 + DEFAULT_PC_ADDR*2;

        //Clear OUT_B & Set SPI send data length;
        tmpi_datain = {`SUB, `gr3, 1'b0, `gr3, 1'b0, `gr3};
        mem_out[ i] = tmpi_datain[7:0];  i = 21 + DEFAULT_PC_ADDR*2;
        mem_out[ i] = tmpi_datain[15:8]; i = 22 + DEFAULT_PC_ADDR*2;
        tmpi_datain = {`SET, `gr3, 4'b0000, 4'b0010};
        mem_out[ i] = tmpi_datain[7:0];  i = 23 + DEFAULT_PC_ADDR*2;
        mem_out[ i] = tmpi_datain[15:8]; i = 24 + DEFAULT_PC_ADDR*2;

        //set the control reg for SPI to begin output
        tmpi_datain = {`SET, `gr1, 3'b010, 3'b000, 2'b00};
        mem_out[ i] = tmpi_datain[7:0];  i = 25 + DEFAULT_PC_ADDR*2;
        mem_out[ i] = tmpi_datain[15:8]; i = 26 + DEFAULT_PC_ADDR*2;

        //reset the control reg for SPI to end output
        tmpi_datain = {`SET, `gr1, 3'b000, 3'b000, 2'b00};
        mem_out[ i] = tmpi_datain[7:0];  i = 27 + DEFAULT_PC_ADDR*2;
        mem_out[ i] = tmpi_datain[15:8]; i = 28 + DEFAULT_PC_ADDR*2;

        //System finish
        tmpi_datain = {`HALT, 11'b000_0000_0000};
        mem_out[ i] = tmpi_datain[7:0];  i = 29 + DEFAULT_PC_ADDR*2;
        mem_out[ i] = tmpi_datain[15:8]; i = 30 + DEFAULT_PC_ADDR*2;
    end

    assign  mem_sa = mem_out[addr];
endmodule
`endif//I_MEMORY_SA_TASK_8BIT_V