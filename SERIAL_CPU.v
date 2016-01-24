//+FHDR****************************************************************
// ECE department, TAMU
// --------------------------------------------------------------------
// FILE NAME    : SERIAL_CPU.v
// AUTHER       : Jiafan Wang
// DATE         : 01/23/2016
// VERSION      : 1.0
// PURPOSE      : the kernel of a serial CPU with five states
// --------------------------------------------------------------------
// ABSTRACT
//
// --------------------------------------------------------------------

`timescale 1ns / 1ps
`include "DEFINE_CPU.v"

`ifndef SERIAL_CPU_V
`define SERIAL_CPU_V

module SERIAL_CPU(
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
                PC_MEM_ADDR_WIDTH   = 8;
                
    parameter   MSB_OP_16B          = 16,
                OP_WIDTH_5B         = 5,
                MSB_OPER1_11B       = 11,
                MSB_OPER2_8B        = 8,
                MSB_OPER3_4B        = 4,
                MSB_VAL2_7B         = 7,
                MSB_VAL3_3B         = 3;
    
    parameter   STATE_IDLE          = 3'b000,
                STATE_IF            = 3'b001,
                STATE_ID            = 3'b011,
                STATE_EX            = 3'b010,
                STATE_MEM           = 3'b110,
                STATE_WB            = 3'b100;
    
    input   clk;
    input   enable;
    input   rst_n;
    input   start;
    input   [INSTRT_DATA_WIDTH-1:0] i_datain;    //input instruction data
    input   [D_MEM_DATA_WIDTH-1:0]  d_datain;    //input memory data
    output  nxt;
    output  [INSTRT_ADDR_WIDTH-1:0] i_addr;      //output instruction address
    output  [D_MEM_ADDR_WIDTH-1:0]  d_addr;      //output memory data address 
    output  d_we;               //memory read or write signal, 1: write
    output  [D_MEM_DATA_WIDTH-1:0]  d_dataout;   //output memory data 
    // for I/O control and data in&out
    input   [GENERAL_REG_WIDTH-1:0]  io_status;
    input   [GENERAL_REG_WIDTH-1:0]  io_datainA;
    input   [GENERAL_REG_WIDTH-1:0]  io_datainB;
    output  [GENERAL_REG_WIDTH-1:0]  io_control;
    output  [GENERAL_REG_WIDTH-1:0]  io_dataoutA;
    output  [GENERAL_REG_WIDTH-1:0]  io_dataoutB;
    
    reg     cf_buf;
    reg     [GENERAL_REG_WIDTH-1:0] ALUo;
    reg     [2:0] state, next_state;
    reg     zf, nf, cf, dw, nxt;     //flag registers
    reg     [PC_MEM_ADDR_WIDTH-1:0] pc;
    reg     [GENERAL_REG_WIDTH-1:0] id_ir, ex_ir, mem_ir, wb_ir;// instruction registers
    reg     [GENERAL_REG_WIDTH-1:0] reg_A, reg_B, reg_C, reg_C1, smdr, smdr1;
    reg     [GENERAL_REG_WIDTH-1:0] gr[7:0];
    wire    branch_flag;

    assign  io_control  = gr[1];
    assign  io_dataoutA = gr[2];
    assign  io_dataoutB = gr[3];
    
    //*********** Facilitate code learning ***********//
    wire    [4:0]   code_type;
    wire    [2:0]   oper1_r1;
    wire    [3:0]   oper2_r2;
    wire    oper2_is_val;
    wire    [3:0]   oper3_r3;
    wire    oper3_is_val;
    
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
                STATE_IF:   next_state <= STATE_ID;
                STATE_ID:   next_state <= STATE_EX;
                STATE_EX:   next_state <= STATE_MEM;
                STATE_MEM:  next_state <= STATE_WB;
                STATE_WB:
                    if (wb_ir[MSB_OP_16B-1:MSB_OPER1_11B] == `HALT) begin
                        nxt <= 1'b1;
                        next_state <= STATE_IDLE;
                    end
                    else begin
                        nxt <= 1'b0;
                        next_state <= STATE_IF;
                    end
            endcase
        end
        
        
        
    //************* IF *************//
    assign i_addr = pc;
    always @(posedge clk or negedge rst_n)
        begin
            if (!rst_n)
                begin
                    id_ir <= {`NOP, 11'b000_0000_0000};
                    // pc <= 8'b0000_0000;
                end
            else if (state == STATE_IF)
                begin
                    id_ir <= i_datain;
                    
                    // if(branch_flag)
                        // pc <= reg_C[PC_MEM_ADDR_WIDTH-1:0];
                    // else
                        // pc <= pc + 1;
                end
        end
        
        
    //************* ID *************//
    always @(posedge clk or negedge rst_n)
        begin
            if (!rst_n)
                begin
                    ex_ir <= {`NOP, 11'b000_0000_0000};
                    reg_A <= 16'b0000_0000_0000_0000;
                    reg_B <= 16'b0000_0000_0000_0000;
                    smdr <= 16'b0000_0000_0000_0000;
                end
            else if (state == STATE_ID)
                begin
                    ex_ir <= id_ir;
                    
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

    //************* EX *************//
    always @(posedge clk or negedge rst_n)
        begin
            if (!rst_n)
                begin
                    mem_ir <= {`NOP, 11'b000_0000_0000};
                    reg_C <= 16'b0000_0000_0000_0000;
                    smdr1 <= 16'b0000_0000_0000_0000;
                    dw <= 1'b0;
                    zf <= 1'b0;
                    nf <= 1'b0;
                    cf <= 1'b0;
                end
            
            else if (state == STATE_EX)
                begin
                    if (ex_ir[MSB_OP_16B-1:MSB_OPER1_11B] == `LIOA)
                    reg_C <= io_datainA;
                    else if (ex_ir[MSB_OP_16B-1:MSB_OPER1_11B] == `LIOB)
                    reg_C <= io_datainB;
                    else if (ex_ir[MSB_OP_16B-1:MSB_OPER1_11B] == `LIOS)
                    reg_C <= io_status;
                    else
                    reg_C <= ALUo;
                    mem_ir <= ex_ir;
                    
                    if ((ex_ir[MSB_OP_16B-1:MSB_OPER1_11B] == `LDIH)
                            || (ex_ir[MSB_OP_16B-1:MSB_OPER1_11B] == `SUIH)
                            || (ex_ir[MSB_OP_16B-1:MSB_OPER1_11B] == `ADD)
                            || (ex_ir[MSB_OP_16B-1:MSB_OPER1_11B] == `ADDI)
                            || (ex_ir[MSB_OP_16B-1:MSB_OPER1_11B] == `ADDC)
                            || (ex_ir[MSB_OP_16B-1:MSB_OPER1_11B] == `SUB)
                            || (ex_ir[MSB_OP_16B-1:MSB_OPER1_11B] == `SUBI)
                            || (ex_ir[MSB_OP_16B-1:MSB_OPER1_11B] == `SUBC)
                            || (ex_ir[MSB_OP_16B-1:MSB_OPER1_11B] == `CMP)
                            || (ex_ir[MSB_OP_16B-1:MSB_OPER1_11B] == `AND)
                            || (ex_ir[MSB_OP_16B-1:MSB_OPER1_11B] == `OR)
                            || (ex_ir[MSB_OP_16B-1:MSB_OPER1_11B] == `XOR)
                            || (ex_ir[MSB_OP_16B-1:MSB_OPER1_11B] == `SLL)
                            || (ex_ir[MSB_OP_16B-1:MSB_OPER1_11B] == `SRL)
                            || (ex_ir[MSB_OP_16B-1:MSB_OPER1_11B] == `SLA)
                            || (ex_ir[MSB_OP_16B-1:MSB_OPER1_11B] == `SRA))
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
                    
                    if (ex_ir[MSB_OP_16B-1:MSB_OPER1_11B] == `STORE)
                        begin
                            dw <= 1'b1;
                            smdr1 <= smdr;
                        end
                    else
                        begin
                            dw <= 1'b0;
                            smdr1 <= smdr1;
                        end
                end
        end
    always @(*)
        begin
            case(ex_ir[MSB_OP_16B-1:MSB_OPER1_11B])
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

    //************* MEM *************//
    assign d_addr = reg_C[D_MEM_ADDR_WIDTH-1:0];
    assign d_we = dw;
    assign d_dataout = smdr1;
    assign branch_flag = ((mem_ir[MSB_OP_16B-1:MSB_OPER1_11B] == `JUMP)
                        || (mem_ir[MSB_OP_16B-1:MSB_OPER1_11B] == `JMPR)
                        || ((mem_ir[MSB_OP_16B-1:MSB_OPER1_11B] == `BZ) && (zf == 1'b1))
                        || ((mem_ir[MSB_OP_16B-1:MSB_OPER1_11B] == `BNZ) && (zf == 1'b0))
                        || ((mem_ir[MSB_OP_16B-1:MSB_OPER1_11B] == `BN) && (nf == 1'b1))
                        || ((mem_ir[MSB_OP_16B-1:MSB_OPER1_11B] == `BNN) && (nf == 1'b0))
                        || ((mem_ir[MSB_OP_16B-1:MSB_OPER1_11B] == `BC) && (cf == 1'b1))
                        || ((mem_ir[MSB_OP_16B-1:MSB_OPER1_11B] == `BNC) && (cf == 1'b0)));
    always @(posedge clk or negedge rst_n)
        begin
            if (!rst_n)
                begin
                    wb_ir <= {`NOP, 11'b000_0000_0000};
                    reg_C1 <= 16'b0000_0000_0000_0000;
                end
            
            else if (state == STATE_MEM)
                begin
                    wb_ir <= mem_ir;
                    
                    if (mem_ir[MSB_OP_16B-1:MSB_OPER1_11B] == `LOAD)
                        reg_C1 <= d_datain;
                    else
                        reg_C1 <= reg_C;
                end
        end
            
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
                    gr[5] <= 16'b0000_0000_0000_0000;
                    gr[6] <= 16'b0000_0000_0000_0000;
                    gr[7] <= 16'b0000_0000_0000_0000;
                    
                    pc <= 8'b0000_0000;
                end
            
            else if (state == STATE_WB)
                begin
                    if (I_REG_TYPE(wb_ir[MSB_OP_16B-1:MSB_OPER1_11B]))
                        gr[wb_ir[MSB_OPER1_11B-1:MSB_OPER2_8B]] <= reg_C1;
                        
                    //the pc update could be move to MEM state to save time;
                    if(branch_flag)
                        pc <= reg_C[PC_MEM_ADDR_WIDTH-1:0];
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
`endif//SERIAL_CPU_V
