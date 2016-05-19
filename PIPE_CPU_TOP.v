//+FHDR****************************************************************
// ECE department, TAMU
// --------------------------------------------------------------------
// FILE NAME    : PIPE_CPU_TOP.v
// AUTHER       : Jiafan Wang
// DATE         : 12/22/2014
// VERSION      : 1.0
// PURPOSE      : the connections between CPU and memory
// --------------------------------------------------------------------
// ABSTRACT
//
// --------------------------------------------------------------------

`timescale 1ns / 1ps
`include "DEFINE_CPU.v"
`include "PIPE_CPU.v"
`include "D_MEMORY.v"
`include "I_MEMORY.v"

`ifndef PIPE_CPU_TOP_V
`define PIPE_CPU_TOP_V

module PIPE_CPU_TOP(
    input clk,
    input enable,
    input start,
    input rst,
    input [3:0] select_y,
    output [15:0] y
    );
    
    wire [15:0] i_datain;
    wire [15:0] d_datain;
    wire [7:0] i_addr;
    wire [7:0] d_addr;
    wire d_we;
    wire [15:0] d_dataout;

    pcpu u_pcpu (
        .clock(clk), 
        .enable(enable), 
        .reset(rst), 
        .start(start), 
        .i_datain(i_datain), 
        .d_datain(d_datain), 
        .select_y(select_y), 
        .i_addr(i_addr), 
        .d_addr(d_addr), 
        .d_we(d_we), 
        .d_dataout(d_dataout), 
        .y(y)
    );
    i_memory i_mem (
        .clk(clk),
        .rst(rst),
        .addr(i_addr),
        .we(1'b0),
        .datain(16'b0000_0000_0000_0000),
        .dataout(i_datain)
    );
    d_memory d_mem (
        .clk(clk),
        .rst(rst),
        .addr(d_addr),
        .we(d_we),
        .datain(d_dataout),
        .dataout(d_datain)
    );

endmodule
`endif//PIPE_CPU_TOP_V