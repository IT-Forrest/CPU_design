//+FHDR****************************************************************
// ECE department, TAMU
// --------------------------------------------------------------------
// FILE NAME    : SCPU_IO_CTRL_LOGIC_TEST.v
// AUTHER       : Jiafan Wang
// DATE         : 07/10/2016
// VERSION      : 1.0
// PURPOSE      : works as PC manager in C Language
// --------------------------------------------------------------------
// ABSTRACT: ModelSim simulation time 6us given each time period 10ns
// --------------------------------------------------------------------
`timescale 1ns / 1ps
`include "../DEFINE_CPU.v"
`include "../SRAM_IO_CTRL.v"
`include "../SRAM_IO_CTRL_LOGIC.v"
`include "../I_MEMORY_8bit.v"

module SRAM_IO_CTRL_LOGIC_TEST;

   parameter    MEMORY_DATA_WIDTH   = 8,
                MEMORY_ADDR_WIDTH   = 9,
                REG_BITS_WIDTH = MEMORY_ADDR_WIDTH + MEMORY_DATA_WIDTH;

    // Inputs
    reg clk;
    reg rsi_reset_n;
    reg CTRL_BGN;// enable signal for CTRL_SRAM
    reg start;// enable signal for SERIAL_CPU_8bit
    reg [1:0]   CTRL_MODE;
    
    // Wires
    // wire is_i_addr;
    // wire [7:0]  i_datain;
    // wire [7:0]  d_datain;
    // wire [7:0]  d_dataout;
    wire [7:0]  m_datain;

    wire [7:0]  m_dataout;
    wire [8:0]  m_addr;
    // wire [8:0]  i_addr;
    // wire [8:0]  d_addr;
    wire d_we;
    wire CEN;
    wire SO;
    wire RDY;
    
    integer i,j,k;
    integer error_cnt;
    reg  [15:0] tmpi_datain;
    reg  [REG_BITS_WIDTH-1:0]  tmpi_all;//addr+instruction
    reg  [8:0]  tmpi_adder;
    reg  SI;
    reg  LOAD_N;
   
    // Instantiate the Unit Under Test (UUT)
    SRAM_IO_CTRL cct (
        .CLK    (clk),
        .BGN    (coe_ctrl_bgn_export),
        .SI     (coe_ctrl_si_export),
        .LOAD_N (!coe_ctrl_load_export),// might invert later
        .CTRL   ({coe_ctrl_mod1_export,coe_ctrl_mod0_export}),
        .PI     (m_dataout),
        .RDY    (coe_ctrl_rdy_export),
        .D_WE   (d_we),
        .CEN    (CEN),
        .SO     (coe_ctrl_so_export),
        .A      (m_addr),
        .PO     (m_datain)
    );
    
    parameter   IDX_SCPU_CTRL_BGN  = 0;     // SCPU CTRL Module's start bit
    parameter   IDX_SCPU_CTRL_LOAD = 1;     // SCPU CTRL Module's load bit
    parameter   IDX_SCPU_CTRL_MOD0 = 2;     // SCPU CTRL Module's mode bit
    parameter   IDX_SCPU_CTRL_MOD1 = 3;     // SCPU CTRL Module's mode bit

    parameter   IDX_SCPU_CTRL_RDY  = 0;
    
    reg     avs_cpuctrl_write;
    reg     avs_sram_addr_write;
    reg     avs_sram_data_write;
    
    reg     [31:0]  avs_cpuctrl_writedata;
    wire    [31:0]  avs_cpustat_readdata;
    reg     [31:0]  avs_sram_addr_writedata;
    reg     [31:0]  avs_sram_data_writedata;
    
    wire    [31:0]  avs_sram_addr_readdata;
    wire    [31:0]  avs_sram_data_readdata;
    
    assign  RDY = avs_cpustat_readdata[IDX_SCPU_CTRL_RDY];
    
    SRAM_IO_CTRL_LOGIC fpga(
        //input
        .csi_clk                (clk                    ),                // Clock
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

        // .avs_adc_writedata      (avs_adc_writedata      ),          // ADC data from analog
        // .avs_adc_write          (avs_adc_write          ),

        //// Internal Output Connections ////
        .avs_sram_addr_readdata (avs_sram_addr_readdata ),     // Instruction addr value
        .avs_sram_data_readdata (avs_sram_data_readdata ),     // Instruction data value

        //// External I/O Connections (Output)
        .coe_ctrl_bgn_export    (coe_ctrl_bgn_export    ),
        .coe_ctrl_mod0_export   (coe_ctrl_mod0_export   ),
        .coe_ctrl_mod1_export   (coe_ctrl_mod1_export   ),
        .coe_ctrl_load_export   (coe_ctrl_load_export   ),
        .coe_ctrl_si_export     (coe_ctrl_si_export     ),
        //// External I/O Connections (Input)
        .coe_ctrl_so_export     (coe_ctrl_so_export     ),
        .coe_ctrl_rdy_export    (coe_ctrl_rdy_export    )
    );
    
    I_MEMORY_8BIT   sram (
        .clk(clk),
        .rst_n(!CEN), 
        .addr(m_addr),
        .d_we(!d_we),// need a seperate control signal; or instruction set will be overwritten when d_we=1
        .datain(m_datain),//i_instruct
        .dataout(m_dataout)
    );

    I_MEMORY_8BIT   i_mem(
        // .clk(clk),
        // .rst_n(CEN), 
        // .addr(m_addr),
        // .d_we(d_we),// need a seperate control signal; or instruction set will be overwritten when d_we=1
        // .datain(m_datain),//i_instruct
        // .dataout(m_dataout)
    );
    
    parameter   DEFAULT_PC_ADDR = 16;
    //defparam    uut.DEFAULT_PC_ADDR = DEFAULT_PC_ADDR;

    
    initial begin
        // Initialize Inputs
        clk = 0;
        rsi_reset_n = 0;
        CTRL_BGN = 0;
        start = 0;
        LOAD_N = 1;
        error_cnt = 0;
        CTRL_MODE = 2'b00;
        
        avs_cpuctrl_writedata   = 0;
        avs_sram_addr_writedata = 0;
        avs_sram_data_writedata = 0;
        
        avs_cpuctrl_write   = 1;
        avs_sram_addr_write = 1;
        avs_sram_data_write = 1;
        // Wait 100 ns for global rst_n to finish
        #100;
        
        // Add stimulus here
        // $display("pc  :               id_ir                :reg_A :reg_B :reg_C\
            // : da  :  dd  : w :  gr1  :  gr2  :  gr3   :zf :nf:cf");
        // $monitor("%3d : %b : %h : %h : %h : %h : %h : %b : %h : %h : %h : %b : %b : %b", 
            // uut.pc, uut.id_ir, uut.reg_A, uut.reg_B, uut.reg_C,
            // d_addr, d_dataout, d_we, uut.gr[1], uut.gr[2], uut.gr[3],
            // uut.zf, uut.nf, uut.cf);

        /* (1) Initilization  */
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
        tmpi_datain = {`HALT, 11'b000_0000_0000};//due to the pipeline, we need to add many `NOP to the instruction set
        i_mem.I_RAM[ i] = tmpi_datain[7:0];  i = 13+ DEFAULT_PC_ADDR*2;
        i_mem.I_RAM[ i] = tmpi_datain[15:8]; i = 14+ DEFAULT_PC_ADDR*2;
        // i_mem.I_RAM[19] = {`NOP, 11'b000_0000_0000};
        // i_mem.I_RAM[20] = {`NOP, 11'b000_0000_0000};
        // i_mem.I_RAM[21] = {`NOP, 11'b000_0000_0000};
        
        i = 0;
        tmpi_datain = 16'h00AB;
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

        #10 rsi_reset_n = 0; 
        #10 rsi_reset_n = 1;

        /* (2) Serially Input the address & Instruction to CTRL and then to SRAM */
        for (i = DEFAULT_PC_ADDR; i<7+ DEFAULT_PC_ADDR; i=i+1) begin
            for (k = 2; k>=1; k=k-1) begin
                /** (a) load data to SRAM_IO_CTRL from PC **/
                // C code modify control word

                #10 CTRL_BGN = 1;
                avs_cpuctrl_writedata[IDX_SCPU_CTRL_BGN] = 1'b1;
                #10 CTRL_MODE = 2'b00;
                avs_cpuctrl_writedata[IDX_SCPU_CTRL_MOD0] = 1'b0;
                avs_cpuctrl_writedata[IDX_SCPU_CTRL_MOD1] = 1'b0;
                
                tmpi_adder = (i<<1)+k-1;
                tmpi_all = {tmpi_adder, i_mem.I_RAM[tmpi_adder]};
                avs_sram_addr_writedata = tmpi_adder;
                avs_sram_data_writedata = i_mem.I_RAM[tmpi_adder];
                // C code triger FPGA gen Load signal
                avs_cpuctrl_write = 0;
                #10 avs_cpuctrl_write = 1;
                avs_cpuctrl_writedata[IDX_SCPU_CTRL_LOAD] = 1'b1;

                // begin
                    // FPGA send Load signal & data to CTRL
                    // #10 LOAD_N = 0;
                    // for (j = 0; j < REG_BITS_WIDTH; j=j+1) begin
                        // #10 SI = tmpi_all[j];
                    // end
                // end

                // C code polling to do next
                begin: ctrl_module_load_ready
                forever begin
                    #10;
                    if (RDY) begin
                        disable ctrl_module_load_ready;
                    end
                end
                end
                
                // C code modify control word
                #10 CTRL_BGN = 0;
                avs_cpuctrl_writedata[IDX_SCPU_CTRL_BGN] = 0;
                #10 LOAD_N = 1;//this FPGA signal is related to CTRL_BGN
                avs_cpuctrl_write = 0;
                #10 avs_cpuctrl_write = 1;
                avs_cpuctrl_writedata[IDX_SCPU_CTRL_LOAD] = 0;
                begin: ctrl_module_load_finish
                forever begin
                    #10;
                    if (!RDY) begin
                        disable ctrl_module_load_finish;
                    end
                end
                end

                /** (b) notify SRAM_IO_CTRL to send data to SRAM **/
                // C code modify control word
                #10 CTRL_BGN = 1;
                avs_cpuctrl_writedata[IDX_SCPU_CTRL_BGN] = 1;
                #10 CTRL_MODE = 2'b11;
                avs_cpuctrl_writedata[IDX_SCPU_CTRL_MOD0] = 1;
                avs_cpuctrl_writedata[IDX_SCPU_CTRL_MOD1] = 1;
                // C code triger FPGA gen Load signal
                avs_cpuctrl_write = 0;
                #10 avs_cpuctrl_write = 1;
                avs_cpuctrl_writedata[IDX_SCPU_CTRL_LOAD] = 1;
                
                // begin
                    // FPGA send Load signal & data to CTRL
                    // #10 LOAD_N = 0;
                // end
                
                // C code polling to do next
                begin: ctrl_module_write_ready
                forever begin
                    #10;
                    if (RDY) begin
                        disable ctrl_module_write_ready;
                    end
                end
                end
                
                // C code modify control word
                #10 CTRL_BGN = 0;
                avs_cpuctrl_writedata[IDX_SCPU_CTRL_BGN] = 0;
                #10 LOAD_N = 1;//this FPGA signal is related to CTRL_BGN
                avs_cpuctrl_write = 0;
                #10 avs_cpuctrl_write = 1;
                avs_cpuctrl_writedata[IDX_SCPU_CTRL_LOAD] = 0;
                begin: ctrl_module_write_finish
                forever begin
                    #10;
                    if (!RDY) begin
                        disable ctrl_module_write_finish;
                    end
                end
                end
            end
        end
        #3130;
        
        // (3) Read the inner instructions
        //force   CEN = 0;//enable RA1SHD_ibm512x8
        //force   d_we = 0;//read module
        for (i = DEFAULT_PC_ADDR; i<7+ DEFAULT_PC_ADDR; i=i+1) begin
            $write("%4x\t", (i<<1));
            for (k = 2; k >= 1; k=k-1) begin
                /** (a) load data to SRAM_IO_CTRL from PC **/
                // C code modify control word
                #10 CTRL_BGN = 1;
                avs_cpuctrl_writedata[IDX_SCPU_CTRL_BGN] = 1;
                #10 CTRL_MODE = 2'b00;
                avs_cpuctrl_writedata[IDX_SCPU_CTRL_MOD0] = 0;
                avs_cpuctrl_writedata[IDX_SCPU_CTRL_MOD1] = 0;
                
                tmpi_adder = (i<<1)+k-1;
                tmpi_all = {tmpi_adder, {MEMORY_DATA_WIDTH{1'b0}}};//i_mem.I_RAM[tmpi_adder]
                avs_sram_addr_writedata = tmpi_adder;
                avs_sram_data_writedata = {MEMORY_DATA_WIDTH{1'b0}};
                // C code triger FPGA gen Load signal
                avs_cpuctrl_write = 0;
                #10 avs_cpuctrl_write = 1;
                avs_cpuctrl_writedata[IDX_SCPU_CTRL_LOAD] = 1;
                
                // begin
                    // FPGA send Load signal & data to CTRL
                    // #10 LOAD_N = 0;
                    // for (j = 0; j < REG_BITS_WIDTH; j=j+1) begin
                        // #10 SI = tmpi_all[j];
                    // end
                // end

                // C code polling to do next
                begin: ctrl_module_load_ready_2nd
                forever begin
                    #10;
                    if (RDY) begin
                        disable ctrl_module_load_ready_2nd;
                    end
                end
                end
                
                // C code modify control word
                #10 CTRL_BGN = 0;
                avs_cpuctrl_writedata[IDX_SCPU_CTRL_BGN] = 0;
                #10 LOAD_N = 1;//this FPGA signal is related to CTRL_BGN
                avs_cpuctrl_write = 0;
                #10 avs_cpuctrl_write = 1;
                avs_cpuctrl_writedata[IDX_SCPU_CTRL_LOAD] = 0;
                begin: ctrl_module_load_finish_2nd
                forever begin
                    #10;
                    if (!RDY) begin
                        disable ctrl_module_load_finish_2nd;
                    end
                end
                end
               
                /** (b) notify SRAM_IO_CTRL to send data to SRAM **/
                // C code modify control word
                #10 CTRL_BGN = 1;
                avs_cpuctrl_writedata[IDX_SCPU_CTRL_BGN] = 1;
                #10 CTRL_MODE = 2'b01;
                avs_cpuctrl_writedata[IDX_SCPU_CTRL_MOD0] = 1;
                avs_cpuctrl_writedata[IDX_SCPU_CTRL_MOD1] = 0;
                // C code triger FPGA gen Load signal
                avs_cpuctrl_write = 0;
                #10 avs_cpuctrl_write = 1;
                avs_cpuctrl_writedata[IDX_SCPU_CTRL_LOAD] = 1;
                
                // begin
                    // FPGA send Load signal & data to CTRL
                    // #10 LOAD_N = 0;
                // end
                
                // C code polling to do next
                begin: ctrl_module_read_ready
                forever begin
                    #10;
                    if (RDY) begin
                        disable ctrl_module_read_ready;
                    end
                end
                end
                
                // C code modify control word
                #10 CTRL_BGN = 0;
                avs_cpuctrl_writedata[IDX_SCPU_CTRL_BGN] = 0;
                #10 LOAD_N = 1;//this FPGA signal is related to CTRL_BGN
                avs_cpuctrl_write = 0;
                #10 avs_cpuctrl_write = 1;
                avs_cpuctrl_writedata[IDX_SCPU_CTRL_LOAD] = 0;
                begin: ctrl_module_read_finish
                forever begin
                    #10;
                    if (!RDY) begin
                        disable ctrl_module_read_finish;
                    end
                end
                end
                
                /** (c) Export SRAM data from SRAM_IO_CTRL**/
                $write("%8b ", cct.reg_bits[MEMORY_DATA_WIDTH-1:0]);
                if (k == 1)
                    tmpi_datain[MEMORY_DATA_WIDTH-1:0] = cct.reg_bits[MEMORY_DATA_WIDTH-1:0];
                else if (k == 2)
                    tmpi_datain[2*MEMORY_DATA_WIDTH-1:MEMORY_DATA_WIDTH] = cct.reg_bits[MEMORY_DATA_WIDTH-1:0];
            end
        
            if (tmpi_datain != {i_mem.I_RAM[(i<<1)+1],i_mem.I_RAM[i<<1]}) begin
                $write("<-- Data Wrong!");
                error_cnt = error_cnt + 1;
            end
            $display("");
        end
        
        // Judge Final Test Result
        if (error_cnt)
            $display("Test Failed!");
        else
            $display("Test Passed!");
        //#10 release CEN; release d_we;
        $stop();//
    end
    
    always #5
        clk = ~clk;
      
endmodule

