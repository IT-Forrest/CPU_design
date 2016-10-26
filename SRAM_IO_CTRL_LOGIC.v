//+FHDR****************************************************************
// ECE department, TAMU
// --------------------------------------------------------------------
// FILE NAME    : SRAM_IO_CTRL_LOGIC.v
// AUTHER       : Jiafan Wang
// DATE         : 07/09/2016
// VERSION      : 1.0
// PURPOSE      : This FPGA module reads & writes the SCPU_IO_CTRL on Chip
// --------------------------------------------------------------------
// ABSTRACT: Altera simulation 100MHz clock
// --------------------------------------------------------------------

`timescale 1ns / 1ps
//`include "DEFINE_CPU.v"

`ifndef SRAM_IO_CTRL_LOGIC_V
`define SRAM_IO_CTRL_LOGIC_V

module SRAM_IO_CTRL_LOGIC(
    //input
    csi_clk,                // Clock
    rsi_reset_n,            // Reset (Active Low)

    //// Control Word ////
    avs_cpuctrl_writedata,  // wsa control flag
    avs_cpuctrl_write,
    
    //// Status Word ////
    avs_cpustat_readdata,
    
    avs_sram_addr_writedata,    // SRAM address value
    avs_sram_addr_write,

    avs_sram_data_writedata,    // Instruction data value
    avs_sram_data_write,
    
    // avs_adc_writedata,          // ADC data from analog
    // avs_adc_write,
    
    //// Internal Output Connections ////
    avs_sram_addr_readdata,     // Instruction addr value
    avs_sram_data_readdata,     // Instruction data value
    
    //// External I/O Connections (Output)
    coe_ctrl_bgn_export,
    coe_ctrl_mod0_export,
    coe_ctrl_mod1_export,
    coe_ctrl_load_export,
    coe_ctrl_si_export,
    //// External I/O Connections (Input)
    coe_ctrl_so_export,
    coe_ctrl_rdy_export
    );

    parameter   MEMORY_DATA_WIDTH   = 8,
                MEMORY_ADDR_WIDTH   = 10,
                REG_BITS_WIDTH = MEMORY_ADDR_WIDTH + MEMORY_DATA_WIDTH;
    
    parameter   AVS_WIDTH       = 32;
    parameter   CT_WIDTH        = 16;
    
    //// Global ////
    input                       csi_clk;
    input                       rsi_reset_n;
    
    //// Control Word ////
    input   [31 : 0]            avs_cpuctrl_writedata;  
    input                       avs_cpuctrl_write;

    parameter   IDX_SCPU_CTRL_BGN  = 0;     // SCPU CTRL Module's start bit
    parameter   IDX_SCPU_CTRL_LOAD = 1;     // SCPU CTRL Module's load bit
    parameter   IDX_SCPU_CTRL_MOD0 = 2;     // SCPU CTRL Module's mode bit
    parameter   IDX_SCPU_CTRL_MOD1 = 3;     // SCPU CTRL Module's mode bit
    
    //// Status Word ////
    output  [31 : 0]            avs_cpustat_readdata;

    parameter   IDX_SCPU_CTRL_RDY  = 0;     // SCPU CTRL Module's ready signal
    // parameter   IDX_SCPU_NXT_EXT   = 1;     // SCPU process finish
    // parameter   IDX_SCPU_NXT_INS   = 2;     // SCPU Instructions run over
    
    input   [31 : 0]            avs_sram_addr_writedata;// SRAM address value
    input                       avs_sram_addr_write;

    input   [31 : 0]            avs_sram_data_writedata;// Instruction data value
    input                       avs_sram_data_write;
    
    // input   [31 : 0]            avs_adc_writedata;      // ADC data from analog
    // input                       avs_adc_write;
    
    //// Internal Output Connections ////
    output  [31 : 0]            avs_sram_addr_readdata; // Instruction addr value
    output  [31 : 0]            avs_sram_data_readdata; // Instruction data value
    
    //// External I/O Connections
    output                      coe_ctrl_bgn_export;
    output                      coe_ctrl_mod0_export;
    output                      coe_ctrl_mod1_export;
    output                      coe_ctrl_load_export;
    output                      coe_ctrl_si_export;
    
    input                       coe_ctrl_so_export;
    input                       coe_ctrl_rdy_export;
    
    // Registers and wires
    reg         reg_ctrl_bgn, reg_ctrl_bgn_dly, reg_load_dly;
    reg         [1:0]   reg_LOAD;
    reg         [1:0]   reg_ctrl_mode;
    reg         [CT_WIDTH-1:0]  reg_sram_addr;
    reg         [CT_WIDTH-1:0]  reg_sram_data;
            
    reg         [REG_BITS_WIDTH-1:0]  reg_sram_all;//addr+instruction
    reg         [7:0]   cnt_bit_load;
    reg         is_shift;
    
    wire    CTRL_SO;
    assign  CTRL_SO = coe_ctrl_so_export;
    wire    is_LOAD;
    assign  is_LOAD = reg_load_dly;//reg_LOAD[0];

    wire    is_load2_ctrl = (reg_ctrl_mode == 2'b00);
    wire    is_rfrom_ctrl = (reg_ctrl_mode == 2'b10);
    
    assign  avs_cpustat_readdata[IDX_SCPU_CTRL_RDY] = coe_ctrl_rdy_export;
    assign  avs_sram_addr_readdata = reg_sram_all[REG_BITS_WIDTH-1:MEMORY_DATA_WIDTH];
    assign  avs_sram_data_readdata = reg_sram_all[MEMORY_DATA_WIDTH-1:0];
    
    assign  coe_ctrl_bgn_export  = reg_ctrl_bgn_dly;//reg_ctrl_bgn
    assign  coe_ctrl_load_export = is_LOAD;
    assign  coe_ctrl_si_export   = reg_sram_all[0];
    assign  coe_ctrl_mod1_export = (reg_ctrl_mode[0])?reg_ctrl_mode[1]:1'b0;
    assign  coe_ctrl_mod0_export = reg_ctrl_mode[0];
    
    //************* Combinational Mapping For CTRL MODE *************//
    /* always @(*) begin
        case(reg_ctrl_mode)
        /// Due to clock delay, serial data between CHIP and FPGA have different processes
        2'b00://serial input data to CHIP from FPGA 
            {coe_ctrl_mod1_export,coe_ctrl_mod0_export} = 2'b00;
        2'b10://serial input data to FPGA from CHIP
            {coe_ctrl_mod1_export,coe_ctrl_mod0_export} = 2'b00;

        /// Due to SRAM delay, PI data between SRAM and CTRL have different processes
        2'b01://read PI data from SRAM to CTRL (all on CHIP)
            {coe_ctrl_mod1_export,coe_ctrl_mod0_export} = reg_ctrl_mode;
        2'b11://send PI data from CTRL to SRAM (all on CHIP)
            {coe_ctrl_mod1_export,coe_ctrl_mod0_export} = reg_ctrl_mode;
        endcase
    end */
    
    //************* CEN should not active at posedge *************//
    always @(negedge csi_clk)
    begin
        if (~rsi_reset_n)
            reg_ctrl_bgn_dly <= 1'b0;
        else
            reg_ctrl_bgn_dly <= reg_ctrl_bgn;
    end
    
    always @(negedge csi_clk)
    begin
        if (~rsi_reset_n)
            reg_load_dly <= 1'b0;
        else
            reg_load_dly <= reg_LOAD[0];
    end
    
    //************* make IDX_SCPU_CTRL_LOAD only works for one cycle *************//
    always @(posedge csi_clk)
    begin
        if ((~rsi_reset_n) | (~avs_cpuctrl_write))
        begin
            reg_LOAD <= 2'b00;
        end else if (avs_cpuctrl_write &
                    avs_cpuctrl_writedata[IDX_SCPU_CTRL_LOAD] &
                    (reg_LOAD == 2'b00))
        begin
            reg_LOAD <= 2'b01;//is_LOAD = reg_LOAD[0];
        end else 
        begin
            reg_LOAD <= 2'b10;
        end
    end
    
    /************** Send Serial data to SRAM_IO_CTRL  ***********/
    always @(negedge csi_clk)
    begin
        if (cnt_bit_load)
            is_shift <= 1'b1;
        else
            is_shift <= 1'b0;
    end
    
    always @(negedge csi_clk)
    begin
        if (~rsi_reset_n)
            reg_sram_all <= {REG_BITS_WIDTH{1'b0}};
        else if (is_LOAD)
            if (is_load2_ctrl)
                reg_sram_all <= {reg_sram_addr[MEMORY_ADDR_WIDTH-1:0], reg_sram_data[MEMORY_DATA_WIDTH-1:0]};
            else if (is_rfrom_ctrl)
                // Due to clock delay, FPGA starts to read when is_LOAD
                reg_sram_all <= {CTRL_SO, reg_sram_all[REG_BITS_WIDTH-1:1]};
            else
                reg_sram_all <= reg_sram_all;
        else if (is_shift)
            reg_sram_all <= {CTRL_SO, reg_sram_all[REG_BITS_WIDTH-1:1]};
    end
    
    always @(negedge csi_clk)
    begin
        if (~rsi_reset_n)
            cnt_bit_load <= 0;
        else if (is_LOAD)
            if (is_load2_ctrl)
                cnt_bit_load <= REG_BITS_WIDTH-1;
            else if (is_rfrom_ctrl)
                // Due to clock delay, FPGA starts to read when is_LOAD
                cnt_bit_load <= REG_BITS_WIDTH-1;
            else
                cnt_bit_load <= 0;
        else if (cnt_bit_load)
            cnt_bit_load <= cnt_bit_load - 1;
    end
    
    //// Register Assignment ////
    always @(posedge csi_clk)
    begin
        if (~rsi_reset_n)
        begin
            reg_ctrl_bgn  <= 1'b0;
            reg_ctrl_mode <= 2'b00;
            
            reg_sram_addr <= {CT_WIDTH{1'b0}};
            reg_sram_data <= {CT_WIDTH{1'b0}};
        end else
        begin
            if (avs_cpuctrl_write)// Set registers if any value changes
            begin
                reg_ctrl_bgn <= avs_cpuctrl_writedata[IDX_SCPU_CTRL_BGN];
                reg_ctrl_mode <= {avs_cpuctrl_writedata[IDX_SCPU_CTRL_MOD1],
                                avs_cpuctrl_writedata[IDX_SCPU_CTRL_MOD0]};
            end
                
            if (avs_sram_addr_write)
                reg_sram_addr <= avs_sram_addr_writedata[CT_WIDTH-1:0];
                
            if (avs_sram_data_write)
                reg_sram_data <= avs_sram_data_writedata[CT_WIDTH-1:0];

        end
    end
endmodule
`endif//SRAM_IO_CTRL_LOGIC_V