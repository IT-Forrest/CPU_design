//+FHDR****************************************************************
// ECE department, TAMU
// --------------------------------------------------------------------
// FILE NAME    : SCPU_SRAM_8BIT_ALU_SPI_TOP.v
// AUTHER       : Jiafan Wang
// DATE         : 07/02/2016
// VERSION      : 2.0
// PURPOSE      : non-SRAM Digital Part, RA1SH 512x8 SRAM and PAD
// --------------------------------------------------------------------
// ABSTRACT: ModelSim simulation time 6us given each time period 10ns
// --------------------------------------------------------------------
`timescale 1ns / 1ps
`include "DEFINE_CPU.v"
`include "SCPU_8BIT_ALU_CTRL_SPI.v"
//`include "RA1SHD_IBM512X8.v"
//`include "iogpil_cmrf8sf_rvt.v"

`ifndef SCPU_SRAM_8BIT_ALU_SPI_TOP_V
`define SCPU_SRAM_8BIT_ALU_SPI_TOP_V

module SCPU_SRAM_8BIT_ALU_SPI_TOP(
    CLK,
    RST_N,
    CTRL_MODE,
    CTRL_BGN,
    CPU_BGN,
    LOAD_N,
    CTRL_SI,
    APP_DONE,
    ADC_PI,
    // output
    CTRL_RDY,
    //ANA_RDY,
    CTRL_SO,
    //ANA_SO,
    NXT,
    //SEL,
    SCLK1,
    SCLK2,
    LAT,
    SPI_SO
    );

    parameter   MEMORY_DATA_WIDTH   = 8,
                MEMORY_ADDR_WIDTH   = 10;
    parameter   GENERAL_REG_WIDTH   = 16;
    
    // Inputs
    input   CLK;
    input   RST_N;
    input   [1:0]  CTRL_MODE;
    input   CTRL_BGN;
    input   CPU_BGN;
    input   LOAD_N;
    input   CTRL_SI;
    //input   ANA_SI;
    input   [9:0] ADC_PI;
    
    // Output
    output  CTRL_RDY;
    //output  ANA_RDY;
    output  CTRL_SO;
    //output  ANA_SO;
    output  [1:0]   NXT;
    //output  SEL;
    output  SCLK1;
    output  SCLK2;
    output  LAT;
    output  SPI_SO;
    
    // Wires
    wire    [1:0]   i_CTRL_MODE;
    wire    [1:0]   i_NXT;
    wire    [9:0]   i_ADC_PI;
    wire    WEN_after_mux;
    wire    CEN_after_mux;
    wire [MEMORY_ADDR_WIDTH-1:0]  A_after_mux;
    wire [MEMORY_DATA_WIDTH-1:0]  D_after_mux;
    wire [MEMORY_DATA_WIDTH-1:0]  Q_from_SRAM;
   
    SCPU_8BIT_ALU_CTRL_SPI  scpu_ctrl_spi(
        // I/O with SRAM
        .CEN_after_mux  (CEN_after_mux  ),
        .WEN_after_mux  (WEN_after_mux  ),
        .A_after_mux    (A_after_mux    ),
        .D_after_mux    (D_after_mux    ),
        .Q_from_SRAM    (Q_from_SRAM    ),
        // input
        .CLK            (i_CLK          ),
        .RST_N          (i_RST_N        ),
        .CTRL_MODE      (i_CTRL_MODE    ),
        .CTRL_BGN       (i_CTRL_BGN     ),
        .CPU_BGN        (i_CPU_BGN      ),
        .LOAD_N         (i_LOAD_N       ),
        .CTRL_SI        (i_CTRL_SI      ),
        .APP_DONE       (i_APP_DONE     ),
        .ADC_PI         (i_ADC_PI       ),
        // output
        .CTRL_RDY       (i_CTRL_RDY     ),
        //.ANA_RDY        (i_ANA_RDY      ),
        .CTRL_SO        (i_CTRL_SO      ),
        //.ANA_SO         (i_ANA_SO       ),
        .NXT            (i_NXT          ),
        //.SEL            (i_SEL          ),
        .SCLK1          (i_SCLK1        ),
        .SCLK2          (i_SCLK2        ),
        .LAT            (i_LAT          ),
        .SPI_SO         (i_SPI_SO       )
    );

    // SRAM module
    RA1SHD_IBM1024X8   sram (
        .CLK(i_CLK),
        .CEN(CEN_after_mux), 
        .A(A_after_mux),
        // need a seperate control signal; or instruction set will be overwritten when d_we=1
        .WEN(WEN_after_mux),
        .D(D_after_mux),//i_instruct
        .Q(Q_from_SRAM)
    );

    // Input Pad information
    PIC     ipad_clk        (.Y(i_CLK), .P(CLK), .IE(1'b1));
    PIC     ipad_rst_n      (.Y(i_RST_N), .P(RST_N), .IE(1'b1));
    PIC     ipad_ctrl_mode0 (.Y(i_CTRL_MODE[0]), .P(CTRL_MODE[0]), .IE(1'b1));
    PIC     ipad_ctrl_mode1 (.Y(i_CTRL_MODE[1]), .P(CTRL_MODE[1]), .IE(1'b1));
    PIC     ipad_ctrl_bgn   (.Y(i_CTRL_BGN), .P(CTRL_BGN), .IE(1'b1));
    PIC     ipad_cpu_bgn    (.Y(i_CPU_BGN), .P(CPU_BGN), .IE(1'b1));
    PIC     ipad_load_n     (.Y(i_LOAD_N), .P(LOAD_N), .IE(1'b1));
    PIC     ipad_ctrl_si    (.Y(i_CTRL_SI), .P(CTRL_SI), .IE(1'b1));
    PIC     ipad_app_done   (.Y(i_APP_DONE), .P(APP_DONE), .IE(1'b1));
    PIC     ipad_adc_pi0	(.Y(i_ADC_PI[0]), .P(ADC_PI[0]), .IE(1'b1));
    PIC     ipad_adc_pi1	(.Y(i_ADC_PI[1]), .P(ADC_PI[1]), .IE(1'b1));
    PIC     ipad_adc_pi2	(.Y(i_ADC_PI[2]), .P(ADC_PI[2]), .IE(1'b1));
    PIC     ipad_adc_pi3	(.Y(i_ADC_PI[3]), .P(ADC_PI[3]), .IE(1'b1));
    PIC     ipad_adc_pi4	(.Y(i_ADC_PI[4]), .P(ADC_PI[4]), .IE(1'b1));
    PIC     ipad_adc_pi5	(.Y(i_ADC_PI[5]), .P(ADC_PI[5]), .IE(1'b1));
    PIC     ipad_adc_pi6	(.Y(i_ADC_PI[6]), .P(ADC_PI[6]), .IE(1'b1));
    PIC     ipad_adc_pi7	(.Y(i_ADC_PI[7]), .P(ADC_PI[7]), .IE(1'b1));
    PIC     ipad_adc_pi8	(.Y(i_ADC_PI[8]), .P(ADC_PI[8]), .IE(1'b1));
    PIC     ipad_adc_pi9	(.Y(i_ADC_PI[9]), .P(ADC_PI[9]), .IE(1'b1));
    
    // output Pad information
    POC8B   opad_ctrl_rdy   (.P(CTRL_RDY), .A(i_CTRL_RDY));
    POC8B   opad_ctrl_so    (.P(CTRL_SO), .A(i_CTRL_SO));
    POC8B   opad_nxt0       (.P(NXT[0]), .A(i_NXT[0]));
    POC8B   opad_nxt1       (.P(NXT[1]), .A(i_NXT[1]));
    POC8B   opad_sclk1      (.P(SCLK1), .A(i_SCLK1));
    POC8B   opad_sclk2      (.P(SCLK2), .A(i_SCLK2));
    POC8B   opad_lat        (.P(LAT), .A(i_LAT));
    POC8B   opad_spi_so     (.P(SPI_SO), .A(i_SPI_SO));
    
endmodule
`endif//SCPU_SRAM_8BIT_ALU_SPI_TOP_V
