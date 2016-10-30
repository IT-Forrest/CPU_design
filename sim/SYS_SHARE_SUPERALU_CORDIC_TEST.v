//+FHDR****************************************************************
// ECE department, TAMU
// --------------------------------------------------------------------
// FILE NAME    : SYS_SHARE_SUPERALU_CORDIC_TEST.v
// AUTHER       : Jiafan Wang
// DATE         : 07/14/2016
// VERSION      : 1.0
// PURPOSE      : sytem level testbench of the super ALU including *, / and sqrt
// --------------------------------------------------------------------
// ABSTRACT: loop-test simulation time 100ms given each time period 20ns
// --------------------------------------------------------------------
`timescale  1 ns / 100 ps
`include    "../DEFINE_CPU.v"
`include "../SCPU_SRAM_8BIT_ALU_SPI_TOP.v"
`include "../I_MEMORY_8bit.v"

module  SYS_SHARE_SUPERALU_CORDIC_TEST();

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
        .APP_DONE       (1'b0   ),
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
        tmpi_datain = {`SET, `gr1, 3'b001, 3'b001, 2'b00};
        i_mem.I_RAM[ i] = tmpi_datain[7:0];  i = 7 + DEFAULT_PC_ADDR*2;
        i_mem.I_RAM[ i] = tmpi_datain[15:8]; i = 8 + DEFAULT_PC_ADDR*2;
        
        //if (`gr3 != 0) go to I_RAM[ 9];
        // CPU is supposed to finish the loop automatically
        
        //Load I/O data_A to `gr2 as FOUT
        tmpi_datain = {`LIOA, `gr2, 4'b0000, 4'b0000};
        i_mem.I_RAM[ i] = tmpi_datain[7:0];  i = 9 + DEFAULT_PC_ADDR*2;
        i_mem.I_RAM[ i] = tmpi_datain[15:8]; i = 10+ DEFAULT_PC_ADDR*2;
        //Load I/O data_B to `gr3 as POUT
        tmpi_datain = {`LIOB, `gr3, 4'b0000, 4'b0000};
        i_mem.I_RAM[ i] = tmpi_datain[7:0];  i = 11+ DEFAULT_PC_ADDR*2;
        i_mem.I_RAM[ i] = tmpi_datain[15:8]; i = 12+ DEFAULT_PC_ADDR*2;
        //reset the control reg for ALU
        tmpi_datain = {`SET, `gr1, 3'b000, 3'b000, 2'b00};
        i_mem.I_RAM[ i] = tmpi_datain[7:0];  i = 13+ DEFAULT_PC_ADDR*2;
        i_mem.I_RAM[ i] = tmpi_datain[15:8]; i = 14+ DEFAULT_PC_ADDR*2;
        //Save FOUT to SRAM at 0x2;
        tmpi_datain = {`STORE, `gr2, 1'b0, `gr0, 4'b0010};
        i_mem.I_RAM[ i] = tmpi_datain[7:0];  i = 15+ DEFAULT_PC_ADDR*2;
        i_mem.I_RAM[ i] = tmpi_datain[15:8]; i = 16+ DEFAULT_PC_ADDR*2;
        //Save POUT to SRAM at 0x3;
        tmpi_datain = {`STORE, `gr3, 1'b0, `gr0, 4'b0011};
        i_mem.I_RAM[ i] = tmpi_datain[7:0];  i = 17+ DEFAULT_PC_ADDR*2;
        i_mem.I_RAM[ i] = tmpi_datain[15:8]; i = 18+ DEFAULT_PC_ADDR*2;
        //System finish
        tmpi_datain = {`HALT, 11'b000_0000_0000};
        i_mem.I_RAM[ i] = tmpi_datain[7:0];  i = 19+ DEFAULT_PC_ADDR*2;
        i_mem.I_RAM[ i] = tmpi_datain[15:8]; i = 20+ DEFAULT_PC_ADDR*2;
        
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
        tmpi_datain = 16'h0000;
        i_mem.I_RAM[ i] = tmpi_datain[7:0];  i = 7;
        i_mem.I_RAM[ i] = tmpi_datain[15:8]; i = 8;
        // i_mem.D_RAM[0] = 16'h00AB;
        // i_mem.D_RAM[1] = 16'h3C00;
        // i_mem.D_RAM[2] = 16'h0000;
        // i_mem.D_RAM[3] = 16'h0000;
        
        #10 RST_N = 0; CTRL_BGN = 1;
        #10 RST_N = 1;
        
        /* (1) Serially Input the address & Instruction to CTRL and then to SRAM */
        for (i = 0; i<10+ DEFAULT_PC_ADDR; ) begin
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
        
        /* (2) Activate CPU to load from LIOA */
        #10     CTRL_BGN = 0;
        #10     CPU_BGN = 1;
        #10     CPU_BGN = 0;
        
        #110;
        ADC_PI = 58;//{GENERAL_REG_WIDTH}'d
        #50;
        ADC_PI = 50;//{GENERAL_REG_WIDTH}'d
        #50;
        
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
        for (i = 2; i<4; i=i+1) begin
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

            if (i == 2) begin
                if (tmpi_datain == 88)
                    $write("\t<--- Fout Correct!");
                else begin
                    $write("\t<--- Fout Wrong!");
                    error_cnt = error_cnt + 1;
                end
            end
            else if (i == 3) begin
                if (tmpi_datain == 369)
                    $write("\t<--- Pout Correct!");
                else begin
                    $write("\t<--- POUT Wrong!");
                    error_cnt = error_cnt + 1;
                end
            end
            $display("");
        end

        // (4) Judge Final Test Result
        if (error_cnt)
            $display("Test Failed!");
        else
            $display("Test Passed!");
        #20 $stop();
    end

    always #5
        CLK = ~CLK;
   
endmodule

