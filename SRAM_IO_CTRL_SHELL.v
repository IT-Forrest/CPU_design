//+FHDR****************************************************************
// ECE department, TAMU
// --------------------------------------------------------------------
// FILE NAME    : SRAM_IO_CTRL_SHELL.v
// AUTHER       : Jiafan Wang
// DATE         : 09/17/2016
// VERSION      : 1.0
// PURPOSE      : This FPGA module reads & writes the SCPU_IO_CTRL on Chip
// --------------------------------------------------------------------
// ABSTRACT: Altera simulation 100MHz clock
// --------------------------------------------------------------------

`timescale 1ns / 1ps
//`include "DEFINE_CPU.v"

`ifndef SRAM_IO_CTRL_SHELL_V
`define SRAM_IO_CTRL_SHELL_V

module SRAM_IO_CTRL_SHELL(
    //input
    csi_clk,                // Clock
    rsi_reset_n,            // Reset (Active Low)

    //// Control Word ////
    avs_cpuctrl_writedata,  // wsa control flag
    avs_cpuctrl_write,
    
    //// Status Word ////
    avs_cpustat_readdata,
    
    avs_cntsclk_writedata,
    avs_cntsclk_write,
    
    avs_sram_addr_writedata,    // SRAM address value
    avs_sram_addr_write,

    avs_sram_data_writedata,    // Instruction data value
    avs_sram_data_write,
    avs_adc_writedata,
    avs_adc_write,
    avs_xin_writedata,          // mimic ADC data from analog
    avs_xin_write,
    avs_yin_writedata,          // mimic ADC data from analog
    avs_yin_write,
    
    //// Internal Output Connections ////
    avs_sram_addr_readdata,     // Instruction addr value
    avs_sram_data_readdata,     // Instruction data value
    
    //// External I/O Connections (Output)
    coe_anag_sclk1_export,
    coe_anag_sclk2_export,
    coe_anag_lat_export,
    coe_anag_spi_o_export,
    
    coe_ctrl_cpu_export,
    coe_ctrl_bgn_export,
    coe_ctrl_mod0_export,
    coe_ctrl_mod1_export,
    coe_ctrl_load_export,
    coe_ctrl_si_export,
    //// External I/O Connections (Input)
    coe_ctrl_nxt_export,
    coe_ctrl_adc_export,
    coe_ctrl_so_export,
    coe_ctrl_rdy_export
    );

    parameter   MEMORY_DATA_WIDTH   = 8,
                MEMORY_ADDR_WIDTH   = 9,
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
    parameter   IDX_SCPU_CTRL_RST  = 4;     // SCPU global RESET bit
    parameter   IDX_SCPU_CTRL_CPU  = 5;     // SCPU CPU  Module's start bit
    parameter   IDX_SCPU_CTRL_TEST = 6;     // SCPU test flag bit
    parameter   IDX_SCPU_CTRL_ADC  = 7;     // SCPU ADC flag bit (conflict with IDX_SCPU_CTRL_LOAD)
    
    //// Status Word ////
    output  [31 : 0]            avs_cpustat_readdata;

    parameter   IDX_SCPU_CTRL_RDY  = 0;     // SCPU CTRL Module's ready signal
    parameter   IDX_SCPU_CTRL_NXT0 = 1;     // SCPU process finish
    parameter   IDX_SCPU_CTRL_NXT1 = 2;     // SCPU Instructions run over
    
    input   [31 : 0]            avs_cntsclk_writedata;// freq divider value
    input                       avs_cntsclk_write;
    
    input   [31 : 0]            avs_sram_addr_writedata;// SRAM address value
    input                       avs_sram_addr_write;

    input   [31 : 0]            avs_sram_data_writedata;// Instruction data value
    input                       avs_sram_data_write;
    input   [31 : 0]            avs_adc_writedata;
    input                       avs_adc_write;
    input   [31 : 0]            avs_xin_writedata;      // mimic ADC data from analog
    input                       avs_xin_write;
    input   [31 : 0]            avs_yin_writedata;      // mimic ADC data from analog
    input                       avs_yin_write;
    
    //// Internal Output Connections ////
    output  [31 : 0]            avs_sram_addr_readdata; // Instruction addr value
    output  [31 : 0]            avs_sram_data_readdata; // Instruction data value
    
    //// External I/O Connections
    output                      coe_anag_sclk1_export;
    output                      coe_anag_sclk2_export;
    output                      coe_anag_lat_export  ;
    output                      coe_anag_spi_o_export;
    
    output                      coe_ctrl_cpu_export;
    output                      coe_ctrl_bgn_export;
    output                      coe_ctrl_mod0_export;
    output                      coe_ctrl_mod1_export;
    output                      coe_ctrl_load_export;
    output                      coe_ctrl_si_export;
    
    input   [1:0]               coe_ctrl_nxt_export;
    input   [9:0]               coe_ctrl_adc_export;
    input                       coe_ctrl_so_export;
    input                       coe_ctrl_rdy_export;
    
    // Registers and wires
    reg         reg_ctrl_bgn, reg_ctrl_bgn_dly, reg_load_dly;
    reg         reg_cpu_bgn, reg_TEST_MUX, reg_adc_set;
    reg         [1:0]   reg_LOAD;
    reg         [1:0]   reg_ctrl_mode;
    reg         [CT_WIDTH-1:0]  reg_sram_addr;
    reg         [CT_WIDTH-1:0]  reg_sram_data;
    reg         [3:0]   cnt_adc_in;
    reg         [9:0]   reg_adc_avs;
    reg         [9:0]   reg_adc_data;
    reg         [9:0]   reg_xin_data;
    reg         [9:0]   reg_yin_data;
    wire        CTRL_SO_dly;
    wire        CTRL_RDY_dly;
    wire        [9:0]   ADC_PI_dly;
    assign      ADC_PI_dly = (reg_TEST_MUX)? reg_adc_avs: coe_ctrl_adc_export; 
    
    reg         [REG_BITS_WIDTH-1:0]  reg_sram_all;//addr+instruction
    reg         [7:0]   cnt_bit_load;
    reg         [2:0]   cnt_chip_clk;
    reg         reg_RST, reg_CLK;
    reg         [2:0]   reg_cntsclk;
    reg         is_shift;
    
    wire        SCLK1 ;
    wire        SCLK2 ;
    wire        LAT   ;
    wire        SPI_SO;
    
    wire    [1:0]  CPU_NXT_dly;
    wire    CTRL_SO;
    assign  CTRL_SO = (reg_TEST_MUX)? CTRL_SO_dly : coe_ctrl_so_export;
    wire    is_LOAD;
    assign  is_LOAD = reg_load_dly;//reg_LOAD[0];

    wire    is_load2_ctrl = (reg_ctrl_mode == 2'b00);
    wire    is_rfrom_ctrl = (reg_ctrl_mode == 2'b10);
    
    assign  avs_cpustat_readdata[IDX_SCPU_CTRL_RDY]  = (reg_TEST_MUX)? CTRL_RDY_dly : coe_ctrl_rdy_export;
    assign  avs_cpustat_readdata[IDX_SCPU_CTRL_NXT0] = (reg_TEST_MUX)? CPU_NXT_dly[0]: coe_ctrl_nxt_export[0];
    assign  avs_cpustat_readdata[IDX_SCPU_CTRL_NXT1] = (reg_TEST_MUX)? CPU_NXT_dly[1]: coe_ctrl_nxt_export[1];
    assign  avs_sram_addr_readdata = reg_sram_all[REG_BITS_WIDTH-1:MEMORY_DATA_WIDTH];
    assign  avs_sram_data_readdata = reg_sram_all[MEMORY_DATA_WIDTH-1:0];
    
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

    //************* simple Minic ADC input behavior *************//
    always @(posedge reg_CLK)
    begin
        if (~rsi_reset_n)
        begin
            cnt_adc_in <= 4'd0;
            reg_adc_avs <= 10'd0;
        end else if (reg_adc_set)
        begin
            cnt_adc_in <= 4'd0;
            reg_adc_avs <= reg_adc_data;
        end else if (reg_load_dly)
        begin
            cnt_adc_in <= 4'd10;
            reg_adc_avs <= 10'd0;
        end else if (cnt_adc_in)
        begin
            cnt_adc_in <= cnt_adc_in - 1;
            reg_adc_avs <= reg_xin_data;
        end else
        begin
            cnt_adc_in <= 0;
            reg_adc_avs <= reg_yin_data;
        end
    end
    
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
            reg_cntsclk <= 0;//by default, the same freq as csi_clk
        
            reg_cpu_bgn   <= 1'b0;
            reg_RST       <= 1'b0;
            reg_ctrl_bgn  <= 1'b0;
            reg_ctrl_mode <= 2'b00;
            reg_TEST_MUX  <= 1'b0;
            reg_adc_set   <= 1'b0;
            
            reg_sram_addr <= {CT_WIDTH{1'b0}};
            reg_sram_data <= {CT_WIDTH{1'b0}};
            
            reg_adc_data <= 10'b0;
            reg_xin_data <= 10'b0;
            reg_yin_data <= 10'b0;
        end else
        begin
            if (avs_cntsclk_write)
                reg_cntsclk <= avs_cntsclk_writedata[CT_WIDTH-1:0];
        
            if (avs_cpuctrl_write)// Set registers if any value changes
            begin
                reg_cpu_bgn  <= avs_cpuctrl_writedata[IDX_SCPU_CTRL_CPU];
                reg_RST      <= avs_cpuctrl_writedata[IDX_SCPU_CTRL_RST];
                reg_ctrl_bgn <= avs_cpuctrl_writedata[IDX_SCPU_CTRL_BGN];
                reg_ctrl_mode <= {avs_cpuctrl_writedata[IDX_SCPU_CTRL_MOD1],
                                avs_cpuctrl_writedata[IDX_SCPU_CTRL_MOD0]};
                reg_TEST_MUX <= avs_cpuctrl_writedata[IDX_SCPU_CTRL_TEST];
                reg_adc_set  <= avs_cpuctrl_writedata[IDX_SCPU_CTRL_ADC];
            end
                
            if (avs_sram_addr_write)
                reg_sram_addr <= avs_sram_addr_writedata[CT_WIDTH-1:0];
                
            if (avs_sram_data_write)
                reg_sram_data <= avs_sram_data_writedata[CT_WIDTH-1:0];

            if (avs_adc_write)
                reg_adc_data <= avs_adc_writedata[9:0];

            if (avs_xin_write)
                reg_xin_data <= avs_xin_writedata[9:0];

            if (avs_yin_write)
                reg_yin_data <= avs_yin_writedata[9:0];
        end
    end
    
    //// Clock Generation for CHIP ////
    always @(posedge csi_clk)
    begin
        if (~rsi_reset_n)
        begin
            cnt_chip_clk <= 0;
            reg_CLK <= 0;
        end
        else
        begin
            // f(reg_CLK) = f(csi_clk)/(reg_cntsclk+1);
            if (cnt_chip_clk == reg_cntsclk)
            begin
                cnt_chip_clk <= 0;
                reg_CLK <= ~reg_CLK;
            end else
            begin
                cnt_chip_clk <= cnt_chip_clk + 1;
                reg_CLK <= reg_CLK;
            end
        end
    end
    
    SCPU_SRAM_8BIT_ALU_SPI_TOP  scpu_sram_alu(
        .CLK            (reg_CLK    ),
        .RST_N          (reg_RST    ),
        .CTRL_MODE      (CTRL_MODE_dly),
        .CTRL_BGN       (CTRL_BGN_dly),
        .CPU_BGN        (reg_cpu_bgn),//delay is not serious for this port
        .LOAD_N         (LOAD_N_dly),
        .CTRL_SI        (CTRL_SI_dly),
        .ADC_PI         (ADC_PI_dly ),
        // output
        .CTRL_RDY       (CTRL_RDY_dly),
        .CTRL_SO        (CTRL_SO_dly),
        .NXT            (CPU_NXT_dly),
        //.SEL            (SEL        ),
        .SCLK1          (SCLK1      ),
        .SCLK2          (SCLK2      ),
        .LAT            (LAT        ),
        .SPI_SO         (SPI_SO     )
    );

    assign  coe_anag_sclk1_export  = SCLK1;
    assign  coe_anag_sclk2_export  = SCLK2;
    assign  coe_anag_lat_export    = LAT;
    assign  coe_anag_spi_o_export  = SPI_SO;
    
    assign  coe_ctrl_cpu_export  = reg_cpu_bgn;
    assign  coe_ctrl_bgn_export  = reg_ctrl_bgn_dly;//reg_ctrl_bgn
    assign  coe_ctrl_mod1_export = (reg_ctrl_mode[0])?reg_ctrl_mode[1]:1'b0;
    assign  coe_ctrl_mod0_export = reg_ctrl_mode[0];
    assign  coe_ctrl_load_export = is_LOAD;
    assign  coe_ctrl_si_export   = reg_sram_all[0];

    assign  CTRL_MODE_dly = {coe_ctrl_mod1_export,coe_ctrl_mod0_export};
    assign  CTRL_BGN_dly = coe_ctrl_bgn_export;
    assign  LOAD_N_dly = !coe_ctrl_load_export;
    assign  CTRL_SI_dly = coe_ctrl_si_export;
    
endmodule
`endif//SRAM_IO_CTRL_SHELL_V