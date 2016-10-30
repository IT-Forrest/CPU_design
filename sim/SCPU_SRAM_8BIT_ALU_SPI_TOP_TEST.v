//+FHDR****************************************************************
// ECE department, TAMU
// --------------------------------------------------------------------
// FILE NAME    : SCPU_SRAM_8BIT_ALU_SPI_TOP_TEST.v
// AUTHER       : Jiafan Wang
// DATE         : 07/04/2016
// VERSION      : 1.0
// PURPOSE      : test the SCPU_SRAM_8BIT_ALU_SPI_TOP whole block
// --------------------------------------------------------------------
// ABSTRACT: ModelSim simulation time 6us given each time period 10ns
// --------------------------------------------------------------------
`timescale 1ns / 1ps
`include "../DEFINE_CPU.v"
`include "../SCPU_SRAM_8BIT_ALU_SPI_TOP.v"
`include "../I_MEMORY_8bit.v"

module SCPU_SRAM_8BIT_ALU_SPI_TOP_TEST;

    parameter   MEMORY_DATA_WIDTH   = 8,
                MEMORY_ADDR_WIDTH   = 10,
                REG_BITS_WIDTH = MEMORY_ADDR_WIDTH + MEMORY_DATA_WIDTH;

    parameter   GENERAL_REG_WIDTH   = 16;
    parameter   DEFAULT_PC_ADDR     = 16;
   
    // Inputs
    integer i,j,k;
    integer error_cnt;

    reg     [REG_BITS_WIDTH-1:0]  tmpi_all;//addr+instruction
    reg     [15:0] tmpi_datain; //MEMORY_DATA_WIDTH*2 -1
    reg     [MEMORY_ADDR_WIDTH-1:0]  tmpi_adder;  //MEMORY_ADDR_WIDTH -1

    reg     CLK;
    reg     RST_N;//no use here
    reg     [1:0]  CTRL_MODE;
    reg     CTRL_BGN;
    reg     CPU_BGN;// enable signal for SERIAL_CPU_8bit
    reg     LOAD_N;
    reg     CTRL_SI;
    reg     CPU_WAIT;
    reg     [9:0] ADC_PI;
    reg     [2:0] TEST_MUX;
    
    // Wires
    wire    CTRL_RDY;
    wire    APP_START;
    wire    CTRL_SO;
    wire    ANA_SO;
    wire    [1:0]  NXT;
    wire    SEL;
    wire    SCLK1;
    wire    SCLK2;
    wire    LAT;
    wire    CLRN;
    wire    CLK_ADC;
    wire    RSTN_ADC;
    
    SCPU_SRAM_8BIT_ALU_SPI_TOP  scpu_sram_alu(
        .CLK            (CLK        ),
        .RST_N          (RST_N      ),
        .CTRL_MODE      (CTRL_MODE  ),
        .CTRL_BGN       (CTRL_BGN   ),
        .CPU_BGN        (CPU_BGN    ),
        .LOAD_N         (LOAD_N     ),
        .CTRL_SI        (CTRL_SI    ),
        .APP_DONE       (1'b1   ),
        .ADC_PI         (ADC_PI     ),
        .TEST_MUX       (TEST_MUX   ),//for debug
        .CPU_WAIT       (CPU_WAIT   ),
        // output
        .CTRL_RDY       (CTRL_RDY   ),
        .APP_START      (APP_START  ),
        .CTRL_SO        (CTRL_SO    ),
        //.ANA_SO         (ANA_SO     ),
        .NXT            (NXT        ),
        //.SEL            (SEL        ),
        .SCLK1          (SCLK1      ),
        .SCLK2          (SCLK2      ),
        .LAT            (LAT        ),
        .SPI_SO         (SPI_SO     )
        //.CLRN           (CLRN       ),
        //.CLK_ADC        (CLK_ADC    ),
        //.RSTN_ADC       (RSTN_ADC   )
    );
   
    // only used for testbench
    I_MEMORY_8BIT   i_mem(
        // .CLK(CLK),
        // .RST_N(CEN), 
        // .addr(m_addr),
        // .d_we(d_we),// need a seperate control signal; or instruction set will be overwritten when d_we=1
        // .datain(m_datain),//i_instruct
        // .dataout(m_dataout)
    );
    
    initial begin
        // Initialize Inputs Signals
        CLK = 0;
        RST_N = 0;
        CTRL_BGN = 0;
        CPU_BGN = 0;
        LOAD_N = 1;
        error_cnt = 0;
        CTRL_MODE = 2'b00;
        CPU_WAIT = 0;
        TEST_MUX = 3'b000;
        #100;
        // Wait 100 ns for global RST_N to finish

        /* (0) Add stimulus here: Using a pseudo memory to load instruction*/ 
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

        #10 RST_N = 0; CTRL_BGN = 1;
        #10 RST_N = 1; 

        /* (1) Serially Input the address & Instruction to CTRL and then to SRAM */
        for (i = 0; i<7+ DEFAULT_PC_ADDR; ) begin
            for (k=2; k>=1; k=k-1) begin
                /** (a) load data to SRAM_IO_CTRL from PC **/
                // C code modify control word
                #10 CTRL_BGN = 1;
                #10 CTRL_MODE = 2'b00;
                tmpi_adder = (i<<1)+k-1;
                tmpi_all = {tmpi_adder, i_mem.I_RAM[tmpi_adder]};
                // C code triger FPGA gen Load signal
                
                begin
                    // FPGA send Load signal & data to CTRL
                    #10 LOAD_N = 0;
                    #10;//need to wait one more cycle for the delay
                    for (j = 0; j < REG_BITS_WIDTH; j=j+1) begin
                        #10 CTRL_SI = tmpi_all[j];
                    end
                end
                
                // C code polling to do next
                //polling_wait(CTRL_RDY);
                begin: ctrl_module_load_ready
                forever begin
                    #10;
                    if (CTRL_RDY) begin
                        disable ctrl_module_load_ready;
                    end
                end
                end
                
                // C code modify control word
                #10 CTRL_BGN = 0;
                #10 LOAD_N = 1;//this FPGA signal is related to CTRL_BGN
                //polling_wait(!CTRL_RDY);
                begin: ctrl_module_load_finish
                forever begin
                    #10;
                    if (!CTRL_RDY) begin
                        disable ctrl_module_load_finish;
                    end
                end
                end
                
                /** (b) notify SRAM_IO_CTRL to send data to SRAM **/
                // C code modify control word
                #10 CTRL_BGN = 1;
                #10 CTRL_MODE = 2'b11;
                // C code triger FPGA gen Load signal
                
                begin
                    // FPGA send Load signal & data to CTRL
                    #10 LOAD_N = 0;
                end

                // C code polling to do next
                //polling_wait(CTRL_RDY);
                begin: ctrl_module_write_ready
                forever begin
                    #10;
                    if (CTRL_RDY) begin
                        disable ctrl_module_write_ready;
                    end
                end
                end
                
                // C code modify control word
                #10 CTRL_BGN = 0;
                #10 LOAD_N = 1;//this FPGA signal is related to CTRL_BGN
                //polling_wait(!CTRL_RDY);
                begin: ctrl_module_write_finish
                forever begin
                    #10;
                    if (!CTRL_RDY) begin
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
        #1500;
        
        /* (2) Activate CPU to load from SRAM and then run */
        #10     CTRL_BGN = 0;
        #10     CPU_BGN = 1;
        #10     CPU_BGN = 0;
        
        // C code polling to do next
        //polling_wait(NXT[0]);
        begin : cpu_process_loop
            forever begin
                #10;
                if (NXT[0]) begin
                    disable cpu_process_loop;
                end
            end
        end
        
        /* (3) fetch the inner instructions */ 
        // force   CEN_after_mux = 0;//enable RA1SHD_ibm512x8
        // force   WEN_after_mux = 1;//read module
        #10     CTRL_BGN = 1;
        for (i = DEFAULT_PC_ADDR; i<7+ DEFAULT_PC_ADDR; i=i+1) begin
            $write("%4x\t", (i<<1));
            for (k=2; k>=1; k=k-1) begin
                /** (a) load data to SRAM_IO_CTRL from PC **/
                // C code modify control word
                #10 CTRL_BGN = 1;
                #10 CTRL_MODE = 2'b00;
                tmpi_adder = (i<<1)+k-1;
                tmpi_all = {tmpi_adder, {MEMORY_DATA_WIDTH{1'b0}}};//i_mem.I_RAM[tmpi_adder]
                // C code triger FPGA gen Load signal

                begin
                    // FPGA send Load signal & data to CTRL
                    #10 LOAD_N = 0;
                    #10;//need to wait one more cycle for the delay
                    for (j = 0; j < REG_BITS_WIDTH; j=j+1) begin
                        #10 CTRL_SI = tmpi_all[j];
                    end
                end

                // C code polling to do next
                //polling_wait(CTRL_RDY);
                begin: ctrl_module_load_ready_2nd
                forever begin
                    #10;
                    if (CTRL_RDY) begin
                        disable ctrl_module_load_ready_2nd;
                    end
                end
                end
                
                // C code modify control word
                #10 CTRL_BGN = 0;
                #10 LOAD_N = 1;//this FPGA signal is related to CTRL_BGN
                //polling_wait(!CTRL_RDY);
                begin: ctrl_module_load_finish_2nd
                forever begin
                    #10;
                    if (!CTRL_RDY) begin
                        disable ctrl_module_load_finish_2nd;
                    end
                end
                end
                
                /** (b) notify SRAM_IO_CTRL to send data to SRAM **/
                // C code modify control word
                #10 CTRL_BGN = 1;
                #10 CTRL_MODE = 2'b01;
                // C code triger FPGA gen Load signal
                
                begin
                    // FPGA send Load signal & data to CTRL
                    #10 LOAD_N = 0;
                end

                // C code polling to do next
                //polling_wait(CTRL_RDY);
                begin: ctrl_module_read_ready
                forever begin
                    #10;
                    if (CTRL_RDY) begin
                        disable ctrl_module_read_ready;
                    end
                end
                end
                
                // C code modify control word
                #10 CTRL_BGN = 0;
                #10 LOAD_N = 1;//this FPGA signal is related to CTRL_BGN
                //polling_wait(!CTRL_RDY);
                begin: ctrl_module_read_finish
                forever begin
                    #10;
                    if (!CTRL_RDY) begin
                        disable ctrl_module_read_finish;
                    end
                end
                end
                
                /** (c) Export SRAM data from SRAM_IO_CTRL **/
                $write("%8b ", scpu_sram_alu.scpu_ctrl_spi.cct.reg_bits[MEMORY_DATA_WIDTH-1:0]);
                if (k == 1)
                    tmpi_datain[MEMORY_DATA_WIDTH-1:0] = scpu_sram_alu.scpu_ctrl_spi.cct.reg_bits[MEMORY_DATA_WIDTH-1:0];
                else if (k == 2)
                    tmpi_datain[2*MEMORY_DATA_WIDTH-1:MEMORY_DATA_WIDTH] = scpu_sram_alu.scpu_ctrl_spi.cct.reg_bits[MEMORY_DATA_WIDTH-1:0];
            end
            
            if ({i_mem.I_RAM[(i<<1)+1],i_mem.I_RAM[(i<<1)]} == tmpi_datain)
                $write("\t<--- Inst Correct!");
            else begin
                $write("\t<--- Inst Wrong!");
                error_cnt = error_cnt + 1;
            end
            $display("");
        end
        
        // (4) Judge Final Test Result
        if (error_cnt)
            $display("Test Failed!");
        else begin
            i = 2;
            $write("%4x\t", (i<<1));
            for (k=2; k>=1; k=k-1) begin
                /** (a) load data to SRAM_IO_CTRL from PC **/
                // C code modify control word
                #10 CTRL_BGN = 1;
                #10 CTRL_MODE = 2'b00;
                tmpi_adder = (i<<1)+k-1;
                tmpi_all = {tmpi_adder, {MEMORY_DATA_WIDTH{1'b0}}};//i_mem.I_RAM[tmpi_adder]
                // C code triger FPGA gen Load signal
            
                begin
                    // FPGA send Load signal & data to CTRL
                    #10 LOAD_N = 0;
                    #10;//need to wait one more cycle for the delay
                    for (j = 0; j < REG_BITS_WIDTH; j=j+1) begin
                        #10 CTRL_SI = tmpi_all[j];
                    end
                end
            
                // C code polling to do next
                //polling_wait(CTRL_RDY);
                begin: ctrl_module_load_ready_4th
                forever begin
                    #10;
                    if (CTRL_RDY) begin
                        disable ctrl_module_load_ready_4th;
                    end
                end
                end
                
                // C code modify control word
                #10 CTRL_BGN = 0;
                #10 LOAD_N = 1;//this FPGA signal is related to CTRL_BGN
                //polling_wait(!CTRL_RDY);
                begin: ctrl_module_load_finish_4th
                forever begin
                    #10;
                    if (!CTRL_RDY) begin
                        disable ctrl_module_load_finish_4th;
                    end
                end
                end
                
                /** (b) notify SRAM_IO_CTRL to send data to SRAM **/
                // C code modify control word
                #10 CTRL_BGN = 1;
                #10 CTRL_MODE = 2'b01;
                // C code triger FPGA gen Load signal
                
                begin
                    // FPGA send Load signal & data to CTRL
                    #10 LOAD_N = 0;
                end
                
                // C code polling to do next
                //polling_wait(CTRL_RDY);
                begin: ctrl_module_read_ready_2nd
                forever begin
                    #10;
                    if (CTRL_RDY) begin
                        disable ctrl_module_read_ready_2nd;
                    end
                end
                end
                
                // C code modify control word
                #10 CTRL_BGN = 0;
                #10 LOAD_N = 1;//this FPGA signal is related to CTRL_BGN

                //polling_wait(!CTRL_RDY);
                begin: ctrl_module_read_finish_2nd
                forever begin
                    #10;
                    if (!CTRL_RDY) begin
                        disable ctrl_module_read_finish_2nd;
                    end
                end
                end
                
                /** (c) Export SRAM data from SRAM_IO_CTRL**/
                $write("%8b ", scpu_sram_alu.scpu_ctrl_spi.cct.reg_bits[MEMORY_DATA_WIDTH-1:0]);
                if (k == 1)
                    tmpi_datain[MEMORY_DATA_WIDTH-1:0] = scpu_sram_alu.scpu_ctrl_spi.cct.reg_bits[MEMORY_DATA_WIDTH-1:0];
                else if (k == 2)
                    tmpi_datain[2*MEMORY_DATA_WIDTH-1:MEMORY_DATA_WIDTH] = scpu_sram_alu.scpu_ctrl_spi.cct.reg_bits[MEMORY_DATA_WIDTH-1:0];
            end
            $display("");
            
            if (10 == tmpi_datain)
                $display("Test Passed!");
            else
                $display("Test Failed!");
        end
        //#10 release CEN_after_mux; release WEN_after_mux;
        #20 $stop();//
    end
    
    always #5
        CLK = ~CLK;
      
endmodule

