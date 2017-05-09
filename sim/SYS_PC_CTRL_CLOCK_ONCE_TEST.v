//+FHDR****************************************************************
// ECE department, TAMU
// --------------------------------------------------------------------
// FILE NAME    : SYS_PC_CTRL_CLOCK_ONCE_TEST.v
// AUTHER       : Jiafan Wang
// DATE         : 05/09/2017
// VERSION      : 1.0
// PURPOSE      : the SCPU test with self-created SRAM (1024X8 SRAM)
// --------------------------------------------------------------------
// ABSTRACT: ModelSim simulation time 6us given each time period 10ns
// --------------------------------------------------------------------
`timescale 1ns / 1ps
`include    "../DEFINE_CPU.v"
`include    "../RA1SHD_IBM1024X8.v"
`include    "../SERIAL_CPU_8bit.v"
`include    "../SHARE_SUPERALU.v"
`include    "../SRAM_IO_CTRL.v"
`include    "../PSEUDO_SPI_INTF.v"
`include    "../SCPU_8BIT_ALU_CTRL_SPI.v"
`include    "../SCPU_SRAM_8BIT_ALU_SPI_TOP.v"
`include    "../SRAM_IO_CTRL_LOGIC.v"
`include    "../I_MEMORY_8bit.v"
`include    "../SC_CELL_V3.v"

module SYS_PC_CTRL_CLOCK_ONCE_TEST;
    parameter   MEMORY_DATA_WIDTH   = 8,
                MEMORY_ADDR_WIDTH   = 10,
                REG_BITS_WIDTH = MEMORY_ADDR_WIDTH + MEMORY_DATA_WIDTH;
    
    parameter   DEFAULT_PC_ADDR     = 16;
    parameter   CLK_PERIOD          = 20;
    
    integer i,j,k;
    integer error_cnt;
    reg     [15:0] tmpi_datain; //MEMORY_DATA_WIDTH*2 -1
    reg     [REG_BITS_WIDTH-1:0]  tmpi_all;//addr+instruction
    reg     [MEMORY_ADDR_WIDTH-1:0]  tmpi_adder;  //MEMORY_ADDR_WIDTH -1
    
    reg     CLK;
    reg     RST_N;
    reg     rsi_reset_n;
    reg     [1:0]  CTRL_MODE;
    reg     CTRL_BGN;
    reg     CPU_BGN;// enable signal for SERIAL_CPU_8bit
    reg     LOAD_N;
    reg     CTRL_SI;
    reg     CPU_WAIT;
    reg     [9:0] ADC_PI;
    wire    [9:0] ADC_PI_dly;
    reg     [2:0] TEST_MUX;
    wire    [2:0] TEST_MUX_dly;
    
    // Wires
    wire    CTRL_RDY;
    wire    APP_START;
    wire    CTRL_SO;
    wire    ANA_SO;
    wire    [1:0]  CPU_NXT;
    wire    SEL;
    wire    SCLK1;
    wire    SCLK2;
    wire    LAT;
    wire    CLRN;
    wire    CLK_ADC;
    wire    RSTN_ADC;
    wire    [1:0]   CTRL_MODE_dly;
    //wire    [1:0]   CPU_NXT_dly;
    
    SCPU_SRAM_8BIT_ALU_SPI_TOP  scpu_sram_alu(
        .CLK            (CSI_CLK_dly),
        .RST_N          (RST_N_dly  ),//RST_N_dly
        .CTRL_MODE      (CTRL_MODE_dly),
        .CTRL_BGN       (CTRL_BGN_dly),
        .CPU_BGN        (CPU_BGN_dly),//CPU_BGN_dly
        .LOAD_N         (LOAD_N_dly),
        .CTRL_SI        (CTRL_SI_dly),
        .APP_DONE       (APP_DONE_dly),//1'b0
        .ADC_PI         (ADC_PI_dly ),
        .TEST_MUX       (TEST_MUX_dly),
        .CPU_WAIT       (CPU_WAIT_dly),//CPU_WAIT_dly
        // output
        .CTRL_RDY       (CTRL_RDY),
        .APP_START      (APP_START  ),
        .CTRL_SO        (CTRL_SO    ),
        .NXT            (CPU_NXT    ),
        //.SEL            (SEL        ),
        .SCLK1          (SCLK1      ),
        .SCLK2          (SCLK2      ),
        .LAT            (LAT        ),
        .SPI_SO         (SPI_SO     )
    );
   
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
    parameter   IDX_SCPU_CLK_DISCRT= 13;    // SCPU switch between continous/discrete timer
    parameter   IDX_SCPU_CLK_1TIME = 14;    // SCPU give 1 clk cycle during IDX_SCPU_CLK_DISCRT
    
    parameter   IDX_SCPU_CTRL_RDY  = 0;
    parameter   IDX_SCPU_NXT_END   = 1;     // SCPU process finish
    parameter   IDX_SCPU_NXT_CONT  = 2;     // SCPU Instructions run over
    parameter   IDX_SCPU_APP_START = 3;     // External APP's start signal
    
    reg     avs_cpuctrl_write;
    reg     avs_sram_addr_wrt_write;
    reg     avs_sram_data_wrt_write;
    reg     avs_cntsclk_write;
    reg     avs_adc_write;

    reg     [31:0]  avs_cpuctrl_writedata;
    wire    [31:0]  avs_cpustat_readdata;
    reg     [31:0]  avs_sram_addr_wrt_writedata;
    reg     [31:0]  avs_sram_data_wrt_writedata;
    reg     [31:0]  avs_cntsclk_writedata;
    reg     [31:0]  avs_adc_writedata;

    wire    [31:0]  avs_sram_addr_rd_readdata;
    wire    [31:0]  avs_sram_data_rd_readdata;
    wire    [31:0]  avs_scan_chain_readdata;
    wire    [ 9:0]  coe_adc_value_export;
    
    assign  avs_cpustat_ctrl_rdy = avs_cpustat_readdata[IDX_SCPU_CTRL_RDY];
    assign  avs_cpustat_nxt_end  = avs_cpustat_readdata[IDX_SCPU_NXT_END];
    assign  avs_cpustat_nxt_cont = avs_cpustat_readdata[IDX_SCPU_NXT_CONT];
    assign  avs_cpustat_app_start= avs_cpustat_readdata[IDX_SCPU_APP_START];

    SRAM_IO_CTRL_LOGIC fpga(
        //input
        .csi_clk                (CLK                    ),                // Clock
        .rsi_reset_n            (rsi_reset_n            ),            // Reset (Active Low)

        //// Control Word ////  
        .avs_cpuctrl_writedata  (avs_cpuctrl_writedata  ),  // wsa control flag
        .avs_cpuctrl_write      (avs_cpuctrl_write      ),

        //// Status Word ////  
        .avs_cpustat_readdata   (avs_cpustat_readdata   ),

        .avs_cntsclk_writedata  (avs_cntsclk_writedata  ),
        .avs_cntsclk_write      (avs_cntsclk_write      ),
        
        .avs_sram_addr_wrt_writedata(avs_sram_addr_wrt_writedata),    // SRAM address value
        .avs_sram_addr_wrt_write    (avs_sram_addr_wrt_write    ),

        .avs_sram_data_wrt_writedata(avs_sram_data_wrt_writedata),    // Instruction data value
        .avs_sram_data_wrt_write    (avs_sram_data_wrt_write    ),
        .avs_adc_writedata      (avs_adc_writedata      ),          // ADC data from analog
        .avs_adc_write          (avs_adc_write          ),

        //// Internal Output Connections ////
        .avs_sram_addr_rd_readdata (avs_sram_addr_rd_readdata ),     // Instruction addr value
        .avs_sram_data_rd_readdata (avs_sram_data_rd_readdata ),     // Instruction data value
        .avs_scan_chain_readdata(avs_scan_chain_readdata),
        
        //// External I/O Connections (Output)
        .coe_cpu_bgn_export     (coe_cpu_bgn_export     ),
        .coe_ctrl_bgn_export    (coe_ctrl_bgn_export    ),
        .coe_ctrl_mod0_export   (coe_ctrl_mod0_export   ),
        .coe_ctrl_mod1_export   (coe_ctrl_mod1_export   ),
        .coe_ctrl_load_export   (coe_ctrl_load_export   ),
        .coe_ctrl_si_export     (coe_ctrl_si_export     ),
        .coe_cpu_wait_export    (coe_cpu_wait_export    ),
        .coe_adc_value_export   (coe_adc_value_export   ),
        .coe_app_done_export    (coe_app_done_export    ),
        .coe_rst_n_export       (coe_rst_n_export       ),
        .coe_clk_export         (coe_clk_export         ),
        .coe_test_mux0_export   (coe_test_mux0_export   ),
        .coe_test_mux1_export   (coe_test_mux1_export   ),
        .coe_test_mux2_export   (coe_test_mux2_export   ),
        
        //// External I/O Connections (Input)
        .coe_ctrl_rdy_export    (coe_ctrl_rdy_export    ),
        .coe_app_start_export   (coe_app_start_export   ),
        .coe_ctrl_so_export     (coe_ctrl_so_export     ),
        .coe_ctrl_nxt_end_export(coe_ctrl_nxt_end_export),
        .coe_ctrl_nxt_cont_export(coe_ctrl_nxt_cont_export),
        .coe_anag_sclk1_export  (coe_anag_sclk1_export  ),
        .coe_anag_sclk2_export  (coe_anag_sclk2_export  ),
        .coe_anag_lat_export    (coe_anag_lat_export    ),
        .coe_anag_spi_so_export (coe_anag_spi_so_export )
    );
    
    I_MEMORY_8BIT i_mem (
        // .clk(clk_dly),
        // .rst_n(rst_n), 
        // .addr(m_addr),
        // .d_we(d_we),// need a seperate control signal; or instruction set will be overwritten when d_we=1
        // .datain(m_datain),//i_instruct
        // .dataout(m_dataout)
    );

    parameter   VIRTUAL_DLY = 2;
    /// input to CPU chip
    assign  #VIRTUAL_DLY    CPU_WAIT_dly = coe_cpu_wait_export;
    assign  #VIRTUAL_DLY    ADC_PI_dly = coe_adc_value_export;//ADC_PI
    assign  #VIRTUAL_DLY    APP_DONE_dly = coe_app_done_export;
    assign  #VIRTUAL_DLY    TEST_MUX_dly = {coe_test_mux2_export,coe_test_mux1_export,coe_test_mux0_export};
    assign  #VIRTUAL_DLY    CTRL_MODE_dly = {coe_ctrl_mod1_export,coe_ctrl_mod0_export};
    assign  #VIRTUAL_DLY    CTRL_BGN_dly = coe_ctrl_bgn_export;
    assign  #VIRTUAL_DLY    LOAD_N_dly = !coe_ctrl_load_export;
    assign  #VIRTUAL_DLY    CTRL_SI_dly = coe_ctrl_si_export;
    assign  #VIRTUAL_DLY    CSI_CLK_dly = coe_clk_export;
    assign  #VIRTUAL_DLY    RST_N_dly = coe_rst_n_export;
    assign  #VIRTUAL_DLY    CPU_BGN_dly = coe_cpu_bgn_export;
    
    /// output from CPU chip
    assign  #VIRTUAL_DLY    coe_ctrl_so_export = CTRL_SO;
    assign  #VIRTUAL_DLY    coe_ctrl_rdy_export = CTRL_RDY;
    assign  #VIRTUAL_DLY    coe_app_start_export = APP_START;
    assign  #VIRTUAL_DLY    coe_ctrl_nxt_end_export = CPU_NXT[0];
    assign  #VIRTUAL_DLY    coe_ctrl_nxt_cont_export = CPU_NXT[1];
    assign  #VIRTUAL_DLY    coe_anag_sclk1_export = SCLK1;
    assign  #VIRTUAL_DLY    coe_anag_sclk2_export = SCLK2;
    assign  #VIRTUAL_DLY    coe_anag_lat_export = LAT;
    assign  #VIRTUAL_DLY    coe_anag_spi_so_export = SPI_SO;
    //assign  #VIRTUAL_DLY    CPU_NXT_dly = CPU_NXT;
   
    initial begin
        // Initialize Inputs Signals
        CLK = 0;
        RST_N = 0;
        rsi_reset_n = 0;
        CTRL_BGN = 0;
        CPU_BGN = 0;
        LOAD_N = 1;
        error_cnt = 0;
        CTRL_MODE = 2'b00;
        CPU_WAIT = 0;
        TEST_MUX = 3'b000;
        
        avs_cpuctrl_writedata   = 0;
        avs_sram_addr_wrt_writedata = 0;
        avs_sram_data_wrt_writedata = 0;
        
        avs_cpuctrl_write   = 1;
        avs_sram_addr_wrt_write = 1;
        avs_sram_data_wrt_write = 1;
        // Wait 100 ns for global RST_N to finish
        #(CLK_PERIOD*10);
        avs_cpuctrl_write = 0;
        avs_cpuctrl_writedata[IDX_SCPU_CLK_CHG] = 1'b1;
        avs_cntsclk_write = 1;
        avs_cntsclk_writedata = 9;//0: 1/2 freq; 1: 1/4 freq; 2: 1/6 freq; 3: 1/8 freq;
        //4: 1/10 freq; 5: 1/12 freq; 6: 1/14 freq; 7: 1/16 freq; 8: 1/18 freq; 9: 1/20 freq;
        
        // #(CLK_PERIOD) avs_cpuctrl_write = 0;
        // #(CLK_PERIOD) avs_cpuctrl_write = 1;
        // avs_cpuctrl_writedata[IDX_SCPU_CLK_DISCRT] = 1;
        
        // Add stimulus here
        $display("pc  :               id_ir                :reg_A :reg_B :reg_C\
            : da  :  dd  : w :  gr1  :  gr2  :  gr3   :zf :nf:cf");
        // $monitor("%3d : %b : %h : %h : %h : %h : %h : %b : %h : %h : %h : %b : %b : %b", 
            // uut.pc, uut.id_ir, uut.reg_A, uut.reg_B, uut.reg_C,
            // d_addr, d_dataout, d_we, uut.gr[1], uut.gr[2], uut.gr[3],
            // uut.zf, uut.nf, uut.cf);

        i = 0;
        tmpi_datain = {`JUMP, 3'b000, 4'b0001, 4'b0000};// Jump to certain address
        i_mem.I_RAM[ i] = tmpi_datain[7:0];  i = 1;
        i_mem.I_RAM[ i] = tmpi_datain[15:8]; i = 2;
        tmpi_datain = 16'h00AB;
        i_mem.I_RAM[ i] = tmpi_datain[7:0];  i = 3;
        i_mem.I_RAM[ i] = tmpi_datain[15:8]; i = 4;
        tmpi_datain = 16'h3C00;
        i_mem.I_RAM[ i] = tmpi_datain[7:0];  i = 5;
        i_mem.I_RAM[ i] = tmpi_datain[15:8]; i = 6;

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
        
        //Clear OUT_A & Set SPI starting address;
        tmpi_datain = {`SUB, `gr2, 1'b0, `gr2, 1'b0, `gr2};
        i_mem.I_RAM[ i] = tmpi_datain[7:0];  i = 13 + DEFAULT_PC_ADDR*2;
        i_mem.I_RAM[ i] = tmpi_datain[15:8]; i = 14 + DEFAULT_PC_ADDR*2;
        tmpi_datain = {`SET, `gr2, 4'b0000, 4'b0011};
        i_mem.I_RAM[ i] = tmpi_datain[7:0];  i = 15 + DEFAULT_PC_ADDR*2;
        i_mem.I_RAM[ i] = tmpi_datain[15:8]; i = 16 + DEFAULT_PC_ADDR*2;
        
        //Clear OUT_B & Set SPI send data length;
        tmpi_datain = {`SUB, `gr3, 1'b0, `gr3, 1'b0, `gr3};
        i_mem.I_RAM[ i] = tmpi_datain[7:0];  i = 17 + DEFAULT_PC_ADDR*2;
        i_mem.I_RAM[ i] = tmpi_datain[15:8]; i = 18 + DEFAULT_PC_ADDR*2;
        tmpi_datain = {`SET, `gr3, 4'b0000, 4'b0010};
        i_mem.I_RAM[ i] = tmpi_datain[7:0];  i = 19 + DEFAULT_PC_ADDR*2;
        i_mem.I_RAM[ i] = tmpi_datain[15:8]; i = 20 + DEFAULT_PC_ADDR*2;
       
        //set the control reg for SPI
        tmpi_datain = {`SET, `gr1, 3'b010, 3'b000, 2'b00};
        i_mem.I_RAM[ i] = tmpi_datain[7:0];  i = 21 + DEFAULT_PC_ADDR*2;
        i_mem.I_RAM[ i] = tmpi_datain[15:8]; i = 22 + DEFAULT_PC_ADDR*2;
        
        // CPU is supposed to finish the loop automatically
        
        //reset the control reg for SPI
        tmpi_datain = {`SET, `gr1, 3'b000, 3'b000, 2'b00};
        i_mem.I_RAM[ i] = tmpi_datain[7:0];  i = 23 + DEFAULT_PC_ADDR*2;
        i_mem.I_RAM[ i] = tmpi_datain[15:8]; i = 24 + DEFAULT_PC_ADDR*2;
        
        tmpi_datain = {`HALT, 11'b000_0000_0000};//due to the pipeline, we need to add many `NOP to the instruction set
        i_mem.I_RAM[ i] = tmpi_datain[7:0];  i = 25+ DEFAULT_PC_ADDR*2;
        i_mem.I_RAM[ i] = tmpi_datain[15:8]; i = 26+ DEFAULT_PC_ADDR*2;
        // i_mem.I_RAM[19] = {`NOP, 11'b000_0000_0000};
        // i_mem.I_RAM[20] = {`NOP, 11'b000_0000_0000};
        // i_mem.I_RAM[21] = {`NOP, 11'b000_0000_0000};
        
        #(CLK_PERIOD) RST_N = 0; rsi_reset_n = 0; CTRL_BGN = 1;
        #(CLK_PERIOD) RST_N = 1; rsi_reset_n = 1;
        #(CLK_PERIOD) avs_cpuctrl_write = 0;
        #(CLK_PERIOD) avs_cpuctrl_write = 1;
        avs_cpuctrl_writedata[IDX_SCPU_RST_N] = 1'b1;
        
        /* (1) Serially Input the address & Instruction to CTRL and then to SRAM */
//        for (i = 0; i<13+ DEFAULT_PC_ADDR; i=i) begin
//            for (k=2; k>=1; k=k-1) begin
//                /** (a) load data to SRAM_IO_CTRL from PC **/
//                // C code modify control word
//                #(CLK_PERIOD) CTRL_BGN = 1;
//                avs_cpuctrl_writedata[IDX_SCPU_CTRL_BGN] = 1'b1;
//                #(CLK_PERIOD) CTRL_MODE = 2'b00;
//                avs_cpuctrl_writedata[IDX_SCPU_CTRL_MOD1] = 1'b0;
//                avs_cpuctrl_writedata[IDX_SCPU_CTRL_MOD0] = 1'b0;
//
//                tmpi_adder = (i<<1)+k-1;
//                tmpi_all = {tmpi_adder, i_mem.I_RAM[tmpi_adder]};
//                avs_sram_addr_wrt_writedata = tmpi_adder;
//                avs_sram_data_wrt_writedata = i_mem.I_RAM[tmpi_adder];
//                // C code triger FPGA gen Load signal
//                avs_cpuctrl_write = 0;
//                #(CLK_PERIOD) avs_cpuctrl_write = 1;
//                avs_cpuctrl_writedata[IDX_SCPU_CTRL_LOAD] = 1'b1;
//                
//                // C code polling to do next
//                //polling_wait(CTRL_RDY);
//                begin: ctrl_module_load_ready
//                forever begin
//                    #(CLK_PERIOD);
//                    if (avs_cpustat_ctrl_rdy) begin
//                        disable ctrl_module_load_ready;
//                    end
//                end
//                end
//                
//                // C code modify control word
//                #(CLK_PERIOD) CTRL_BGN = 0;
//                avs_cpuctrl_writedata[IDX_SCPU_CTRL_BGN] = 0;
//                #(CLK_PERIOD) LOAD_N = 1;//this FPGA signal is related to CTRL_BGN
//                avs_cpuctrl_write = 0;
//                #(CLK_PERIOD) avs_cpuctrl_write = 1;
//                avs_cpuctrl_writedata[IDX_SCPU_CTRL_LOAD] = 0;
//                begin: ctrl_module_load_finish
//                forever begin
//                    #(CLK_PERIOD);
//                    if (!avs_cpustat_ctrl_rdy) begin
//                        disable ctrl_module_load_finish;
//                    end
//                end
//                end
//                
//                /** (b) notify SRAM_IO_CTRL to send data to SRAM **/
//                // C code modify control word
//                #(CLK_PERIOD) CTRL_BGN = 1;
//                avs_cpuctrl_writedata[IDX_SCPU_CTRL_BGN] = 1;
//                #(CLK_PERIOD) CTRL_MODE = 2'b11;
//                avs_cpuctrl_writedata[IDX_SCPU_CTRL_MOD1] = 1;
//                avs_cpuctrl_writedata[IDX_SCPU_CTRL_MOD0] = 1;
//                // C code triger FPGA gen Load signal
//                avs_cpuctrl_write = 0;
//                #(CLK_PERIOD) avs_cpuctrl_write = 1;
//                avs_cpuctrl_writedata[IDX_SCPU_CTRL_LOAD] = 1;
//
//                // C code polling to do next
//                //polling_wait(CTRL_RDY);
//                begin: ctrl_module_write_ready
//                forever begin
//                    #(CLK_PERIOD);
//                    if (avs_cpustat_ctrl_rdy) begin
//                        disable ctrl_module_write_ready;
//                    end
//                end
//                end
//                
//                // C code modify control word
//                #(CLK_PERIOD) CTRL_BGN = 0;
//                avs_cpuctrl_writedata[IDX_SCPU_CTRL_BGN] = 0;
//                #(CLK_PERIOD) LOAD_N = 1;//this FPGA signal is related to CTRL_BGN
//                avs_cpuctrl_write = 0;
//                #(CLK_PERIOD) avs_cpuctrl_write = 1;
//                avs_cpuctrl_writedata[IDX_SCPU_CTRL_LOAD] = 0;
//                begin: ctrl_module_write_finish
//                forever begin
//                    #(CLK_PERIOD);
//                    if (!avs_cpustat_ctrl_rdy) begin
//                        disable ctrl_module_write_finish;
//                    end
//                end
//                end
//            end
//            
//            if (i == 0)
//                i = DEFAULT_PC_ADDR;
//            else
//                i = i + 1;
//        end
//        #(CLK_PERIOD*150);
        
        
        /* (2) Loop out the instructions from SRAM */
//        for (i = DEFAULT_PC_ADDR; i<DEFAULT_PC_ADDR+1; i=i+1) begin
//            $write("%4x\t", (i<<1));
//            for (k=2; k>=1; k=k-1) begin
//                /** (a) load data to SRAM_IO_CTRL from PC **/
//                // C code modify control word
//                #(CLK_PERIOD) CTRL_BGN = 1;
//                avs_cpuctrl_writedata[IDX_SCPU_CTRL_BGN] = 1;
//                #(CLK_PERIOD) CTRL_MODE = 2'b00;
//                avs_cpuctrl_writedata[IDX_SCPU_CTRL_MOD1] = 0;
//                avs_cpuctrl_writedata[IDX_SCPU_CTRL_MOD0] = 0;
//
//                tmpi_adder = (i<<1)+k-1;
//                tmpi_all = {tmpi_adder, {MEMORY_DATA_WIDTH{1'b0}}};//i_mem.I_RAM[tmpi_adder]
//                avs_sram_addr_wrt_writedata = tmpi_adder;
//                avs_sram_data_wrt_writedata = {MEMORY_DATA_WIDTH{1'b1}};
//                // C code triger FPGA gen Load signal
//                avs_cpuctrl_write = 0;
//                #(CLK_PERIOD) avs_cpuctrl_write = 1;
//                avs_cpuctrl_writedata[IDX_SCPU_CTRL_LOAD] = 1;
//
//                // C code polling to do next
//                //polling_wait(CTRL_RDY);
//                begin: ctrl_module_load_ready_2nd
//                forever begin
//                    #(CLK_PERIOD);
//                    if (avs_cpustat_ctrl_rdy) begin
//                        disable ctrl_module_load_ready_2nd;
//                    end
//                end
//                end
//        
//                // C code modify control word
//                #(CLK_PERIOD) CTRL_BGN = 0;
//                avs_cpuctrl_writedata[IDX_SCPU_CTRL_BGN] = 0;
//                #(CLK_PERIOD) LOAD_N = 1;//this FPGA signal is related to CTRL_BGN
//                avs_cpuctrl_write = 0;
//                #(CLK_PERIOD) avs_cpuctrl_write = 1;
//                avs_cpuctrl_writedata[IDX_SCPU_CTRL_LOAD] = 0;
//                begin: ctrl_module_load_finish_2nd
//                forever begin
//                    #(CLK_PERIOD);
//                    if (!avs_cpustat_ctrl_rdy) begin
//                        disable ctrl_module_load_finish_2nd;
//                    end
//                end
//                end
//        
//                /** (b) notify SRAM_IO_CTRL to send data to SRAM **/
//                // C code modify control word
//                #(CLK_PERIOD) CTRL_BGN = 1;
//                avs_cpuctrl_writedata[IDX_SCPU_CTRL_BGN] = 1;
//                #(CLK_PERIOD) CTRL_MODE = 2'b01;
//                avs_cpuctrl_writedata[IDX_SCPU_CTRL_MOD1] = 0;
//                avs_cpuctrl_writedata[IDX_SCPU_CTRL_MOD0] = 1;
//                // C code triger FPGA gen Load signal
//                avs_cpuctrl_write = 0;
//                #(CLK_PERIOD) avs_cpuctrl_write = 1;
//                avs_cpuctrl_writedata[IDX_SCPU_CTRL_LOAD] = 1;
//
//                // C code polling to do next
//                //polling_wait(CTRL_RDY);
//                begin: ctrl_module_read_ready
//                forever begin
//                    #(CLK_PERIOD);
//                    if (avs_cpustat_ctrl_rdy) begin
//                        disable ctrl_module_read_ready;
//                    end
//                end
//                end
//
//                // C code modify control word
//                #(CLK_PERIOD) CTRL_BGN = 0;
//                avs_cpuctrl_writedata[IDX_SCPU_CTRL_BGN] = 0;
//                #(CLK_PERIOD) LOAD_N = 1;//this FPGA signal is related to CTRL_BGN
//                avs_cpuctrl_write = 0;
//                #(CLK_PERIOD) avs_cpuctrl_write = 1;
//                avs_cpuctrl_writedata[IDX_SCPU_CTRL_LOAD] = 0;
//                begin: ctrl_module_read_finish
//                forever begin
//                    #(CLK_PERIOD);
//                    if (!avs_cpustat_ctrl_rdy) begin
//                        disable ctrl_module_read_finish;
//                    end
//                end
//                end
//                
//                /** (c) Export SRAM data from SRAM_IO_CTRL **/
//                // C code modify control word
//                #(CLK_PERIOD) CTRL_BGN = 1;
//                avs_cpuctrl_writedata[IDX_SCPU_CTRL_BGN] = 1;
//                #(CLK_PERIOD) CTRL_MODE = 2'b00;
//                avs_cpuctrl_writedata[IDX_SCPU_CTRL_MOD1] = 1;
//                avs_cpuctrl_writedata[IDX_SCPU_CTRL_MOD0] = 0;
//                
//                tmpi_adder = {MEMORY_ADDR_WIDTH{1'b0}};
//                tmpi_all = {tmpi_adder, {MEMORY_DATA_WIDTH{1'b0}}};//i_mem.I_RAM[tmpi_adder]
//                avs_sram_addr_wrt_writedata = tmpi_adder;
//                avs_sram_data_wrt_writedata = {MEMORY_DATA_WIDTH{1'b0}};
//                // C code triger FPGA gen Load signal
//                avs_cpuctrl_write = 0;
//                #(CLK_PERIOD) avs_cpuctrl_write = 1;
//                avs_cpuctrl_writedata[IDX_SCPU_CTRL_LOAD] = 1;
//                
//                // C code polling to do next
//                begin: ctrl_module_load_ready_3nd
//                forever begin
//                    #(CLK_PERIOD);
//                    if (avs_cpustat_ctrl_rdy) begin
//                        disable ctrl_module_load_ready_3nd;
//                    end
//                end
//                end
//                
//                // C code modify control word
//                #(CLK_PERIOD) CTRL_BGN = 0;
//                avs_cpuctrl_writedata[IDX_SCPU_CTRL_BGN] = 0;
//                #(CLK_PERIOD) LOAD_N = 1;//this FPGA signal is related to CTRL_BGN
//                avs_cpuctrl_write = 0;
//                #(CLK_PERIOD) avs_cpuctrl_write = 1;
//                avs_cpuctrl_writedata[IDX_SCPU_CTRL_LOAD] = 0;
//                begin: ctrl_module_load_finish_3nd
//                forever begin
//                    #(CLK_PERIOD);
//                    if (!avs_cpustat_ctrl_rdy) begin
//                        disable ctrl_module_load_finish_3nd;
//                    end
//                end
//                end
//                
//                $write("%8b ", avs_sram_data_rd_readdata[MEMORY_DATA_WIDTH-1:0]);
//                if (k == 1)
//                    tmpi_datain[MEMORY_DATA_WIDTH-1:0] = avs_sram_data_rd_readdata[MEMORY_DATA_WIDTH-1:0];
//                else if (k == 2)
//                    tmpi_datain[2*MEMORY_DATA_WIDTH-1:MEMORY_DATA_WIDTH] = avs_sram_data_rd_readdata[MEMORY_DATA_WIDTH-1:0];
//            end
//            
//            if (i == DEFAULT_PC_ADDR) begin
//                if (tmpi_datain == {`SET, `gr3, 4'b0000, 4'b0100})
//                    $write("\t<--- Instruction SET gr3=4 Correct!");
//                else begin
//                    $write("\t<--- Instruction SET gr3=4 Wrong!");
//                    error_cnt = error_cnt + 1;
//                end
//            end
//            $display("");
//        end
        

        // (4) Loop IN/OUT Test start
        for (i = DEFAULT_PC_ADDR; i<DEFAULT_PC_ADDR+1; i=i+1) begin
            //$write("%4x\t", (i<<1));
            for (k=2; k>=1; k=k-1) begin
                /** (a) load data to SRAM_IO_CTRL from PC **/
                // C code modify control word
                #(CLK_PERIOD) CTRL_BGN = 1;
                avs_cpuctrl_writedata[IDX_SCPU_CTRL_BGN] = 1;
                #(CLK_PERIOD) CTRL_MODE = 2'b00;
                avs_cpuctrl_writedata[IDX_SCPU_CTRL_MOD1] = 0;
                avs_cpuctrl_writedata[IDX_SCPU_CTRL_MOD0] = 0;

                tmpi_adder = 10'd240;//(i<<1)+k-1;
                tmpi_all = {tmpi_adder, 8'd100};//{MEMORY_DATA_WIDTH{1'b0}}
                avs_sram_addr_wrt_writedata = tmpi_adder;
                avs_sram_data_wrt_writedata = 8'd100;//{MEMORY_DATA_WIDTH{1'b1}}
                // C code triger FPGA gen Load signal
                #(CLK_PERIOD) avs_cpuctrl_write = 0;
                #(CLK_PERIOD) avs_cpuctrl_write = 1;
                avs_cpuctrl_writedata[IDX_SCPU_CTRL_LOAD] = 1;

                // C code polling to do next
                //polling_wait(CTRL_RDY);
                begin: ctrl_module_load_ready_3rd
                forever begin
                    #(CLK_PERIOD);
                    if (avs_cpustat_ctrl_rdy) begin
                        disable ctrl_module_load_ready_3rd;
                    end
                end
                end
        
                // C code modify control word
                #(CLK_PERIOD) CTRL_BGN = 0;
                avs_cpuctrl_writedata[IDX_SCPU_CTRL_BGN] = 0;
                #(CLK_PERIOD) LOAD_N = 1;//this FPGA signal is related to CTRL_BGN
                #(CLK_PERIOD) avs_cpuctrl_write = 0;
                #(CLK_PERIOD) avs_cpuctrl_write = 1;
                avs_cpuctrl_writedata[IDX_SCPU_CTRL_LOAD] = 0;
                begin: ctrl_module_load_finish_3rd
                forever begin
                    #(CLK_PERIOD);
                    if (!avs_cpustat_ctrl_rdy) begin
                        disable ctrl_module_load_finish_3rd;
                    end
                end
                end
        
                $write("%10b ",avs_sram_addr_rd_readdata[MEMORY_ADDR_WIDTH-1:0]);
                $write("%8b ", avs_sram_data_rd_readdata[MEMORY_DATA_WIDTH-1:0]);
                $write("Loop k=%d\n", k);
                if (k == 1) begin
                    tmpi_datain[MEMORY_DATA_WIDTH-1:0] = avs_sram_data_rd_readdata[MEMORY_DATA_WIDTH-1:0];
                end
                else if (k == 2) begin
                    tmpi_datain[2*MEMORY_DATA_WIDTH-1:MEMORY_DATA_WIDTH] = avs_sram_data_rd_readdata[MEMORY_DATA_WIDTH-1:0];
                end
            end
            
            if (i == DEFAULT_PC_ADDR) begin
                if (tmpi_all == {avs_sram_addr_rd_readdata[MEMORY_ADDR_WIDTH-1:0], avs_sram_data_rd_readdata[MEMORY_DATA_WIDTH-1:0]})
                    $write("\t<--- Loop in/out Test Correct!");
                else begin
                    $write("\t<--- Loop in/out Test Wrong!");
                    error_cnt = error_cnt + 1;
                end
            end
            $display("");
        end
        
        // (5) Judge Final Test Result
        if (error_cnt) begin
            $display("Test Failed!");
        end
        // else if (avs_scan_chain_readdata[12:0] != 13'd10) begin
            // $display("Test Failed! data = 0x%.4x", avs_scan_chain_readdata[12:0]);
        // end
        else begin
            $display("Test Passed!");
        end
        #(CLK_PERIOD) $stop();
    end
    
    always #(CLK_PERIOD/2)
        CLK = ~CLK;
      
endmodule

