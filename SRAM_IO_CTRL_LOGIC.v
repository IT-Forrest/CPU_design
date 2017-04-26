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
    
    avs_cntsclk_writedata,
    avs_cntsclk_write,
    
    avs_sram_addr_wrt_writedata,    // SRAM address value
    avs_sram_addr_wrt_write,

    avs_sram_data_wrt_writedata,    // Instruction data value
    avs_sram_data_wrt_write,
    avs_adc_writedata,          // ADC data from analog
    avs_adc_write,
    
    //// Internal Output Connections ////
    avs_sram_addr_rd_readdata,     // Instruction addr value
    avs_sram_data_rd_readdata,     // Instruction data value
    avs_scan_chain_readdata,    // Scan chain data value
    
    //// External I/O Connections (Output)
    coe_cpu_bgn_export,
    coe_ctrl_bgn_export,
    coe_ctrl_mod0_export,
    coe_ctrl_mod1_export,
    coe_ctrl_load_export,
    coe_ctrl_si_export,
    coe_cpu_wait_export,
    coe_adc_value_export,
    coe_app_done_export,
    coe_rst_n_export,
    coe_clk_export,
    coe_test_mux0_export,
    coe_test_mux1_export,
    coe_test_mux2_export,
    
    //// External I/O Connections (Input)
    coe_ctrl_so_export,
    coe_ctrl_rdy_export,
    coe_ctrl_nxt_end_export,
    coe_ctrl_nxt_cont_export,
    coe_app_start_export,
    coe_anag_sclk1_export,
    coe_anag_sclk2_export,
    coe_anag_lat_export,
    coe_anag_spi_so_export
    );

    parameter   ADC_DATA_WIDTH      = 10,
				MAX_SQRT_WIDTH		= 13;
    parameter   MEMORY_DATA_WIDTH   = 8,
                MEMORY_ADDR_WIDTH   = 10,
                REG_BITS_WIDTH = MEMORY_ADDR_WIDTH + MEMORY_DATA_WIDTH;
    
    parameter   AVS_WIDTH       = 32;
    parameter   CT_WIDTH        = 16;
    parameter   CLK_WIDTH       =  8;
    
    parameter   DEFAULT_CNTSCLK = 0;//0: 1/2 freq; 1: 1/4 freq
    
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
    parameter   IDX_SCPU_APP_DONE  = 4;     // External App's done signal
    parameter   IDX_SCPU_CPU_BGN   = 5;     // SCPU BGN start bit
    parameter   IDX_SCPU_RST_N     = 6;	    // SCPU RST_N bit
    parameter   IDX_SCPU_CPU_WAIT  = 7;     // SCPU CPU WAIT signal bit
    parameter   IDX_SCPU_TEST_MUX0 = 8;     // SCPU TEST MUX signal0
    parameter   IDX_SCPU_TEST_MUX1 = 9;     // SCPU TEST MUX signal1
    parameter   IDX_SCPU_TEST_MUX2 = 10;    // SCPU TEST MUX signal2
    parameter   IDX_SCPU_CLK_STOP  = 11;    // SCPU STOP the clock signal
    parameter   IDX_SCPU_CLK_CHG   = 12;    // SCPU CHANGE the clock frequency
    
    //// Status Word ////
    output  [31 : 0]            avs_cpustat_readdata;

    parameter   IDX_SCPU_CTRL_RDY  = 0;     // SCPU CTRL Module's ready signal
    parameter   IDX_SCPU_NXT_END   = 1;     // SCPU process finish
    parameter   IDX_SCPU_NXT_CONT  = 2;     // SCPU Instructions run over
    parameter   IDX_SCPU_APP_START = 3;     // External APP's start signal

    input   [31 : 0]            avs_cntsclk_writedata;// freq divider value
    input                       avs_cntsclk_write;
    reg     [CLK_WIDTH-1 : 0]   reg_cntsclk;
    reg     [CLK_WIDTH-1 : 0]   cntsclk;
    reg                         csi_split_clk, reg_clk_stop, reg_clk_chg;

    input   [31 : 0]            avs_sram_addr_wrt_writedata;// SRAM address value
    input                       avs_sram_addr_wrt_write;

    input   [31 : 0]            avs_sram_data_wrt_writedata;// Instruction data value
    input                       avs_sram_data_wrt_write;
    input   [31 : 0]            avs_adc_writedata;      // ADC data from analog
    input                       avs_adc_write;
    
    //// Internal Output Connections ////
    output  [31 : 0]            avs_sram_addr_rd_readdata; // Instruction addr value
    output  [31 : 0]            avs_sram_data_rd_readdata; // Instruction data value
    output	[31 : 0]			avs_scan_chain_readdata;// Scan chain data value
	
    //// External I/O Connections
    output                      coe_cpu_bgn_export;
    output                      coe_ctrl_bgn_export;
    output                      coe_ctrl_mod0_export;
    output                      coe_ctrl_mod1_export;
    output                      coe_ctrl_load_export;
    output                      coe_ctrl_si_export;
    output                      coe_cpu_wait_export;
    output  [ 9 : 0]            coe_adc_value_export;
    output                      coe_app_done_export;
    output                      coe_rst_n_export;
    output                      coe_clk_export;
    output                      coe_test_mux0_export;
    output                      coe_test_mux1_export;
    output                      coe_test_mux2_export;
    
    input                       coe_ctrl_so_export;
    input                       coe_ctrl_rdy_export;
    input                       coe_ctrl_nxt_end_export;
    input                       coe_ctrl_nxt_cont_export;
    input                       coe_app_start_export;
    input                       coe_anag_sclk1_export;
    input                       coe_anag_sclk2_export;
    input                       coe_anag_lat_export;
    input                       coe_anag_spi_so_export;
    
    // Registers and wires
    reg         reg_ctrl_bgn, reg_ctrl_bgn_dly, reg_load_dly;
    reg         reg_rst_n, reg_cpu_bgn_dly, reg_cpu_wait;
    reg         [1:0]   reg_cpu_bgn;
    reg         [1:0]   reg_LOAD;
    reg         [1:0]   reg_ctrl_mode;
    reg         [2:0]   reg_test_mux;
    reg         [CT_WIDTH-1:0]  reg_sram_addr;
    reg         [CT_WIDTH-1:0]  reg_sram_data;
    reg         [ADC_DATA_WIDTH-1:0]  reg_adc_value;
    reg         [1:0]   reg_APP_DONE;
    reg         reg_app_done_dly;
    reg         reg_app_done_keep;// keep the app done signal all the time
            
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
    assign  avs_cpustat_readdata[IDX_SCPU_NXT_END]  = coe_ctrl_nxt_end_export;
    assign  avs_cpustat_readdata[IDX_SCPU_NXT_CONT] = coe_ctrl_nxt_cont_export;
    assign  avs_cpustat_readdata[IDX_SCPU_APP_START]= coe_app_start_export;
    assign  avs_sram_addr_rd_readdata = {{(32-MEMORY_ADDR_WIDTH){1'b0}}, reg_sram_all[REG_BITS_WIDTH-1:MEMORY_DATA_WIDTH]};
    assign  avs_sram_data_rd_readdata = {{(32-MEMORY_DATA_WIDTH){1'b0}}, reg_sram_all[MEMORY_DATA_WIDTH-1:0]};
    
    assign  coe_cpu_bgn_export   = reg_cpu_bgn_dly;//reg_cpu_bgn
    assign  coe_ctrl_bgn_export  = reg_ctrl_bgn_dly;//reg_ctrl_bgn
    assign  coe_ctrl_load_export = is_LOAD;
    assign  coe_ctrl_si_export   = reg_sram_all[0];
    assign  coe_ctrl_mod1_export = (reg_ctrl_mode[0])?reg_ctrl_mode[1]:1'b0;
    assign  coe_ctrl_mod0_export = reg_ctrl_mode[0];
    assign  coe_rst_n_export     = reg_rst_n;
    assign  coe_clk_export       = (reg_clk_stop)?1'b0: 
                                    ((reg_clk_chg)?csi_split_clk:csi_clk);//need to adjust the frequency?
    assign  coe_cpu_wait_export  = reg_cpu_wait;
    assign  coe_adc_value_export = reg_adc_value;
    assign  coe_test_mux0_export = reg_test_mux[0];
    assign  coe_test_mux1_export = reg_test_mux[1];
    assign  coe_test_mux2_export = reg_test_mux[2];
    assign  coe_app_done_export  = reg_app_done_keep;//reg_app_done_dly;
    
	wire	SEL_B;//
	assign	SEL_B = 1'b0;
	reg		[MAX_SQRT_WIDTH-1:0]        FOUT;
	wire	[MAX_SQRT_WIDTH-1:0]        CFSA_FOUT;
	assign	SPI_SO_dly = coe_anag_spi_so_export;
	assign	LAT_dly = coe_anag_lat_export;
	assign	SCLK1_dly = coe_anag_sclk1_export;
	assign	SCLK2_dly = coe_anag_sclk2_export;
	
    //************* Need a scan chain module??? *************//
    SC_CELL_V3	CS208( .SIN(SPI_SO_dly), .SO(M0  ), .PO(CFSA_FOUT[12]), .PIN(FOUT[12]), .SEL(SEL_B), .LAT(LAT_dly), .SCK1(SCLK1_dly), .SCK2(SCLK2_dly), .BYP_N(1'b0) );
    SC_CELL_V3	CS209( .SIN(M0        ), .SO(M1  ), .PO(CFSA_FOUT[11]), .PIN(FOUT[11]), .SEL(SEL_B), .LAT(LAT_dly), .SCK1(SCLK1_dly), .SCK2(SCLK2_dly), .BYP_N(1'b0) );
    SC_CELL_V3	CS210( .SIN(M1        ), .SO(M2  ), .PO(CFSA_FOUT[10]), .PIN(FOUT[10]), .SEL(SEL_B), .LAT(LAT_dly), .SCK1(SCLK1_dly), .SCK2(SCLK2_dly), .BYP_N(1'b0) );
    SC_CELL_V3	CS211( .SIN(M2        ), .SO(M3  ), .PO(CFSA_FOUT[9 ]), .PIN(FOUT[9 ]), .SEL(SEL_B), .LAT(LAT_dly), .SCK1(SCLK1_dly), .SCK2(SCLK2_dly), .BYP_N(1'b0) );
    SC_CELL_V3	CS212( .SIN(M3        ), .SO(M4  ), .PO(CFSA_FOUT[8 ]), .PIN(FOUT[8 ]), .SEL(SEL_B), .LAT(LAT_dly), .SCK1(SCLK1_dly), .SCK2(SCLK2_dly), .BYP_N(1'b0) );
    SC_CELL_V3	CS213( .SIN(M4        ), .SO(M5  ), .PO(CFSA_FOUT[7 ]), .PIN(FOUT[7 ]), .SEL(SEL_B), .LAT(LAT_dly), .SCK1(SCLK1_dly), .SCK2(SCLK2_dly), .BYP_N(1'b0) );
    SC_CELL_V3	CS214( .SIN(M5        ), .SO(M6  ), .PO(CFSA_FOUT[6 ]), .PIN(FOUT[6 ]), .SEL(SEL_B), .LAT(LAT_dly), .SCK1(SCLK1_dly), .SCK2(SCLK2_dly), .BYP_N(1'b0) );
    SC_CELL_V3	CS215( .SIN(M6        ), .SO(M7  ), .PO(CFSA_FOUT[5 ]), .PIN(FOUT[5 ]), .SEL(SEL_B), .LAT(LAT_dly), .SCK1(SCLK1_dly), .SCK2(SCLK2_dly), .BYP_N(1'b0) );
    SC_CELL_V3	CS216( .SIN(M7        ), .SO(M8  ), .PO(CFSA_FOUT[4 ]), .PIN(FOUT[4 ]), .SEL(SEL_B), .LAT(LAT_dly), .SCK1(SCLK1_dly), .SCK2(SCLK2_dly), .BYP_N(1'b0) );
    SC_CELL_V3	CS217( .SIN(M8        ), .SO(M9  ), .PO(CFSA_FOUT[3 ]), .PIN(FOUT[3 ]), .SEL(SEL_B), .LAT(LAT_dly), .SCK1(SCLK1_dly), .SCK2(SCLK2_dly), .BYP_N(1'b0) );
    SC_CELL_V3	CS218( .SIN(M9        ), .SO(M10 ), .PO(CFSA_FOUT[2 ]), .PIN(FOUT[2 ]), .SEL(SEL_B), .LAT(LAT_dly), .SCK1(SCLK1_dly), .SCK2(SCLK2_dly), .BYP_N(1'b0) );
    SC_CELL_V3	CS219( .SIN(M10       ), .SO(M11 ), .PO(CFSA_FOUT[1 ]), .PIN(FOUT[1 ]), .SEL(SEL_B), .LAT(LAT_dly), .SCK1(SCLK1_dly), .SCK2(SCLK2_dly), .BYP_N(1'b0) );
    SC_CELL_V3	CS220( .SIN(M11       ), .SO(SO_B), .PO(CFSA_FOUT[0 ]), .PIN(FOUT[0 ]), .SEL(SEL_B), .LAT(LAT_dly), .SCK1(SCLK1_dly), .SCK2(SCLK2_dly), .BYP_N(1'b0) );

	assign	avs_scan_chain_readdata = {{(32-MAX_SQRT_WIDTH){1'b0}},CFSA_FOUT};
    
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
            reg_cpu_bgn_dly <= 1'b0;
        else
            reg_cpu_bgn_dly <= reg_cpu_bgn[0];
    end
    
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
    
    //************* make IDX_SCPU_CPU_BGN only works for one cycle *************//
    always @(posedge csi_clk)
    begin
        if ((~rsi_reset_n) | (~avs_cpuctrl_write))
        begin
            reg_cpu_bgn <= 2'b00;
        end else if (avs_cpuctrl_write &
                    avs_cpuctrl_writedata[IDX_SCPU_CPU_BGN] &
                    (reg_cpu_bgn == 2'b00))
        begin
            reg_cpu_bgn <= 2'b01;
        end else
        begin
            reg_cpu_bgn <= 2'b10;
        end
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
                cnt_bit_load <= REG_BITS_WIDTH;
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
            reg_clk_stop <= 1'b0;// clock control flag
            reg_clk_chg <= 1'b0;// split the frequency
            reg_ctrl_bgn  <= 1'b0;
            reg_ctrl_mode <= 2'b00;
            reg_rst_n <= 1'b0;
            reg_cpu_wait <= 1'b0;
            reg_test_mux <= 3'b000;
            reg_app_done_keep <= 1'b0;
            
            reg_sram_addr <= {CT_WIDTH{1'b0}};
            reg_sram_data <= {CT_WIDTH{1'b0}};
            reg_adc_value <= {ADC_DATA_WIDTH{1'b0}};
            reg_cntsclk <= DEFAULT_CNTSCLK;
        end else
        begin
            if (avs_cpuctrl_write)// Set registers if any value changes
            begin
                reg_clk_stop <= avs_cpuctrl_writedata[IDX_SCPU_CLK_STOP];
                reg_clk_chg <= avs_cpuctrl_writedata[IDX_SCPU_CLK_CHG];
                reg_ctrl_bgn <= avs_cpuctrl_writedata[IDX_SCPU_CTRL_BGN];
                reg_ctrl_mode <= {avs_cpuctrl_writedata[IDX_SCPU_CTRL_MOD1],
                                avs_cpuctrl_writedata[IDX_SCPU_CTRL_MOD0]};
                reg_rst_n <= avs_cpuctrl_writedata[IDX_SCPU_RST_N];
                reg_cpu_wait <= avs_cpuctrl_writedata[IDX_SCPU_CPU_WAIT];
                reg_test_mux <= {avs_cpuctrl_writedata[IDX_SCPU_TEST_MUX2],
                                avs_cpuctrl_writedata[IDX_SCPU_TEST_MUX1],
                                avs_cpuctrl_writedata[IDX_SCPU_TEST_MUX0]};
                reg_app_done_keep <= avs_cpuctrl_writedata[IDX_SCPU_APP_DONE];
            end
                
            if (avs_sram_addr_wrt_write)
                reg_sram_addr <= avs_sram_addr_wrt_writedata[CT_WIDTH-1:0];
                
            if (avs_sram_data_wrt_write)
                reg_sram_data <= avs_sram_data_wrt_writedata[CT_WIDTH-1:0];

            if (avs_adc_write)
                reg_adc_value <= avs_adc_writedata[ADC_DATA_WIDTH-1:0];
                
            if (avs_cntsclk_write)
                reg_cntsclk <= avs_cntsclk_writedata[CLK_WIDTH-1:0];
        end
    end
    
    always @(negedge csi_clk)
    begin
        if (~rsi_reset_n)
            reg_app_done_dly <= 1'b0;
        else
            reg_app_done_dly <= reg_APP_DONE[0];
    end
    
    //************* make IDX_SCPU_APP_DONE only works for one cycle *************//
    always @(posedge csi_clk)
    begin
        if ((~rsi_reset_n) | (~avs_cpuctrl_write))
        begin
            reg_APP_DONE <= 2'b00;
        end else if (avs_cpuctrl_write &
                    avs_cpuctrl_writedata[IDX_SCPU_APP_DONE] &
                    (reg_APP_DONE == 2'b00))
        begin
            reg_APP_DONE <= 2'b01;//is_LOAD = reg_APP_DONE[0];
        end else 
        begin
            reg_APP_DONE <= 2'b10;
        end
    end
    
    //************* make splited clock works *************//
    always @(posedge csi_clk)
    begin
        if (~rsi_reset_n)
        begin
            cntsclk <= 0;
            csi_split_clk <= 0;
        end
        else
        begin
            if (cntsclk == reg_cntsclk)
            begin
                cntsclk <= 0;
                csi_split_clk <= ~csi_split_clk;
            end else
            begin
                cntsclk <= cntsclk + 1;
                csi_split_clk <= csi_split_clk;
            end
        end
    end
    
endmodule
`endif//SRAM_IO_CTRL_LOGIC_V