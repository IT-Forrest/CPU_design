//Verilog HDL for "amsLib2", "cf_testbench" "verilog"
//+FHDR****************************************************************
// ECE department, TAMU
// --------------------------------------------------------------------
// FILE NAME    : SQRT_POWSUM_418.v
// AUTHER       : Jiafan Wang
// DATE         : 03/28/2014
// VERSION      : 4.0
// PURPOSE      : the SQRTPOWSUM module with magnitude and phase output
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

module SQRT_POWSUM_418(CLK, RST_N, enable, X_IN, Y_IN, OFFSET, FOUT, POUT, cordic_sqrt_is_done);//, FY); 

    parameter   INDEX_WIDTH     = 4,
                CADC_WIDTH      = 10,
                MAX_SQRT_WIDTH  = 13;//12

    // sqrt power sum
    parameter   SQRT_STEP0 = 4'b0000,
                SQRT_STEP1 = 4'b0001,
                SQRT_STEP2 = 4'b0010,
                SQRT_STEP3 = 4'b1101,
                SQRT_STEP4 = 4'b0100,
                SQRT_STEP5 = 4'b0101,
                SQRT_STEP6 = 4'b0110,
                SQRT_STEP7 = 4'b0111,
                SQRT_STEP8 = 4'b1000,
                SQRT_STEP9 = 4'b1001,
                SQRT_STEP10 = 4'b1010,
                SQRT_STEP11 = 4'b1011,
                SQRT_STEP12 = 4'b1100,
                SQRT_SMEND = 4'b0011,
                INI_DEGREE = 13'b0000111100110;     //0.95*512
                //INI_DEGREE = 13'b0000111110100;     //0.97*512=500
    parameter   SQRT_RSHT_WIDTH = 4'b1000;// index
    
    input   CLK; 
    input   RST_N;
    input   [MAX_SQRT_WIDTH-1:0] X_IN; 
    input   [MAX_SQRT_WIDTH-1:0] Y_IN;
    input   enable;
    input   [CADC_WIDTH-1:0]     OFFSET;
    output  [MAX_SQRT_WIDTH-1:0] FOUT;
    output  [MAX_SQRT_WIDTH-1:0] POUT;
    output  cordic_sqrt_is_done;

    reg     [MAX_SQRT_WIDTH-1:0] xtemp, ytemp, wtemp, ztemp; 
    reg     [INDEX_WIDTH-1:0]   index;   // range should cover from 1 to MAX_SQRT_ITER
    reg     [INDEX_WIDTH-1:0]   rsht_bits;   // right shift bit numbers 
    reg     [3:0]   step;       // time step in each iteration
    reg     SEL_SRC;            // control signal to choose between xtemp and ytemp
    reg     XOR_SRC;            // xor signal to make sure "xtemp" is bigger than "ytemp"
    reg     SEL_Z;
    reg     sign_x, sign_y;
    reg     pre_work;
    
    wire    sigma;// the sign of Y
    wire    [MAX_SQRT_WIDTH-1:0] sum_ab, oper_a, oper_b;
    assign  sum_ab = oper_a + oper_b;
    assign  oper_a = (SEL_Z)? ztemp: ((SEL_SRC ^ XOR_SRC)? xtemp: ytemp);
    assign  oper_b = wtemp;
    assign  sigma = (XOR_SRC)? xtemp[MAX_SQRT_WIDTH-1]: ytemp[MAX_SQRT_WIDTH-1];
 
    assign  cordic_sqrt_is_done = (step == 4'b0011);
    assign  FOUT = (XOR_SRC)? ytemp[MAX_SQRT_WIDTH-1:2] : xtemp[MAX_SQRT_WIDTH-1:2];
    assign  POUT    = ztemp;//only SQRT has two output

    always @(posedge CLK or negedge RST_N)
    begin
        if (RST_N == 0) begin
            xtemp <= 0;
            ytemp <= 0;
            ztemp <= 0;
            wtemp <= 0;
            SEL_SRC <= 0;
            XOR_SRC <= 0;
            SEL_Z <= 0;
            pre_work <= 1;
            index <= 0;
            rsht_bits <= 0;
            step <= 0;
            sign_x <= 0;
            sign_y <= 0;
        end
        else if (enable == 0) begin
            xtemp <= 0;
            ytemp <= 0;
            ztemp <= 0;
            wtemp <= 0;
            SEL_SRC <= 0;
            XOR_SRC <= 0;
            SEL_Z <= 0;
            pre_work <= 1;
            index <= 0;
            rsht_bits <= 0;
            step <= 0;
            sign_x <= 0;
            sign_y <= 0;
        end
        else if (pre_work) begin
            if (step == SQRT_STEP0) begin
                xtemp <= {X_IN, 2'b00};
                ytemp <= {Y_IN, 2'b00};
                wtemp <= (~{OFFSET, 2'b00} + 1'b1);
                ztemp <= 0;
                SEL_SRC <= 1;   // choose xtemp
                SEL_Z <= 0;
                XOR_SRC <= 0;
                index <= 0;
                rsht_bits <= 0;
                sign_x <= 0;
                sign_y <= 0;
                step <= SQRT_STEP1;
            end
            else if (step == SQRT_STEP1) begin
                xtemp <= (sum_ab[MAX_SQRT_WIDTH-1]? (~sum_ab + 1'b1):(sum_ab));
                sign_x <= xtemp[MAX_SQRT_WIDTH-1];
                SEL_SRC <= 0;// choose ytemp
                step <= SQRT_STEP2;
            end
            else if (step == SQRT_STEP2) begin
                ytemp <= (sum_ab[MAX_SQRT_WIDTH-1]? (~sum_ab+1'b1) : sum_ab);
                sign_y <= ytemp[MAX_SQRT_WIDTH-1];
                step <= SQRT_STEP3;
            end
            else if (step == SQRT_STEP3) begin
                if (ytemp > xtemp) begin
                    XOR_SRC <= 1;   // reverse the xtemp and ytemp
                end
                else begin
                    XOR_SRC <= 0;   // keep the xtemp and ytemp sequence
                end
                pre_work <= 0;
                index <= 1;
                // choose ytemp to sum with wtemp in the computation of xtemp
                SEL_SRC <= 0;
                step <= SQRT_STEP1;
            end
        end
        ////////////////////////////////////////////////////////////////////
        // (1) To simplify Amplitude calc, the compute is limited in 1st quadrant,
        // which makes the X/Y switching trick significant; otherwise big errors are 
        // caused due to Yn's inconvergency if |Y/X|>10. Mainly 3 steps:
        //   a) get Zn: compute angle alpha(n-1) by shifting initial angle iteratively;
        //   b) get Xn: compute term Y(n-1)/2^(n-1) by shifting Y(n-1) iteratively;
        //   c) get Yn: compute term X(n-1)/2^(n-1) by shifting X(n-1) iteratively.
        // ** following iterations stops when "iter_num" counts to 8 which is 0 in 3bits          
        ////////////////////////////////////////////////////////////////////
        else if (index != SQRT_RSHT_WIDTH) begin//????
            case (step)
            SQRT_STEP1  :begin
                SEL_Z <= 0;
                rsht_bits <= index;
                step <= SQRT_STEP2;
            end
            SQRT_STEP2  :begin
                if (rsht_bits != 0) begin
                    if (rsht_bits == index) begin
                        wtemp <= {1'b0, INI_DEGREE[MAX_SQRT_WIDTH-1:1]}; 
                    end
                    else begin
                        wtemp <= {1'b0, wtemp[MAX_SQRT_WIDTH-1:1]};//(wtemp >> 1) do it rsht_num times;
                    end
                    rsht_bits <= rsht_bits - 1'b1;
                    step <= SQRT_STEP2;
                end
                else begin
                    step <= SQRT_STEP3;
                end
            end
            SQRT_STEP3  :begin
                //if((XOR_SRC==0)||(iter_num==1)) begin
                wtemp <= (sigma? (~wtemp + 1'b1): wtemp);
                /*end else begin
                wtemp <= (sigma?  wtemp : (~wtemp + 1'b1));
                end*/
                SEL_Z <= 1;
                step <= SQRT_STEP4;
            end
            SQRT_STEP4:     begin
                // the phase computation is finished
                ztemp <= sum_ab;
                step <= SQRT_STEP5;
            end
            SQRT_STEP5:     begin
                SEL_Z <=0;
                step <= SQRT_STEP6;
            end
            SQRT_STEP6:     begin
                wtemp <= (sigma? (~oper_a+1'b1) : (oper_a));//(sigma? (~ytemp+1'b1) : (ytemp));
                rsht_bits <= index;
                step <= SQRT_STEP7;
            end
            SQRT_STEP7:     begin
                if (rsht_bits != 0) begin
                    // no need to get the absolute value of wtemp, since it's already done in SQRT_STEP1
                    wtemp <= {1'b0, wtemp[MAX_SQRT_WIDTH-1:1]};//(wtemp >> 1) divide between 2;
                    rsht_bits <= rsht_bits - 1'b1;
                    step <= SQRT_STEP7;
                end
                else begin
                    SEL_SRC <= 1;       // choose xtemp to sum with wtemp in the computation of X_new
                    step <= SQRT_STEP8;
                end
            end
            SQRT_STEP8:     begin// the computation of Xn=X(n-1)-d(n-1)*(Y(n-1)>>(n-1))
                // X_new = xtemp + (sigma? ((~ytemp+1'b1)>>iter_num) : (ytemp>>iter_num));
                if (XOR_SRC) begin
                    ytemp <= sum_ab;//xtemp + wtemp;
                end
                else begin
                    xtemp <= sum_ab;//xtemp + wtemp;
                end
                wtemp <= oper_a;        //xtemp;// Give X_old to wtemp
                rsht_bits <= index;
                step <= SQRT_STEP9;
            end
            SQRT_STEP9:     begin
                if (rsht_bits != 0) begin
                    // no need to get the absolute value of xtemp, since the x coordinate is always in the 1st & 4nd quadratic
                    wtemp <= {1'b0, wtemp[MAX_SQRT_WIDTH-1:1]};//(wtemp >> 1) do it rsht_num times;
                    rsht_bits <= rsht_bits - 1'b1;
                    step <= SQRT_STEP9;
                end
                else begin
                    wtemp <= (sigma? wtemp : (~wtemp + 1'b1));
                    SEL_SRC <= 0;   // choose ytemp to sum with wtemp in the computation of Y_new
                    step <= SQRT_STEP10;
                end
            end
            SQRT_STEP10:    begin// the computation of Yn=Y(n-1)+d(n-1)*(X(n-1)>>(n-1))
                // Y_new <= ytemp + (sigma? (xtemp>>iter_num) : (~(xtemp>>iter_num)+1'b1));
                if (XOR_SRC)
                    xtemp <= sum_ab;//ytemp + (sigma? wtemp : (~wtemp + 1'b1));
                else
                    ytemp <= sum_ab;//ytemp + (sigma? wtemp : (~wtemp + 1'b1));
                SEL_SRC <= 0;//SEL_SRC <= 1;   // Fout = xtemp
                step <= SQRT_STEP1;
                index <= index + 1'b1;
            end
            default:    begin
                step <= SQRT_STEP12;
                //step <= SQRT_STEP3;
                index <= SQRT_RSHT_WIDTH;
            end
            endcase
        end
        ////////////////////////////////////////////////////////////////////
        // (2) Since the X/Y switching trick in Amplitude calc makes the Phase calc only
        // accurate within range [0~45]degree, following branch refines the final result. 
        ////////////////////////////////////////////////////////////////////
        //else if (index == SQRT_RSHT_WIDTH && (step == SQRT_STEP1 || step == SQRT_STEP2)) begin
        else if (step == SQRT_STEP1 || step == SQRT_STEP2) begin //(step != SQRT_STEP12)
            // Output the process finish signal 
            if (sign_x & sign_y) begin //both numbers are negative
                if(XOR_SRC) begin// ztemp = 3pi/2- ztemp = -(-3pi/2+ztemp)
                    if(step == SQRT_STEP1) begin
                        wtemp <= 13'b1011010010011;//3pi/2=4.7(*512=2411) then XOR 8192
                        SEL_Z <=1;
                        step <= SQRT_STEP2;
                    end
                    else if(step == SQRT_STEP2) begin
                        ztemp <= (~sum_ab+1'b1);
                        step <= SQRT_STEP12;
                    end
                end
                else begin// ztemp = pi + ztemp;
                    if(step == SQRT_STEP1) begin
                        wtemp <= 13'b0011001001000;//pi=3.14(*512=1607)
                        SEL_Z <=1;
                        step <= SQRT_STEP2;
                    end
                    else if(step == SQRT_STEP2) begin
                        ztemp <= sum_ab;
                        step <= SQRT_STEP12;
                    end
                end
            end
            else if (sign_x ^ sign_y)  begin //one of the numbers is negative
                if (sign_x) begin //only x is negative
                    if (XOR_SRC) begin// ztemp = pi/2+ ztemp
                        if(step == SQRT_STEP1) begin
                            wtemp <= 13'b0001100100100; //pi/2=1.57(*512=803)
                            SEL_Z <=1;
                            step <= SQRT_STEP2;
                        end
                        else if(step == SQRT_STEP2) begin
                            ztemp <= sum_ab;
                            step <= SQRT_STEP12;
                        end
                    end
                    else begin// ztemp = pi- ztemp = -(-pi + ztemp)
                        if(step == SQRT_STEP1) begin
                            wtemp <= 13'b1100110111000; //pi=3.14(*512=1607) then XOR 8192
                            SEL_Z <=1;
                            step <= SQRT_STEP2;
                        end
                        else if(step == SQRT_STEP2) begin
                            ztemp <= (~sum_ab+1'b1);
                            step <= SQRT_STEP12;
                        end
                    end
                end
                else begin //only y is negative
                    if(XOR_SRC) begin//ztemp = 3pi/2+ ztemp
                        if(step == SQRT_STEP1) begin
                            wtemp <= 13'b0100101101101; //3pi/2=4.7(*512=2411)
                            SEL_Z <=1;
                            step <= SQRT_STEP2;
                        end
                        else if(step == SQRT_STEP2) begin
                            ztemp <= sum_ab;
                            step <= SQRT_STEP12;
                        end
                    end
                    else begin//ztemp = 2pi- ztemp = -(-2pi+ ztemp)
                        if(step == SQRT_STEP1) begin
                            wtemp <= 13'b1001101101111; //2pi=6.28(*512=3215) then XOR 8192
                            SEL_Z <=1;
                            step <= SQRT_STEP2;
                        end
                        else if(step == SQRT_STEP2) begin
                            ztemp <= (~sum_ab+1'b1);
                            step <= SQRT_STEP12;
                        end
                    end
                end
            end
            else begin// both numbers positive
                if(XOR_SRC) begin //ztemp = pi/2-ztemp = -(-pi/2 + ztemp)
                    if(step == SQRT_STEP1) begin
                        wtemp <= 13'b1110011011100;//pi/2=1.57(*512=803) then XOR 8192
                        SEL_Z <=1;
                        step <= SQRT_STEP2;
                    end
                    else if(step == SQRT_STEP2) begin
                        ztemp <= (~sum_ab+1'b1);
                        step <= SQRT_STEP12;
                    end
                end
                else begin
                    //fundamental computation: nothing need to do here
                    step <= SQRT_STEP12;
                end
            end
        end
        //else if (step == SQRT_STEP12) begin  //iter_num == SQRT_RSHT_WIDTH
        else begin
            //cordic_sqrt_is_done <= 1;
            `ifdef  CF_DEBUG_ON
            $display($time, " SQRT(%d(%b)** + %d(%b)**) = %d(%b)", X_IN, X_IN, Y_IN, Y_IN, FOUT, FOUT);
            `endif
            SEL_Z <=0;
            step <= SQRT_SMEND;
        end
    end 

endmodule

`endif//SQRT_POWSUM_418_V
