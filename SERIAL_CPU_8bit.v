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
    io_dataoutB
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
                STATE_WB            = 4'b1111;
    
    input   clk;
    input   enable;
    input   rst_n;
    input   start;
    input   [MEMORY_DATA_WIDTH-1:0] i_datain;    //input instruction data
    input   [MEMORY_DATA_WIDTH-1:0] d_datain;    //input memory data
    output  nxt;
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
    
    reg     lowest_bit;
    reg     cf_buf;
    reg     [GENERAL_REG_WIDTH-1:0] ALUo;
    reg     [3:0] state, next_state;
    reg     zf, nf, cf, dw, nxt;     //flag registers
    reg     [PC_MEM_ADDR_WIDTH-1:0] pc;
    reg     [GENERAL_REG_WIDTH-1:0] id_ir;// instruction registers, ex_ir, mem_ir, wb_ir
    reg     [GENERAL_REG_WIDTH-1:0] reg_A, reg_B, reg_C, smdr;// reg_C1, smdr1;
    reg     [GENERAL_REG_WIDTH-1:0] gr[3:0];
    wire    branch_flag;

    assign  io_control  = gr[1];
    assign  io_dataoutA = gr[2];
    assign  io_dataoutB = gr[3];
    
    //*********** Facilitate code learning ***********//
    wire    instr_over; // instructions in SRAM are over
    wire    [4:0]   code_type;
    wire    [2:0]   oper1_r1;
    wire    [3:0]   oper2_r2;
    wire    oper2_is_val;
    wire    [3:0]   oper3_r3;
    wire    oper3_is_val;
    
    assign  instr_over = (pc == {PC_MEM_ADDR_WIDTH{1'b1}});
    assign  code_type = id_ir[MSB_OP_16B-1:MSB_OPER1_11B];
    assign  oper1_r1 = id_ir[MSB_OPER1_11B-1:MSB_OPER2_8B];
    assign  oper2_r2 = id_ir[MSB_OPER2_8B-1:MSB_OPER3_4B];
    assign  oper3_r3 = id_ir[MSB_OPER3_4B-1:0];
    assign  oper2_is_val = id_ir[MSB_OPER2_8B-1];
    assign  oper3_is_val = id_ir[MSB_OPER3_4B-1];
    
    //************* CPU Control *************//
    always @(posedge clk)
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
                        nxt <= 1'b0;
                        next_state <= STATE_IF;
                    end
                    else begin
                        nxt <= 1'b0;
                        next_state <= STATE_IDLE;
                    end
                STATE_IF:   next_state <= STATE_IF2;
                STATE_IF2:  next_state <= STATE_ID;
                STATE_ID:   next_state <= STATE_EX;
                STATE_EX:   next_state <= STATE_EX2;
                STATE_EX2:  next_state <= STATE_MEM;
                STATE_MEM:  next_state <= STATE_MEM2;
                STATE_MEM2: next_state <= STATE_WB;//next_state <= STATE_MEM;
                STATE_WB:
                    if (id_ir[MSB_OP_16B-1:MSB_OPER1_11B] == `HALT) begin
                        nxt <= 1'b1;
                        next_state <= STATE_IDLE;
                    end
                    else if (instr_over) begin
                        nxt <= 1'b0;
                        next_state <= STATE_IDLE;
                    end
                    else begin
                        nxt <= 1'b0;
                        next_state <= STATE_IF;
                    end
                default:
                    begin
                        nxt <= 1'b0;
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
                    // pc <= 8'b0000_0000;
                end
            else if (state == STATE_IF)
                begin
                    id_ir[MEMORY_DATA_WIDTH-1:0] <= i_datain;
                    
                    // if(branch_flag)
                        // pc <= reg_C[PC_MEM_ADDR_WIDTH-1:0];
                    // else
                        // pc <= pc + 1;
                end
            else if (state == STATE_IF2)
                begin
                    id_ir[(MEMORY_DATA_WIDTH<<1)-1:MEMORY_DATA_WIDTH] <= i_datain;
                end
        end

    //************* lowest_bit ***************
    assign i_addr = {pc, lowest_bit};
    always @(posedge clk or negedge rst_n)
        begin
            if (!rst_n)
                lowest_bit <= 0;
            else if (state == STATE_IDLE)
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
                    //id_ir <= {`NOP, 11'b000_0000_0000};
                    reg_A <= 16'b0000_0000_0000_0000;
                    reg_B <= 16'b0000_0000_0000_0000;
                    smdr <= 16'b0000_0000_0000_0000;
                end
            else if (state == STATE_ID)
                begin
                    //id_ir <= id_ir;
                    
                    if (id_ir[MSB_OP_16B-1:MSB_OPER1_11B] == `STORE)
                        smdr <= gr[id_ir[MSB_OPER1_11B-1:MSB_OPER2_8B]];
                    else
                        smdr <= smdr;
                
                    if (id_ir[MSB_OP_16B-1:MSB_OPER1_11B] == `JUMP)
                        reg_A <= 16'b0000_0000_0000_0000;
                    else if (I_R1_TYPE(id_ir[MSB_OP_16B-1:MSB_OPER1_11B]))
                        reg_A <= gr[id_ir[MSB_OPER1_11B-1:MSB_OPER2_8B]];
                    else if (I_R2_TYPE(id_ir[MSB_OP_16B-1:MSB_OPER1_11B]))
                        reg_A <= gr[id_ir[MSB_VAL2_7B-1:MSB_OPER3_4B]];
                    else
                        reg_A <= reg_A;
                    
                    if (I_V3_TYPE(id_ir[MSB_OP_16B-1:MSB_OPER1_11B]))
                        reg_B <= {12'b0000_0000_0000, id_ir[MSB_OPER3_4B-1:0]};
                    else if (I_ZEROV2V3_TYPE(id_ir[MSB_OP_16B-1:MSB_OPER1_11B]))
                        reg_B <= {8'b0000_0000, id_ir[MSB_OPER2_8B-1:0]};
                    else if (I_V2V3ZERO_TYPE(id_ir[MSB_OP_16B-1:MSB_OPER1_11B]))
                        reg_B <= {id_ir[MSB_OPER2_8B-1:0], 8'b0000_0000};
                    else if (I_R3_TYPE(id_ir[MSB_OP_16B-1:MSB_OPER1_11B]))
                        reg_B <= gr[id_ir[MSB_VAL3_3B-1:0]];
                    else
                        reg_B <= reg_B;
                end
        end
    //************* Combinational ALU *************//
    always @(*)
        begin
            case(id_ir[MSB_OP_16B-1:MSB_OPER1_11B])
                `AND:   {cf_buf, ALUo} <= {1'b0, reg_A & reg_B};
                `OR:    {cf_buf, ALUo} <= {1'b0, reg_A | reg_B};
                `XOR:   {cf_buf, ALUo} <= {1'b0, reg_A ^ reg_B};
                `SLL:   {cf_buf, ALUo} <= {cf_buf, reg_A << reg_B[MSB_OPER3_4B-1:0]};
                `SRL:   {cf_buf, ALUo} <= {cf_buf, reg_A >> reg_B[MSB_OPER3_4B-1:0]};
                `SLA:   {cf_buf, ALUo} <= {cf_buf, reg_A <<< reg_B[MSB_OPER3_4B-1:0]};
                `SRA:   {cf_buf, ALUo} <= {cf_buf, reg_A >>> reg_B[MSB_OPER3_4B-1:0]};
                `SET:   {cf_buf, ALUo} <= {1'b0, reg_B};
                //`JUMP:  {cf_buf, ALUo} <= {cf_buf, reg_B};
                //`LDIH:
                `ADD:   {cf_buf, ALUo} <= reg_A + reg_B;
                `ADDI:  {cf_buf, ALUo} <= reg_A + reg_B;
                `ADDC:  {cf_buf, ALUo} <= reg_A + reg_B + cf;
                `SUB:   {cf_buf, ALUo} <= reg_A - reg_B;
                `SUBI:  {cf_buf, ALUo} <= reg_A - reg_B;
                `SUIH:  {cf_buf, ALUo} <= reg_A - reg_B;
                `SUBC:  {cf_buf, ALUo} <= reg_A - reg_B - cf;
                `CMP:   {cf_buf, ALUo} <= reg_A - reg_B;
                //`LOAD:`STORE:`JMPR:
                //`BZ:`BNZ:`BN:`BNN:`BC:`BNC:
                default:{cf_buf, ALUo} <= {cf_buf, reg_A + reg_B};
            endcase
        
            // if (ex_ir[MSB_OP_16B-1:MSB_OPER1_11B] == `AND)
                // begin
                    // cf_buf <= 1'b0;
                    // ALUo <= reg_A & reg_B;
                // end
            // else if (ex_ir[MSB_OP_16B-1:MSB_OPER1_11B] == `OR)
                // begin
                    // cf_buf <= 1'b0;
                    // ALUo <= reg_A | reg_B;
                // end
            // else if (ex_ir[MSB_OP_16B-1:MSB_OPER1_11B] == `XOR)
                // begin
                    // cf_buf <= 1'b0;
                    // ALUo <= reg_A ^ reg_B;
                // end
            // else if (ex_ir[MSB_OP_16B-1:MSB_OPER1_11B] == `SLL)
                // {cf_buf, ALUo[GENERAL_REG_WIDTH-1:0]} <= {cf, reg_A[GENERAL_REG_WIDTH-1:0]} << reg_B[MSB_OPER3_4B-1:0];
            // else if (ex_ir[MSB_OP_16B-1:MSB_OPER1_11B] == `SRL)
                // {ALUo[GENERAL_REG_WIDTH-1:0], cf_buf} <= {reg_A[GENERAL_REG_WIDTH-1:0], cf} >> reg_B[MSB_OPER3_4B-1:0];
            // else if (ex_ir[MSB_OP_16B-1:MSB_OPER1_11B] == `SLA)
                // {cf_buf, ALUo[GENERAL_REG_WIDTH-1:0]} <= {cf, reg_A[GENERAL_REG_WIDTH-1:0]} <<< reg_B[MSB_OPER3_4B-1:0];
            // else if (ex_ir[MSB_OP_16B-1:MSB_OPER1_11B] == `SRA)
                // {ALUo[GENERAL_REG_WIDTH-1:0], cf_buf} <= {reg_A[GENERAL_REG_WIDTH-1:0], cf} >>> reg_B[MSB_OPER3_4B-1:0];
            // else if ((ex_ir[MSB_OP_16B-1:MSB_OPER1_11B] == `SUB)
                    // || (ex_ir[MSB_OP_16B-1:MSB_OPER1_11B] == `SUBI)
                    // || (ex_ir[MSB_OP_16B-1:MSB_OPER1_11B] == `CMP)
                    // || (ex_ir[MSB_OP_16B-1:MSB_OPER1_11B] == `SUIH))
                // {cf_buf, ALUo} <= reg_A - reg_B;
            // else if (ex_ir[MSB_OP_16B-1:MSB_OPER1_11B] == `SUBC)
                // {cf_buf, ALUo} <= reg_A - reg_B - cf;
            // else if (ex_ir[MSB_OP_16B-1:MSB_OPER1_11B] == `ADDC)
                // {cf_buf, ALUo} <= reg_A + reg_B + cf;
            // else
                // {cf_buf, ALUo} <= reg_A + reg_B;
        end
        
    //************* EX (&EX2) *************//
    assign d_addr = {reg_C[PC_MEM_ADDR_WIDTH-1:0],lowest_bit};//D_MEM_ADDR_WIDTH
    assign d_we = dw;
    assign d_dataout = (!lowest_bit)?
                    smdr[MEMORY_DATA_WIDTH-1:0]:
                    smdr[(MEMORY_DATA_WIDTH<<1)-1:MEMORY_DATA_WIDTH];
    always @(posedge clk or negedge rst_n)
        begin
            if (!rst_n)
                begin
                    //id_ir <= {`NOP, 11'b000_0000_0000};
                    reg_C <= 16'b0000_0000_0000_0000;
                    //smdr <= 16'b0000_0000_0000_0000;
                    //dw <= 1'b0;
                    zf <= 1'b0;
                    nf <= 1'b0;
                    cf <= 1'b0;
                end
            
            else if (state == STATE_EX)
                begin
                    if (id_ir[MSB_OP_16B-1:MSB_OPER1_11B] == `LIOA)
                        reg_C <= io_datainA;
                    else if (id_ir[MSB_OP_16B-1:MSB_OPER1_11B] == `LIOB)
                        reg_C <= io_datainB;
                    else if (id_ir[MSB_OP_16B-1:MSB_OPER1_11B] == `LIOS)
                        reg_C <= io_status;
                    else
                        reg_C <= ALUo;
                    //id_ir <= id_ir;
                    
                    if (I_ZFNFCF_TYPE(id_ir[MSB_OP_16B-1:MSB_OPER1_11B]))
                    // if ((id_ir[MSB_OP_16B-1:MSB_OPER1_11B] == `LDIH)
                            // || (id_ir[MSB_OP_16B-1:MSB_OPER1_11B] == `SUIH)
                            // || (id_ir[MSB_OP_16B-1:MSB_OPER1_11B] == `ADD)
                            // || (id_ir[MSB_OP_16B-1:MSB_OPER1_11B] == `ADDI)
                            // || (id_ir[MSB_OP_16B-1:MSB_OPER1_11B] == `ADDC)
                            // || (id_ir[MSB_OP_16B-1:MSB_OPER1_11B] == `SUB)
                            // || (id_ir[MSB_OP_16B-1:MSB_OPER1_11B] == `SUBI)
                            // || (id_ir[MSB_OP_16B-1:MSB_OPER1_11B] == `SUBC)
                            // || (id_ir[MSB_OP_16B-1:MSB_OPER1_11B] == `CMP)
                            // || (id_ir[MSB_OP_16B-1:MSB_OPER1_11B] == `AND)
                            // || (id_ir[MSB_OP_16B-1:MSB_OPER1_11B] == `OR)
                            // || (id_ir[MSB_OP_16B-1:MSB_OPER1_11B] == `XOR)
                            // || (id_ir[MSB_OP_16B-1:MSB_OPER1_11B] == `SLL)
                            // || (id_ir[MSB_OP_16B-1:MSB_OPER1_11B] == `SRL)
                            // || (id_ir[MSB_OP_16B-1:MSB_OPER1_11B] == `SLA)
                            // || (id_ir[MSB_OP_16B-1:MSB_OPER1_11B] == `SRA))
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
                    
                    // if (id_ir[MSB_OP_16B-1:MSB_OPER1_11B] == `STORE)
                        // begin
                            // dw <= 1'b1;
                            // smdr <= smdr;
                        // end
                    // else
                        // begin
                            // dw <= 1'b0;
                            // smdr <= smdr;
                        // end
                end
        end

    //************* dw SRAM write signal ***************
    always @(posedge clk or negedge rst_n)
        begin
            if (!rst_n)
                dw <= 1'b0;
            else if (state == STATE_EX)
                begin
                    if (id_ir[MSB_OP_16B-1:MSB_OPER1_11B] == `STORE)
                        dw <= 1'b1;
                    else
                        dw <= 1'b0;
                end
            else if (state == STATE_MEM)
                dw <= 1'b0;
        end
        
    //************* MEM *************//
    assign branch_flag = ((id_ir[MSB_OP_16B-1:MSB_OPER1_11B] == `JUMP)
                        || (id_ir[MSB_OP_16B-1:MSB_OPER1_11B] == `JMPR)
                        || ((id_ir[MSB_OP_16B-1:MSB_OPER1_11B] == `BZ) && (zf == 1'b1))
                        || ((id_ir[MSB_OP_16B-1:MSB_OPER1_11B] == `BNZ) && (zf == 1'b0))
                        || ((id_ir[MSB_OP_16B-1:MSB_OPER1_11B] == `BN) && (nf == 1'b1))
                        || ((id_ir[MSB_OP_16B-1:MSB_OPER1_11B] == `BNN) && (nf == 1'b0))
                        || ((id_ir[MSB_OP_16B-1:MSB_OPER1_11B] == `BC) && (cf == 1'b1))
                        || ((id_ir[MSB_OP_16B-1:MSB_OPER1_11B] == `BNC) && (cf == 1'b0)));
    // always @(posedge clk or negedge rst_n)
        // begin
            // if (!rst_n)
                // begin
                    //id_ir <= {`NOP, 11'b000_0000_0000};
                    // reg_C1 <= 16'b0000_0000_0000_0000;
                // end
            
            // else if (state == STATE_MEM)
                // begin
                    //id_ir <= id_ir;
                    
                    // if (id_ir[MSB_OP_16B-1:MSB_OPER1_11B] == `LOAD)
                        // reg_C1 <= d_datain;
                    // else
                        // reg_C1 <= reg_C;
                // end
        // end
            
    //************* WB *************//
    always @(posedge clk or negedge rst_n)
        begin
            if (!rst_n)
                begin
                    gr[0] <= 16'b0000_0000_0000_0000;
                    gr[1] <= 16'b0000_0000_0000_0000;
                    gr[2] <= 16'b0000_0000_0000_0000;
                    gr[3] <= 16'b0000_0000_0000_0000;
                    // gr[4] <= 16'b0000_0000_0000_0000;
                    // gr[5] <= 16'b0000_0000_0000_0000;
                    // gr[6] <= 16'b0000_0000_0000_0000;
                    // gr[7] <= 16'b0000_0000_0000_0000;
                    
                    pc <= DEFAULT_PC_ADDR;//8'b0000_0000;
                end
            else if (state == STATE_MEM2)
                begin
                    if (id_ir[MSB_OP_16B-1:MSB_OPER1_11B] == `LOAD)
                        gr[id_ir[MSB_OPER1_11B-1:MSB_OPER2_8B]] <= {d_datain, {MEMORY_DATA_WIDTH{1'b0}}};
                end
            else if (state == STATE_WB)
                begin
                    if (id_ir[MSB_OP_16B-1:MSB_OPER1_11B] == `LOAD)
                        gr[id_ir[MSB_OPER1_11B-1:MSB_OPER2_8B]][MEMORY_DATA_WIDTH-1:0] <= d_datain;
                    else if (I_REG_TYPE(id_ir[MSB_OP_16B-1:MSB_OPER1_11B]))
                        gr[id_ir[MSB_OPER1_11B-1:MSB_OPER2_8B]] <= reg_C;
                        
                    //the pc update could be move to MEM state to save time;
                    if(branch_flag)
                        pc <= reg_C[PC_MEM_ADDR_WIDTH-1:0];
                    else if(instr_over)
                        pc <= DEFAULT_PC_ADDR;
                    else
                        pc <= pc + 1;
                end
        end
        
    /**************select Y*****************/
    // always@(*)
        // begin
            // case(select_y)
                // 4'b0000:    y <= reg_C;
                // 4'b0001:    y <= reg_A;
                // 4'b0010:    y <= reg_B;
                // 4'b0011:    y <= {pc, 8'b0000_0000};
                // 4'b0100:    y <= id_ir;
                // 4'b0101:    y <= smdr;
                // 4'b0110:    y <= reg_C1;
                // 4'b0111:    y <= smdr1;
                // 4'b1000:    y <= ex_ir;
                // 4'b1001:    y <= mem_ir;
                // 4'b1010:    y <= wb_ir;
                // default:    y <= reg_C;
            // endcase
        // end
    /***************************************/
        
        //***** Judge an instruction whether needs to change zf, nf and cf *****//
        function I_ZFNFCF_TYPE;
            input [OP_WIDTH_5B-1:0] op;
            begin
                I_ZFNFCF_TYPE = ((op == `LDIH)
                        || (op == `SUIH)
                        || (op == `ADD)
                        || (op == `ADDI)
                        || (op == `ADDC)
                        || (op == `SUB)
                        || (op == `SUBI)
                        || (op == `SUBC)
                        || (op == `CMP)
                        || (op == `AND)
                        || (op == `OR)
                        || (op == `XOR)
                        || (op == `SLL)
                        || (op == `SRL)
                        || (op == `SLA)
                        || (op == `SRA));
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
                        || (op == `ADDC)
                        || (op == `SUIH)
                        || (op == `SUB)
                        || (op == `SUBI)
                        || (op == `SUBC)
                        || (op == `AND)
                        || (op == `OR)
                        || (op == `XOR)
                        || (op == `SLL)
                        || (op == `SRL)
                        || (op == `SLA)
                        || (op == `SRA)
                        || (op == `LIOA)
                        || (op == `LIOB)
                        || (op == `LIOS)
                        || (op == `SET));
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
                        || (op == `ADDC)
                        || (op == `SUB)
                        || (op == `SUBC)
                        || (op == `CMP)
                        || (op == `AND)
                        || (op == `OR)
                        || (op == `XOR)
                        || (op == `SLL)
                        || (op == `SRL)
                        || (op == `SLA)
                        || (op == `SRA));
            end
        endfunction
        
        //************* R3 as reg_B *************//
        function I_R3_TYPE;
            input [OP_WIDTH_5B-1:0] op;
            begin
                I_R3_TYPE = ((op == `ADD)
                        || (op == `ADDC)
                        || (op == `SUB)
                        || (op == `SUBC)
                        || (op == `CMP)
                        || (op == `AND)
                        || (op == `OR)
                        || (op == `XOR));
            end
        endfunction
        
        //************* val3 as reg_B *************//
        function I_V3_TYPE;
            input [OP_WIDTH_5B-1:0] op;
            begin
                I_V3_TYPE = ((op == `LOAD)
                        || (op == `STORE)
                        || (op == `SLL)
                        || (op == `SRL)
                        || (op == `SLA)
                        || (op == `SRA));
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
