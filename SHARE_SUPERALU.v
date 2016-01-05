//+FHDR****************************************************************
// ECE department, TAMU
// --------------------------------------------------------------------
// FILE NAME    : SHARE_SUPERALU.v
// AUTHER       : Jiafan Wang
// DATE         : 01/01/2016
// VERSION      : 1.0
// PURPOSE      : the combination of Multiply, Division & SQRTPOWSUM
// --------------------------------------------------------------------
// ABSTRACT
// 
// INPUT: alu_type = {Multiply_start, Division_start, Sqrtpow_start, 1'b0};
// How to use this block:
// (1) reset alu_type; then set a single start signal "1";
// (2) wait until the alu_is_done is "1";
// (3) get the result from FOUT or POUT and then clr the start signal
// --------------------------------------------------------------------


`ifndef SHARE_SUPERALU_V
`define SHARE_SUPERALU_V

// Fixed-point Multiplication used for generating step from T_value
module SHARE_SUPERALU(
    //input 
    CLK,
    RST_N,
    X_IN,//dividend or multiplicand or I
    Y_IN,//dividor or multiplier or Q
    alu_start,//enable signal
    alu_type,//"*" or "/" or "sqrt"
    mode_type,//div_mode or mul_mode
    OFFSET,
    
    FOUT,//division or multiplication or amplitude
    POUT,//phase
    alu_is_done//finish signal
);

    parameter   ALU_MULTIPLY    = 3'b100,
                ALU_DIVISION    = 3'b010,
                ALU_SQRTPOWS    = 3'b001;

    // parameter   MULTIPLICAND_WIDTH  = 9,// the division of CF
                // MULTIPLIER_WIDTH    = 8,// for the random value used by SA, it's the width of LFSR 
                // EXTEND_WIDTH        = 3,
                // MULTIPLICATION_WIDTH= 12,// multiplicand + extend width
                // INDEX_WIDTH         = 4;// must can cover MULTIPLICATION_WIDTH
                
    parameter   INDEX_WIDTH     = 4,
                CADC_WIDTH      = 10,
                MAX_SQRT_WIDTH  = 13;//12
    parameter   QUOTIENT_WIDTH  = 9,
                RANDOM_WIDTH    = 8;

    // multiplication
    parameter   MULTI_PURE      = 0,// multiply a pure fraction
                MULTI_FRAC      = 1,// multiply a fraction like 1.4
                MULTI_MAXM      = 2;// multiply a fraction like 2.3, then bound to 2
    parameter   STEP_MLSHT  = 4'b0000,
                STEP_MJUDGE = 4'b0001,
                STEP_MRSHT  = 4'b0010,
                STEP_MMEND  = 4'b0011;
                
    // division
    parameter   SA_DIV          = 0,
                CF_T27          = 1,
                CF_T36          = 2;
    parameter   STEP_DLSHT  = 4'b0000,
                STEP_DJUDGE = 4'b0001,
                STEP_DRSHT  = 4'b0010,
                STEP_DMEND  = 4'b0011;
                
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
    input   alu_start;
    input   [2:0]   alu_type;//4bits, 0x8 Multiply; 0x4 Division; 0x2 SQRT
    input   [1:0]   mode_type;
    input   [CADC_WIDTH-1:0]     OFFSET;
    output  [MAX_SQRT_WIDTH-1:0] FOUT;
    output  [MAX_SQRT_WIDTH-1:0] POUT;
    output  alu_is_done;
    
    reg     [MAX_SQRT_WIDTH-1:0] xtemp, ytemp, wtemp, ztemp; 
    reg     [INDEX_WIDTH-1:0]    index;//2:0 for POWER
    reg     [INDEX_WIDTH-1:0]    rsht_bits;//[2:0]
    reg     [3:0]   step;
    reg     SEL_SRC;
    reg     XOR_SRC;
    reg     SEL_Z;
    reg     sign_x, sign_y;
    reg     pre_work;
    //reg     start_dly;//simply the connetion of CFSA_4D_TOP_LEVEL
    
    // for multiplication
    wire    post_work;
    assign  post_work = SEL_SRC;//SEL_Z;//reuse this reg
    
    // for division
    wire    [QUOTIENT_WIDTH-1:0]    division_head;
    wire    [QUOTIENT_WIDTH-1:0]    division_rema;
    //xtemp+ytemp store dividand; where the lowest QUOTIENT_WIDTH is for remain part
    assign  division_head = {xtemp[QUOTIENT_WIDTH-1:0],ytemp[MAX_SQRT_WIDTH-1:QUOTIENT_WIDTH]};
    assign  division_rema = ytemp[QUOTIENT_WIDTH-1:0];
    
    // for sqrt power sum
    wire    sigma;// the sign of Y
    wire    [MAX_SQRT_WIDTH-1:0] sum_ab, oper_a, oper_b;
    assign  sum_ab = oper_a + oper_b;
    assign  oper_a = (SEL_Z)? ztemp: ((SEL_SRC ^ XOR_SRC)? xtemp: ytemp);
    assign  oper_b = wtemp;
    assign  sigma = (XOR_SRC)? xtemp[MAX_SQRT_WIDTH-1]: ytemp[MAX_SQRT_WIDTH-1];

    // for shared output
    assign  alu_is_done = (step == 4'b0011);
    // assign  alu_is_done = (alu_type==ALU_MULTIPLY)? (step == STEP_MMEND):
                          // (alu_type==ALU_DIVISION)? (step == STEP_DMEND):
                          // (alu_type==ALU_SQRTPOWS)? (step == SQRT_SMEND):0;//((index == SQRT_RSHT_WIDTH) && (step == SQRT_STEP3)):0;

    assign  FOUT    = (alu_type==ALU_MULTIPLY)? xtemp: //12 bits  multiplication_tmp
                      (alu_type==ALU_DIVISION)? division_rema: //9 bits  dividend_tmp[QUOTIENT_WIDTH-1:0]
                      (alu_type==ALU_SQRTPOWS)? ((XOR_SRC)? ytemp[MAX_SQRT_WIDTH-1:2] : xtemp[MAX_SQRT_WIDTH-1:2]):
                            {MAX_SQRT_WIDTH{1'b0}};// since SQRT has enlarge X_IN/Y_IN X4
    assign  POUT    = (alu_type==ALU_SQRTPOWS)? ztemp:{MAX_SQRT_WIDTH{1'b0}};//only SQRT has two output

    always @(posedge CLK or negedge RST_N)
    begin
        if ((RST_N == 0) || (alu_start == 0)) begin
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
        else if (alu_type == ALU_MULTIPLY) begin
            if (pre_work) begin
                if (MULTI_PURE == mode_type) begin //2'b00
                    xtemp <= 0;//X_IN;
                    ytemp <= Y_IN;
                    rsht_bits <= 1;
                    step <= STEP_MJUDGE;//STEP_MLSHT;
                    pre_work <= 0;
                    SEL_SRC <= 0;//SEL_Z <= 0;//post_work
                    index <= 8;//MULTIPLIER_WIDTH;
                end
                else if (MULTI_FRAC == mode_type) begin //2'b01
                    xtemp <= 0;//X_IN;
                    ytemp <= Y_IN;
                    rsht_bits <= 1;
                    step <= STEP_MJUDGE;//STEP_MLSHT;
                    pre_work <= 0;
                    SEL_SRC <= 1;//SEL_Z <= 1;//post_work
                    index <= 8;//MULTIPLIER_WIDTH;
                end
                else begin
                    // 2'b10: maximum is X2
                    xtemp <= (X_IN << 1);
                    ytemp <= 0;
                    rsht_bits <= 0;
                    step <= STEP_MMEND;
                    pre_work <= 0;
                    SEL_SRC <= 0;//SEL_Z <= 0;
                    index <= 0;
                end
            end
            else if (index != 0) begin
                case (step)
                STEP_MLSHT:  begin
                    ytemp <= (ytemp >> 1);
                    index <= index - 1'b1;
                    step <= STEP_MJUDGE;
                end
                STEP_MJUDGE: begin
                    if (ytemp[0]) begin
                    //iter_num <= iter_num - 1;
                    step <= STEP_MRSHT;
                    end
                    else begin
                    //iter_num <= iter_num - 1;
                    rsht_bits <= rsht_bits + 1;
                    //multiplier_tmp <= (multiplier_tmp >> 1);
                    //step <= STEP_MJUDGE;
                    step <= STEP_MLSHT;
                    end
                end
                STEP_MRSHT:  begin
                    if (rsht_bits) begin
                    xtemp <= (xtemp >> 1);
                    rsht_bits <= rsht_bits - 1;
                    step <= STEP_MRSHT;
                    end
                    else begin
                    xtemp <= xtemp + X_IN;
                    rsht_bits <= 1;
                    //iter_num <= iter_num - 1;
                    //multiplier_tmp <= (multiplier_tmp >> 1);
                    //step <= STEP_MJUDGE;
                    step <= STEP_MLSHT;
                    end
                end
                default:    begin
                    index <= 0;
                    SEL_SRC <= 0;//SEL_Z <= 0;
                    step <= STEP_MMEND;
                end
                endcase
            end
            else if (rsht_bits != 0) begin
                xtemp <= (xtemp >> 1);
                rsht_bits <= rsht_bits - 1;
            end
            else if (post_work) begin
                xtemp <= xtemp + X_IN;
                SEL_SRC <= 0;//SEL_Z <= 0;
            end
            else begin
            // multiply_done = (step == STEP_MMEND)
                step <= STEP_MMEND;
            end
        end
        else if (alu_type == ALU_DIVISION) begin
            if (pre_work) begin
                step <= STEP_DLSHT;//1;
                pre_work <= 0;
                `ifdef DIV_DEBUG_ON
                $strobe($time, " dividend = %b, dividor = %b", X_IN, Y_IN);
                `endif
                case (mode_type)
                    CF_T27: begin
                        if ((X_IN >> 2) >= Y_IN) begin
                        ytemp[QUOTIENT_WIDTH-1:0] <= 9'b11_1111111;
                        index <= 0;// finish the compute
                        end
                        else begin
                        {xtemp,ytemp} <= {{6{1'b0}}, X_IN, {7{1'b0}}};
                        index <= QUOTIENT_WIDTH;
                        end
                    end
                    CF_T36: begin
                        if ((X_IN >> 2) >= Y_IN) begin
                        ytemp[QUOTIENT_WIDTH-1:0] <= 9'b100_000000;
                        index <= 0;
                        end
                        else begin
                        {xtemp,ytemp} <= {{7{1'b0}}, X_IN, {6{1'b0}}};
                        index <= QUOTIENT_WIDTH;
                        end
                    end
                    default: begin
                        //this works for SA_DIV only because the division in SA is A/B where A is always smaller than B
                        {xtemp,ytemp} <= {X_IN, {QUOTIENT_WIDTH{1'b0}}};//SA_DIV RANDOM_WIDTH
                        index <= RANDOM_WIDTH;
                        // In SA, deltaE is always smaller than T; delatE/T
                    end
                endcase
            end
            else if (index != 0) begin
                if (step == STEP_DLSHT) begin//1
                    {xtemp, ytemp} <= {xtemp[MAX_SQRT_WIDTH-2:0], ytemp, 1'b0};
                    step <= STEP_DJUDGE;//0;
                    `ifdef DIV_DEBUG_ON
                    $strobe($time, " dividend_tmp = %b, dividor = %b", {xtemp,ytemp}, Y_IN);
                    `endif
                end
                else if (step == STEP_DJUDGE) begin //0
                    //considering to reuse the sum_ab
                    if (division_head >= Y_IN) begin
                        ztemp <= division_head;
                        wtemp <= ~(Y_IN)+1'b1;
                        SEL_Z <= 1;
                    end
                    else begin
                        SEL_Z <= 0;
                        // {xtemp, ytemp} <= {xtemp, ytemp};
                    end
                    step <= STEP_DRSHT;//2;
                end
                else if (step == STEP_DRSHT) begin//2
                    if (SEL_Z == 1) begin
                        {xtemp[QUOTIENT_WIDTH-1:0],ytemp[MAX_SQRT_WIDTH-1:QUOTIENT_WIDTH]} <= sum_ab;
                        ytemp[0] <= 1;
                        //{xtemp[QUOTIENT_WIDTH-1:0],ytemp[MAX_SQRT_WIDTH-1:QUOTIENT_WIDTH]} <= division_head - Y_IN;
                        //ytemp[QUOTIENT_WIDTH-1:0] <= division_rema + 1;
                    end
                    else begin 
                        {xtemp, ytemp} <= {xtemp, ytemp};
                    end
                    `ifdef DIV_DEBUG_ON
                    $strobe($time, " dividend_tmp = %b, dividor = %b", {xtemp,ytemp}, Y_IN);
                    `endif
                    SEL_Z <= 0;
                    index <= index - 1'b1;
                    step <= STEP_DLSHT;//1;
                end
            end
            else begin //(index == 0)
                step <= STEP_DMEND;
            end
        end
        else if (alu_type == ALU_SQRTPOWS) begin
            ////////////////////////////////////////////////////////////////////
            // (0) pre_work is to remove the offset from X_IN and Y_IN
            // If sum_ab is negative(MSB=1) the complement a2 is appled; 
            // else it is assigned to xtemp: takes the absolute value
            //else
            if (pre_work) begin
                if (step == SQRT_STEP0) begin
                    xtemp <= {X_IN, 2'b00};
                    ytemp <= {Y_IN, 2'b00};
                    wtemp <= {~{OFFSET, 2'b00} + 1'b1};
                    ztemp <= 0;
                    SEL_SRC <= 1;// choose xtemp
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
                SQRT_STEP1:     begin
                    SEL_Z <= 0;
                    rsht_bits <= index;
                    step <= SQRT_STEP2;
                end
                SQRT_STEP2:     begin
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
                SQRT_STEP3:     begin
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
            else if (step != SQRT_STEP12) begin
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
        else begin
            // For unknown ALU type, just reset the output
            //start_dly <= 1;
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
    end
endmodule

`endif //SHARE_SUPERALU_V


