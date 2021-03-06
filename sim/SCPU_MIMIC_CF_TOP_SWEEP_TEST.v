//+FHDR****************************************************************
// ECE department, TAMU
// --------------------------------------------------------------------
// FILE NAME    : SCPU_MIMIC_CF_TOP_SWEEP_TEST.v
// AUTHER       : Jiafan Wang
// DATE         : 04/10/2017
// VERSION      : 1.0
// PURPOSE      : testbench for the cost function simulation
// --------------------------------------------------------------------
// ABSTRACT: loop-test simulation time 100ms given each time period 20ns
// --------------------------------------------------------------------

`timescale  1 ns / 100 ps

//`include    "../ibm13rfrvt_neg.v"       //IBM130 standard cells
//`include    "../iogpil_cmrf8sf_rvt.v"   //Pad cells
`include    "../DEFINE_CPU.v"
`include    "../RA1SHD_IBM1024X8.v"
`include    "../SERIAL_CPU_8bit.v"
`include    "../SHARE_SUPERALU.v"
`include    "../SRAM_IO_CTRL.v"
`include    "../PSEUDO_SPI_INTF.v"
`include    "../SCPU_8BIT_ALU_CTRL_SPI.v"
`include    "../SCPU_SRAM_8BIT_ALU_SPI_TOP.v"
`include    "../SRAM_IO_CTRL_LOGIC.v"
`include    "../SC_CELL_V3.v"

`include    "../I_MEMORY_CF_TASK_8BIT.v"

module MIMIC_ADC_VAL(
    app_start,
    rst_n,
    clk,
    app_done,
    adc_value
    );
    
    parameter   ADC_DATA_WIDTH      = 10,
                TUNE_BIT_WIDTH      = 5;
                
    parameter   ADC_IODATA_NUM      = 16;
    
    input   app_start;
    input   clk;
    input   rst_n;
    output  reg [ADC_DATA_WIDTH-1:0]    adc_value;
    output  reg app_done;
    reg     [ADC_DATA_WIDTH-1:0]    mem_adc[0: ADC_IODATA_NUM*(1 << (TUNE_BIT_WIDTH*2)) - 1];
    reg     [1:0]   reg_app_start_cnt;
    reg     [1:0]   reg_app_done_cnt;
    reg     app_done_flag;
    reg     [3:0]   data_cnt;

    initial begin
    //$readmemb("CF4D15M_4MZdata.txt", mem_adc);
    //$readmemb("CF4D20M_8MZdata.txt", mem_adc);
    //$readmemb("CF4D10M_2MZdata.txt", mem_adc);

    //$readmemb("sim/parse_data2.txt", mem_adc);
    //$readmemb("sim/case3_7_4_binary.txt", mem_adc);
    //$readmemb("sim/case3_7_7_binary.txt", mem_adc);
    
    // files for temperature tests
    //$readmemb("sim/sweep_67_74_80_25C_516off.bin",mem_adc);
    //$readmemb("sim/sweep_67_74_80_40C_517off.bin",mem_adc);
    //$readmemb("sim/sweep_67_74_80_55C_517off.bin",mem_adc);
    //$readmemb("sim/sweep_67_74_80_70C_517off.bin",mem_adc);
    //$readmemb("sim/79_89_102_swpxy.bin",mem_adc);
    //$readmemb("79_89_102_swpxy.bin", mem_adc);

    // files for functional tests
    $readmemb("mscript/sweep_67_74_80_25C_516off.bin", mem_adc);
    //$readmemb("sim/BPF_31M_F2.txt", mem_adc);
    //$readmemb("sim/BPF_31M_F1.txt", mem_adc);
    end

    parameter   MAX_DATA_NUM = 12;
    
    assign  app_start_local_once = reg_app_start_cnt[0];
    assign  app_done_once = reg_app_done_cnt[0];
    
    // generate one cycle start signal to prevent data_cnt change continuously
    always @(posedge clk) begin
        if ((~rst_n) | (~app_start)) begin
            reg_app_start_cnt <= 2'b00;
        end
        else if (app_start & (reg_app_start_cnt == 2'b00)) begin
            reg_app_start_cnt <= 2'b01;
        end
        else begin
            reg_app_start_cnt <= 2'b10;
        end
    end
    // release the done signal later and keep the signal
    always @(posedge clk) begin
        if ((~rst_n) | (~app_done_flag)) begin
            reg_app_done_cnt <= 0;
        end
        else if (app_done_flag) begin
            reg_app_done_cnt <= 2'b10;
        end
        else if (reg_app_done_cnt != 2'b01) begin
            reg_app_done_cnt <= reg_app_done_cnt -1;
        end
    end
    
    // the mem_adc and flag signal
    always @(posedge clk)
    begin
        if (~rst_n) begin
            data_cnt <= 4'd0000;
            app_done_flag <= 1'b0;
            adc_value <= {ADC_DATA_WIDTH{1'b1}};
        end
        else if (data_cnt != MAX_DATA_NUM & app_start_local_once) begin
            adc_value <= mem_adc[data_cnt];
            data_cnt <= data_cnt + 1;
            app_done_flag <= 1'b1;
        end
        else if (~app_start_local_once) begin
            data_cnt <= data_cnt;
            app_done_flag <= 1'b0;
            adc_value <= adc_value;
        end
    end
    
    //assign adc_value = mem_adc[X1*(1<<(3*`VAR_WIDTH)) + X2*(1<<(2*`VAR_WIDTH)) + X3*(1<<`VAR_WIDTH) + X4];
    //assign adc_value = mem_adc[TUNE_X2*(1 << TUNE_BIT_WIDTH) + TUNE_X1];
    //assign adc_value = mem_adc[TUNE_X2*(1 << TUNE_BIT_WIDTH) + TUNE_X1];
endmodule


module  SCPU_MIMIC_CF_TOP_SWEEP_TEST();
    parameter   MEMORY_DATA_WIDTH   = 8,
                MEMORY_ADDR_WIDTH   = 10,
                REG_BITS_WIDTH = MEMORY_ADDR_WIDTH + MEMORY_DATA_WIDTH;
    
    parameter   DEFAULT_PC_ADDR     = 30;//reserve for parameters
    parameter   CLK_PERIOD          = 20;
    parameter   MAX_SQRT_WIDTH      = 13;
    
    integer i,j,k,p,q,adc_addr;
    integer error_cnt;
    reg     [15:0] tmpi_datain; //MEMORY_DATA_WIDTH*2 -1
    reg     [REG_BITS_WIDTH-1:0]  tmpi_all;//addr+instruction
    reg     [9:0]  tmpi_adder;  //MEMORY_ADDR_WIDTH -1
    wire    [7:0]  tmp_mem_data;//MEMORY_DATA_WIDTH-1
    
   //Set the connecting wire
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
    wire    [1:0]   CPU_NXT;
    wire    SEL;
    wire    SCLK1;
    wire    SCLK2;
    wire    LAT;
    wire    CLRN;
    wire    CLK_ADC;
    wire    RSTN_ADC;
    wire    [1:0]   CTRL_MODE_dly;
    //wire    [4:0]   TUNE_X1, TUNE_X2;

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

    parameter   IDX_SCPU_CTRL_RDY  = 0,
                IDX_SCPU_NXT_END   = 1,
                IDX_SCPU_NXT_CONT  = 2,
                IDX_SCPU_APP_START = 3;
    
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
   
    wire    SEL_B;
    assign  SEL_B   = 1'b0;
    
    reg     [MAX_SQRT_WIDTH-1:0]    FOUT;
    wire    [MAX_SQRT_WIDTH-1:0]    CFSA_FOUT;
    assign  TUNE_X1 = CFSA_FOUT[12:8];
    assign  TUNE_X2 = CFSA_FOUT[ 7:3];
    
    // Scan chain 1: length 14
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

    
    parameter   VIRTUAL_DLY = 2;//0;//
    /// input to CPU chip
    assign  #VIRTUAL_DLY    CPU_WAIT_dly = coe_cpu_wait_export;
    assign  #VIRTUAL_DLY    ADC_PI_dly = coe_adc_value_export;//ADC_PI
    assign  #VIRTUAL_DLY    APP_DONE_dly = coe_app_done_export;
    assign  #VIRTUAL_DLY    TEST_MUX_dly = {coe_test_mux2_export,coe_test_mux1_export,coe_test_mux0_export};
    assign  #VIRTUAL_DLY    CTRL_MODE_dly = {coe_ctrl_mod1_export,coe_ctrl_mod0_export};
    assign  #VIRTUAL_DLY    CTRL_BGN_dly = coe_ctrl_bgn_export;
    assign  #VIRTUAL_DLY    LOAD_N_dly = coe_ctrl_load_export;
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
    
    //store ADC value for cost function
    MIMIC_ADC_VAL   ADC01(
        // .app_start(coe_app_start_export),
        // .rst_n(RST_N),
        // .clk(CLK),
        // .app_done(coe_app_done_export),
        // .adc_value(coe_adc_value_export)
    );

    //Store the instructions for CF
    I_MEMORY_CF_TASK_8BIT   i_mem(
        .addr(tmpi_adder),
        .mem_cf(tmp_mem_data)
    );
    
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
        avs_adc_writedata = 0;
        
        avs_cpuctrl_write   = 1;
        avs_sram_addr_wrt_write = 1;
        avs_sram_data_wrt_write = 1;
        avs_adc_write = 1;

        #(CLK_PERIOD) RST_N = 0; rsi_reset_n = 0;
        #(CLK_PERIOD*10) avs_cpuctrl_write = 1;
        avs_cpuctrl_writedata[IDX_SCPU_RST_N] = 1'b0;
        #(CLK_PERIOD*10) avs_cpuctrl_write = 0;
        #(CLK_PERIOD) RST_N = 1; rsi_reset_n = 1;
        #(CLK_PERIOD*10) avs_cpuctrl_write = 1;
        //avs_cpuctrl_writedata[IDX_SCPU_RST_N] = 1'b1;
        #(CLK_PERIOD*10) avs_cpuctrl_write = 0;
        
        // Change clock freq
        #(CLK_PERIOD*10) avs_cntsclk_write = 1;
        avs_cntsclk_writedata = 1;//0: 1/2 freq; 1: 1/4 freq; 2: 1/6 freq; 3: 1/8 freq;
        //4: 1/10 freq; 5: 1/12 freq; 6: 1/14 freq; 7: 1/16 freq; 8: 1/18 freq; 9: 1/20 freq;
        #(CLK_PERIOD*10) avs_cntsclk_write = 0;

        #(CLK_PERIOD*10) avs_cpuctrl_write = 1;
        avs_cpuctrl_writedata[IDX_SCPU_CLK_CHG] = 1'b1;
        #(CLK_PERIOD*10) avs_cpuctrl_write = 0;
                
        #(CLK_PERIOD*10) avs_cpuctrl_write = 1;
        avs_cpuctrl_writedata[IDX_SCPU_CLK_DISCRT] = 1'b1;
        #(CLK_PERIOD*10) avs_cpuctrl_write = 0;

        /* (1) Serially Input the address & Instruction to CTRL and then to SRAM */
        //initialize one cycle
        #(CLK_PERIOD*10) avs_cpuctrl_write = 1;
        avs_cpuctrl_writedata[IDX_SCPU_CLK_1TIME] = 1'b1;
        #(CLK_PERIOD*10) avs_cpuctrl_write = 0;
        #(CLK_PERIOD*avs_cntsclk_writedata*5);// wait enough time
        
        #(CLK_PERIOD*10) avs_cpuctrl_write = 1;
        avs_cpuctrl_writedata[IDX_SCPU_CLK_1TIME] = 1'b0;
        #(CLK_PERIOD*10) avs_cpuctrl_write = 0;
        #(CLK_PERIOD*avs_cntsclk_writedata*5);// wait enough time
        
        // (2) write data to SRAM: <(bin_line-1)+DEFAULT_PC_ADDR
        for (i = 0; i<72+ DEFAULT_PC_ADDR; i=i) begin
            for (k=2; k>=1; k=k-1) begin
                /** (a) load data to SRAM_IO_CTRL from PC **/
                // C code modify control word
                #(CLK_PERIOD) CTRL_BGN = 1;
                avs_cpuctrl_writedata[IDX_SCPU_CTRL_BGN] = 1'b1;
                #(CLK_PERIOD) CTRL_MODE = 2'b00;
                avs_cpuctrl_writedata[IDX_SCPU_CTRL_MOD1] = 1'b0;
                avs_cpuctrl_writedata[IDX_SCPU_CTRL_MOD0] = 1'b0;

                tmpi_adder = (i<<1)+k-1;
                tmpi_all = {tmpi_adder, i_mem.mem_out[tmpi_adder]};//tmp_mem_data
                avs_sram_addr_wrt_writedata = tmpi_adder;
                avs_sram_data_wrt_writedata = i_mem.mem_out[tmpi_adder];//tmp_mem_data
                // C code triger FPGA gen Load signal
                #(CLK_PERIOD*10) avs_cpuctrl_write = 1;
                avs_cpuctrl_writedata[IDX_SCPU_CTRL_LOAD] = 1;
                #(CLK_PERIOD*10) avs_cpuctrl_write = 0;
                
                // sleep 10 cycles to mimic the polling process
                // invoke several clock cycles; p is changed by ModelSim
                p = 23;// minium 21 is OK for simulation
                for (j=0; j<p; j=j+1) begin
                    #(CLK_PERIOD) avs_cpuctrl_write = 1;
                    avs_cpuctrl_writedata[IDX_SCPU_CLK_1TIME] = 1'b1;
                    #(CLK_PERIOD) avs_cpuctrl_write = 0;
                    #(CLK_PERIOD*avs_cntsclk_writedata*5);// wait enough time
                    #(CLK_PERIOD) avs_cpuctrl_write = 1;
                    avs_cpuctrl_writedata[IDX_SCPU_CLK_1TIME] = 1'b0;
                    #(CLK_PERIOD) avs_cpuctrl_write = 0;
                    #(CLK_PERIOD*avs_cntsclk_writedata*5);// wait enough time
                end
                
                // C code polling to do next
                //polling_wait(CTRL_RDY);
                begin: ctrl_module_load_ready
                forever begin
                    #(CLK_PERIOD);
                    if (avs_cpustat_ctrl_rdy) begin
                        disable ctrl_module_load_ready;
                    end
                end
                end
                
                // C code modify control word
                #(CLK_PERIOD) CTRL_BGN = 0;
                #(CLK_PERIOD*10) avs_cpuctrl_write = 1;
                avs_cpuctrl_writedata[IDX_SCPU_CTRL_BGN] = 0;
                #(CLK_PERIOD*10) avs_cpuctrl_write = 0;
                #(CLK_PERIOD) LOAD_N = 1;//this FPGA signal is related to CTRL_BGN
                #(CLK_PERIOD*10) avs_cpuctrl_write = 1;
                avs_cpuctrl_writedata[IDX_SCPU_CTRL_LOAD] = 0;
                #(CLK_PERIOD*10) avs_cpuctrl_write = 0;

                p = 4;// minium 2 is OK for simulation
                for (j=0; j<p; j=j+1) begin
                    #(CLK_PERIOD) avs_cpuctrl_write = 1;
                    avs_cpuctrl_writedata[IDX_SCPU_CLK_1TIME] = 1'b1;
                    #(CLK_PERIOD) avs_cpuctrl_write = 0;
                    #(CLK_PERIOD*avs_cntsclk_writedata*5);// wait enough time
                    #(CLK_PERIOD) avs_cpuctrl_write = 1;
                    avs_cpuctrl_writedata[IDX_SCPU_CLK_1TIME] = 1'b0;
                    #(CLK_PERIOD) avs_cpuctrl_write = 0;
                    #(CLK_PERIOD*avs_cntsclk_writedata*5);// wait enough time
                end
                
                begin: ctrl_module_load_finish
                forever begin
                    #(CLK_PERIOD);
                    if (!avs_cpustat_ctrl_rdy) begin
                        disable ctrl_module_load_finish;
                    end
                end
                end
                
                /** (b) notify SRAM_IO_CTRL to send data to SRAM **/
                // C code modify control word
                #(CLK_PERIOD) CTRL_BGN = 1;
                avs_cpuctrl_writedata[IDX_SCPU_CTRL_BGN] = 1;
                #(CLK_PERIOD) CTRL_MODE = 2'b11;
                avs_cpuctrl_writedata[IDX_SCPU_CTRL_MOD1] = 1;
                avs_cpuctrl_writedata[IDX_SCPU_CTRL_MOD0] = 1;
                // C code triger FPGA gen Load signal
                #(CLK_PERIOD*10) avs_cpuctrl_write = 1;
                avs_cpuctrl_writedata[IDX_SCPU_CTRL_LOAD] = 1;
                #(CLK_PERIOD*10) avs_cpuctrl_write = 0;

                p = 4;// waiting for the write ready
                for (j=0; j<p; j=j+1) begin
                    #(CLK_PERIOD) avs_cpuctrl_write = 1;
                    avs_cpuctrl_writedata[IDX_SCPU_CLK_1TIME] = 1'b1;
                    #(CLK_PERIOD) avs_cpuctrl_write = 0;
                    #(CLK_PERIOD*avs_cntsclk_writedata*5);// wait enough time
                    #(CLK_PERIOD) avs_cpuctrl_write = 1;
                    avs_cpuctrl_writedata[IDX_SCPU_CLK_1TIME] = 1'b0;
                    #(CLK_PERIOD) avs_cpuctrl_write = 0;
                    #(CLK_PERIOD*avs_cntsclk_writedata*5);// wait enough time
                end
                
                // C code polling to do next
                //polling_wait(CTRL_RDY);
                begin: ctrl_module_write_ready
                forever begin
                    #(CLK_PERIOD);
                    if (avs_cpustat_ctrl_rdy) begin
                        disable ctrl_module_write_ready;
                    end
                end
                end
                
                // C code modify control word
                #(CLK_PERIOD) CTRL_BGN = 0;
                #(CLK_PERIOD*10) avs_cpuctrl_write = 1;
                avs_cpuctrl_writedata[IDX_SCPU_CTRL_BGN] = 0;
                #(CLK_PERIOD*10) avs_cpuctrl_write = 0;
                #(CLK_PERIOD) LOAD_N = 1;//this FPGA signal is related to CTRL_BGN
                #(CLK_PERIOD*10) avs_cpuctrl_write = 1;
                avs_cpuctrl_writedata[IDX_SCPU_CTRL_LOAD] = 0;
                #(CLK_PERIOD*10) avs_cpuctrl_write = 0;        
                
                p = 4;// waiting for the write ready
                for (j=0; j<p; j=j+1) begin
                    #(CLK_PERIOD) avs_cpuctrl_write = 1;
                    avs_cpuctrl_writedata[IDX_SCPU_CLK_1TIME] = 1'b1;
                    #(CLK_PERIOD) avs_cpuctrl_write = 0;
                    #(CLK_PERIOD*avs_cntsclk_writedata*5);// wait enough time
                    #(CLK_PERIOD) avs_cpuctrl_write = 1;
                    avs_cpuctrl_writedata[IDX_SCPU_CLK_1TIME] = 1'b0;
                    #(CLK_PERIOD) avs_cpuctrl_write = 0;
                    #(CLK_PERIOD*avs_cntsclk_writedata*5);// wait enough time
                end
                
                begin: ctrl_module_write_finish
                forever begin
                    #(CLK_PERIOD);
                    if (!avs_cpustat_ctrl_rdy) begin
                        disable ctrl_module_write_finish;
                    end
                end
                end
            end
            
            if (i == 0)
                i = DEFAULT_PC_ADDR;
            else
                i = i + 1;
        end
        #(CLK_PERIOD*150);//1500;
        
        for (q=0; q<1024; q=q+1) begin
            // (3) Activate CPU & input 1024x16 ADC data
            #(CLK_PERIOD*10) avs_cpuctrl_write = 1;
            avs_cpuctrl_writedata[IDX_SCPU_CLK_DISCRT] = 1'b0;
            #(CLK_PERIOD*10) avs_cpuctrl_write = 0;
            
            // 50MHz clock frequency
            #(CLK_PERIOD*10) avs_cpuctrl_write = 1;
            avs_cpuctrl_writedata[IDX_SCPU_CLK_CHG] = 1'b0;
            #(CLK_PERIOD*10) avs_cpuctrl_write = 0;
            
            #(CLK_PERIOD*10) avs_cpuctrl_write = 1;
            avs_cpuctrl_writedata[IDX_SCPU_RST_N] = 1'b1;
            #(CLK_PERIOD*10) avs_cpuctrl_write = 0;

            #(CLK_PERIOD*10) avs_cpuctrl_write = 1;
            avs_cpuctrl_writedata[IDX_SCPU_CTRL_BGN] = 1'b0;
            #(CLK_PERIOD*10) avs_cpuctrl_write = 0;
            
            #(CLK_PERIOD*10) avs_cpuctrl_write = 1;
            avs_cpuctrl_writedata[IDX_SCPU_CPU_BGN] = 1'b1;
            /// need to wait enough time and then turn off the signal
            #(CLK_PERIOD*avs_cntsclk_writedata*2) avs_cpuctrl_write = 0;
            
            #(CLK_PERIOD*10) avs_cpuctrl_write = 1;
            avs_cpuctrl_writedata[IDX_SCPU_CPU_BGN] = 1'b0;
            #(CLK_PERIOD*10) avs_cpuctrl_write = 0;

            j = q;//for (j=0; j<1; j=j+1) begin//1024
                for (k=0; k <16; k=k+1) begin
                    adc_addr = 0;
                    adc_addr = (j<<4)+k;
                    ADC_PI = ADC01.mem_adc[adc_addr];
                    // if (j==0)
                        // ADC_PI = 10'd537;//1st ADC data
                    // else
                        // ADC_PI = 10'd492;//2nd ADC data
                    
                    //polling_wait(APP_START);
                    begin : wait_app_start_loop_1st
                        forever begin
                            #(CLK_PERIOD);
                            if (avs_cpustat_app_start) begin //CPU_NXT_dly[0]
                                disable wait_app_start_loop_1st;
                            end
                        end
                    end
                    
                    #(CLK_PERIOD*10) avs_adc_write = 1;
                    avs_adc_writedata = ADC_PI;
                    #(CLK_PERIOD*10) avs_adc_write = 0;
                    
                    #(CLK_PERIOD*10) avs_cpuctrl_write = 1;
                    avs_cpuctrl_writedata[IDX_SCPU_APP_DONE] = 1'b1;
                    #(CLK_PERIOD*10) avs_cpuctrl_write = 0;
                    
                    //polling_wait (APP_START) DONE;
                    begin : wait_app_start_done_1st
                        forever begin
                            #(CLK_PERIOD);
                            if (!avs_cpustat_app_start) begin //CPU_NXT_dly[0]
                                disable wait_app_start_done_1st;
                            end
                        end
                    end
                    
                    //wait enough time to reset APP_DONE
                    //#(CLK_PERIOD*avs_cntsclk_writedata*10);
                    #(CLK_PERIOD*10) avs_cpuctrl_write = 1;
                    avs_cpuctrl_writedata[IDX_SCPU_APP_DONE] = 1'b0;
                    #(CLK_PERIOD*10) avs_cpuctrl_write = 0;
                end
            //end
            
            //polling_wait(NXT[0]);
            begin: cpu_process_loop
                forever begin
                    #(CLK_PERIOD);
                    if (avs_cpustat_nxt_end) begin
                        //$display("CPU instructions finish!");
                        disable cpu_process_loop;
                    end
                end
            end
            
            // (4) Read out data from SRAM
            #(CLK_PERIOD*10) avs_cpuctrl_write = 1;
            avs_cpuctrl_writedata[IDX_SCPU_RST_N] = 1'b0;
            #(CLK_PERIOD*10) avs_cpuctrl_write = 0;

            #(CLK_PERIOD*10) avs_cpuctrl_write = 1;
            avs_cpuctrl_writedata[IDX_SCPU_CLK_DISCRT] = 1'b1;
            #(CLK_PERIOD*10) avs_cpuctrl_write = 0;
            
            for (i = 5; i<6; i=i+1) begin//DEFAULT_PC_ADDR
                //$write("%4x\t", (i<<1));
                for (k=2; k>=1; k=k-1) begin
                    /** (a) load data to SRAM_IO_CTRL from PC **/
                    // C code modify control word
                    #(CLK_PERIOD) CTRL_BGN = 1;
                    avs_cpuctrl_writedata[IDX_SCPU_CTRL_BGN] = 1;
                    #(CLK_PERIOD) CTRL_MODE = 2'b00;
                    avs_cpuctrl_writedata[IDX_SCPU_CTRL_MOD1] = 0;
                    avs_cpuctrl_writedata[IDX_SCPU_CTRL_MOD0] = 0;

                    tmpi_adder = (i<<1)+k-1;//10'd240;//
                    tmpi_all = {tmpi_adder, 8'd100};//{MEMORY_DATA_WIDTH{1'b0}}
                    avs_sram_addr_wrt_writedata = tmpi_adder;
                    avs_sram_data_wrt_writedata = 8'd255;//{MEMORY_DATA_WIDTH{1'b1}}
                    // C code triger FPGA gen Load signal
                    #(CLK_PERIOD*10) avs_cpuctrl_write = 1;
                    avs_cpuctrl_writedata[IDX_SCPU_CTRL_LOAD] = 1;
                    #(CLK_PERIOD*10) avs_cpuctrl_write = 0;

                    // sleep 10 cycles to mimic the polling process
                    // invoke several clock cycles; p is changed by ModelSim
                    p = 23;// minium 21 is OK for simulation
                    for (j=0; j<p; j=j+1) begin
                        #(CLK_PERIOD) avs_cpuctrl_write = 1;
                        avs_cpuctrl_writedata[IDX_SCPU_CLK_1TIME] = 1'b1;
                        #(CLK_PERIOD) avs_cpuctrl_write = 0;
                        #(CLK_PERIOD*avs_cntsclk_writedata*5);// wait enough time
                        #(CLK_PERIOD) avs_cpuctrl_write = 1;
                        avs_cpuctrl_writedata[IDX_SCPU_CLK_1TIME] = 1'b0;
                        #(CLK_PERIOD) avs_cpuctrl_write = 0;
                        #(CLK_PERIOD*avs_cntsclk_writedata*5);// wait enough time
                    end

                    // C code polling to do next
                    //polling_wait(CTRL_RDY);
                    begin: ctrl_module_load_ready_4th
                    forever begin
                        #(CLK_PERIOD);
                        if (avs_cpustat_ctrl_rdy) begin
                            disable ctrl_module_load_ready_4th;
                        end
                    end
                    end
                    
                    // C code modify control word
                    #(CLK_PERIOD) CTRL_BGN = 0;
                    #(CLK_PERIOD*10) avs_cpuctrl_write = 1;
                    avs_cpuctrl_writedata[IDX_SCPU_CTRL_BGN] = 0;
                    #(CLK_PERIOD*10) avs_cpuctrl_write = 0;
                    #(CLK_PERIOD) LOAD_N = 1;//this FPGA signal is related to CTRL_BGN
                    #(CLK_PERIOD*10) avs_cpuctrl_write = 1;
                    avs_cpuctrl_writedata[IDX_SCPU_CTRL_LOAD] = 0;
                    #(CLK_PERIOD*10) avs_cpuctrl_write = 0;

                    p = 4;// minium 2 is OK for simulation
                    for (j=0; j<p; j=j+1) begin
                        #(CLK_PERIOD) avs_cpuctrl_write = 1;
                        avs_cpuctrl_writedata[IDX_SCPU_CLK_1TIME] = 1'b1;
                        #(CLK_PERIOD) avs_cpuctrl_write = 0;
                        #(CLK_PERIOD*avs_cntsclk_writedata*5);// wait enough time
                        #(CLK_PERIOD) avs_cpuctrl_write = 1;
                        avs_cpuctrl_writedata[IDX_SCPU_CLK_1TIME] = 1'b0;
                        #(CLK_PERIOD) avs_cpuctrl_write = 0;
                        #(CLK_PERIOD*avs_cntsclk_writedata*5);// wait enough time
                    end
                    
                    begin: ctrl_module_load_finish_4th
                    forever begin
                        #(CLK_PERIOD);
                        if (!avs_cpustat_ctrl_rdy) begin
                            disable ctrl_module_load_finish_4th;
                        end
                    end
                    end
            
                    /** (b) Read data from SRAM **/
                    // C code modify control word
                    #(CLK_PERIOD) CTRL_BGN = 1;
                    avs_cpuctrl_writedata[IDX_SCPU_CTRL_BGN] = 1;
                    #(CLK_PERIOD) CTRL_MODE = 2'b01;
                    avs_cpuctrl_writedata[IDX_SCPU_CTRL_MOD1] = 0;
                    avs_cpuctrl_writedata[IDX_SCPU_CTRL_MOD0] = 1;
                    // C code triger FPGA gen Load signal
                    #(CLK_PERIOD*10) avs_cpuctrl_write = 1;
                    avs_cpuctrl_writedata[IDX_SCPU_CTRL_LOAD] = 1;
                    #(CLK_PERIOD*10) avs_cpuctrl_write = 0;

                    p = 4;// waiting for the write ready
                    for (j=0; j<p; j=j+1) begin
                        #(CLK_PERIOD) avs_cpuctrl_write = 1;
                        avs_cpuctrl_writedata[IDX_SCPU_CLK_1TIME] = 1'b1;
                        #(CLK_PERIOD) avs_cpuctrl_write = 0;
                        #(CLK_PERIOD*avs_cntsclk_writedata*5);// wait enough time
                        #(CLK_PERIOD) avs_cpuctrl_write = 1;
                        avs_cpuctrl_writedata[IDX_SCPU_CLK_1TIME] = 1'b0;
                        #(CLK_PERIOD) avs_cpuctrl_write = 0;
                        #(CLK_PERIOD*avs_cntsclk_writedata*5);// wait enough time
                    end
                    
                    // C code polling to do next
                    //polling_wait(CTRL_RDY);
                    begin: ctrl_module_write_ready_5th
                    forever begin
                        #(CLK_PERIOD);
                        if (avs_cpustat_ctrl_rdy) begin
                            disable ctrl_module_write_ready_5th;
                        end
                    end
                    end
                    
                    // C code modify control word
                    #(CLK_PERIOD) CTRL_BGN = 0;
                    #(CLK_PERIOD*10) avs_cpuctrl_write = 1;
                    avs_cpuctrl_writedata[IDX_SCPU_CTRL_BGN] = 0;
                    #(CLK_PERIOD*10) avs_cpuctrl_write = 0;
                    #(CLK_PERIOD) LOAD_N = 1;//this FPGA signal is related to CTRL_BGN
                    #(CLK_PERIOD*10) avs_cpuctrl_write = 1;
                    avs_cpuctrl_writedata[IDX_SCPU_CTRL_LOAD] = 0;
                    #(CLK_PERIOD*10) avs_cpuctrl_write = 0;        
                    
                    p = 4;// waiting for the write ready
                    for (j=0; j<p; j=j+1) begin
                        #(CLK_PERIOD) avs_cpuctrl_write = 1;
                        avs_cpuctrl_writedata[IDX_SCPU_CLK_1TIME] = 1'b1;
                        #(CLK_PERIOD) avs_cpuctrl_write = 0;
                        #(CLK_PERIOD*avs_cntsclk_writedata*5);// wait enough time
                        #(CLK_PERIOD) avs_cpuctrl_write = 1;
                        avs_cpuctrl_writedata[IDX_SCPU_CLK_1TIME] = 1'b0;
                        #(CLK_PERIOD) avs_cpuctrl_write = 0;
                        #(CLK_PERIOD*avs_cntsclk_writedata*5);// wait enough time
                    end
                    
                    begin: ctrl_module_write_finish_5th
                    forever begin
                        #(CLK_PERIOD);
                        if (!avs_cpustat_ctrl_rdy) begin
                            disable ctrl_module_write_finish_5th;
                        end
                    end
                    end
                    
                    /** (c) Export SRAM data from SRAM_IO_CTRL to fpga **/
                    #(CLK_PERIOD) CTRL_BGN = 1;
                    avs_cpuctrl_writedata[IDX_SCPU_CTRL_BGN] = 1;
                    #(CLK_PERIOD) CTRL_MODE = 2'b10;
                    avs_cpuctrl_writedata[IDX_SCPU_CTRL_MOD1] = 1;
                    avs_cpuctrl_writedata[IDX_SCPU_CTRL_MOD0] = 0;
                    
                    tmpi_adder = 10'd0;//(i<<1)+k-1;//
                    tmpi_all = {tmpi_adder, 8'd0};//{MEMORY_DATA_WIDTH{1'b0}}
                    avs_sram_addr_wrt_writedata = tmpi_adder;
                    avs_sram_data_wrt_writedata = 8'd0;//{MEMORY_DATA_WIDTH{1'b1}}
                    // C code triger FPGA gen Load signal
                    #(CLK_PERIOD*10) avs_cpuctrl_write = 1;
                    avs_cpuctrl_writedata[IDX_SCPU_CTRL_LOAD] = 1;
                    #(CLK_PERIOD*10) avs_cpuctrl_write = 0;
                    
                    p = 23;// waiting for the write ready
                    for (j=0; j<p; j=j+1) begin
                        #(CLK_PERIOD) avs_cpuctrl_write = 1;
                        avs_cpuctrl_writedata[IDX_SCPU_CLK_1TIME] = 1'b1;
                        #(CLK_PERIOD) avs_cpuctrl_write = 0;
                        #(CLK_PERIOD*avs_cntsclk_writedata*5);// wait enough time
                        #(CLK_PERIOD) avs_cpuctrl_write = 1;
                        avs_cpuctrl_writedata[IDX_SCPU_CLK_1TIME] = 1'b0;
                        #(CLK_PERIOD) avs_cpuctrl_write = 0;
                        #(CLK_PERIOD*avs_cntsclk_writedata*5);// wait enough time
                    end
                    
                    // C code polling to do next
                    begin: ctrl_module_load_ready_6th
                    forever begin
                        #(CLK_PERIOD);
                        if (avs_cpustat_ctrl_rdy) begin
                            disable ctrl_module_load_ready_6th;
                        end
                    end
                    end
                    
                    // C code modify control word
                    #(CLK_PERIOD) CTRL_BGN = 0;
                    #(CLK_PERIOD*10) avs_cpuctrl_write = 1;
                    avs_cpuctrl_writedata[IDX_SCPU_CTRL_BGN] = 0;
                    #(CLK_PERIOD*10) avs_cpuctrl_write = 0;
                    #(CLK_PERIOD) LOAD_N = 1;//this FPGA signal is related to CTRL_BGN
                    #(CLK_PERIOD*10) avs_cpuctrl_write = 1;
                    avs_cpuctrl_writedata[IDX_SCPU_CTRL_LOAD] = 0;
                    #(CLK_PERIOD*10) avs_cpuctrl_write = 0;        
                    
                    p = 4;// waiting for the write ready
                    for (j=0; j<p; j=j+1) begin
                        #(CLK_PERIOD) avs_cpuctrl_write = 1;
                        avs_cpuctrl_writedata[IDX_SCPU_CLK_1TIME] = 1'b1;
                        #(CLK_PERIOD) avs_cpuctrl_write = 0;
                        #(CLK_PERIOD*avs_cntsclk_writedata*5);// wait enough time
                        #(CLK_PERIOD) avs_cpuctrl_write = 1;
                        avs_cpuctrl_writedata[IDX_SCPU_CLK_1TIME] = 1'b0;
                        #(CLK_PERIOD) avs_cpuctrl_write = 0;
                        #(CLK_PERIOD*avs_cntsclk_writedata*5);// wait enough time
                    end
                    
                    begin: ctrl_module_write_finish_6th
                    forever begin
                        #(CLK_PERIOD);
                        if (!avs_cpustat_ctrl_rdy) begin
                            disable ctrl_module_write_finish_6th;
                        end
                    end
                    end
                    
                    //$write("%10b ",avs_sram_addr_rd_readdata[MEMORY_ADDR_WIDTH-1:0]);
                    //$write("%8b ", avs_sram_data_rd_readdata[MEMORY_DATA_WIDTH-1:0]);
                    //$write("Addr =0x%.3x\n", tmpi_adder);
                    
                    if (k == 1) begin
                        tmpi_datain[MEMORY_DATA_WIDTH-1:0] = avs_sram_data_rd_readdata[MEMORY_DATA_WIDTH-1:0];
                    end
                    else if (k == 2) begin
                        tmpi_datain[2*MEMORY_DATA_WIDTH-1:MEMORY_DATA_WIDTH] = avs_sram_data_rd_readdata[MEMORY_DATA_WIDTH-1:0];
                    end
                end
                
                // if ((i == 10) && (tmpi_datain[9:0] != 10'd537))
                    // error_cnt = error_cnt + 1;//1st ADC data
                // else if ((i == 11) && (tmpi_datain[9:0] != 10'd492))
                    // error_cnt = error_cnt + 1;//2nd ADC data
                $display("ANA_bits = %d\tq = %d", tmpi_datain[9:0], q);
            end
        end
        
        // (5) Judge Final Test Result
        if (error_cnt || (q!= 1024))
            $display("Test Failed!");
        else
            $display("Test Passed!");
        #(CLK_PERIOD*2) $stop();
    end
    
    // Clock generation
    always #(CLK_PERIOD/2)
        CLK = ~CLK;

    // Dump signals to view waveform
    //initial
    //begin
        //$dumpfile ("wave_scpu_mimic_cf.dump");
        //$dumpvars (0, SCPU_MIMIC_CF_TOP_TEST);
    //end

endmodule


