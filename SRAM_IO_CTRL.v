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
    reg [7:0]   cnt_bit_load;
    reg [REG_BITS_WIDTH-1:0] reg_bits;
    //reg [1:0]   reg_LOAD;
    
    reg     is_shift;
    wire    is_write;
    wire    is_LOAD;
    // notify the outside process
    assign  is_sram = CTRL[0];
    assign  is_write = CTRL[1];
    assign  is_LOAD = (!LOAD_N);//reg_LOAD[0];
    assign  RDY = (ctrl_state == IO_MRDY);
    // Write data to SRAM
    assign  SO  = reg_bits[0];
    assign  A   = (!CEN)?(reg_bits[REG_BITS_WIDTH-1:MEMORY_DATA_WIDTH]):0;
    assign  PO  = (!CEN && !D_WE)?(reg_bits[MEMORY_DATA_WIDTH-1:0]):0;
    // Read data from SRAM
    
    //************* The negedge WEN & CEN signal *************//
    //assign  D_WE = (ctrl_state == IO_SEND);
    always @(negedge CLK)
    begin
        if ((ctrl_state == IO_SEND) && is_write)
            D_WE <= 0;/* low write */
        else
            D_WE <= 1;
    end
    //assign  CEN = (ctrl_state != IO_IDLE);
    always @(negedge CLK)
    begin
        if (ctrl_state == IO_SEND)
            CEN <= 0;/* low enable */
        else
            CEN <= 1;
    end
    
    //*********** Flag for data shifting ***********//
    always @(posedge CLK)
    begin
        if (cnt_bit_load)
            is_shift <= 1'b1;
        else
            is_shift <= 1'b0;
    end
    
    //************* IO shift process *************//
    always @(posedge CLK)
    begin
        //if (!BGN)
        //    reg_bits <= {REG_BITS_WIDTH{1'b0}};
        //else
        if ((ctrl_state == IO_LOAD) && is_shift)
            reg_bits <= {SI, reg_bits[REG_BITS_WIDTH-1:1]};
        else if ((ctrl_state == IO_SEND) && (!is_shift) && !is_write)
            reg_bits[MEMORY_DATA_WIDTH-1:0] <= PI;
        else
            reg_bits <= reg_bits;
    end
    
    //************* make LOAD_N only works for one cycle *************//
    // always @(posedge CLK)
    // begin
        // if ((!BGN) || (LOAD_N))
        // begin
            // reg_LOAD <= 2'b00;
        // end else if ((!LOAD_N) & (reg_LOAD == 2'b00))
        // begin
            // reg_LOAD <= 2'b01;//is_LOAD = reg_LOAD[0];
        // end else 
        // begin
            // reg_LOAD <= 2'b10;
        // end
    // end
    
    //************* IO shift cnt *************//
    always @(posedge CLK)
    begin
        if (!BGN)
            cnt_bit_load <= 0;
        else if (!cnt_bit_load) begin
            case (ctrl_state)
                IO_IDLE:
                    if (is_LOAD) begin
                        if (!is_sram)
                            cnt_bit_load <= REG_BITS_WIDTH;
                        else if (!is_write)
                            cnt_bit_load <= 1;//read SRAM need 2 cycles
                        else//is_write
                            cnt_bit_load <= 0;
                    end
                IO_LOAD:    cnt_bit_load <= 0;//cnt=1 makes SEND state last 2 cycles
                IO_SEND:    cnt_bit_load <= 0;
                IO_MRDY:    cnt_bit_load <= 0;
                //default:    cnt_bit_load <= 0;
            endcase
        end
        else
            cnt_bit_load <= cnt_bit_load - 1;
    end
    
    //************* State Change *************//
    always @(posedge CLK)
    begin
        if (!BGN)
            ctrl_state <= IO_IDLE;
        else begin
            case (ctrl_state)
                IO_IDLE:
                    if (is_LOAD) begin
                        if (!is_sram)
                            ctrl_state <= IO_LOAD;
                        else//CTRL[0] == 1
                            ctrl_state <= IO_SEND;
                    end
                IO_LOAD: if (!cnt_bit_load) ctrl_state <= IO_MRDY;
                IO_SEND: if (!cnt_bit_load) ctrl_state <= IO_MRDY;
                IO_MRDY: ctrl_state <= IO_MRDY;
                //default: ctrl_state <= IO_IDLE;
            endcase
        end
    end
    
    
endmodule
`endif//SRAM_IO_CTRL_V
