//+FHDR****************************************************************
// ECE department, TAMU
// --------------------------------------------------------------------
// FILE NAME    : I_MEMORY_8BIT.v
// AUTHER       : Jiafan Wang
// DATE         : 03/11/2016
// VERSION      : 1.0
// PURPOSE      : simulate the SRAM with 8 bit word length; 512 address
// --------------------------------------------------------------------
// ABSTRACT: simulation time 85 us given each time period 20ns
// --------------------------------------------------------------------

//`timescale 1ns / 1ps
//`include "DEFINE_CPU.v"

`ifndef I_MEMORY_8BIT_V
`define I_MEMORY_8BIT_V

module I_MEMORY_8BIT(
    clk,
    rst_n,
    addr,
    d_we,
    datain,
    dataout
    );

    parameter   MEMORY_DATA_WIDTH   = 8,
                MEMORY_ADDR_WIDTH   = 10;

    input   clk;
    input   rst_n;
    input   [MEMORY_ADDR_WIDTH-1:0] addr;
    input   d_we;
    input   [MEMORY_DATA_WIDTH-1:0] datain;
    output reg [MEMORY_DATA_WIDTH-1:0] dataout;
    
    reg [MEMORY_DATA_WIDTH-1:0] I_RAM[(1<<MEMORY_ADDR_WIDTH)-1:0];
    //assign dataout = I_RAM[addr];
    always @(posedge clk or negedge rst_n)
        begin
            if (!rst_n)
                begin
                    // The initialization is moved to the top-level test bench
                    // I_RAM[0] <= {`LOAD, `gr1, 1'b0, `gr0, 4'b0000};
                    // I_RAM[1] <= {`LOAD, `gr2, 1'b0, `gr0, 4'b0001};
                    // I_RAM[2] <= {`NOP, 11'b000_0000_0000};
                    // I_RAM[3] <= {`NOP, 11'b000_0000_0000};
                    // I_RAM[4] <= {`NOP, 11'b000_0000_0000};
                    // I_RAM[5] <= {`ADD, `gr3, 1'b0, `gr1, 1'b0, `gr2};
                    // I_RAM[6] <= {`NOP, 11'b000_0000_0000};
                    // I_RAM[7] <= {`NOP, 11'b000_0000_0000};
                    // I_RAM[8] <= {`NOP, 11'b000_0000_0000};
                    // I_RAM[9] <= {`STORE, `gr3, 1'b0, `gr0, 4'b0010};
                    // I_RAM[10] <= {`BNZ, `gr1, 8'b0001_0000};
                    // I_RAM[11] <= {`NOP, 11'b000_0000_0000};
                    // I_RAM[12] <= {`NOP, 11'b000_0000_0000};
                    // I_RAM[13] <= {`NOP, 11'b000_0000_0000};
                    // I_RAM[187] <= {`CMP, 4'b0000, `gr1, 1'b0, `gr2};
                    // I_RAM[188] <= {`HALT, 11'b000_0000_0000};
                end
            else if (d_we)
                I_RAM[addr] <= datain;
            else
                dataout <= I_RAM[addr];
        end

endmodule
`endif//I_MEMORY_8BIT_V