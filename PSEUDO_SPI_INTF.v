//+FHDR****************************************************************
// ECE department, TAMU
// --------------------------------------------------------------------
// FILE NAME    : PSEUDO_SPT_INTF.v
// AUTHER       : Jiafan Wang
// DATE         : 06/07/2016
// VERSION      : 1.0
// PURPOSE      : Given the starting address and data length; then
//                generate the clock signals and SRAM control signals
//                to send the data to analog device bit by bit.
//
// --------------------------------------------------------------------
// ABSTRACT: ModelSim simulation time 6us given each time period 10ns
// --------------------------------------------------------------------

`timescale 1ns / 1ps
`include "DEFINE_CPU.v"

`ifndef PSEUDO_SPI_OUT_V
`define PSEUDO_SPI_OUT_V

module PSEUDO_SPT_INTF(
    // input
    CLK,
    BGN,
    ADDR_BGN,
    DATA_LEN,
    //FREQ_DIV,
    PI,
    
    // output
    SCLK1,
    SCLK2,
    LAT,//LAT for write; SEL for read
    SPI_SO,
    
    A,
    CEN,
    D_WE,//memory read or write signal, 1: write
    spi_MUX,
    spi_is_done
);

    parameter   MEMORY_DATA_WIDTH   = 8,
                MEMORY_ADDR_WIDTH   = 9,
                RESERVED_DATA_LEN   = 8;

    input   CLK;
    input   BGN;
    input   [MEMORY_ADDR_WIDTH-1:0] ADDR_BGN;
    input   [RESERVED_DATA_LEN-1:0] DATA_LEN;    //1 data = (MEMORY_DATA_WIDTH bits)
    //input   [7:0]   FREQ_DIV;
    input   [MEMORY_DATA_WIDTH-1:0] PI;         // read from SRAM
    
    output  SCLK1;
    output  SCLK2;
    output  LAT;
    output  SPI_SO;
    output  [MEMORY_ADDR_WIDTH-1:0] A;
    output  CEN;
    output  D_WE;//memory read or write signal, 1: write
    output  spi_MUX;
    output  spi_is_done;

    // State Machine Parameters
    parameter   SPI_IDLE = 3'b000,
                SPI_ADDR = 3'b001,
                SPI_READ = 3'b011,
                SPI_SOUT = 3'b010,
                SPI_LOOP = 3'b110,
                SPI_RDY  = 3'b100,
                SPI_DONE = 3'b101;
    
    reg     [MEMORY_ADDR_WIDTH-1:0] sram_addr;
    reg     [MEMORY_DATA_WIDTH-1:0] sram_regs;
    
    reg             spi_MUX;
    reg     [3:0]   spi_state;
    reg     [2:0]   cnt_state;
    reg     [4:0]   cnt_bit_sent;
    reg     [4:0]   cnt_addr_len;
    reg     [4:0]   cnt_freq_div;
    reg             is_addr_len_nz;
    
    assign  SPI_SO  = sram_regs[0];
    assign  A       = sram_addr;//(!CEN)?(sram_addr):0;
    assign  CEN     = 1'b0;/* low enable */
    assign  D_WE    = 1'b1;/* low write */
    assign  SCLK1   = (spi_MUX & cnt_state[0] & cnt_state[1]);
    assign  SCLK2   = (spi_MUX & cnt_state[0] & ~cnt_state[1]);
    assign  LAT     = (spi_state == SPI_RDY);
    assign  spi_is_done = (spi_state == SPI_DONE);
    
    //******** Negedge WEN/CEN signals to SRAM ********//
    // always @(negedge CLK)
    // begin
        // if ((ctrl_state == IO_SEND) && is_write)
            // D_WE <= 0;/* low write */
        // else
            // D_WE <= 1;
    // end
    // always @(negedge CLK)
    // begin
        // if ((spi_state == SPI_ADDR) || (spi_state == SPI_READ))
            // CEN <= 0;/* low enable */
        // else
            // CEN <= 1;
    // end
    
    //************* delay SPI_MUX signal for one cycle *************//
    always @(negedge CLK)
    begin
        if (!BGN)
            spi_MUX <= 1'b0;
        else if (SPI_ADDR == spi_state)//((SPI_IDLE == spi_state) && !cnt_state)
            spi_MUX <= 1'b1;
        else if (SPI_DONE == spi_state)
            spi_MUX <= 1'b0;
    end
    
    //******** Frequency Divisior ********//
    // always @(posedge CLK or negedge BGN)
    // begin
        // if (!BGN)
            // cnt_freq_div <= FREQ_DIV;
        // else if (SPI_SOUT == spi_state)
            // cnt_freq_div <= cnt_freq_div - 1;
        // else if (SPI_LOOP == spi_state)
            // cnt_freq_div <= FREQ_DIV;
        // else
            // cnt_freq_div <= cnt_freq_div;
    // end
    
    always @(negedge CLK)
    begin
        if (!BGN)
            is_addr_len_nz <= 1'b0;
        else if (cnt_addr_len)
            is_addr_len_nz <= 1'b1;
        else
            is_addr_len_nz <= 1'b0;
    end
    
    //************* Addr & Buffer Update *************//
    always @(negedge CLK)
    begin
        if (!BGN)
            sram_addr <= ADDR_BGN;
        else if ((SPI_ADDR == spi_state) && is_addr_len_nz)
            sram_addr <= sram_addr + 1;
        else
            sram_addr <= sram_addr;
    end
    
    always @(posedge CLK)
    begin
        if (!BGN)
            sram_regs <= 0;
        else if (SPI_READ == spi_state)
            sram_regs <= PI;
        else if (SPI_LOOP == spi_state)
            sram_regs <= {1'b0, sram_regs[MEMORY_DATA_WIDTH-1:1]};
        else
            sram_regs <= sram_regs;
    end

    //************* Bit & Length cnt *************//
    always @(posedge CLK or negedge BGN)
    begin
        if (!BGN)
            cnt_bit_sent <= 0;
        else if (SPI_READ == spi_state)
            cnt_bit_sent <= (MEMORY_DATA_WIDTH - 1); // bit# for each address
        else if ((SPI_LOOP == spi_state) && cnt_bit_sent)
            cnt_bit_sent <= cnt_bit_sent - 1;
        else
            cnt_bit_sent <= cnt_bit_sent;
    end
    
    always @(posedge CLK or negedge BGN)
    begin
        if (!BGN)
            cnt_addr_len <= DATA_LEN;
        else if ((SPI_ADDR == spi_state) && cnt_addr_len)
            cnt_addr_len <= cnt_addr_len - 1;
        else
            cnt_addr_len <= cnt_addr_len;
    end
    
    //************* State Cycle cnt *************//
    always @(posedge CLK or negedge BGN)
    begin
        if (!BGN)
            cnt_state <= 1;
        else if (!cnt_state) begin
            case (spi_state)
                SPI_IDLE:   cnt_state <= 0;
                SPI_READ:   cnt_state <= 4;
                SPI_SOUT:   cnt_state <= 0;
                SPI_LOOP:   cnt_state <= (cnt_bit_sent)?4:0;
                SPI_ADDR:   cnt_state <= 0;
                default:    cnt_state <= 0;
            endcase
        end
        else
            cnt_state <= cnt_state - 1;
    end
    
    //************* State Machine *************//
    always @(posedge CLK or negedge BGN)
    begin
        if (!BGN)
            spi_state <= SPI_IDLE;
        else begin
            case (spi_state)
                SPI_IDLE:   if (!cnt_state) spi_state <= SPI_ADDR;
                SPI_READ:   if (!cnt_state) spi_state <= SPI_SOUT;
                SPI_SOUT:   if (!cnt_state) spi_state <= SPI_LOOP;
                SPI_LOOP:
                    if (!cnt_state) begin
                        if (cnt_bit_sent)
                            spi_state <= SPI_SOUT;
                        else
                            spi_state <= SPI_ADDR;
                    end
                SPI_ADDR:
                    if (!cnt_state) begin
                        if (is_addr_len_nz)
                            spi_state <= SPI_READ;
                        else
                            spi_state <= SPI_RDY;
                    end
                default:    spi_state <= SPI_DONE;
            endcase
        end
    end
    
endmodule

`endif//PSEUDO_SPT_INTF

