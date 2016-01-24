//Verilog HDL for "amsLib2", "cf_testbench" "verilog"
//+FHDR****************************************************************
// ECE department, TAMU
// --------------------------------------------------------------------
// FILE NAME    : SA_4D_DEFINE_418.v
// AUTHER       : Jiafan Wang
// DATE         : 03/28/2014
// VERSION      : 4.0
// PURPOSE      : macros defined in the SA design
// --------------------------------------------------------------------
// ABSTRACT
//
// sqrt of power sum based on Cordic algorithm; also consider the offset
// --------------------------------------------------------------------
`timescale 1 ns / 1 ps

`ifndef SQRT_POWSUM_418_V
`define SQRT_POWSUM_418_V

//`define CF_DEBUG_ON
//`include    "/homes/grad/jiafan0420/cadence/amsLib2/COST_4D_DEFINE.v"
//`include    "../src/COST_4D_DEFINE.v"

module SQRT_POWSUM_418(CLK, RST_N, enable, X_IN, Y_IN, OFFSET, FOUT, cordic_sqrt_is_done);//, FY); 

    parameter   CADC_WIDTH      = 10,
                MAX_SQRT_WIDTH  = 13;//12

    input   CLK; 
    input   RST_N;
    input   enable;
    input   [MAX_SQRT_WIDTH-1:0] X_IN; 
    input   [MAX_SQRT_WIDTH-1:0] Y_IN;
    input   [CADC_WIDTH-1:0]     OFFSET;
    output  [MAX_SQRT_WIDTH-1:0] FOUT;
    output  reg cordic_sqrt_is_done;

    parameter   SQRT_STEP0 = 3'b000,
                SQRT_STEP1 = 3'b001,
                SQRT_STEP2 = 3'b010,
                SQRT_STEP3 = 3'b011,
                SQRT_STEP4 = 3'b100,
                SQRT_STEP5 = 3'b101,
                SQRT_STEP6 = 3'b110,
                SQRT_STEP7 = 3'b111;
    
    reg     [MAX_SQRT_WIDTH-1:0] xtemp, ytemp, ztemp; 
    reg     [2:0]   iter_num;   // range should cover from 1 to MAX_SQRT_ITER
    reg     [2:0]   rsht_num;   // right shift bit numbers 
    reg     [2:0]   step;       // time step in each iteration
    reg     SEL_SRC;            // control signal to choose between xtemp and ytemp
    reg     XOR_SRC;            // xor signal to make sure "xtemp" is bigger than "ytemp"
    reg     pre_work;
    wire    sigma;
    // wire    [MAX_SQRT_WIDTH-1:0] positive_x;
    // wire    [MAX_SQRT_WIDTH-1:0] positive_y;
    
    wire    [MAX_SQRT_WIDTH-1:0] sum_ab, oper_a, oper_b;
    assign  sum_ab = oper_a + oper_b;
    assign  oper_a = (SEL_SRC ^ XOR_SRC)? xtemp: ytemp;
    assign  oper_b = ztemp;
 
    assign  sigma = (XOR_SRC)? xtemp[MAX_SQRT_WIDTH-1]: ytemp[MAX_SQRT_WIDTH-1];
    assign  FOUT = (XOR_SRC)? ytemp[MAX_SQRT_WIDTH-1:2] : xtemp[MAX_SQRT_WIDTH-1:2];
    // assign  positive_x = (X_IN[MAX_SQRT_WIDTH-1]? (~X_IN+1'b1) : X_IN);
    // assign  positive_y = (Y_IN[MAX_SQRT_WIDTH-1]? (~Y_IN+1'b1) : Y_IN);

    always @(posedge CLK or negedge RST_N) begin 
        if (RST_N == 0) begin
            xtemp <= 0;
            ytemp <= 0;
            ztemp <= 0;
            SEL_SRC <= 0;
            XOR_SRC <= 0;
            pre_work <= 0;
            iter_num <= 0;//`MAX_SQRT_ITER;
            rsht_num <= 0;
            cordic_sqrt_is_done <= 0;
            step <= SQRT_STEP0;
        end
        else if (!enable) begin
            // Activation signal will only be enable once
            xtemp <= {X_IN, 2'b00};
            ytemp <= {Y_IN, 2'b00};
            ztemp <= (~{OFFSET, 2'b00} + 1'b1);
            SEL_SRC <= 1;   // choose xtemp
            XOR_SRC <= 0;
            pre_work <= 1;
            iter_num <= 0;//`MAX_SQRT_ITER;
            rsht_num <= 0;
            
            // if (positive_y > positive_x) begin
                // xtemp <= positive_y;
                // ytemp <= positive_x;
            // end
            // else begin
                // xtemp <= positive_x;
                // ytemp <= positive_y;
            // end
            // ztemp <= 0;
            // iter_num <= 1;//`MAX_SQRT_ITER;
            cordic_sqrt_is_done <= 0;
            step <= SQRT_STEP1;
        end
        else if (pre_work) begin
            // Pre_work: only states 1,2,3;
            if (step == SQRT_STEP1) begin
                xtemp <= (sum_ab[MAX_SQRT_WIDTH-1]? (~sum_ab+1'b1) : sum_ab);
                SEL_SRC <= 0;   // choose ytemp
                step <= SQRT_STEP2;
            end
            else if (step == SQRT_STEP2) begin
                ytemp <= (sum_ab[MAX_SQRT_WIDTH-1]? (~sum_ab+1'b1) : sum_ab);
                step <= SQRT_STEP3;
            end
            else if (step == SQRT_STEP3) begin
                // if (ytemp > xtemp) begin
                    // xtemp <= ytemp;
                    // ytemp <= xtemp;
                // end
                // else begin
                    // xtemp <= xtemp;
                    // ytemp <= ytemp;
                // end
                if (ytemp > xtemp) begin
                    XOR_SRC <= 1;   // reverse the xtemp and ytemp
                end
                else begin
                    XOR_SRC <= 0;   // keep the xtemp and ytemp sequence
                end
                pre_work <= 0;
                iter_num <= 1;
                SEL_SRC <= 0;       // choose ytemp to sum with ztemp in the computation of xtemp
                step <= SQRT_STEP1;
            end
        end
        else if (iter_num != 0) begin
            // iteration: states 1,2,3,4,5;
            case (step)
                SQRT_STEP1  :begin
                    ztemp <= (sigma? (~oper_a+1'b1) : (oper_a));//(sigma? (~ytemp+1'b1) : (ytemp));
                    rsht_num <= iter_num;
                    step <= SQRT_STEP2;
                end
                SQRT_STEP2  :begin
                    if (rsht_num != 0) begin
                        // no need to get the absolute value of ztemp, since it's already done in SQRT_STEP1
                        ztemp <= {1'b0, ztemp[MAX_SQRT_WIDTH-1:1]};//(ztemp >> 1);
                        rsht_num <= rsht_num - 1'b1;
                        step <= SQRT_STEP2;
                    end
                    else begin
                        SEL_SRC <= 1;       // choose xtemp to sum with ztemp in the computation of X_new
                        step <= SQRT_STEP3;
                    end
                end
                SQRT_STEP3  :begin
                    // X_new = xtemp + (sigma? ((~ytemp+1'b1)>>iter_num) : (ytemp>>iter_num));
                    if (XOR_SRC) begin
                        ytemp <= sum_ab;//xtemp + ztemp;
                    end
                    else begin
                        xtemp <= sum_ab;//xtemp + ztemp;
                    end
                    ztemp <= oper_a;        //xtemp;// Give X_old to ztemp
                    rsht_num <= iter_num;
                    step <= SQRT_STEP4;
                end
                SQRT_STEP4  :begin
                    if (rsht_num != 0) begin
                        // no need to get the absolute value of xtemp, since the x coordinate is always in the 1st & 4nd quadratic
                        ztemp <= {1'b0, ztemp[MAX_SQRT_WIDTH-1:1]};//(ztemp >> 1);
                        rsht_num <= rsht_num - 1'b1;
                        step <= SQRT_STEP4;
                    end
                    else begin
                        ztemp <= (sigma? ztemp : (~ztemp + 1'b1));
                        SEL_SRC <= 0;   // choose ytemp to sum with ztemp in the computation of Y_new
                        step <= SQRT_STEP5;
                    end
                end
                SQRT_STEP5  :begin
                    // Y_new <= ytemp + (sigma? (xtemp>>iter_num) : (~(xtemp>>iter_num)+1'b1));
                    if (XOR_SRC)
                        xtemp <= sum_ab;//ytemp + (sigma? ztemp : (~ztemp + 1'b1));
                    else
                        ytemp <= sum_ab;//ytemp + (sigma? ztemp : (~ztemp + 1'b1));
                    iter_num <= iter_num + 1'b1;
                    SEL_SRC <= 0;//SEL_SRC <= 1;   // Fout = xtemp
                    step <= SQRT_STEP1;
                end
                default: begin
                    step <= SQRT_STEP6;
                end
            endcase
        end
        else if (iter_num == 0 && step == SQRT_STEP1) begin
            // Output the process finish signal 
            cordic_sqrt_is_done <= 1;
            step <= 0;
            `ifdef  CF_DEBUG_ON
            $display($time, " SQRT(%d(%b)** + %d(%b)**) = %d(%b)", X_IN, X_IN, Y_IN, Y_IN, FOUT, FOUT);
            `endif
        end
        else if (iter_num == 0 && step == 0) begin
            cordic_sqrt_is_done <= 0;//FOUT <= xtemp;
        end
    end 

endmodule

`endif//SQRT_POWSUM_418_V
