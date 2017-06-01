//+FHDR****************************************************************
// ECE department, TAMU
// --------------------------------------------------------------------
// FILE NAME    : SCPU_MIMIC_SA_TOP_TEST.v
// AUTHER       : Jiafan Wang
// DATE         : 04/07/2017
// VERSION      : 1.0
// PURPOSE      : testbench for the Simulated Annealing algorithm
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
`include    "../I_MEMORY_8bit.v"
`include    "../SC_CELL_V3.v"
`include    "../I_MEMORY_TASK_8BIT.v"

module MIMIC_COST_VAL(
    TUNE_X1,
    TUNE_X2,
    rst_n,
    clk,
    cost_val
    );
    
    parameter   ADC_DATA_WIDTH      = 10,
                TUNE_BIT_WIDTH      = 5;
    
    input   [TUNE_BIT_WIDTH-1:0]    TUNE_X1;
    input   [TUNE_BIT_WIDTH-1:0]    TUNE_X2;
    input   clk;
    input   rst_n;
    output  reg [ADC_DATA_WIDTH-1:0]    cost_val;

    reg     [ADC_DATA_WIDTH-1:0]    mem_adc[0:(1 << (TUNE_BIT_WIDTH*2)) - 1];

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
    $readmemb("sim/BPF_31M_F3.txt", mem_adc);
    //$readmemb("sim/BPF_31M_F2.txt", mem_adc);
    //$readmemb("sim/BPF_31M_F1.txt", mem_adc);
    end

    //assign cost_val = mem_adc[X1*(1<<(3*`VAR_WIDTH)) + X2*(1<<(2*`VAR_WIDTH)) + X3*(1<<`VAR_WIDTH) + X4];
    //assign cost_val = mem_adc[TUNE_X2*(1 << TUNE_BIT_WIDTH) + TUNE_X1];
    assign  cost_val = mem_adc[TUNE_X2*(1 << TUNE_BIT_WIDTH) + TUNE_X1];
endmodule


module  SCPU_MIMIC_SA_TOP_TEST();
    parameter   CLKPERIOD = 20;
    
    parameter   MAX_SQRT_WIDTH      = 13;

    parameter   MEMORY_DATA_WIDTH   = 8,
                MEMORY_ADDR_WIDTH   = 10,
                REG_BITS_WIDTH = MEMORY_ADDR_WIDTH + MEMORY_DATA_WIDTH;
    
    parameter   DEFAULT_PC_ADDR     = 16;//reserve for parameters
    
    integer i,j,k;
    integer error_cnt;
    reg     [15:0] tmpi_datain; //MEMORY_DATA_WIDTH*2 -1
    reg     [REG_BITS_WIDTH-1:0]  tmpi_all;//addr+instruction
    reg     [8:0]  tmpi_adder;  //MEMORY_ADDR_WIDTH -1
    
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
    reg     [2:0] TEST_MUX;
    
    // Wires
    wire    CTRL_RDY;
    wire    CTRL_SO;
    wire    [1:0]   CPU_NXT;
    wire    SEL;
    wire    SCLK1;
    wire    SCLK2;
    wire    LAT;
    wire    CLRN;
    wire    CLK_ADC;
    wire    RSTN_ADC;
    wire    [1:0]   CTRL_MODE_dly;
    wire    [9:0]   ADC_PI_dly;
    wire    [9:0]   ADC_VALUE;
    wire    [4:0]   TUNE_X1, TUNE_X2;

/*
    wire    [19:0] TUNE_BITS;
    reg     [19:0] INIT_TUNE_BITS;
    reg     [10:0] MAX_SA_ITERATION;
    reg     [10:0] MAX_SS_ITERATION;
    reg     [5:0]  INITIAL_T_VALUE;
    reg     [2:0]  STEP_T_VALUE; 
    reg     OPT_MODE;
    reg     DIV_ACCU;
    reg     [7:0]   SS_THRESHOLD;
 
    wire    OSCD;
    wire    [7:0]  ANA_BITS;//[`ANA_WIDTH-1:0]
    wire    [1:0]  FS;
    wire    PHS;
    wire    CAL;
    wire    SRC;
    wire    CLRN;
    wire    CLK_ADC;
    wire    RSTN_ADC;
    wire    NXT;

    reg     [9:0]   OFFSET;
    reg     [5:0]   TOL;
    integer i,j;    

    wire    [7:0]   prob_tmp;
    wire    division_is_done;
    wire    [11:0]   dividend_SA;
    wire    [11:0]   dividor_SA;
    wire    [5:0]    multiplicand_SA;
    wire    [7:0]    multiplier_SA;
    wire    [9:0]    multiplication;

    parameter   MULTIPLIER_WIDTH = 8;//Total bits for MULTIPLIER is 8
    parameter   QUOTIENT_WIDTH   = 9;//Total bits for QUOTIENT is 9; affect different curcuit

    wire    [QUOTIENT_WIDTH-1:0]    signed_division;
    assign  prob_tmp = (QUOTIENT_WIDTH==9)? (signed_division >> 1): (signed_division << (8-QUOTIENT_WIDTH));
 */

    SCPU_SRAM_8BIT_ALU_SPI_TOP  scpu_sram_alu(
        .CLK            (CLK        ),
        .RST_N          (RST_N      ),
        .CTRL_MODE      (CTRL_MODE_dly),
        .CTRL_BGN       (CTRL_BGN_dly),
        .CPU_BGN        (CPU_BGN    ),
        .LOAD_N         (LOAD_N_dly),
        .CTRL_SI        (CTRL_SI_dly),
        .APP_DONE       (APP_DONE_dly),//1'b0
        .ADC_PI         (ADC_PI_dly ),
        .TEST_MUX       (TEST_MUX   ),//for debug
        .CPU_WAIT       (CPU_WAIT   ),
        // output
        .CTRL_RDY       (CTRL_RDY),
        .APP_START      (APP_START  ),
        .CTRL_SO        (CTRL_SO    ),
        .NXT            (CPU_NXT    ),
        .SCLK1          (SCLK1      ),
        .SCLK2          (SCLK2      ),
        .LAT            (LAT        ),
        .SPI_SO         (SPI_SO     )
    );
    
    parameter   IDX_SCPU_CTRL_BGN  = 0;     // SCPU CTRL Module's start bit
    parameter   IDX_SCPU_CTRL_LOAD = 1;     // SCPU CTRL Module's load bit
    parameter   IDX_SCPU_CTRL_MOD0 = 2;     // SCPU CTRL Module's mode bit
    parameter   IDX_SCPU_CTRL_MOD1 = 3;     // SCPU CTRL Module's mode bit

    parameter   IDX_SCPU_CTRL_RDY  = 0,
                IDX_SCPU_NXT_END   = 1,
                IDX_SCPU_NXT_CONT  = 2,
                IDX_SCPU_APP_START = 3;
    
    reg     avs_cpuctrl_write;
    reg     avs_sram_addr_write;
    reg     avs_sram_data_write;
    reg     avs_adc_write;
    
    reg     [31:0]  avs_cpuctrl_writedata;
    wire    [31:0]  avs_cpustat_readdata;
    reg     [31:0]  avs_sram_addr_writedata;
    reg     [31:0]  avs_sram_data_writedata;
    reg     [31:0]  avs_adc_writedata;
    
    wire    [31:0]  avs_sram_addr_readdata;
    wire    [31:0]  avs_sram_data_readdata;
   
    wire    [9:0]   coe_adc_value_export;
   
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

        .avs_sram_addr_writedata(avs_sram_addr_writedata),    // SRAM address value
        .avs_sram_addr_write    (avs_sram_addr_write    ),

        .avs_sram_data_writedata(avs_sram_data_writedata),    // Instruction data value
        .avs_sram_data_write    (avs_sram_data_write    ),

        .avs_adc_writedata      (avs_adc_writedata      ),          // ADC data from analog
        .avs_adc_write          (avs_adc_write          ),

        //// Internal Output Connections ////
        .avs_sram_addr_readdata (avs_sram_addr_readdata ),     // Instruction addr value
        .avs_sram_data_readdata (avs_sram_data_readdata ),     // Instruction data value

        //// External I/O Connections (Output)
        .coe_ctrl_bgn_export    (coe_ctrl_bgn_export    ),
        .coe_ctrl_mod0_export   (coe_ctrl_mod0_export   ),
        .coe_ctrl_mod1_export   (coe_ctrl_mod1_export   ),
        .coe_ctrl_load_export   (coe_ctrl_load_export   ),
        .coe_ctrl_si_export     (coe_ctrl_si_export     ),
        .coe_adc_value_export   (coe_adc_value_export   ),
        .coe_app_done_export    (coe_app_done_export    ),
        
        //// External I/O Connections (Input)
        .coe_ctrl_so_export     (coe_ctrl_so_export     ),
        .coe_ctrl_rdy_export    (coe_ctrl_rdy_export    ),
        .coe_ctrl_nxt_end_export(coe_ctrl_nxt_end_export),
        .coe_ctrl_nxt_cont_export(coe_ctrl_nxt_cont_export),
        .coe_app_start_export   (coe_app_start_export   )
    );
   
    I_MEMORY_8BIT   i_mem(
        // .clk(clk),
        // .rst_n(CEN), 
        // .addr(m_addr),
        // .d_we(d_we),// need a seperate control signal; or instruction set will be overwritten when d_we=1
        // .datain(m_datain),//i_instruct
        // .dataout(m_dataout)
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

    parameter   VIRTUAL_DLY = 0;//0;//
    
    assign  #VIRTUAL_DLY    SCLK1_dly   = SCLK1;
    assign  #VIRTUAL_DLY    SCLK2_dly   = SCLK2;
    assign  #VIRTUAL_DLY    LAT_dly     = LAT;
    assign  #VIRTUAL_DLY    SPI_SO_dly  = SPI_SO;

    assign  #VIRTUAL_DLY    CTRL_MODE_dly = {coe_ctrl_mod1_export,coe_ctrl_mod0_export};
    assign  #VIRTUAL_DLY    CTRL_BGN_dly = coe_ctrl_bgn_export;
    assign  #VIRTUAL_DLY    LOAD_N_dly = !coe_ctrl_load_export;
    assign  #VIRTUAL_DLY    CTRL_SI_dly = coe_ctrl_si_export;
    assign  #VIRTUAL_DLY    ADC_PI_dly = coe_adc_value_export;
    assign  #VIRTUAL_DLY    APP_DONE_dly = coe_app_done_export;
    
    assign  #VIRTUAL_DLY    coe_ctrl_rdy_export = CTRL_RDY;
    assign  #VIRTUAL_DLY    coe_ctrl_so_export = CTRL_SO;
    assign  #VIRTUAL_DLY    coe_ctrl_nxt_end_export = CPU_NXT[0];
    assign  #VIRTUAL_DLY    coe_ctrl_nxt_cont_export = CPU_NXT[1];
    assign  #VIRTUAL_DLY    coe_app_start_export = APP_START;
    
/*
    //Invoke the SA module
    SA_4D_TOP_LEVEL_418   SA02(
    .CLK(CLK),
    .RST_N(RST_N),
    .NXT(Vir_NXT[0]),//NXT
    
    // Input
    .INIT_TUNE_BITS(INIT_TUNE_BITS),
    .MAX_SA_ITERATION(MAX_SA_ITERATION),
    .MAX_SS_ITERATION(MAX_SS_ITERATION), 
    .INITIAL_T_VALUE(INITIAL_T_VALUE),  
    .STEP_T_VALUE(STEP_T_VALUE),
    .OPT_MODE(OPT_MODE),
    .FLAG4D(FLAG4D),
    .RAND_GROUP(RAND_GROUP),
    .SS_THRESHOLD(SS_THRESHOLD),
    .ANA_BITS(ANA_BITS),
    //.div_mode(div_mode),
    
    // Output
    .TUNE_READY(TUNE_READY),
    .TUNE_BITS(TUNE_BITS),
    
    // share division
    //output
    .dividend(dividend_SA),
    .dividor(dividor_SA),
    .division_start(set_division_start_SA),
    //Input
    .prob_tmp(prob_tmp),
    .division_done(division_is_done),

    //share multiply
    //output
    .multiplicand(multiplicand_SA),
    .multiplier(multiplier_SA),
    .multiply_start(set_multiply_start_SA),
    //.mul_mode(mul_mode_sa),
    //input
    .multiplication(multiplication),
    .multiply_done(multiply_is_done)
    );
    
    // Mux for share DIVISION
    SHARE_DIVISION_418      inst_division(
    //Input
    .CLK(CLK),
    .RST_N(RST_N),
    .dividend(dividend_SA),
    .dividor(dividor_SA),
    .division_start(set_division_start_SA),
    .div_mode(2'b00),//2'b00 div_mode
    
    // Output
    .signed_division(signed_division),
    .division_done(division_is_done)
    );

    SHARE_MULTIPLY_418      inst_multiply(
    //Input
    .CLK(CLK),
    .RST_N(RST_N),
    .multiplicand({3'b000, multiplicand_SA}),
    .multiplier(multiplier_SA[7:(8-MULTIPLIER_WIDTH)]),
    .multiply_start(set_multiply_start_SA),
    .mul_mode(2'b00),//mul_mode),

    .multiplication(multiplication),
    .multiply_done(multiply_is_done)
    );

    defparam    inst_multiply.MULTIPLIER_WIDTH = MULTIPLIER_WIDTH;
    defparam    inst_division.QUOTIENT_WIDTH = QUOTIENT_WIDTH;
 */    
 
    //Invoke the MIMIC_COST_VAL module
    MIMIC_COST_VAL   COST01(
        .TUNE_X1(TUNE_X1),
        .TUNE_X2(TUNE_X2),
        .rst_n(RST_N),
        .clk(CLK),
        .cost_val(ADC_VALUE)
    );

    MEM_SA_TASK_8BIT    i_mem();
    
    // Initial Settings
    initial begin
/*
        //NXT = 1'b0;
        CLK = 1'b0;
        RST_N = 1'b0;
        //TUNE_READY = 0;
        FLAG4D = 0;// 1 is OK
        RAND_GROUP = 1;
        OFFSET = 10'd0;
        TOL = 6'd32;
        SS_THRESHOLD = 8'd100;

        INIT_TUNE_BITS = 20'b01111011110111101110;
        MAX_SA_ITERATION = 11'd150;//16;
        MAX_SS_ITERATION = 11'd8;
        INITIAL_T_VALUE = 8'd32;
        STEP_T_VALUE = 3'd3;
        OPT_MODE = 1'd1;//1'b0
        DIV_ACCU = 1;

        #(20*5) RST_N = 1'b1;

        for (i = 0; i <= 3000; i=i+1) begin
            for (j = 0; j <= 3000; j=j+1) begin
                if (SA02.inst_ctrlpath.state == 4'b1000) begin
                    #20;
                    $display("%d\t%d\t%d\t%d\t \t%d", TUNE_BITS[19:15],TUNE_BITS[14:10],TUNE_BITS[9:5],TUNE_BITS[4:0],ANA_BITS);
                    $stop();
                end
                else
                    #20;
            end
        end */
        
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
        avs_sram_addr_writedata = 0;
        avs_sram_data_writedata = 0;
        avs_adc_writedata = 0;
        
        avs_cpuctrl_write   = 1;
        avs_sram_addr_write = 1;
        avs_sram_data_write = 1;
        avs_adc_write = 1;
        // Wait 100 ns for global RST_N to finish
        #(CLKPERIOD*10);//100;

        // (0) Initialize peudo SRAM to keep the instructions;
        mem_help.init_1024x8bit(i_mem.I_RAM);
        
        
        #CLKPERIOD RST_N = 0; rsi_reset_n = 0; CTRL_BGN = 1;
        #CLKPERIOD RST_N = 1; rsi_reset_n = 1;
        
        /* (1) Serially Input the address & Instruction to CTRL and then to SRAM */
        for (i = 0; i<15+ DEFAULT_PC_ADDR; i=i) begin
            for (k=2; k>=1; k=k-1) begin
                /** (a) load data to SRAM_IO_CTRL from PC **/
                // C code modify control word
                #CLKPERIOD CTRL_BGN = 1;
                avs_cpuctrl_writedata[IDX_SCPU_CTRL_BGN] = 1'b1;
                #CLKPERIOD CTRL_MODE = 2'b00;
                avs_cpuctrl_writedata[IDX_SCPU_CTRL_MOD1] = 1'b0;
                avs_cpuctrl_writedata[IDX_SCPU_CTRL_MOD0] = 1'b0;

                tmpi_adder = (i<<1)+k-1;
                tmpi_all = {tmpi_adder, i_mem.I_RAM[tmpi_adder]};
                avs_sram_addr_writedata = tmpi_adder;
                avs_sram_data_writedata = i_mem.I_RAM[tmpi_adder];
                // C code triger FPGA gen Load signal
                avs_cpuctrl_write = 0;
                #CLKPERIOD avs_cpuctrl_write = 1;
                avs_cpuctrl_writedata[IDX_SCPU_CTRL_LOAD] = 1'b1;
                
                // begin
                    // FPGA send Load signal & data to CTRL
                    // #10 LOAD_N = 0;
                    // for (j = 0; j < REG_BITS_WIDTH; j=j+1) begin
                        // #10 CTRL_SI = tmpi_all[j];
                    // end
                // end
                
                // C code polling to do next
                //polling_wait(CTRL_RDY);
                begin: ctrl_module_load_ready
                forever begin
                    #CLKPERIOD;
                    if (avs_cpustat_ctrl_rdy) begin
                        disable ctrl_module_load_ready;
                    end
                end
                end
                
                // C code modify control word
                #CLKPERIOD CTRL_BGN = 0;
                avs_cpuctrl_writedata[IDX_SCPU_CTRL_BGN] = 0;
                #CLKPERIOD LOAD_N = 1;//this FPGA signal is related to CTRL_BGN
                avs_cpuctrl_write = 0;
                #CLKPERIOD avs_cpuctrl_write = 1;
                avs_cpuctrl_writedata[IDX_SCPU_CTRL_LOAD] = 0;
                begin: ctrl_module_load_finish
                forever begin
                    #CLKPERIOD;
                    if (!avs_cpustat_ctrl_rdy) begin
                        disable ctrl_module_load_finish;
                    end
                end
                end
                
                /** (b) notify SRAM_IO_CTRL to send data to SRAM **/
                // C code modify control word
                #CLKPERIOD CTRL_BGN = 1;
                avs_cpuctrl_writedata[IDX_SCPU_CTRL_BGN] = 1;
                #CLKPERIOD CTRL_MODE = 2'b11;
                avs_cpuctrl_writedata[IDX_SCPU_CTRL_MOD1] = 1;
                avs_cpuctrl_writedata[IDX_SCPU_CTRL_MOD0] = 1;
                // C code triger FPGA gen Load signal
                avs_cpuctrl_write = 0;
                #CLKPERIOD avs_cpuctrl_write = 1;
                avs_cpuctrl_writedata[IDX_SCPU_CTRL_LOAD] = 1;

                // begin
                    // FPGA send Load signal & data to CTRL
                    // #10 LOAD_N = 0;
                // end

                // C code polling to do next
                //polling_wait(CTRL_RDY);
                begin: ctrl_module_write_ready
                forever begin
                    #CLKPERIOD;
                    if (avs_cpustat_ctrl_rdy) begin
                        disable ctrl_module_write_ready;
                    end
                end
                end
                
                // C code modify control word
                #CLKPERIOD CTRL_BGN = 0;
                avs_cpuctrl_writedata[IDX_SCPU_CTRL_BGN] = 0;
                #CLKPERIOD LOAD_N = 1;//this FPGA signal is related to CTRL_BGN
                avs_cpuctrl_write = 0;
                #CLKPERIOD avs_cpuctrl_write = 1;
                avs_cpuctrl_writedata[IDX_SCPU_CTRL_LOAD] = 0;
                begin: ctrl_module_write_finish
                forever begin
                    #CLKPERIOD;
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
        #(CLKPERIOD*150);//1500;
        
        /* (2) Activate CPU to load from LIOA */
        #CLKPERIOD     CTRL_BGN = 0;
        #CLKPERIOD     CPU_BGN = 1;
        #CLKPERIOD     CPU_BGN = 0;
        
        /* (3) Detect instructions exhaust & reload new instructions */
        // begin: detect_nxt_signals_1st
            // forever begin
                // #CLKPERIOD;
                // // program is finish; nxt[0]
                // if (avs_cpustat_nxt_end) begin
                    // // cpu_halt = 1;
                    // disable detect_nxt_signals_1st;
                // end
                
                // // SRAM runs out; nxt[1] replace old instructions with the new ones;
                // if (avs_cpustat_nxt_cont) begin
            // i= DEFAULT_PC_ADDR*2;
            // tmpi_datain = {`LOAD, `gr2, 1'b0, `gr0, 4'b0001};//load data from 0x02~0x03
            // i_mem.I_RAM[ i] = tmpi_datain[7:0];  i = 1 + DEFAULT_PC_ADDR*2;
            // i_mem.I_RAM[ i] = tmpi_datain[15:8]; i = 2 + DEFAULT_PC_ADDR*2;
            // tmpi_datain = {`ADD, `gr1, 1'b0, `gr1, 1'b0, `gr2};
            // i_mem.I_RAM[ i] = tmpi_datain[7:0];  i = 3 + DEFAULT_PC_ADDR*2;
            // i_mem.I_RAM[ i] = tmpi_datain[15:8]; i = 4 + DEFAULT_PC_ADDR*2;
            // tmpi_datain = {`STORE, `gr1, 1'b0, `gr0, 4'b0011};
            // i_mem.I_RAM[ i] = tmpi_datain[7:0];  i = 5+ DEFAULT_PC_ADDR*2;
            // i_mem.I_RAM[ i] = tmpi_datain[15:8]; i = 6+ DEFAULT_PC_ADDR*2;
            // tmpi_datain = {`HALT, 11'b000_0000_0000};// set the finish instruction
            // i_mem.I_RAM[ i] = tmpi_datain[7:0];  i = 7 + DEFAULT_PC_ADDR*2;
            // i_mem.I_RAM[ i] = tmpi_datain[15:8]; i = 8 + DEFAULT_PC_ADDR*2;
                    // disable detect_nxt_signals_1st;
                // end
            // end
        // end
        
        // (4) Judge Final Test Result
        if (error_cnt)
            $display("Test Failed!");
        else
            $display("Test Passed!");
        #(CLKPERIOD*2) $stop();
    end
    
    // Clock generation
    always #(CLKPERIOD/2)
        CLK = ~CLK;

    // Dump signals to view waveform
    initial
    begin
        $dumpfile ("wave_scpu_mimic_cfsa.dump");
        $dumpvars (0, SCPU_MIMIC_SA_TOP_TEST);
    end

endmodule


