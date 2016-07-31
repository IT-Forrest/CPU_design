//+FHDR****************************************************************
// ECE department, TAMU
// --------------------------------------------------------------------
// FILE NAME    : SERIAL_CPU_8bit.v
// AUTHER       : Jiafan Wang
// DATE         : 03/08/2016
// VERSION      : 2.0
// PURPOSE      : the kernel of a serial CPU with 8bit word length
// --------------------------------------------------------------------
// ABSTRACT
//
// --------------------------------------------------------------------

`timescale 1ns / 1ps
`include "DEFINE_CPU.v"

`ifndef SERIAL_CPU_8BIT_V
`define SERIAL_CPU_8BIT_V

module SERIAL_CPU_8BIT(
    clk,
    enable,
    rst_n,
    start,
    i_datain,
    d_datain,
    // output
    is_i_addr,
    nxt,
    i_addr,
    d_addr,
    d_we,
    d_dataout,
    io_status,
    io_control,
    io_datainA,
    io_datainB,
    io_dataoutA,
    io_dataoutB,
    io_offset
    );

    parameter   INSTRT_ADDR_WIDTH   = 8,
                INSTRT_DATA_WIDTH   = 16,
                D_MEM_ADDR_WIDTH    = 8,
                D_MEM_DATA_WIDTH    = 16,
                GENERAL_REG_WIDTH   = 16,// width of the internal general registers
                PC_MEM_ADDR_WIDTH   = 8,
                MEMORY_DATA_WIDTH   = 8,
                MEMORY_ADDR_WIDTH   = 9;
    parameter   DEFAULT_PC_ADDR     = 16;// default pc starting address (16*2 BYTE)
                
    parameter   MSB_OP_16B          = 16,// index of the MSB bit of instruction ID
                OP_WIDTH_5B         = 5,//  bit number of the instruction ID 
                MSB_OPER1_11B       = 11,// index of the MSB bit of operand1
                MSB_OPER2_8B        = 8,//  index of the MSB bit of operand2
                MSB_OPER3_4B        = 4,//  index of the MSB bit of operand3
                MSB_VAL2_7B         = 7,//  index of the MSB bit of value2
                MSB_VAL3_3B         = 3;//  index of the MSB bit of value3
    
    parameter   STATE_IDLE          = 4'b0000,
                STATE_IF            = 4'b0001,
                STATE_IF2           = 4'b0011,
                STATE_ID            = 4'b0010,
                STATE_EX            = 4'b0110,
                STATE_EX2           = 4'b0100,
                STATE_MEM           = 4'b0101,
                STATE_MEM2          = 4'b0111,
                STATE_WB            = 4'b1111,
                STATE_LP            = 4'b1110;
    
    input   clk;
    input   enable;
    input   rst_n;
    input   start;
    input   [MEMORY_DATA_WIDTH-1:0] i_datain;    //input instruction data
    input   [MEMORY_DATA_WIDTH-1:0] d_datain;    //input memory data
    output  is_i_addr;
    output  [1:0] nxt;
    output  [MEMORY_ADDR_WIDTH-1:0] i_addr;      //output instruction address
    output  [MEMORY_ADDR_WIDTH-1:0] d_addr;      //output memory data address 
    output  d_we;               //memory read or write signal, 1: write
    output  [MEMORY_DATA_WIDTH-1:0] d_dataout;   //output memory data 
    // for I/O control and data in&out
    input   [GENERAL_REG_WIDTH-1:0]  io_status;
    input   [GENERAL_REG_WIDTH-1:0]  io_datainA;
    input   [GENERAL_REG_WIDTH-1:0]  io_datainB;
    output  [GENERAL_REG_WIDTH-1:0]  io_control;
    output  [GENERAL_REG_WIDTH-1:0]  io_dataoutA;
    output  [GENERAL_REG_WIDTH-1:0]  io_dataoutB;
    output  [GENERAL_REG_WIDTH-1:0]  io_offset;
    
    reg     is_i_addr;
    reg     lowest_bit;
    reg     cf_buf;
    reg     [GENERAL_REG_WIDTH-1:0] ALUo;
    reg     [3:0] state, next_state;
    reg     zf, nf, cf, dw;     //flag registers
    reg     [1:0] nxt;
    reg     [PC_MEM_ADDR_WIDTH-1:0] pc;
    reg     [GENERAL_REG_WIDTH-1:0] id_ir;// instruction registers, ex_ir, mem_ir, wb_ir
    reg     [GENERAL_REG_WIDTH-1:0] reg_A, reg_B, reg_C, smdr;// reg_C1, smdr1;
    reg     [GENERAL_REG_WIDTH-1:0] gr[4:0];
    wire    branch_flag;
    wire    cpu_suspend;
    wire    cpu_restore;

    assign  io_control  = gr[1];
    assign  io_dataoutA = gr[2];
    assign  io_dataoutB = gr[3];
    assign  io_offset   = gr[4];
    assign  cpu_suspend = (io_control[7:4]!= 4'b0000);
    assign  cpu_restore = (io_status[3:0] != 4'b0000);
    
    //*********** Facilitate code learning ***********//
    wire    instr_over; // instructions in SRAM are over
    wire    [4:0]   code_type;
    wire    [2:0]   oper1_r1;
    wire    [3:0]   oper2_r2;
    wire    oper2_is_val;
    wire    [3:0]   oper3_r3;
    wire    oper3_is_val;
    
    //assign  is_i_addr = ((state == STATE_IF)||(state == STATE_IF2));
    assign  instr_over = (pc == {PC_MEM_ADDR_WIDTH{1'b1}});
    assign  code_type = id_ir[MSB_OP_16B-1:MSB_OPER1_11B];
    assign  oper1_r1 = id_ir[MSB_OPER1_11B-1:MSB_OPER2_8B];
    assign  oper2_r2 = id_ir[MSB_OPER2_8B-1:MSB_OPER3_4B];
    assign  oper3_r3 = id_ir[MSB_OPER3_4B-1:0];
    assign  oper2_is_val = id_ir[MSB_OPER2_8B-1];
    assign  oper3_is_val = id_ir[MSB_OPER3_4B-1];
    
    //************* delay is_i_addr signal *************//
    always @(negedge clk)
        begin
            if ((state == STATE_IF)||(state == STATE_IF2)||(state == STATE_ID)||(state == STATE_LP))
                is_i_addr <= 1'b1;
            else
                is_i_addr <= 1'b0;
        end
    
    //************* CPU Control *************//
    always @(posedge clk or negedge rst_n)
        begin
            if (!rst_n)
                state <= STATE_IDLE;
            else
                state <= next_state;
        end
    
    //************* CPU Control *************//
    always @(*)
        begin
            case (state)
                STATE_IDLE: 
                    if (start == 1'b1) begin
                        nxt <= 2'b00;
                        next_state <= STATE_IF;
                    end
                    else begin
                        //nxt <= 2'b00;
                        next_state <= STATE_IDLE;
                    end
                STATE_IF:
                    if (cpu_suspend && !cpu_restore) begin
                        next_state <= STATE_LP;
                    end
                    else begin
                        next_state <= STATE_IF2;
                    end
                STATE_IF2:  next_state <= STATE_ID;
                STATE_ID:   next_state <= STATE_EX;
                STATE_EX:   next_state <= STATE_EX2;
                STATE_EX2:  next_state <= STATE_MEM;
                STATE_MEM:  next_state <= STATE_MEM2;
                STATE_MEM2: next_state <= STATE_WB;//next_state <= STATE_MEM;
                STATE_WB:
                    if (code_type == `HALT) begin
                        nxt <= 2'b01;
                        next_state <= STATE_IDLE;
                    end
                    else if (instr_over) begin
                        nxt <= 2'b10;
                        next_state <= STATE_IDLE;
                    end
                    else begin
                        nxt <= 2'b00;
                        next_state <= STATE_IF;
                    end
                STATE_LP:
                    if (cpu_restore) begin
                        next_state <= STATE_IF2;
                    end
                    else begin
                        next_state <= STATE_LP;
                    end
                default:
                    begin
                        nxt <= 2'b00;
                        next_state <= STATE_IDLE;
                    end
            endcase
        end
        
        
    //************* IF (&IF2) *************//
    always @(posedge clk or negedge rst_n)
        begin
            if (!rst_n)
                begin
                    id_ir <= {`NOP, 11'b000_0000_0000};
                end
            else if (state == STATE_ID)
                begin
                    id_ir[MEMORY_DATA_WIDTH-1:0] <= i_datain;
                end
            else if (state == STATE_IF2)
                begin
                    id_ir[(MEMORY_DATA_WIDTH<<1)-1:MEMORY_DATA_WIDTH] <= i_datain;
                end
        end

    //************* lowest_bit ***************
    assign i_addr = {pc, lowest_bit};
    always @(negedge clk)
        begin
            if (state == STATE_IDLE)
                lowest_bit <= 0;
            else if (state == STATE_IF)
                lowest_bit <= 1;
            else if (state == STATE_IF2)
                lowest_bit <= 0;
            else if (state == STATE_EX)
                lowest_bit <= 0;// could be omitted
            else if (state == STATE_EX2)
                lowest_bit <= 1;
            else if (state == STATE_MEM)
                lowest_bit <= 0;
            else if (state == STATE_MEM2)
                lowest_bit <= 1;
            else if (state == STATE_WB)
                lowest_bit <= 0;
        end
        
    //************* ID *************//
    always @(posedge clk or negedge rst_n)
        begin
            if (!rst_n)
                begin
                    reg_A <= 16'b0000_0000_0000_0000;
                    reg_B <= 16'b0000_0000_0000_0000;
                    smdr  <= 16'b0000_0000_0000_0000;
                end
            else if (state == STATE_EX)
                begin
                    if (code_type == `STORE)
                        smdr <= gr[oper1_r1];
                    else
                        smdr <= smdr;
                
                    if (code_type == `JUMP)
                        reg_A <= 16'b0000_0000_0000_0000;
                    else if (I_R1_TYPE(code_type))
                        reg_A <= gr[oper1_r1];
                    else if (I_R2_TYPE(code_type))
                        reg_A <= gr[id_ir[MSB_VAL2_7B-1:MSB_OPER3_4B]];
                    else
                        reg_A <= reg_A;
                    
                    if (I_V3_TYPE(code_type))
                        reg_B <= {12'b0000_0000_0000, id_ir[MSB_OPER3_4B-1:0]};
                    else if (I_ZEROV2V3_TYPE(code_type))
                        reg_B <= {8'b0000_0000, id_ir[MSB_OPER2_8B-1:0]};
                    else if (I_V2V3ZERO_TYPE(code_type))
                        reg_B <= {id_ir[MSB_OPER2_8B-1:0], 8'b0000_0000};
                    else if (I_R3_TYPE(code_type))
                        reg_B <= gr[id_ir[MSB_VAL3_3B-1:0]];
                    else
                        reg_B <= reg_B;
                end
        end
    //************* Combinational ALU *************//
    always @(*)
        begin
            case(code_type)
                `AND:   {cf_buf, ALUo} <= {1'b0, reg_A & reg_B};
                `OR:    {cf_buf, ALUo} <= {1'b0, reg_A | reg_B};
                `XOR:   {cf_buf, ALUo} <= {1'b0, reg_A ^ reg_B};
                `SLL:   {cf_buf, ALUo} <= {cf_buf, reg_A << reg_B[MSB_OPER3_4B-1:0]};
                `SRL:   {cf_buf, ALUo} <= {cf_buf, reg_A >> reg_B[MSB_OPER3_4B-1:0]};
                //`SLA:   {cf_buf, ALUo} <= {cf_buf, reg_A <<< reg_B[MSB_OPER3_4B-1:0]};
                //`SRA:   {cf_buf, ALUo} <= {cf_buf, reg_A >>> reg_B[MSB_OPER3_4B-1:0]};
                `LFSR:  {cf_buf, ALUo} <= {1'b0, reg_B};
                `SET:   {cf_buf, ALUo} <= {1'b0, reg_B};
                `JUMP:  {cf_buf, ALUo} <= {cf_buf, reg_B};
                //`LDIH:
                `ADD:   {cf_buf, ALUo} <= reg_A + reg_B;
                `ADDI:  {cf_buf, ALUo} <= reg_A + reg_B;
                //`LDIH:
                //`ADDC:  {cf_buf, ALUo} <= reg_A + reg_B + cf;
                `SUB:   {cf_buf, ALUo} <= reg_A - reg_B;
                `SUBI:  {cf_buf, ALUo} <= reg_A - reg_B;
                `SUIH:  {cf_buf, ALUo} <= reg_A - reg_B;
                //`SUBC:  {cf_buf, ALUo} <= reg_A - reg_B - cf;
                `CMP:   {cf_buf, ALUo} <= reg_A - reg_B;
                //`LOAD:`STORE:`JMPR:
                //`BZ:`BNZ:`BN:`BNN:`BC:`BNC:
                default:{cf_buf, ALUo} <= {cf_buf, reg_A + reg_B};
            endcase
        end
        
    //************* EX (&EX2) *************//
    assign d_addr = {reg_C[PC_MEM_ADDR_WIDTH-1:0],lowest_bit};//D_MEM_ADDR_WIDTH
    assign d_we = dw;
    assign d_dataout = (!lowest_bit)?
                    smdr[MEMORY_DATA_WIDTH-1:0]:
                    smdr[(MEMORY_DATA_WIDTH<<1)-1:MEMORY_DATA_WIDTH];
    //negedge reg_C since it's used as SRAM addr which should avoid posedge clk
    always @(negedge clk)
    begin
        if (state == STATE_EX2)
            begin
                if (code_type == `LIOA)
                    reg_C <= io_datainA;
                else if (code_type == `LIOB)
                    reg_C <= io_datainB;
                else if (code_type == `LIOS)
                    reg_C <= io_status;
                else if (code_type == `LFSR)
                    reg_C <= {ALUo[14:0], (ALUo[15] ^ ALUo[13] ^ ALUo[12] ^ ALUo[10])}; //16 bits
                else
                    reg_C <= ALUo;
            end
    end
                    
    always @(posedge clk or negedge rst_n)
        begin
            if (!rst_n)
                begin
                    //reg_C <= 16'b0000_0000_0000_0000;
                    //smdr <= 16'b0000_0000_0000_0000;
                    //dw <= 1'b0;
                    zf <= 1'b0;
                    nf <= 1'b0;
                    cf <= 1'b0;
                end
            
            else if (state == STATE_EX2)
                begin
                    // if (code_type == `LIOA)
                        // reg_C <= io_datainA;
                    // else if (code_type == `LIOB)
                        // reg_C <= io_datainB;
                    // else if (code_type == `LIOS)
                        // reg_C <= io_status;
                    // else if (code_type == `LFSR)
                        // reg_C <= {ALUo[14:0], (ALUo[15] ^ ALUo[13] ^ ALUo[12] ^ ALUo[10])}; //16 bits
                    // else
                        // reg_C <= ALUo;
                    
                    if (I_ZFNFCF_TYPE(code_type))
                        begin
                            cf <= cf_buf;
                            if (ALUo == 16'b0000_0000_0000_0000)
                                zf <= 1'b1;
                            else
                                zf <= 1'b0;
                            if (ALUo[GENERAL_REG_WIDTH-1] == 1'b1)
                                nf <= 1'b1;
                            else
                                nf <= 1'b0;
                        end
                    else
                        begin
                            zf <= zf;
                            nf <= nf;
                            cf <= cf;
                        end
                end
        end

    //************* dw SRAM write signal ***************
    always @(negedge clk)
        begin
            if ((state == STATE_EX2)||(state == STATE_MEM))
                begin
                    if (code_type == `STORE)
                        dw <= 1'b1;
                    else
                        dw <= 1'b0;
                end
            else// if (state == STATE_MEM)
                dw <= 1'b0;
        end
        
    //************* MEM *************//
    assign branch_flag = ((code_type == `JUMP)
                        || (code_type == `JMPR)
                        || ((code_type == `BZ) && (zf == 1'b1))
                        || ((code_type == `BNZ) && (zf == 1'b0))
                        || ((code_type == `BN) && (nf == 1'b1))
                        || ((code_type == `BNN) && (nf == 1'b0))
                        || ((code_type == `BC) && (cf == 1'b1))
                        || ((code_type == `BNC) && (cf == 1'b0)));

    //************* WB *************//
    always @(posedge clk or negedge rst_n)
        begin
            if (!rst_n)
                begin
                    gr[0] <= 16'b0000_0000_0000_0000;
                    gr[1] <= 16'b0000_0000_0000_0000;
                    gr[2] <= 16'b0000_0000_0000_0000;
                    gr[3] <= 16'b0000_0000_0000_0000;
                    gr[4] <= 16'b0000_0000_0000_0000;
                    // gr[5] <= 16'b0000_0000_0000_0000;
                    // gr[6] <= 16'b0000_0000_0000_0000;
                    // gr[7] <= 16'b0000_0000_0000_0000;
                    
                    pc <= {PC_MEM_ADDR_WIDTH{1'b0}};//DEFAULT_PC_ADDR;
                end
            else if (state == STATE_IDLE)
                begin
                    if (start == 1'b1)
                        pc <= {PC_MEM_ADDR_WIDTH{1'b0}};
                end
            else if (state == STATE_MEM2)
                begin
                    // save the d_datain to the low half
                    if (code_type == `LOAD)
                        gr[oper1_r1][MEMORY_DATA_WIDTH-1:0] <= d_datain;
                end
            else if (state == STATE_WB)
                begin
                    if (code_type == `LOAD)
                        gr[oper1_r1][(MEMORY_DATA_WIDTH<<1)-1:MEMORY_DATA_WIDTH] <= d_datain;
                    else if (I_REG_TYPE(code_type))
                        gr[oper1_r1] <= reg_C;
                        
                    //the pc update could be move to MEM state to save time;
                    if (branch_flag)
                        pc <= reg_C[PC_MEM_ADDR_WIDTH-1:0];
                    else if (instr_over)
                        pc <= pc;//{PC_MEM_ADDR_WIDTH{1'b0}};//DEFAULT_PC_ADDR
                    else
                        pc <= pc + 1;
                end
        end
        
        //***** Judge an instruction whether needs to change zf, nf and cf *****//
        function I_ZFNFCF_TYPE;
            input [OP_WIDTH_5B-1:0] op;
            begin
                I_ZFNFCF_TYPE = ((op == `LDIH)
                        || (op == `SUIH)
                        || (op == `ADD)
                        || (op == `ADDI)
                        //|| (op == `ADDC)
                        || (op == `SUB)
                        || (op == `SUBI)
                        //|| (op == `SUBC)
                        || (op == `CMP)
                        || (op == `AND)
                        || (op == `OR)
                        || (op == `XOR)
                        || (op == `SLL)
                        || (op == `SRL));
                        //|| (op == `SLA)
                        //|| (op == `SRA));
            end
        endfunction
        
        //***** Judge an instruction whether alter the value of a register *****//
        function I_REG_TYPE;
            input [OP_WIDTH_5B-1:0] op;
            begin
                I_REG_TYPE = ((op == `LOAD)
                        || (op == `LDIH)
                        || (op == `ADD)
                        || (op == `ADDI)
                        //|| (op == `ADDC)
                        || (op == `SUIH)
                        || (op == `SUB)
                        || (op == `SUBI)
                        //|| (op == `SUBC)
                        || (op == `AND)
                        || (op == `OR)
                        || (op == `XOR)
                        || (op == `SLL)
                        || (op == `SRL)
                        //|| (op == `SLA)
                        //|| (op == `SRA)
                        || (op == `LIOA)
                        || (op == `LIOB)
                        || (op == `LIOS)
                        || (op == `SET)
                        || (op == `LFSR));
            end
        endfunction
       
        //************* R1 as reg_A *************//
        function I_R1_TYPE;
            input [OP_WIDTH_5B-1:0] op;
            begin
                I_R1_TYPE = ((op == `LDIH)
                        || (op == `SUIH)
                        || (op == `ADDI)
                        || (op == `SUBI)
                        || (op == `JMPR)
                        || (op == `BZ)
                        || (op == `BNZ)
                        || (op == `BN)
                        || (op == `BNN)
                        || (op == `BC)
                        || (op == `BNC)
                        || (op == `SET));
            end
        endfunction
        
        //************* R2 as reg_A *************//
        function I_R2_TYPE;
            input [OP_WIDTH_5B-1:0] op;
            begin
                I_R2_TYPE = ((op == `LOAD)
                        || (op == `STORE)
                        || (op == `ADD)
                        //|| (op == `ADDC)
                        || (op == `SUB)
                        //|| (op == `SUBC)
                        || (op == `CMP)
                        || (op == `AND)
                        || (op == `OR)
                        || (op == `XOR)
                        || (op == `SLL)
                        || (op == `SRL));
                        //|| (op == `SLA)
                        //|| (op == `SRA));
            end
        endfunction
        
        //************* R3 as reg_B *************//
        function I_R3_TYPE;
            input [OP_WIDTH_5B-1:0] op;
            begin
                I_R3_TYPE = ((op == `ADD)
                        //|| (op == `ADDC)
                        || (op == `SUB)
                        //|| (op == `SUBC)
                        || (op == `CMP)
                        || (op == `AND)
                        || (op == `OR)
                        || (op == `XOR)
                        || (op == `LFSR));
            end
        endfunction
        
        //************* val3 as reg_B *************//
        function I_V3_TYPE;
            input [OP_WIDTH_5B-1:0] op;
            begin
                I_V3_TYPE = ((op == `LOAD)
                        || (op == `STORE)
                        || (op == `SLL)
                        || (op == `SRL));
                        //|| (op == `SLA)
                        //|| (op == `SRA));
            end
        endfunction
        
        //************* {0000_0000,val2,val3} as reg_B *************//
        function I_ZEROV2V3_TYPE;
            input [OP_WIDTH_5B-1:0] op;
            begin
                I_ZEROV2V3_TYPE = ((op == `ADDI)
                        || (op == `SUBI)
                        || (op == `JUMP)
                        || (op == `JMPR)
                        || (op == `BZ)
                        || (op == `BNZ)
                        || (op == `BN)
                        || (op == `BNN)
                        || (op == `BC)
                        || (op == `BNC)
                        || (op == `SET));
            end
        endfunction
        
        //************* {val2,val3,0000_0000} as reg_B *************//
        function I_V2V3ZERO_TYPE;
            input [OP_WIDTH_5B-1:0] op;
            begin
                I_V2V3ZERO_TYPE = ((op == `LDIH)
                        || (op == `SUIH));
            end
        endfunction

endmodule
`endif//SERIAL_CPU_8BIT_V

