//+FHDR****************************************************************
// ECE department, TAMU
// --------------------------------------------------------------------
// FILE NAME    : SRAM_IO_CTRL.v
// AUTHER       : Jiafan Wang
// DATE         : 03/12/2016
// VERSION      : 2.0
// PURPOSE      : the I/O module used to load and fetch instructions
// --------------------------------------------------------------------
// ABSTRACT     :
//
//   this module serially loads instructions from outside; and
//   then parallelly sends to SRAM; or fetchs from SRAM and output
// --------------------------------------------------------------------

`ifndef SRAM_IO_CTRL_V
`define SRAM_IO_CTRL_V

module SRAM_IO_CTRL(CLK, BGN, SI, LOAD_N, CTRL, PI, RDY, D_WE, CEN, SO, A, PO);

    parameter   MEMORY_DATA_WIDTH   = 8,
                MEMORY_ADDR_WIDTH   = 9,
                REG_BITS_WIDTH = MEMORY_ADDR_WIDTH + MEMORY_DATA_WIDTH;
                
    parameter   IO_IDLE = 2'b00,
                IO_LOAD = 2'b01,
                IO_SEND = 2'b11,
                IO_MRDY = 2'b10;
                
    input   CLK;
    input   BGN;
    input   SI;
    input   LOAD_N;
    input   [1:0] CTRL;
    input   [MEMORY_DATA_WIDTH-1:0] PI;// read from SRAM
    
    output  RDY;
    output  D_WE;
    output  CEN;
    output  SO;
    output  [MEMORY_ADDR_WIDTH-1:0] A;
    output  [MEMORY_DATA_WIDTH-1:0] PO;// write to SRAM

    reg     D_WE, CEN;
    reg [1:0]   ctrl_state;
    reg [4:0]   cnt_bit_load;
    reg [REG_BITS_WIDTH-1:0] reg_bits;

    // notify the outside process
    assign  RDY = (ctrl_state == IO_MRDY);
    // Write data to SRAM
    assign  SO  = reg_bits[0];
    assign  A   = (!D_WE)?(reg_bits[REG_BITS_WIDTH-1:MEMORY_DATA_WIDTH]):0;
    assign  PO  = (!D_WE)?(reg_bits[MEMORY_DATA_WIDTH-1:0]):0;
    // Read data from SRAM
    
    //************* The negedge WEN & CEN signal *************//
    //assign  D_WE = (ctrl_state == IO_SEND);
    always @(negedge CLK)
    begin
        if (ctrl_state == IO_SEND)
            D_WE <= 0;/* low enable */
        else
            D_WE <= 1;
    end
    //assign  CEN = (ctrl_state != IO_IDLE);
    always @(negedge CLK)
    begin
        if (ctrl_state != IO_IDLE)
            CEN <= 0;/* low enable */
        else
            CEN <= 1;
    end
    
    //************* IO shift process *************//
    always @(posedge CLK)
    begin
        if (ctrl_state == IO_LOAD)
            reg_bits <= {SI, reg_bits[REG_BITS_WIDTH-1:1]};
    end
    
    //************* IO shift cnt *************//
    always @(posedge CLK or negedge BGN)
    begin
        if (!BGN)
            cnt_bit_load <= 0;
        else if (!cnt_bit_load) begin
            case (ctrl_state)
                IO_IDLE:    cnt_bit_load <= REG_BITS_WIDTH - 1;
                IO_LOAD:    cnt_bit_load <= 0;//cnt=1 makes SEND state last 2 cycles
                IO_SEND:    cnt_bit_load <= 0;
                default:    cnt_bit_load <= 0;
            endcase
        end
        else
            cnt_bit_load <= cnt_bit_load - 1;
    end
    
    //************* State Change *************//
    always @(posedge CLK or negedge BGN)
    begin
        if (!BGN)
            ctrl_state <= IO_IDLE;
        else begin
            case (ctrl_state)
                IO_IDLE: if (!LOAD_N)       ctrl_state <= IO_LOAD;
                IO_LOAD: if (!cnt_bit_load) ctrl_state <= IO_SEND;
                IO_SEND: if (!cnt_bit_load) ctrl_state <= IO_MRDY;
                default: ctrl_state <= IO_MRDY;
            endcase
        end
    end
    
    
endmodule
`endif//SRAM_IO_CTRL_V
