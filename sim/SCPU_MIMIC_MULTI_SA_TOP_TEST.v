//+FHDR****************************************************************
// ECE department, TAMU
// --------------------------------------------------------------------
// FILE NAME    : SCPU_MIMIC_MULTI_SA_TOP_TEST.v
// AUTHER       : Jiafan Wang
// DATE         : 06/09/2017
// VERSION      : 1.0
// PURPOSE      : testbench for the Multi-Start 2D Simulated Annealing algorithm
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

`include    "../I_MEMORY_MULTI_SA_TASK_8BIT.v"

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
    parameter   ADC_IOOSCD_NUM      = 18;
    
    input   app_start;
    input   clk;
    input   rst_n;
    output  reg [ADC_DATA_WIDTH-1:0]    adc_value;
    output  reg app_done;
    reg     [ADC_DATA_WIDTH-1:0]    mem_adc[0: ADC_IOOSCD_NUM*(1 << (TUNE_BIT_WIDTH*2)) - 1];
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
    $readmemb("mscript/sweep_67_74_80_25C_516off_oscd.bin", mem_adc);
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

module  SCPU_MIMIC_MULTI_SA_TOP_TEST();
    parameter   MEMORY_DATA_WIDTH   = 8,
                MEMORY_ADDR_WIDTH   = 10,
                REG_BITS_WIDTH = MEMORY_ADDR_WIDTH + MEMORY_DATA_WIDTH;
    
    parameter   DEFAULT_PC_ADDR     = 30;//reserve for parameters
    parameter   CLK_PERIOD          = 20;
    parameter   MAX_SQRT_WIDTH      = 13;
    
    parameter   OSCD_TOL            = 18;//set gr0 = TOL, by default = 18 or (63)
    parameter   ADC_DATA_WIDTH      = 10;
    parameter   ADC_IODATA_NUM      = 16;
    parameter   ADC_IOOSCD_NUM      = 18;
    
    integer i,j,k,p,q,adc_addr;
    integer error_cnt;
    reg     [15:0] tmpi_datain; //MEMORY_DATA_WIDTH*2 -1
    reg     [REG_BITS_WIDTH-1:0]  tmpi_all;//addr+instruction
    reg     [9:0]  tmpi_adder;  //MEMORY_ADDR_WIDTH -1
    wire    [7:0]  tmp_mem_data;//MEMORY_DATA_WIDTH-1
    reg     [ADC_DATA_WIDTH-1:0]    IQ_data[0:ADC_IOOSCD_NUM-1];
    reg     [ADC_DATA_WIDTH-1:0]    IQ_abs[0:1];
    
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
    wire    [9:0]   coe_adc_value_export;
   
    reg     [7:0]   X_new, Y_new;
    reg     [15:0]  tunning_new_sa;
    reg     [9:0]   Ana_new_sa;
    reg     [9:0]   SA_iteration;
    reg     [9:0]   Ana_mimic;
    reg     div_accu;//1: 128; 0:64
    reg     [15:0]  A[0:7];
    reg     [15:0]  F0, F1, F2, F3, F0_tmp, F3_tmp;
    reg     [9:0]   f2_compen;
   
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
    I_MEMORY_MULTI_SA_TASK_8BIT   i_mem(
        .addr(tmpi_adder),
        .mem_sa(tmp_mem_data)
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
        for (i = 0; i<(225-14)+ DEFAULT_PC_ADDR; i=i) begin
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
            
            if (i == 13)//There are 14 Words at the beginning of SRAM
                i = DEFAULT_PC_ADDR;
            else
                i = i + 1;
        end
        #(CLK_PERIOD*150);//1500;
        
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

            div_accu = 1;//1:128; 0:64
            SA_iteration = 255;//X_new = 15; Y_new = 15;
            //$write("Tune_X =%d\tTune_Y =%d\t", X_new, Y_new);
            //q = 495;// the initial value (15,15) => [0,1023]
            for (j=0; j<SA_iteration; j=j+1) begin//SA iteration
                for (k=0; k <18; k=k) begin
                    //polling_wait(APP_START);
                    begin : wait_app_start_loop_1st
                        forever begin
                            #(CLK_PERIOD);
                            if (avs_cpustat_app_start) begin //CPU_NXT_dly[0]
                                disable wait_app_start_loop_1st;
                            end
                        end
                    end
                    
                    // From SPI data get the (X_new, Y_new) and ANA_new;
                    if (k == 0) begin
                        Ana_new_sa = avs_scan_chain_readdata[9:0];
                        if (j != 0) begin
                            $write("Ana_data = %d\n", Ana_new_sa);
                        end
                        tunning_new_sa = avs_scan_chain_readdata[31:16];
                        X_new = tunning_new_sa[15:8];
                        Y_new = tunning_new_sa[7:0];
                        $write("SA#=%4d: Tune_X=%d\tTune_Y=%d\t", j, X_new, Y_new);
                        q = X_new*32 + Y_new;
                        
                        // Mimic the Cost function: OSCD
                        IQ_abs[0] = (ADC01.mem_adc[q*18+0]>ADC01.mem_adc[q*18+2])?(ADC01.mem_adc[q*18+0]-ADC01.mem_adc[q*18+2]):(ADC01.mem_adc[q*18+2]-ADC01.mem_adc[q*18+0]);
                        IQ_abs[1] = (ADC01.mem_adc[q*18+1]>ADC01.mem_adc[q*18+3])?(ADC01.mem_adc[q*18+1]-ADC01.mem_adc[q*18+3]):(ADC01.mem_adc[q*18+3]-ADC01.mem_adc[q*18+1]);
                        
                         //set gr0 = TOL, by default = 18 or (63)
                        if ((IQ_abs[0] + IQ_abs[1]) < OSCD_TOL) begin
                            A[0] = Amp_Cordic(ADC01.mem_adc[q*18+ 2], ADC01.mem_adc[q*18+ 3], 516);
                            A[1] = Amp_Cordic(ADC01.mem_adc[q*18+ 4], ADC01.mem_adc[q*18+ 5], 516);
                            A[2] = Amp_Cordic(ADC01.mem_adc[q*18+ 6], ADC01.mem_adc[q*18+ 7], 516);
                            A[3] = Amp_Cordic(ADC01.mem_adc[q*18+ 8], ADC01.mem_adc[q*18+ 9], 516);
                            A[4] = Amp_Cordic(ADC01.mem_adc[q*18+10], ADC01.mem_adc[q*18+11], 516);
                            A[5] = Amp_Cordic(ADC01.mem_adc[q*18+12], ADC01.mem_adc[q*18+13], 516);
                            A[6] = Amp_Cordic(ADC01.mem_adc[q*18+14], ADC01.mem_adc[q*18+15], 516);
                            A[7] = Amp_Cordic(ADC01.mem_adc[q*18+16], ADC01.mem_adc[q*18+17], 516);
                            
                            F0=((A[0] >> 2) >= A[1])?511: (A[0]*128)/A[1];//F0 = Amp_Division(A[0],A[1],div_accu);
                            F1=((A[2] >> 2) >= A[3])?511: (A[2]*128)/A[3];//F1 = Amp_Division(A[2],A[3],div_accu);
                            F2=((A[4] >> 2) >= A[5])?511: (A[4]*128)/A[5];//F2 = Amp_Division(A[4],A[5],div_accu);
                            F3=((A[6] >> 2) >= A[7])?511: (A[6]*128)/A[7];//F3 = Amp_Division(A[6],A[7],div_accu);
                            
                            // 1.414*F3
                            F0_tmp = F0;
                            F0_tmp = F0_tmp*(256+107)/256;
                            //F0_tmp = F0 + (F0_tmp >> 2);
                            //F0_tmp = F0 + (F0_tmp >> 2);
                            //F0_tmp = F0 + (F0_tmp >> 1);
                            //F0_tmp = F0 + (F0_tmp >> 2);
                            // 1.414*F3
                            F3_tmp = F3;
                            F3_tmp = F3_tmp*(256+107)/256;
                            //F3_tmp = F3 + (F3_tmp >> 2);
                            //F3_tmp = F3 + (F3_tmp >> 2);
                            //F3_tmp = F3 + (F3_tmp >> 1);
                            //F3_tmp = F3 + (F3_tmp >> 2);
                            
                            Ana_mimic = 0;
                            Ana_mimic = Ana_mimic + (F1 > F0_tmp)?(F1 - F0_tmp):(F0_tmp - F1);
                            Ana_mimic = Ana_mimic + (F0 > F3)?(F0 - F3):(F3 - F0);
                            Ana_mimic = Ana_mimic + (F1 > F2)?(F1 - F2):(F2 - F1);
                            Ana_mimic = Ana_mimic + (F2 > F3_tmp)?(F2 - F3_tmp):(F3_tmp - F2);
                            
                            f2_compen = (div_accu)? 128:64;
                            if (F2 < f2_compen) Ana_mimic = Ana_mimic + ((f2_compen-F2));
                            if (Ana_mimic>255) Ana_mimic = 255;
                            
                            //$write("Ana_minic = %d\t", Ana_mimic);
                        end
                        else begin
                            Ana_mimic = 255;
                            //$write("Ana_minic = %d\t", Ana_mimic);
                        end
                    end

                    adc_addr = 0;
                    adc_addr = (q*18)+k;
                    ADC_PI = ADC01.mem_adc[adc_addr];
                    IQ_data[k] = ADC01.mem_adc[adc_addr];
                    // if (j==0)
                        // ADC_PI = 10'd537;//1st ADC data
                    // else
                        // ADC_PI = 10'd492;//2nd ADC data

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
                    
                    if (k == 3) begin//the OSCD process
                        IQ_abs[0] = (IQ_data[0]>IQ_data[2])?(IQ_data[0]-IQ_data[2]):(IQ_data[2]-IQ_data[0]);
                        IQ_abs[1] = (IQ_data[1]>IQ_data[3])?(IQ_data[1]-IQ_data[3]):(IQ_data[3]-IQ_data[1]);
                        
                         //set gr0 = TOL, by default = 18 or (63)
                        if ((IQ_abs[0] + IQ_abs[1]) < OSCD_TOL)
                            k = k + 1;
                        else
                            k=18;//break the for loop
                    end
                    else begin
                        k = k + 1;
                    end
                end

                //polling_wait(APP_START);
                begin : wait_app_start_loop_ana
                    forever begin
                        #(CLK_PERIOD);
                        if (avs_cpustat_app_start) begin //CPU_NXT_dly[0]
                            disable wait_app_start_loop_ana;
                        end
                    end
                end
                
                #(CLK_PERIOD*10) avs_cpuctrl_write = 1;
                avs_cpuctrl_writedata[IDX_SCPU_APP_DONE] = 1'b1;
                #(CLK_PERIOD*10) avs_cpuctrl_write = 0;
                
                //polling_wait (APP_START) DONE;
                begin : wait_app_start_done_ana
                    forever begin
                        #(CLK_PERIOD);
                        if (!avs_cpustat_app_start) begin //CPU_NXT_dly[0]
                            disable wait_app_start_done_ana;
                        end
                    end
                end
                
                //wait enough time to reset APP_DONE
                //#(CLK_PERIOD*avs_cntsclk_writedata*10);
                #(CLK_PERIOD*10) avs_cpuctrl_write = 1;
                avs_cpuctrl_writedata[IDX_SCPU_APP_DONE] = 1'b0;
                #(CLK_PERIOD*10) avs_cpuctrl_write = 0;
            end
        
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

            if (j == SA_iteration) begin
                // the last SA iteration won't invoke SPI
                $write("Ana_data no output\n");
            end
            
            // (4) SPI Output the (X_best, Y_best) and ANA_best;
            tunning_new_sa = avs_scan_chain_readdata[31:16];
            X_new = tunning_new_sa[15:8];
            Y_new = tunning_new_sa[7:0];
            //q = X_new*32 + Y_new;
            Ana_new_sa = avs_scan_chain_readdata[9:0];
            $write("\nBest_X =%d\tBest_Y =%d\tAna_best = %d\n", X_new, Y_new, Ana_new_sa);
            
        // (5) Judge Final Test Result
        if (error_cnt || (j != SA_iteration))
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

    
    // Cordic function get sqrt((X-offset)^2, (Y-offset)^2)
    function [MAX_SQRT_WIDTH-1:0] Amp_Cordic;
        input   [ADC_DATA_WIDTH-1:0]    I_DATA;
        input   [ADC_DATA_WIDTH-1:0]    Q_DATA;
        input   [ADC_DATA_WIDTH-1:0]    offset;
        
        integer     i,sig;
        integer     xn,yn,zn;
        
        begin
            xn = (I_DATA >= offset)? (I_DATA - offset):(offset - I_DATA);
            yn = (Q_DATA >= offset)? (Q_DATA - offset):(offset - Q_DATA);
            zn = xn*xn + yn*yn;
            
            for (i=0; i<=zn/2; i=i) begin
                if (i*i> zn) begin
                    Amp_Cordic = i-1;
                    i = zn/2 + 1;
                end
                else if (i*i== zn) begin
                    Amp_Cordic = i;
                    i = zn/2 + 1;
                end
                else begin
                    i = i+1;
                end
            end
        end
        
        //begin
        //    xn = (I_DATA >= offset)? (I_DATA - offset):(offset - I_DATA);
        //    yn = (Q_DATA >= offset)? (Q_DATA - offset):(offset - Q_DATA);
        //    
        //    if (xn < yn) begin
        //        zn = xn;
        //        xn = yn;
        //        yn = zn;
        //    end
        //    
        //    xn = (xn << 4);
        //    yn = (yn << 4);
        //    
        //    for (i=1; i<=8; i=i+1) begin
        //        sig = ((xn>0 && yn>0)||(xn<0 && yn<0)) ? -1 : 1;
        //        zn = xn;
        //        xn = xn - sig * (yn >> i);
        //        yn = yn + sig * (zn >> i);
        //    end
        //    
        //    Amp_Cordic = (xn >> 4);
        //end
    endfunction
    
    // Cordic function get division A/B
    function [ADC_IODATA_NUM-1:0] Amp_Division;
        input   [ADC_IODATA_NUM-1:0]    x;
        input   [ADC_IODATA_NUM-1:0]    y;
        input   div_accu;
        
        parameter   QUOTIENT_WIDTH   = 9;
        
        integer     i;
        reg [ADC_IODATA_NUM-1:0] divident, dividor;
        reg [2*ADC_IODATA_NUM-1:0] divident_tmp, dividor_tmp;
        
        begin
            divident = x;
            dividor  = y;
            divident_tmp = (div_accu)? (divident<<7):(divident<<6);
            dividor_tmp = (dividor << QUOTIENT_WIDTH);//#define QUOTIENT_WIDTH  9
            
            if ((divident >> 2) >= dividor) begin
                // 511 = 9'b11_1111111; 256 = 9'b100_000000
                Amp_Division = (div_accu)? 511: 256;
            end 
            else begin
                for (i = QUOTIENT_WIDTH; i > 0; i = i-1) begin
                    divident_tmp = (divident_tmp << 1);// left shift 1 bit
                    divident_tmp = (divident_tmp & 32'h1FFFFF);// remove the leftmost bit

                    if (divident_tmp >= dividor_tmp) begin
                        divident_tmp = divident_tmp - dividor_tmp + 1;
                    end
                end
                Amp_Division = (divident_tmp & 32'h1FF);
            end
        end
    endfunction
    
endmodule


