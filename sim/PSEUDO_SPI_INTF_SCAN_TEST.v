//+FHDR****************************************************************
// ECE department, TAMU
// --------------------------------------------------------------------
// FILE NAME    : PSEUDO_SPI_INTF_SCAN_TEST.v
// AUTHER       : Jiafan Wang
// DATE         : 06/27/2016
// VERSION      : 1.0
// PURPOSE      : Pseudo SPI module & Scan chain test
// --------------------------------------------------------------------
// ABSTRACT: ModelSim simulation time 6us given each time period 10ns
// --------------------------------------------------------------------
`timescale 1ns / 1ps
`include "../DEFINE_CPU.v"
`include "../PSEUDO_SPI_INTF.v"
//`include "../RA1SHD_IBM512X8.v"
`include "../I_MEMORY_8bit.v"
`include "../SC_CELL_V3.v"

module PSEUDO_SPI_INTF_SCAN_TEST;

   parameter    MEMORY_DATA_WIDTH   = 8,
                MEMORY_ADDR_WIDTH   = 9,
                REG_BITS_WIDTH = MEMORY_ADDR_WIDTH + MEMORY_DATA_WIDTH;

    // Inputs
    reg CLK;
    reg BGN;// enable signal for PSEUDO_SPI
    reg rst_n;//no use here
    
    // Wires
    // wire is_i_addr;
    // wire [7:0]  i_datain;
    // wire [7:0]  d_datain;
    // wire [7:0]  d_dataout;
    wire [7:0]  m_datain;

    wire [7:0]  m_dataout;
    wire [8:0]  m_addr;     //MEMORY_ADDR_WIDTH
    // wire [8:0]  i_addr;
    // wire [8:0]  d_addr;
    wire d_we;
    wire SPI_SO;
    wire RDY;
    
    integer i,j,k;
    reg  [15:0] tmpi_datain;
    reg  [8:0]  tmpi_adder;
    reg  LOAD_N;
    integer error_cnt;
   
    parameter   RESERVED_DATA_LEN   = 8;
                
    reg   [MEMORY_ADDR_WIDTH-1:0] addr_end;
    reg   [RESERVED_DATA_LEN-1:0] data_len;    //each data width = MEMORY_DATA_WIDTH
    reg   [7:0]   freq_div;
    reg   [MEMORY_DATA_WIDTH-1:0] PI;         // read from SRAM
    
    wire  SCLK1;
    wire  SCLK2;
    wire  LAT;
    wire  CEN;
    wire  spi_is_done;
    
    wire  SEL_B;
    reg   [9:0]   ADC ;
    wire  [9:0]   CFSA_ADC;
    
    // Instantiate the Unit Under Test (UUT)
    PSEUDO_SPT_INTF     put(
        // input
        .CLK        (CLK        ),
        .BGN        (BGN        ),
        .ADDR_BGN   (addr_end   ),
        .DATA_LEN   (data_len   ),
        //.FREQ_DIV   (freq_div   ),
        .PI         (m_dataout  ),
        // output
        .SCLK1      (SCLK1      ),
        .SCLK2      (SCLK2      ),
        .LAT        (LAT        ),//LAT for read; SEL for write
                                
        .SPI_SO     (SPI_SO     ),
        .CEN        (CEN        ),
        .A          (m_addr     ),
        .D_WE       (d_we       ),//memory read or write signal, 1: write
        .spi_is_done(spi_is_done)
    );
  
    // RA1SHD_IBM512X8   sram (
        // .CLK(CLK),
        // .CEN(CEN), 
        // .A(m_addr),
        // .WEN(d_we),// need a seperate control signal; or instruction set will be overwritten when d_we=1
        // .D(m_datain),//i_instruct
        // .Q(m_dataout)
    // );

    // only used for testbench
    I_MEMORY_8BIT   i_mem(
        .clk(CLK),
        .rst_n(1'b1), 
        .addr(m_addr),
        .d_we(1'b0),// need a seperate control signal; or instruction set will be overwritten when d_we=1
        .datain(8'h00),//i_instruct
        .dataout(m_dataout)
    );
    
    I_MEMORY_8BIT   c_mem();
    
    parameter   SPI_IDLE = 3'b000,
                SPI_ADDR = 3'b001,
                SPI_READ = 3'b011,
                SPI_SOUT = 3'b010,
                SPI_LOOP = 3'b110,
                SPI_RDY  = 3'b100,
                SPI_DONE = 3'b101;
                
    //defparam    uut.DEFAULT_PC_ADDR = DEFAULT_PC_ADDR;

    // Scan chain 1: length 14
    SC_CELL_V3	CS208( .SIN(SIN), .SO(M0  ), .PO(SC_CLRN    ), .PIN(CLRN     ), .SEL(SEL_B), .LAT(LAT_B), .SCK1(SCK1_B), .SCK2(SCK2), .BYP_N(1'b0) );
    SC_CELL_V3	CS209( .SIN(M0 ), .SO(M1  ), .PO(SC_CLK_ADC ), .PIN(CLK_ADC  ), .SEL(SEL_B), .LAT(LAT_B), .SCK1(SCK1_B), .SCK2(SCK2), .BYP_N(1'b0) );
    SC_CELL_V3	CS210( .SIN(M1 ), .SO(M2  ), .PO(SC_RSTN_ADC), .PIN(RSTN_ADC ), .SEL(SEL_B), .LAT(LAT_B), .SCK1(SCK1_B), .SCK2(SCK2), .BYP_N(1'b0) );
    SC_CELL_V3	CS211( .SIN(M2 ), .SO(M3  ), .PO(SC_PO_IDLE ), .PIN(PO_IDLE  ), .SEL(SEL_B), .LAT(LAT_B), .SCK1(SCK1_B), .SCK2(SCK2), .BYP_N(1'b0) );
    SC_CELL_V3	CS212( .SIN(M3 ), .SO(M4  ), .PO(CFSA_ADC[0]), .PIN(ADC[0]   ), .SEL(SEL_B), .LAT(LAT_B), .SCK1(SCK1_B), .SCK2(SCK2), .BYP_N(1'b0) );
    SC_CELL_V3	CS213( .SIN(M4 ), .SO(M5  ), .PO(CFSA_ADC[1]), .PIN(ADC[1]   ), .SEL(SEL_B), .LAT(LAT_B), .SCK1(SCK1_B), .SCK2(SCK2), .BYP_N(1'b0) );
    SC_CELL_V3	CS214( .SIN(M5 ), .SO(M6  ), .PO(CFSA_ADC[2]), .PIN(ADC[2]   ), .SEL(SEL_B), .LAT(LAT_B), .SCK1(SCK1_B), .SCK2(SCK2), .BYP_N(1'b0) );
    SC_CELL_V3	CS215( .SIN(M6 ), .SO(M7  ), .PO(CFSA_ADC[3]), .PIN(ADC[3]   ), .SEL(SEL_B), .LAT(LAT_B), .SCK1(SCK1_B), .SCK2(SCK2), .BYP_N(1'b0) );
    SC_CELL_V3	CS216( .SIN(M7 ), .SO(M8  ), .PO(CFSA_ADC[4]), .PIN(ADC[4]   ), .SEL(SEL_B), .LAT(LAT_B), .SCK1(SCK1_B), .SCK2(SCK2), .BYP_N(1'b0) );
    SC_CELL_V3	CS217( .SIN(M8 ), .SO(M9  ), .PO(CFSA_ADC[5]), .PIN(ADC[5]   ), .SEL(SEL_B), .LAT(LAT_B), .SCK1(SCK1_B), .SCK2(SCK2), .BYP_N(1'b0) );
    SC_CELL_V3	CS218( .SIN(M9 ), .SO(M10 ), .PO(CFSA_ADC[6]), .PIN(ADC[6]   ), .SEL(SEL_B), .LAT(LAT_B), .SCK1(SCK1_B), .SCK2(SCK2), .BYP_N(1'b0) );
    SC_CELL_V3	CS219( .SIN(M10), .SO(M11 ), .PO(CFSA_ADC[7]), .PIN(ADC[7]   ), .SEL(SEL_B), .LAT(LAT_B), .SCK1(SCK1_B), .SCK2(SCK2), .BYP_N(1'b0) );
    SC_CELL_V3	CS220( .SIN(M11), .SO(M12 ), .PO(CFSA_ADC[8]), .PIN(ADC[8]   ), .SEL(SEL_B), .LAT(LAT_B), .SCK1(SCK1_B), .SCK2(SCK2), .BYP_N(1'b0) );
    SC_CELL_V3	CS221( .SIN(M12), .SO(SO_B), .PO(CFSA_ADC[9]), .PIN(ADC[9]   ), .SEL(SEL_B), .LAT(LAT_B), .SCK1(SCK1_B), .SCK2(SCK2), .BYP_N(1'b0) );

    assign  SIN     = SPI_SO;
    assign  SCK1_B  = SCLK1;
    assign  SCK2    = SCLK2;
    assign  LAT_B   = LAT;
    assign  SEL_B   = 1'b0;
    //assign  m_addr = (is_i_addr)?i_addr:d_addr;
    //assign  m_datain = d_dataout;
    //assign  i_datain = (is_i_addr)?m_dataout:0;
    //assign  d_datain = (is_i_addr)?0:m_dataout;
    
    parameter   DEFAULT_PC_ADDR = 16,
                MEM_BGN_ADDR    = 0,
                TRANSFER_LEN    = 1*2;
    
    initial begin
        // Initialize Inputs Signals
        CLK = 0;
        rst_n = 0;
        BGN = 0;
        ADC = 10'b0000000000;
        addr_end = MEM_BGN_ADDR + TRANSFER_LEN;
        data_len = TRANSFER_LEN;
        
        LOAD_N = 1;
        error_cnt = 0;
        #50;
        // Wait 100 ns for global rst_n to finish

        /* Add stimulus here: Using a pseudo memory to load instruction*/ 
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
        
        i = 0; j = 0; k = 0;
        tmpi_datain = 16'b111110_00_1010_0111;//510
        i_mem.I_RAM[ i] = tmpi_datain[7:0];  i = 1;
        i_mem.I_RAM[ i] = tmpi_datain[15:8]; i = 2;
        tmpi_datain = 16'h3C00;
        i_mem.I_RAM[ i] = tmpi_datain[7:0];  i = 3;
        i_mem.I_RAM[ i] = tmpi_datain[15:8]; i = 4;
        tmpi_datain = 16'h0500;
        i_mem.I_RAM[ i] = tmpi_datain[7:0];  i = 5;
        i_mem.I_RAM[ i] = tmpi_datain[15:8]; i = 6;
        tmpi_datain = 16'h9E3D;
        i_mem.I_RAM[ i] = tmpi_datain[7:0];  i = 7;
        i_mem.I_RAM[ i] = tmpi_datain[15:8]; i = 8;
        tmpi_datain = 16'hD7C3;
        i_mem.I_RAM[ i] = tmpi_datain[7:0];  i = 9;
        i_mem.I_RAM[ i] = tmpi_datain[15:8]; i = 10;
        tmpi_datain = 16'h7A58;
        i_mem.I_RAM[ i] = tmpi_datain[7:0];  i = 11;
        i_mem.I_RAM[ i] = tmpi_datain[15:8]; i = 12;
        tmpi_datain = 16'hC201;
        i_mem.I_RAM[ i] = tmpi_datain[7:0];  i = 13;
        i_mem.I_RAM[ i] = tmpi_datain[15:8]; i = 14;
        // i_mem.D_RAM[0] = 16'h00AB;
        // i_mem.D_RAM[1] = 16'h3C00;
        // i_mem.D_RAM[2] = 16'h0000;

        #10 BGN = 1; rst_n = 1; 

        /* Fetch SRAM info & print inner instructions */
        for (i = MEM_BGN_ADDR + TRANSFER_LEN + 1; i > (MEM_BGN_ADDR + 1); i=i-1) begin
            $write("%4x\t", i-2); tmpi_datain = 0;
            // Wait for data read from real SRAM;
            #10;
            for (j = 0; j < MEMORY_DATA_WIDTH; j=j+1) begin
                // Serial OUT;
                for (k = 0; k < 10; k=k+1) begin
                    if (put.spi_state == SPI_LOOP) begin
                        k = 10;
                        tmpi_datain = {SPI_SO, tmpi_datain[MEMORY_DATA_WIDTH-1:1]};
                    end
                    #10;
                end
                #10 LOAD_N = 1;
            end
            // Write data to tmp SRAM for later comparison
            c_mem.I_RAM[ i-2] = tmpi_datain[MEMORY_DATA_WIDTH-1:0];
            #10;
            
            $write("%b ", c_mem.I_RAM[ i-2]);
            
            if (i_mem.I_RAM[ i-2] == c_mem.I_RAM[ i-2])
                $write("\t<--- Data Correct!");
            else begin
                $write("\t<--- Data Wrong!");
                error_cnt = error_cnt + 1;
            end
            $display("");
        end
        
        // Judge Bits Correct Result
        tmpi_datain = {c_mem.I_RAM[1], c_mem.I_RAM[0]};
        if ((10'd510 == {CFSA_ADC[9],CFSA_ADC[8],CFSA_ADC[7],CFSA_ADC[6],CFSA_ADC[5],CFSA_ADC[4],CFSA_ADC[3],CFSA_ADC[2],CFSA_ADC[1],CFSA_ADC[0]})
            && ({tmpi_datain[3:0],tmpi_datain[15:10]} == {CFSA_ADC[9],CFSA_ADC[8],CFSA_ADC[7],CFSA_ADC[6],CFSA_ADC[5],CFSA_ADC[4],CFSA_ADC[3],CFSA_ADC[2],CFSA_ADC[1],CFSA_ADC[0]}))
            $write("\tScan Chain Correct!\n");
        else begin
            $write("\tScan Chain Wrong!\n");
            error_cnt = error_cnt + 1;
        end
        
        // Judge Final Test Result
        if (error_cnt)
            $display("Test Failed!");
        else
            $display("Test Passed!");
        //#10 release CEN; release d_we;
        #50 $stop();//
    end
    
    always #5
        CLK = ~CLK;
      
endmodule

