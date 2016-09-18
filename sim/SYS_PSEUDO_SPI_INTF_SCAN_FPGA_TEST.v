//+FHDR****************************************************************
// ECE department, TAMU
// --------------------------------------------------------------------
// FILE NAME    : SYS_PSEUDO_SPI_INTF_SCAN_FPGA_TEST.v
// AUTHER       : Jiafan Wang
// DATE         : 09/17/2016
// VERSION      : 1.0
// PURPOSE      : sytem level testbench of the scan chain output to analog
// --------------------------------------------------------------------
// ABSTRACT: loop-test simulation time 100ms given each time period 20ns
// --------------------------------------------------------------------
`timescale  1 ns / 100 ps
`include    "../ibm13rfrvt_neg.v"       //IBM130 standard cells
`include    "../iogpil_cmrf8sf_rvt.v"   //Pad cells
`include    "../DEFINE_CPU.v"
`include    "../RA1SHD_IBM512X8.v"
`include    "../SCPU_SRAM_8BIT_ALU_SPI_TOP.v"
`include    "../SRAM_IO_CTRL_SHELL.v"
`include    "../I_MEMORY_8bit.v"
`include    "../SC_CELL_V3.v"

module  SYS_PSEUDO_SPI_INTF_SCAN_FPGA_TEST();
    parameter   CLKPERIOD = 20;

    parameter   MULTIPLICAND_WIDTH  = 9,// the division of CF
                MULTIPLIER_WIDTH    = 8,// for the random value used by SA, it's the width of LFSR 
                MAX_SQRT_WIDTH      = 13;
                
    parameter   MEMORY_DATA_WIDTH   = 8,
                MEMORY_ADDR_WIDTH   = 9,
                REG_BITS_WIDTH = MEMORY_ADDR_WIDTH + MEMORY_DATA_WIDTH;

    parameter   GENERAL_REG_WIDTH   = 16;
    parameter   DEFAULT_PC_ADDR     = 16;
    reg     [MULTIPLICAND_WIDTH-1:0]    multiplicand;
    reg     [MULTIPLIER_WIDTH-1:0]      multiplier;

    integer i,j,k;
    integer error_cnt;
    reg     [15:0] tmpi_datain; //MEMORY_DATA_WIDTH*2 -1
    reg     [REG_BITS_WIDTH-1:0]  tmpi_all;//addr+instruction
    reg     [8:0]  tmpi_adder;  //MEMORY_ADDR_WIDTH -1
    
    reg     CLK;
    reg     RST_N;
    reg     rsi_reset_n;
    reg     [1:0]  CTRL_MODE;
    reg     CTRL_BGN;
    reg     CPU_BGN;// enable signal for SERIAL_CPU_8bit
    reg     LOAD_N;
    reg     CTRL_SI;
    //reg     ANA_SI;
    reg     [9:0] ADC_PI;
    
    // Wires
    wire    CTRL_RDY;
    wire    ANA_RDY;
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
    wire    [1:0]   CPU_NXT_dly;
    
    parameter   IDX_SCPU_CTRL_BGN  = 0;     // SCPU CTRL Module's start bit
    parameter   IDX_SCPU_CTRL_LOAD = 1;     // SCPU CTRL Module's load bit
    parameter   IDX_SCPU_CTRL_MOD0 = 2;     // SCPU CTRL Module's mode bit
    parameter   IDX_SCPU_CTRL_MOD1 = 3;     // SCPU CTRL Module's mode bit
    parameter   IDX_SCPU_CTRL_RST  = 4;     // SCPU CTRL Module's mode bit
    parameter   IDX_SCPU_CTRL_CPU  = 5;     // SCPU CTRL Module's mode bit
    parameter   IDX_SCPU_CTRL_TEST = 6;     // SCPU CTRL Module's mode bit
    parameter   IDX_SCPU_CTRL_ADC  = 7;     // SCPU ADC flag bit (conflict with IDX_SCPU_CTRL_LOAD)  
    
    parameter   IDX_SCPU_CTRL_RDY  = 0;
    parameter   IDX_SCPU_CTRL_NXT0 = 1;     // SCPU process finish
    parameter   IDX_SCPU_CTRL_NXT1 = 2;     // SCPU Instructions run over
    
    reg     avs_cpuctrl_write;
    reg     avs_sram_addr_write;
    reg     avs_sram_data_write;
    
    reg     [31:0]  avs_cpuctrl_writedata;
    wire    [31:0]  avs_cpustat_readdata;
    
    reg     [31:0]  avs_cntsclk_writedata;
    reg     [31:0]  avs_sram_addr_writedata;
    reg     [31:0]  avs_sram_data_writedata;
    reg     [31:0]  avs_adc_writedata;
    reg     [31:0]  avs_xin_writedata;
    reg     [31:0]  avs_yin_writedata;
    
    wire    [31:0]  avs_sram_addr_readdata;
    wire    [31:0]  avs_sram_data_readdata;
   
    wire    [1:0]   coe_ctrl_nxt_export;
    wire    [9:0]   coe_ctrl_adc_export;
   
    assign  avs_cpustat_ctrl_rdy = avs_cpustat_readdata[IDX_SCPU_CTRL_RDY];
    assign  avs_cpustat_ctrl_nxt1 = avs_cpustat_readdata[IDX_SCPU_CTRL_NXT1];
    assign  avs_cpustat_ctrl_nxt0 = avs_cpustat_readdata[IDX_SCPU_CTRL_NXT0];
    
    SRAM_IO_CTRL_SHELL fpga(
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
        .avs_sram_addr_writedata(avs_sram_addr_writedata),    // SRAM address value
        .avs_sram_addr_write    (avs_sram_addr_write    ),

        .avs_sram_data_writedata(avs_sram_data_writedata),    // Instruction data value
        .avs_sram_data_write    (avs_sram_data_write    ),
        .avs_adc_writedata      (avs_adc_writedata      ),    // mimic ADC data from analog
        .avs_adc_write          (avs_adc_write          ),
        .avs_xin_writedata      (avs_xin_writedata      ),    // mimic ADC data from analog
        .avs_xin_write          (avs_xin_write          ),
        .avs_yin_writedata      (avs_yin_writedata      ),    // mimic ADC data from analog
        .avs_yin_write          (avs_yin_write          ),

        //// Internal Output Connections ////
        .avs_sram_addr_readdata (avs_sram_addr_readdata ),     // Instruction addr value
        .avs_sram_data_readdata (avs_sram_data_readdata ),     // Instruction data value

        //// External I/O Connections (Output)
        .coe_anag_sclk1_export  (coe_anag_sclk1_export  ),
        .coe_anag_sclk2_export  (coe_anag_sclk2_export  ),
        .coe_anag_lat_export    (coe_anag_lat_export    ),
        .coe_anag_spi_o_export  (coe_anag_spi_o_export  ),
        
        .coe_ctrl_cpu_export    (coe_ctrl_cpu_export    ),
        .coe_ctrl_bgn_export    (coe_ctrl_bgn_export    ),
        .coe_ctrl_mod0_export   (coe_ctrl_mod0_export   ),
        .coe_ctrl_mod1_export   (coe_ctrl_mod1_export   ),
        .coe_ctrl_load_export   (coe_ctrl_load_export   ),
        .coe_ctrl_si_export     (coe_ctrl_si_export     ),
        //// External I/O Connections (Input)
        .coe_ctrl_nxt_export    (coe_ctrl_nxt_export    ),
        .coe_ctrl_adc_export    (coe_ctrl_adc_export    ),
        .coe_ctrl_so_export     (coe_ctrl_so_export     ),
        .coe_ctrl_rdy_export    (coe_ctrl_rdy_export    )
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

    parameter   VIRTUAL_DLY = 0;//2
    
    assign  #VIRTUAL_DLY    SCLK1_dly   = coe_anag_sclk1_export;
    assign  #VIRTUAL_DLY    SCLK2_dly   = coe_anag_sclk2_export;
    assign  #VIRTUAL_DLY    LAT_dly     = coe_anag_lat_export;
    assign  #VIRTUAL_DLY    SPI_SO_dly  = coe_anag_spi_o_export;

    assign  #VIRTUAL_DLY    CTRL_MODE_dly = {coe_ctrl_mod1_export,coe_ctrl_mod0_export};
    assign  #VIRTUAL_DLY    CTRL_BGN_dly = coe_ctrl_bgn_export;
    assign  #VIRTUAL_DLY    LOAD_N_dly = !coe_ctrl_load_export;
    assign  #VIRTUAL_DLY    CTRL_SI_dly = coe_ctrl_si_export;
    
//    assign  #VIRTUAL_DLY    coe_ctrl_rdy_export = CTRL_RDY;
//    assign  #VIRTUAL_DLY    coe_ctrl_so_export = CTRL_SO;
//    assign  #VIRTUAL_DLY    CPU_NXT_dly = coe_ctrl_nxt_export;
    
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
        
        avs_cpuctrl_writedata   = 0;
        avs_cntsclk_writedata   = 0;
        avs_sram_addr_writedata = 0;
        avs_sram_data_writedata = 0;
        
        avs_cpuctrl_write   = 1;
        avs_sram_addr_write = 1;
        avs_sram_data_write = 1;
        // Wait 100 ns for global RST_N to finish
        #(CLKPERIOD*10);//100;
        
        /* (0) Add stimulus here: Using a pseudo memory to load instruction*/ 
        i= DEFAULT_PC_ADDR*2;
        //Load I/O data_A to `gr2 as XIN
        tmpi_datain = {`LIOA, `gr2, 4'b0000, 4'b0000};
        i_mem.I_RAM[ i] = tmpi_datain[7:0];  i = 1 + DEFAULT_PC_ADDR*2;
        i_mem.I_RAM[ i] = tmpi_datain[15:8]; i = 2 + DEFAULT_PC_ADDR*2;
        //Load I/O data_A to `gr3 as YIN
        tmpi_datain = {`LIOA, `gr3, 4'b0000, 4'b0000};
        i_mem.I_RAM[ i] = tmpi_datain[7:0];  i = 3 + DEFAULT_PC_ADDR*2;
        i_mem.I_RAM[ i] = tmpi_datain[15:8]; i = 4 + DEFAULT_PC_ADDR*2;
        //set OFFSET as 0
        tmpi_datain = {`SUB, `gr4, 1'b0, `gr4, 1'b0, `gr4};
        i_mem.I_RAM[ i] = tmpi_datain[7:0];  i = 5 + DEFAULT_PC_ADDR*2;
        i_mem.I_RAM[ i] = tmpi_datain[15:8]; i = 6 + DEFAULT_PC_ADDR*2;
        //set the control reg for ALU
        tmpi_datain = {`SET, `gr1, 3'b001, 3'b100, 2'b01};
        i_mem.I_RAM[ i] = tmpi_datain[7:0];  i = 7 + DEFAULT_PC_ADDR*2;
        i_mem.I_RAM[ i] = tmpi_datain[15:8]; i = 8 + DEFAULT_PC_ADDR*2;
        
        //if (`gr3 != 0) go to I_RAM[ 9];
        // CPU is supposed to finish the loop automatically
        
        //Load I/O data_A to `gr2 as FOUT
        tmpi_datain = {`LIOA, `gr2, 4'b0000, 4'b0000};
        i_mem.I_RAM[ i] = tmpi_datain[7:0];  i = 9 + DEFAULT_PC_ADDR*2;
        i_mem.I_RAM[ i] = tmpi_datain[15:8]; i = 10+ DEFAULT_PC_ADDR*2;
        //Left Shift `gr2 and then save to SRAM
        tmpi_datain = {`SLL, `gr2, 1'b0, `gr2, 4'b0011};
        i_mem.I_RAM[ i] = tmpi_datain[7:0];  i = 11+ DEFAULT_PC_ADDR*2;
        i_mem.I_RAM[ i] = tmpi_datain[15:8]; i = 12+ DEFAULT_PC_ADDR*2;
        //reset the control reg for ALU
        tmpi_datain = {`SET, `gr1, 3'b000, 3'b000, 2'b00};
        i_mem.I_RAM[ i] = tmpi_datain[7:0];  i = 13+ DEFAULT_PC_ADDR*2;
        i_mem.I_RAM[ i] = tmpi_datain[15:8]; i = 14+ DEFAULT_PC_ADDR*2;
        //Save Multiplication to SRAM at 0x2;
        tmpi_datain = {`STORE, `gr2, 1'b0, `gr0, 4'b0010};
        i_mem.I_RAM[ i] = tmpi_datain[7:0];  i = 15+ DEFAULT_PC_ADDR*2;
        i_mem.I_RAM[ i] = tmpi_datain[15:8]; i = 16+ DEFAULT_PC_ADDR*2;
        
        //Clear OUT_A & Set SPI starting address;
        tmpi_datain = {`SUB, `gr2, 1'b0, `gr2, 1'b0, `gr2};
        i_mem.I_RAM[ i] = tmpi_datain[7:0];  i = 17 + DEFAULT_PC_ADDR*2;
        i_mem.I_RAM[ i] = tmpi_datain[15:8]; i = 18 + DEFAULT_PC_ADDR*2;
        tmpi_datain = {`SET, `gr2, 4'b0000, 4'b0011};
        i_mem.I_RAM[ i] = tmpi_datain[7:0];  i = 19 + DEFAULT_PC_ADDR*2;
        i_mem.I_RAM[ i] = tmpi_datain[15:8]; i = 20 + DEFAULT_PC_ADDR*2;
        
        //Clear OUT_B & Set SPI send data length;
        tmpi_datain = {`SUB, `gr3, 1'b0, `gr3, 1'b0, `gr3};
        i_mem.I_RAM[ i] = tmpi_datain[7:0];  i = 21 + DEFAULT_PC_ADDR*2;
        i_mem.I_RAM[ i] = tmpi_datain[15:8]; i = 22 + DEFAULT_PC_ADDR*2;
        tmpi_datain = {`SET, `gr3, 4'b0000, 4'b0010};
        i_mem.I_RAM[ i] = tmpi_datain[7:0];  i = 23 + DEFAULT_PC_ADDR*2;
        i_mem.I_RAM[ i] = tmpi_datain[15:8]; i = 24 + DEFAULT_PC_ADDR*2;
       
        //set the control reg for SPI
        tmpi_datain = {`SET, `gr1, 3'b010, 3'b000, 2'b00};
        i_mem.I_RAM[ i] = tmpi_datain[7:0];  i = 25 + DEFAULT_PC_ADDR*2;
        i_mem.I_RAM[ i] = tmpi_datain[15:8]; i = 26 + DEFAULT_PC_ADDR*2;
        
        // CPU is supposed to finish the loop automatically
        
        //reset the control reg for SPI
        tmpi_datain = {`SET, `gr1, 3'b000, 3'b000, 2'b00};
        i_mem.I_RAM[ i] = tmpi_datain[7:0];  i = 27 + DEFAULT_PC_ADDR*2;
        i_mem.I_RAM[ i] = tmpi_datain[15:8]; i = 28 + DEFAULT_PC_ADDR*2;
        
        //System finish
        tmpi_datain = {`HALT, 11'b000_0000_0000};
        i_mem.I_RAM[ i] = tmpi_datain[7:0];  i = 29 + DEFAULT_PC_ADDR*2;
        i_mem.I_RAM[ i] = tmpi_datain[15:8]; i = 30 + DEFAULT_PC_ADDR*2;
        
        i = 0;
        tmpi_datain = {`JUMP, 3'b000, 4'b0001, 4'b0000};// Jump to certain address
        i_mem.I_RAM[ i] = tmpi_datain[7:0];  i = 1;
        i_mem.I_RAM[ i] = tmpi_datain[15:8]; i = 2;
        tmpi_datain = 16'h3C00;
        i_mem.I_RAM[ i] = tmpi_datain[7:0];  i = 3;
        i_mem.I_RAM[ i] = tmpi_datain[15:8]; i = 4;
        tmpi_datain = 16'h0000;
        i_mem.I_RAM[ i] = tmpi_datain[7:0];  i = 5;
        i_mem.I_RAM[ i] = tmpi_datain[15:8]; i = 6;
        // i_mem.D_RAM[0] = 16'h00AB;
        // i_mem.D_RAM[1] = 16'h3C00;
        // i_mem.D_RAM[2] = 16'h0000;
        
        #CLKPERIOD rsi_reset_n = 1;
        #CLKPERIOD avs_cpuctrl_write = 0;
        avs_cpuctrl_writedata[IDX_SCPU_CTRL_RST] = 1'b1;
        avs_cpuctrl_writedata[IDX_SCPU_CTRL_TEST] = 1'b1;
        #CLKPERIOD avs_cpuctrl_write = 1;
        
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
        
        /* (2) Close CTRL module and Activate CPU to load from LIOA */
        #CLKPERIOD     CTRL_BGN = 0;
        avs_cpuctrl_writedata[IDX_SCPU_CTRL_BGN] = 0;
        avs_cpuctrl_write = 0;
        #CLKPERIOD avs_cpuctrl_write = 1;
        #CLKPERIOD avs_cpuctrl_write = 0;
        
        avs_xin_writedata = 240;//7//multiplicand
        avs_yin_writedata = 8'b01101011;//0.4140625 or 106 out of 256//multiplier
        
        #CLKPERIOD     CPU_BGN = 1;
        avs_cpuctrl_writedata[IDX_SCPU_CTRL_CPU] = 1;
        #CLKPERIOD avs_cpuctrl_write = 1;
        #CLKPERIOD avs_cpuctrl_write = 0;
        #CLKPERIOD     CPU_BGN = 0;
        avs_cpuctrl_writedata[IDX_SCPU_CTRL_CPU] = 0;
        #CLKPERIOD avs_cpuctrl_write = 1;
        #CLKPERIOD avs_cpuctrl_write = 0;
        
        // #(CLKPERIOD*10);
        // multiplicand = 240;//7
        // multiplier = 8'b01101011;//0.4140625 or 106 out of 256
        // ADC_PI = multiplicand;
        // #(CLKPERIOD*5);
        // ADC_PI = multiplier;
        // #(CLKPERIOD*5);
        
        // C code polling to do next
        //polling_wait(NXT[0]);
        begin : cpu_process_loop
            forever begin
                #CLKPERIOD;
                //if (CPU_NXT_dly[0]) begin
                if (avs_cpustat_ctrl_nxt0) begin
                    disable cpu_process_loop;
                end
            end
        end
        
        /* (3) fetch multiplication result from scan chain */
        for (i = 2; i<3; i=i+1) begin
            $write("%4x\t", (i<<1));
            for (k=2; k>=1; k=k-1) begin
                /** (a) load data to SRAM_IO_CTRL from PC **/
                // C code modify control word
                #CLKPERIOD CTRL_BGN = 1;
                avs_cpuctrl_writedata[IDX_SCPU_CTRL_BGN] = 1;
                #CLKPERIOD CTRL_MODE = 2'b00;
                avs_cpuctrl_writedata[IDX_SCPU_CTRL_MOD1] = 0;
                avs_cpuctrl_writedata[IDX_SCPU_CTRL_MOD0] = 0;

                tmpi_adder = (i<<1)+k-1;
                tmpi_all = {tmpi_adder, {MEMORY_DATA_WIDTH{1'b0}}};//i_mem.I_RAM[tmpi_adder]
                avs_sram_addr_writedata = tmpi_adder;
                avs_sram_data_writedata = {MEMORY_DATA_WIDTH{1'b1}};
                // C code triger FPGA gen Load signal
                avs_cpuctrl_write = 0;
                #CLKPERIOD avs_cpuctrl_write = 1;
                avs_cpuctrl_writedata[IDX_SCPU_CTRL_LOAD] = 1;

                // begin
                    // FPGA send Load signal & data to CTRL
                    // #10 LOAD_N = 0;
                    // for (j = 0; j < REG_BITS_WIDTH; j=j+1) begin
                        // #10 CTRL_SI = tmpi_all[j];
                    // end
                // end
        
                // C code polling to do next
                //polling_wait(CTRL_RDY);
                begin: ctrl_module_load_ready_2nd
                forever begin
                    #CLKPERIOD;
                    if (avs_cpustat_ctrl_rdy) begin
                        disable ctrl_module_load_ready_2nd;
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
                begin: ctrl_module_load_finish_2nd
                forever begin
                    #CLKPERIOD;
                    if (!avs_cpustat_ctrl_rdy) begin
                        disable ctrl_module_load_finish_2nd;
                    end
                end
                end
        
                /** (b) notify SRAM_IO_CTRL to send data to SRAM **/
                // C code modify control word
                #CLKPERIOD CTRL_BGN = 1;
                avs_cpuctrl_writedata[IDX_SCPU_CTRL_BGN] = 1;
                #CLKPERIOD CTRL_MODE = 2'b01;
                avs_cpuctrl_writedata[IDX_SCPU_CTRL_MOD1] = 0;
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
                begin: ctrl_module_read_ready
                forever begin
                    #(CLKPERIOD);
                    if (avs_cpustat_ctrl_rdy) begin
                        disable ctrl_module_read_ready;
                    end
                end
                end

                // C code modify control word
                #(CLKPERIOD) CTRL_BGN = 0;
                avs_cpuctrl_writedata[IDX_SCPU_CTRL_BGN] = 0;
                #(CLKPERIOD) LOAD_N = 1;//this FPGA signal is related to CTRL_BGN
                avs_cpuctrl_write = 0;
                #(CLKPERIOD) avs_cpuctrl_write = 1;
                avs_cpuctrl_writedata[IDX_SCPU_CTRL_LOAD] = 0;
                begin: ctrl_module_read_finish
                forever begin
                    #(CLKPERIOD);
                    if (!avs_cpustat_ctrl_rdy) begin
                        disable ctrl_module_read_finish;
                    end
                end
                end
                
                /** (c) Export SRAM data from SRAM_IO_CTRL **/
                // C code modify control word
                #(CLKPERIOD) CTRL_BGN = 1;
                avs_cpuctrl_writedata[IDX_SCPU_CTRL_BGN] = 1;
                #(CLKPERIOD) CTRL_MODE = 2'b00;
                avs_cpuctrl_writedata[IDX_SCPU_CTRL_MOD1] = 1;
                avs_cpuctrl_writedata[IDX_SCPU_CTRL_MOD0] = 0;
                
                tmpi_adder = {MEMORY_ADDR_WIDTH{1'b0}};
                tmpi_all = {tmpi_adder, {MEMORY_DATA_WIDTH{1'b0}}};//i_mem.I_RAM[tmpi_adder]
                avs_sram_addr_writedata = tmpi_adder;
                avs_sram_data_writedata = {MEMORY_DATA_WIDTH{1'b0}};
                // C code triger FPGA gen Load signal
                avs_cpuctrl_write = 0;
                #(CLKPERIOD) avs_cpuctrl_write = 1;
                avs_cpuctrl_writedata[IDX_SCPU_CTRL_LOAD] = 1;
                
                // begin
                    // FPGA send Load signal & data to CTRL
                    // #10 LOAD_N = 0;
                    // for (j = 0; j < REG_BITS_WIDTH; j=j+1) begin
                        // #10 SI = tmpi_all[j];
                    // end
                // end

                // C code polling to do next
                begin: ctrl_module_load_ready_3nd
                forever begin
                    #(CLKPERIOD);
                    if (avs_cpustat_ctrl_rdy) begin
                        disable ctrl_module_load_ready_3nd;
                    end
                end
                end
                
                // C code modify control word
                #(CLKPERIOD) CTRL_BGN = 0;
                avs_cpuctrl_writedata[IDX_SCPU_CTRL_BGN] = 0;
                #(CLKPERIOD) LOAD_N = 1;//this FPGA signal is related to CTRL_BGN
                avs_cpuctrl_write = 0;
                #(CLKPERIOD) avs_cpuctrl_write = 1;
                avs_cpuctrl_writedata[IDX_SCPU_CTRL_LOAD] = 0;
                begin: ctrl_module_load_finish_3nd
                forever begin
                    #(CLKPERIOD);//10;
                    if (!avs_cpustat_ctrl_rdy) begin
                        disable ctrl_module_load_finish_3nd;
                    end
                end
                end
                
                $write("%8b ", avs_sram_data_readdata[MEMORY_DATA_WIDTH-1:0]);
                if (k == 1)
                    tmpi_datain[MEMORY_DATA_WIDTH-1:0] = avs_sram_data_readdata[MEMORY_DATA_WIDTH-1:0];
                else if (k == 2)
                    tmpi_datain[2*MEMORY_DATA_WIDTH-1:MEMORY_DATA_WIDTH] = avs_sram_data_readdata[MEMORY_DATA_WIDTH-1:0];
            end

            if (i == 2) begin
                if ((tmpi_datain>>3) == (multiplicand*{1'b1,multiplier}/256))
                    $write("\t<--- (Multiplication << 3) Correct!");
                else begin
                    $write("\t<--- (Multiplication << 3) Wrong!");
                    error_cnt = error_cnt + 1;
                end
            end
            $display("");
        end

        // (4) Judge Final Test Result
        if (error_cnt)
            $display("Test Failed!");
        else if (CFSA_FOUT != (multiplicand*{1'b1,multiplier}/256))
            $display("Test Failed!");
        else
            $display("Test Passed!");
        #(CLKPERIOD*2) $stop();
    end

    always #(CLKPERIOD/2)
        CLK = ~CLK;

    // Dump signals to view waveform
    // initial
    // begin
        // $dumpfile ("wave_scan_vg.dump");
        // $dumpvars (0, SYS_PSEUDO_SPI_INTF_SCAN_VG_TEST);
    // end
   
endmodule

