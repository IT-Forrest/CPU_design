//+FHDR****************************************************************
// ECE department, TAMU
// --------------------------------------------------------------------
// FILE NAME    : SA_4D_DATA_PATH_418.v
// AUTHER       : Jiafan Wang
// DATE         : 03/26/2015
// VERSION      : 4.0
// PURPOSE      : the DATA_PATH of SA algorithm 
// --------------------------------------------------------------------
// ABSTRACT
//
//   describe the non-blocking task based upon the signal created by
// the CONTROLLER module.
//   Include the SA process and SS process
// --------------------------------------------------------------------

//`include "/homes/grad/jiafan0420/cadence/amsLib2/sa_define.v"
//`include "../src/sa_define.v"

`ifndef SA_4D_DATA_PATH_418_V
`define SA_4D_DATA_PATH_418_V

//`include "../src/SA_4D_DEFINE.v"
//`include "SA_4D_DEFINE.v"

module  SA_4D_DATA_PATH_418(
    // Input ports from outside
    CLK,
    RST_N,
    NXT,
    
    // Input ports from CONTROLLER
    INIT_TUNE_BITS,
    MAX_SA_ITERATION,
    MAX_SS_ITERATION,
    INITIAL_T_VALUE,   // initial temperature
    STEP_T_VALUE,
    FLAG4D,
    RAND_GROUP,
    SS_THRESHOLD,
    ana_bits,
    
    // Input from CONTROLLER
    cp_sa_set_find_minimum,
    cp_ld_init_T_value,    
    //cp_rst_sa_local_cnt,    
    cp_set_group_start,    
    cp_set_sa_start,    
    cp_dim_update_tune_bits, 
    cp_sa_req_ld_tune_bits,  
    cp_init_update_reg_best, 
    cp_rst_first_flag,    
    cp_set_sa_recv,    
    cp_inc_sa_global_cnt,    
    //cp_inc_sa_local_cnt,    
    cp_update_T_value,    
    cp_ss_update_tune_bits,  
    cp_set_ss_start, 
    cp_set_multi_start,
    cp_rst_multi_start_flag,  
    cp_rst_ss_local_cnt,
    cp_rst_global_cnt,
    cp_ss_req_ld_tune_bits,  
    cp_set_ss_recv,    
    cp_inc_ss_global_cnt,    
    cp_inc_ss_local_cnt,    
    cp_ss_update_tune_best,
    cp_ss_output_tune_best,

    // Input from Multiply and Division
    division_is_done,
    prob_tmp,    //provide the division result
    multiply_is_done,
    multiplication,    

    // Output ports to CONTROLLER
    dp_sa_reach_max_iter,   //global_sa_iter_cnt == max_sa_iteration
    dp_sa_reach_min_exp,    //analog_best <= MIN_EXP_VALUE
    dp_sa_need_chg_dim,     //local_sa_iter_cnt == MAX_LOCAL_SA
    dp_ss_reach_max_iter,   //global_ss_iter_cnt == max_ss_iteration
    dp_ss_chk_all_neighbor, //ss_neighbor_cnt == (real_var_num<<1)
    dp_ss_threshold_accept, //analog_val <= SS_THRESHOLD
    dp_group_is_done,
    dp_multi_start_is_done,
    dp_multi_start_flag,
    dp_first_time_flag,
    dp_sa_tune_is_done,
    dp_sa_recv_is_done,
    dp_ss_found_local_min,
    dp_ss_tune_is_done,
    dp_ss_recv_is_done,

    // Output to Multiply and Division
    //dp_set_multiply_start,
    multiplicand,
    multiplier,
    dp_set_division_start,
    dividend,
    dividor,
    TUNE_BITS_OUT
);

    //reg     [`RANDOM_WIDTH-1:0]  prob_tmp;// P(e,e',T)
    parameter   VAR_WIDTH       = 4'd5,
                //VAR_NUM         = 4'd4,
                MAX_TUNE_WIDTH  = 5'd20,//VAR_WIDTH*MAX_VAR_NUM,
                ANA_WIDTH       = 4'd8,
                RANDOM_WIDTH    = 4'd8,
                MAX_VAR_NUM     = 4'd4,
                MAX_T_WIDTH     = 4'd6,
                MAX_T_VALUE     = 6'd32,
                ITER_WIDTH      = 4'd11,
                DIRECT_WIDTH    = 4'd2,
                T_STEP_SIZE     = 4'd4,
                MAX_LOCAL_SA    = 4'd7,//4'd8
                MIN_EXP_VALUE   = 2'd1,

                LFSR8_SEED      = 8'd37,//{RANDOM_WIDTH'd37},//b0010_0101};
                INITIAL_TUNE    = 10'd495,//{VAR_WIDTH'd15,VAR_WIDTH'd15},// `MAX_TUNE_WIDTH
                DIRECTION_X     = 0,
                DIRECTION_Y     = 1;

    parameter   DIVIDEND_WIDTH  = 12,
                DIVIDOR_WIDTH   = 12,
                QUOTIENT_WIDTH  = 9;

    //parameter   ALL_ONES        = {QUOTIENT_WIDTH{1'b1}};
    
    // Input ports from outside
    input   CLK;
    input   RST_N;
    input   NXT;
    
    input   [MAX_TUNE_WIDTH-1:0] INIT_TUNE_BITS;
    input   [ITER_WIDTH-1:0]    MAX_SA_ITERATION;
    input   [ITER_WIDTH-1:0]    MAX_SS_ITERATION;
    input   [MAX_T_WIDTH-1:0]   INITIAL_T_VALUE;
    input   [2:0]   STEP_T_VALUE;
    input   FLAG4D;
    input   RAND_GROUP;
    input   [ANA_WIDTH-1:0] SS_THRESHOLD;
    input   [ANA_WIDTH-1:0] ana_bits;

    // Input ports from CONTROLLER
    input   cp_sa_set_find_minimum;
    input   cp_ld_init_T_value;    
    //input   cp_rst_sa_local_cnt;    
    input   cp_set_group_start;    
    input   cp_set_sa_start;    
    input   cp_dim_update_tune_bits;    
    input   cp_sa_req_ld_tune_bits;    
    input   cp_init_update_reg_best;    
    input   cp_rst_first_flag;    
    input   cp_set_sa_recv;    
    input   cp_inc_sa_global_cnt;    
    //input   cp_inc_sa_local_cnt;    
    input   cp_update_T_value;    
    input   cp_ss_update_tune_bits;    
    input   cp_set_ss_start;
    input   cp_set_multi_start;
    input   cp_rst_multi_start_flag; 
    input   cp_rst_ss_local_cnt;
    input   cp_rst_global_cnt;
    input   cp_ss_req_ld_tune_bits;    
    input   cp_set_ss_recv;    
    input   cp_inc_ss_global_cnt;    
    input   cp_inc_ss_local_cnt;    
    input   cp_ss_update_tune_best;
    input   cp_ss_output_tune_best;
    
    // Input from Multiply and Division
    input   division_is_done;
    input   [QUOTIENT_WIDTH-1:0] prob_tmp;    //provide the division result
    input   multiply_is_done;
    input   [MAX_T_WIDTH-1:0] multiplication;

    // Output wires to CONTROLLER
    output  dp_sa_reach_max_iter;   //global_sa_iter_cnt == MAX_SA_ITERATION
    output  dp_sa_reach_min_exp;    //analog_best <= MIN_EXP_VALUE
    output  dp_sa_need_chg_dim;     //local_sa_iter_cnt == MAX_LOCAL_SA
    output  dp_ss_reach_max_iter;   //global_ss_iter_cnt == MAX_SS_ITERATION
    output  dp_ss_chk_all_neighbor; //ss_neighbor_cnt == (real_var_num<<1)
    output  dp_ss_threshold_accept; //(analog_val <= SS_THRESHOLD);
    output  dp_group_is_done;
    output  dp_multi_start_is_done;
    output  reg dp_multi_start_flag;
    output  reg dp_first_time_flag;
    output  dp_sa_tune_is_done;
    output  reg dp_sa_recv_is_done;
    output  reg dp_ss_found_local_min;
    output  reg dp_ss_tune_is_done;
    output  reg dp_ss_recv_is_done;
        
    // Output ports to Multiply and Division
    //output  reg dp_set_multiply_start;
    output  [MAX_T_WIDTH-1:0]    multiplicand;//[RANDOM_WIDTH-1:0]
    output  [RANDOM_WIDTH-1:0]   multiplier;//[MAX_T_WIDTH-1:0]
    output  reg dp_set_division_start;
    output  [DIVIDEND_WIDTH-1:0]    dividend;
    output  [DIVIDOR_WIDTH-1:0]     dividor;
    output  [MAX_TUNE_WIDTH-1:0] TUNE_BITS_OUT;

    //////////////////////////////////////////
    // Local Register declaration
    //////////////////////////////////////////
    // shared registers
    reg [VAR_WIDTH-1:0]     tune_bits [0:MAX_VAR_NUM-1];
    reg [RANDOM_WIDTH-1:0]  random;
    reg dim_req_lfsr8_enable;
    reg sa_mply_req_enable_lfsr8;
    reg sa_div_req_enable_lfsr8;
    reg [2:0] sa_neighbor_sate;
    reg [ITER_WIDTH-1:0]  global_share_iter_cnt;
    
    // registers for SA algorithm
    reg [ANA_WIDTH-1:0]     analog_reg;
    reg [ANA_WIDTH-1:0]     analog_best;
    reg [ANA_WIDTH-1:0]     analog_val;
    reg [MAX_T_WIDTH-1:0]   T_value;
    wire    [MAX_T_WIDTH-1:0]   step_X;
    assign  step_X = (T_value)? T_value: 1;
    wire    [2:0]    local_sa_iter_cnt;//ITER_WIDTH
    wire    [ITER_WIDTH-1:0]    global_sa_iter_cnt;
    assign  local_sa_iter_cnt = global_sa_iter_cnt[2:0];
    //first cycle=7iters; later every cycle=8iters
    assign  global_sa_iter_cnt = global_share_iter_cnt;
    
    // *_val is used to record the new neighbour
    reg [VAR_WIDTH-1:0]     tune_valX;
    reg [VAR_WIDTH-1:0]     tune_valY;

    // *_reg is used to record the old information
    reg [VAR_WIDTH-1:0]     tune_regX;
    reg [VAR_WIDTH-1:0]     tune_regY;
    
    // *_best is used to record the best information
    reg [VAR_WIDTH-1:0]     tune_bestX;//tune_best;
    reg [VAR_WIDTH-1:0]     tune_bestY;//tune_best;
    reg [VAR_WIDTH-1:0]     tune_bestX2;
    reg [VAR_WIDTH-1:0]     tune_bestY2;
    
    // tune_bits used as buffer; each SA iteration only choose 2-D;
    reg [1:0]  dim_index1;//corresponding to X
    reg [1:0]  dim_index2;//corresponding to Y
    reg [1:0]  dimension_cnt;
    wire    [MAX_VAR_NUM-1:0]   real_var_num;
    
    assign  multiplicand = T_value;//random;
    assign  multiplier = random;//T_value; 
    assign  dividend = (analog_val - analog_reg);
    assign  dividor = {T_value,3'b000};
    assign  TUNE_BITS_OUT = {tune_bits[3], tune_bits[2], tune_bits[1], tune_bits[0]};

    // registers for SS algorithm
    wire    [ITER_WIDTH-1:0]   global_ss_iter_cnt;
    reg [3:0]  neighbor_index;
    reg [3:0]  ss_neighbor_cnt;
    assign  global_ss_iter_cnt = global_share_iter_cnt;

    // registers for SA process flags
    reg     dp_set_random_ratio;
    reg     dp_mply_random_dly;
    reg     dp_wait_multiply_done;
    reg     dp_update_tune_val;
    reg     dp_sa_recv_dly;
    reg     dp_sa_compare_ana_best;
    reg     dp_update_recent_val_to_reg;
    reg     dp_wait_division_done;

    // registers for SS process flags
    reg     dp_backup_tune_dly;
    reg     dp_backup_tune_bits_to_reg;
    reg     dp_chg_neighbor_tune_bits;
    reg     dp_ss_recv_dly;
    reg     dp_ss_compare_local_min;
    reg     dp_ss_restore_tune_bits;

    // registers for Multi-start flags
    //reg     dp_multi_start_dly;
    reg     multi_start_reg_lfsr8_enable;
    reg     [1:0]   multi_start_cnt;
    reg     [1:0]   multi_start_state;
    //reg     multi_update_tune_bits;

    // `ifdef  NEED_ITER_NUM
    // reg     [ITER_WIDTH-1:0]   max_sa_iteration;
    // reg     [ITER_WIDTH-1:0]   max_ss_iteration;
    // `endif
    // reg     [MAX_T_WIDTH-1:0]   initial_T_value;
    // reg     [2:0]   step_T_size;
    assign  real_var_num = (FLAG4D)? 4:2;
    assign  dp_group_is_done = (!dimension_cnt);
    assign  dp_sa_tune_is_done = (sa_neighbor_sate == 3'b100);
    assign  dp_multi_start_is_done = (multi_start_state == 2'b11);//(!multi_start_cnt);
    
    assign  dp_sa_reach_max_iter    = (global_sa_iter_cnt == MAX_SA_ITERATION);
    assign  dp_sa_reach_min_exp     = (analog_best <= MIN_EXP_VALUE);        
    assign  dp_sa_need_chg_dim      = (local_sa_iter_cnt == MAX_LOCAL_SA);
    assign  dp_ss_reach_max_iter    = (global_ss_iter_cnt == MAX_SS_ITERATION);
    assign  dp_ss_chk_all_neighbor  = (ss_neighbor_cnt == (real_var_num<<1));
    assign  dp_ss_threshold_accept  = (analog_val <= SS_THRESHOLD);
    
     ///////////////////////////////////////////////////////
    //LFSR_8  modlue: used to generate a random number
    ///////////////////////////////////////////////////////
    always @(posedge CLK or negedge RST_N)
    begin
        if (RST_N == 0)
            random <= LFSR8_SEED;
        else if (dim_req_lfsr8_enable || sa_mply_req_enable_lfsr8 || sa_div_req_enable_lfsr8 || multi_start_reg_lfsr8_enable)
            random <= {random[6:0], (random[7] ^ random[5] ^ random[4] ^ random[3])};
    end

    ////////////////////////////////////////////////////////////
    // Dimension register: used to choose two dimension values
    ////////////////////////////////////////////////////////////
    always @(posedge CLK or negedge RST_N)
    begin
        if (RST_N == 0) begin
            dim_index1 <= 0;
            dim_index2 <= 1;
        end
        else if (FLAG4D) begin
            if (dimension_cnt == 1) begin
                if (RAND_GROUP) begin
                    dim_index1 <= random[1:0];
                    dim_index2 <= random[1:0] + 1'b1;
                end
                else begin
                    dim_index1 <= dim_index1 + 2;
                    dim_index2 <= dim_index2 + 2;
                end
            end
        end
        else begin
            dim_index1 <= 0;
            dim_index2 <= 1;
        end
    end

    // Dimension module: receive generate random indices
    always @(posedge CLK or negedge cp_set_group_start)
    begin
        if (!cp_set_group_start) begin
            dim_req_lfsr8_enable <= 0;
            dimension_cnt <= 2;
            //dp_group_is_done <= 0;
        end
        else begin
            if (dimension_cnt) begin
                dim_req_lfsr8_enable <= 1;
                dimension_cnt <= dimension_cnt - 1;
            end
            else begin
                dim_req_lfsr8_enable <= 0;
                dimension_cnt <= dimension_cnt;
                //dp_group_is_done <= 1;
            end
        end
    end
    
    /////////////////////////////////////////////////
    // Multi-start block
    /////////////////////////////////////////////////
    always @(posedge CLK or negedge RST_N)
    begin
        if (RST_N == 0) begin
            dp_multi_start_flag <= 0;
        end
        else if (cp_set_multi_start) begin
            dp_multi_start_flag <= 1;
        end
        else if (cp_rst_multi_start_flag) begin
            dp_multi_start_flag <= 0;
        end
    end

    always @(posedge CLK or negedge cp_set_multi_start)
    begin
        // if (RST_N == 0) begin
            // multi_start_reg_lfsr8_enable <= 0;
            // dp_multi_start_dly <= 0;
            // dp_multi_start_is_done <= 0;
            // multi_start_cnt <= 0;
            // multi_update_tune_bits <= 0;
        // end
        // else
        if (!cp_set_multi_start) begin
            multi_start_reg_lfsr8_enable <= 0;
            multi_start_state <= 0;
            //dp_multi_start_dly <= 1;
            //dp_multi_start_is_done <= 0;
            multi_start_cnt <= 0;//(FLAG4D)? 3: 2; 
            //multi_update_tune_bits <= 0;
        end
        else begin
            case (multi_start_state)
            2'b00: begin
                //multi_update_tune_bits <= 0;
                multi_start_state <= 2'b01;
                multi_start_cnt <= (FLAG4D)? 3: 2;//0; 
            end
            2'b01: begin
                if (multi_start_cnt) begin
                    multi_start_reg_lfsr8_enable <= 1;
                    multi_start_cnt <= multi_start_cnt - 1;
                end
                else begin
                    //multi_update_tune_bits <= 1;
                    multi_start_cnt <= multi_start_cnt;
                    multi_start_state <= 2'b11;
                end
            end
            2'b11: begin
                multi_start_state <= multi_start_state;
            end
            default: ;
            endcase
        end
    end

    /////////////////////////////////////////////////
    //  Update step_X for tune_valX  
    /////////////////////////////////////////////////
/*     always @(posedge CLK or negedge RST_N)
    begin
        if (RST_N == 0) begin
            step_X <= 0;
        end
        else if (multiply_is_done) begin
            if (T_value == 0) begin
                step_X <= 1;
            end
            else begin
                `ifdef  SA_DEBUG_ON
                $display($time, " random=%b, T_value=%d", random, T_value);
                `endif
                `ifdef  SA_DEBUG_ON
                $display($time, " step=multiplication=%b", multiplication);
                `endif
                step_X <= multiplication;
            end
        end
    end */

    // function to modify the X or Y 
/*     function [VAR_WIDTH-1:0] modify_tune;
        input   [VAR_WIDTH-1:0]  tune_old;
        input   [MAX_T_WIDTH-1:0] tune_step;
        input   flag;
        if (flag == 0) begin
            modify_tune = tune_old - tune_step;
            `ifdef  SA_DEBUG_ON
            $display($time, " before_tune=%d, step=%d, after_tune=%d", tune_old, tune_step, modify_tune);
            `endif
            end
        else begin
            modify_tune = tune_old + tune_step;
            `ifdef  SA_DEBUG_ON
            $display($time, " before_tune=%d, step=%d, after_tune=%d", tune_old, tune_step, modify_tune);
            `endif
        end
    endfunction */
    
    // reset dp_first_time_flag to 0: use to save the first anabits
    always @(posedge CLK or negedge RST_N)
    begin
        if (RST_N == 0)
            dp_first_time_flag <= 1;
        else if (cp_rst_first_flag)
            dp_first_time_flag <= 0;
    end
    
    //////////////////////////////////////////
    // Temparature modle: T_value and cooling rate 
    //////////////////////////////////////////
    always @(posedge CLK or negedge RST_N)
    begin
        if (RST_N == 0)
            T_value <= INITIAL_T_VALUE;//MAX_T_VALUE
        else if (cp_ld_init_T_value)
            T_value <= INITIAL_T_VALUE;//MAX_T_VALUE
        else if (cp_update_T_value) begin
            if (T_value >= STEP_T_VALUE)
                T_value <= T_value - STEP_T_VALUE;
            else
                T_value <= 0;
        end
    end
    
    //////////////////////////////////////////////////////////
    // Load tune_bits to Analog circuit and set TUNE_READY
    //////////////////////////////////////////////////////////
    always @(posedge CLK or negedge RST_N)
    begin
        if (RST_N == 0) begin
            //since the initial values are all 5'b01111,so simply choose any
            {tune_bits[3],tune_bits[2],tune_bits[1],tune_bits[0]} <= INIT_TUNE_BITS;
            //{tune_bits[3],tune_bits[2],tune_bits[1],tune_bits[0]} <= INITIAL_TUNE;
        end
        else if (cp_sa_req_ld_tune_bits) begin //ml_ld_tune_bits
            // change the corresponding tune bits
            tune_bits[dim_index1] <= tune_valX;//{tune_valY, tune_valX};
            tune_bits[dim_index2] <= tune_valY;
            `ifdef  SA_DEBUG_ON
            $strobe($time, " tune_bits = %b", {tune_bits[3], tune_bits[2], tune_bits[1], tune_bits[0]});
            `endif
            //tune_bits <= {tune_bestX[3], tune_bestX[2], tune_bestX[1], tune_bestX[0]};//tune_reg;
            //$display($time, " ml_ld_tune_bits = (%b)", {tune_bestX[3], tune_bestX[2], tune_bestX[1], tune_bestX[0]});
        end
        else if (cp_sa_set_find_minimum) begin
            //write back the best tune bits before dimension changes
            tune_bits[dim_index1] <= tune_bestX;
            tune_bits[dim_index2] <= tune_bestY;
            //$display($time, " tune_best = %b, val = %d", tune_bestX[dim_index1], analog_best);
            //$strobe($time, " tune_bits = %b", {tune_bits[3], tune_bits[2], tune_bits[1], tune_bits[0]});
        end
        else if (dp_chg_neighbor_tune_bits) begin
            // ss part1 change 1 bit of the tune bit to get the neighbor tune bits
            if (ss_neighbor_cnt[0])
                tune_bits[(ss_neighbor_cnt>>1)] <= tune_regX + 1;
            else
                tune_bits[(ss_neighbor_cnt>>1)] <= tune_regX - 1;
        end
        else if (dp_ss_restore_tune_bits) begin
            // ss part2 restore the tune bits after receive each ana bis
            if (!dp_multi_start_flag) // no need to restore the first multi-start tune bits
                tune_bits[(ss_neighbor_cnt>>1)] <= tune_regX;
        end
        else if (cp_ss_update_tune_bits) begin
            // use local min as a new starting point
            if (neighbor_index[0])
                tune_bits[(neighbor_index>>1)] <= tune_bits[(neighbor_index>>1)] + 1;
            else
                tune_bits[(neighbor_index>>1)] <= tune_bits[(neighbor_index>>1)] - 1;
        end
        else if (cp_set_multi_start) begin
            if (multi_start_cnt == 2'b10 && FLAG4D) begin
                tune_bits[2] <= random[4:0];
                tune_bits[3] <= random[7:3];
            end
            else if (multi_start_cnt == 2'b01) begin
                tune_bits[0] <= random[4:0];
                tune_bits[1] <= random[7:3];
            end
        end
        // else if (multi_update_tune_bits) begin
            // if (FLAG4D == 0) begin
                // if (multi_start_cnt) begin
                    // tune_bits[0] <= random[3:0];
                    // tune_bits[1] <= random[7:4];
                // end
            // end
            // else begin
                // if (multi_start_cnt) begin
                    // tune_bits[0] <= random[3:0];
                    // tune_bits[1] <= random[7:4];
                // end
                // else begin
                    // tune_bits[2] <= random[3:0];
                    // tune_bits[3] <= random[7:4];
                // end
            // end
        // end
        else if (cp_ss_output_tune_best) begin
            tune_bits[0] <= tune_bestX ;
            tune_bits[1] <= tune_bestY ;
            tune_bits[2] <= tune_bestX2;
            tune_bits[3] <= tune_bestY2;
        end
    end
    
    // Update 2-D tune_valX and tune_valY value:
    always @(posedge CLK or negedge RST_N)
    begin
        if (RST_N == 0)
        begin
            //since the initial values are all 5'b01111,so simply choose any
            tune_valX <= INIT_TUNE_BITS[VAR_WIDTH-1:0];
            tune_valY <= INIT_TUNE_BITS[2*VAR_WIDTH-1:VAR_WIDTH];
            //tune_valX <= INITIAL_TUNE[VAR_WIDTH-1:0];
            //tune_valY <= INITIAL_TUNE[2*VAR_WIDTH-1:VAR_WIDTH];
        end
        else if (dp_update_tune_val)//cp_update_tune_reg
        begin
/*             if (T_value == 0)//tune_valY
                case (local_sa_iter_cnt[DIRECT_WIDTH-1:0])
                    2'b00://{(DIRECT_WIDTH)'b00}:
                    begin
                        tune_valX <= tune_regX + 1;
                        tune_valY <= tune_regY;
                    end
                    2'b01://{DIRECT_WIDTH'b01}:
                    begin
                        tune_valX <= tune_regX - 1;
                        tune_valY <= tune_regY;
                    end
                    2'b10://{DIRECT_WIDTH'b10}:
                    begin
                        tune_valX <= tune_regX;
                        tune_valY <= tune_regY + 1;
                    end
                    2'b11://{DIRECT_WIDTH'b11}:
                    begin
                        tune_valX <= tune_regX;
                        tune_valY <= tune_regY - 1;
                    end
                endcase
            else
            begin
                tune_valX <= modify_tune(tune_regX, step_X, random[DIRECTION_X]);//tune_valX
                tune_valY <= modify_tune(tune_regY, T_value - step_X, random[DIRECTION_Y]);
            end */
            case (local_sa_iter_cnt[DIRECT_WIDTH-1:0])
                2'b00://{(DIRECT_WIDTH)'b00}:
                begin
                    tune_valX <= tune_regX + step_X;
                    tune_valY <= tune_regY;
                end
                2'b01://{DIRECT_WIDTH'b01}:
                begin
                    tune_valX <= tune_regX - step_X;
                    tune_valY <= tune_regY;
                end
                2'b10://{DIRECT_WIDTH'b10}:
                begin
                    tune_valX <= tune_regX;
                    tune_valY <= tune_regY + step_X;
                end
                2'b11://{DIRECT_WIDTH'b11}:
                begin
                    tune_valX <= tune_regX;
                    tune_valY <= tune_regY - step_X;
                end
            endcase
        end
    end
    
    // The time to receive new anabits; due to the period waiting for CF
    // it does't updates the same time as tune_valX
    always @(posedge CLK or negedge RST_N)
    begin
        if (RST_N == 0) begin
            analog_val <= 0;
        end
        else if (NXT) begin //ml_set_analog_ready
            analog_val <= ana_bits;
        end
    end
    
    // update the current solution: tune_reg
    always @(posedge CLK or negedge RST_N)
    begin
        if (RST_N == 0) begin
            analog_reg <= {ANA_WIDTH{1'b1}};
            //since the initial values are all 5'b01111,so simply choose any
            tune_regX <= INIT_TUNE_BITS[VAR_WIDTH-1:0];//`VAR_WIDTH'b01111;
            tune_regY <= INIT_TUNE_BITS[2*VAR_WIDTH-1:VAR_WIDTH];//`VAR_WIDTH'b01111;
            //tune_regX <= INITIAL_TUNE[VAR_WIDTH-1:0];
            //tune_regY <= INITIAL_TUNE[2*VAR_WIDTH-1:VAR_WIDTH];
        end
        else if (cp_init_update_reg_best) begin
            // Only for the one-time initial case
            analog_reg <= ana_bits;
            tune_regX <= tune_bits[dim_index1];
            tune_regY <= tune_bits[dim_index2]; 
        end
        else if (cp_dim_update_tune_bits) begin
            // load tune_reg & tune_best after dimension change
            analog_reg <= analog_best;//ana_bits
            tune_regX <= tune_bits[dim_index1];
            tune_regY <= tune_bits[dim_index2]; 
        end
        else if (dp_update_recent_val_to_reg) begin
            // Update tune_reg & migrate to better solutions 
            analog_reg <= analog_val;
            tune_regX <= tune_valX;
            tune_regY <= tune_valY; 
        end
        else if (dp_backup_tune_bits_to_reg) begin
            // first backup the best value
            analog_reg <= analog_best;
            tune_regX <= tune_bits[(ss_neighbor_cnt>>1)];
        end
    end

    // update analog_best and 4-D tune_bestX
    always @(posedge CLK or negedge RST_N) begin
        if (RST_N == 0) begin
            analog_best <= {ANA_WIDTH{1'b1}};
            // Each iteration only need two dimension ;
            // and initial values are all 5'b01111
            tune_bestX <= INIT_TUNE_BITS[VAR_WIDTH-1:0];
            tune_bestY <= INIT_TUNE_BITS[2*VAR_WIDTH-1:VAR_WIDTH];
            //tune_bestX <= INITIAL_TUNE[VAR_WIDTH-1:0];
            //tune_bestY <= INITIAL_TUNE[2*VAR_WIDTH-1:VAR_WIDTH];
            tune_bestX2 <= INIT_TUNE_BITS[3*VAR_WIDTH-1:2*VAR_WIDTH];
            tune_bestY2 <= INIT_TUNE_BITS[4*VAR_WIDTH-1:3*VAR_WIDTH];
        end
        else if (cp_init_update_reg_best) begin
            // Only for the one-time initial case
            analog_best <= ana_bits;
            tune_bestX <= tune_bits[dim_index1];
            tune_bestY <= tune_bits[dim_index2];
        end
        else if (cp_dim_update_tune_bits) begin
            // load tune_reg & tune_best after dimension change
            //analog_best <= ana_bits;//since analog_best is always updated in previous iterations 
            tune_bestX <= tune_bits[dim_index1];
            tune_bestY <= tune_bits[dim_index2];
        end
        else if (dp_sa_compare_ana_best) begin//((ld_analog_bits == 1) && (analog_val <= analog_best)) begin
            // update the analog_best in SA process
            if (analog_val <= analog_best) begin
                analog_best <= analog_val;
                tune_bestX <= tune_valX;
                tune_bestY <= tune_valY;
            end
        end
        else if (cp_ss_update_tune_best) begin
                tune_bestX <= tune_bits[0];
                tune_bestY <= tune_bits[1];
                tune_bestX2 <= tune_bits[2];
                tune_bestY2 <= tune_bits[3];
        end
        else if (dp_ss_compare_local_min) begin
            // update the analog_best in SS process
            if (analog_val < analog_best) begin
                //tune_bestX <= tune_bits[dim_index1];
                analog_best <= analog_val;

                tune_bestX <= tune_bits[0];
                tune_bestY <= tune_bits[1];
                tune_bestX2 <= tune_bits[2];
                tune_bestY2 <= tune_bits[3];
            end
        end
    end
    
    ///////////////////////////////////////////
    // global and local counters for optimization
    ///////////////////////////////////////////
    // for local EA, cp_inc_sa_local_cnt 
/*     always @(posedge CLK or negedge RST_N)
    begin
        if (RST_N == 0)
            local_sa_iter_cnt <= 0;
        else if (cp_inc_sa_local_cnt)
            local_sa_iter_cnt <= local_sa_iter_cnt + 1;
        else if (cp_rst_sa_local_cnt)
            local_sa_iter_cnt <= 0;
    end */
    
    always @(posedge CLK or negedge RST_N)
    begin 
        if (RST_N == 0)
            global_share_iter_cnt <= 0;
        else if (cp_rst_global_cnt)
            global_share_iter_cnt <= 0;
        else if (cp_inc_sa_global_cnt || cp_inc_ss_global_cnt)
            global_share_iter_cnt <= global_share_iter_cnt + 1;
    end
    // for global management, cp_inc_global_sa_cnt
    // always @(posedge CLK or negedge RST_N)
    // begin
        // if (RST_N == 0)
            // global_sa_iter_cnt <= 0;
        // else if (cp_inc_sa_global_cnt)
            // global_sa_iter_cnt <= global_sa_iter_cnt + 1;
    // end
    
    ///////////////////////////////////////////////////////
    // Simulated Annealing block1: create a new neighbor
    ///////////////////////////////////////////////////////
    always @(posedge CLK or negedge cp_set_sa_start)
    begin
        if (!cp_set_sa_start) begin
            sa_neighbor_sate <= 3'b000;
            sa_mply_req_enable_lfsr8 <= 0;
            //dp_set_multiply_start <= 0;
            dp_update_tune_val <= 0;
        end
        else begin
            case (sa_neighbor_sate)
                3'b000: begin
                    sa_mply_req_enable_lfsr8 <= 1;
                    sa_neighbor_sate <= 3'b001;
                end
                3'b001: begin
                    if (T_value == 0) begin
                        sa_mply_req_enable_lfsr8 <= 0;
                        dp_update_tune_val <= 1;
                        sa_neighbor_sate <= 3'b011;
                    end
                    else begin
                        sa_mply_req_enable_lfsr8 <= 1;
                        sa_neighbor_sate <= 3'b010;
                    end
                end
                3'b010: begin
/*                     sa_mply_req_enable_lfsr8 <= 0;
                    // (3) Waiting for the Multiply result
                    if (!multiply_is_done) begin
                        dp_set_multiply_start <= 1;            
                    end
                    else begin
                        dp_update_tune_val <= 1;
                        dp_set_multiply_start <= 1;
                        sa_neighbor_sate <= 3'b011;
                    end */
                        dp_update_tune_val <= 1;
                        sa_neighbor_sate <= 3'b011;
                end
                3'b011: begin
                    dp_update_tune_val <= 0;
                    //dp_set_multiply_start <= 0;
                    sa_neighbor_sate <= 3'b100;
                end
                default: ;
            endcase
        end
    end
    
    
    /* always @(posedge CLK or negedge RST_N)
    begin
        if (RST_N == 0) begin
            dp_set_random_ratio <= 0;
            sa_mply_req_enable_lfsr8 <= 0;
            dp_mply_random_dly <= 0;
            dp_set_multiply_start <= 0;
            dp_wait_multiply_done <= 0;
            dp_update_tune_val <= 0;
            dp_sa_tune_is_done <= 0;
        end
        else if (!cp_set_sa_start) begin
            // (0) Stay here till "cp_set_sa_start=1"
            dp_set_random_ratio <= 0;
            sa_mply_req_enable_lfsr8 <= 0;
            dp_mply_random_dly <= 1;
            dp_set_multiply_start <= 0;
            dp_wait_multiply_done <= 0;
            dp_update_tune_val <= 0;
            dp_sa_tune_is_done <= 0;
        end
        else if (dp_mply_random_dly) begin
            // (1) Create random value and then the neighbor
            sa_mply_req_enable_lfsr8 <= 1;
            dp_mply_random_dly <= 0;
            dp_set_random_ratio <= 1;
        end
        else if (dp_set_random_ratio) begin
            sa_mply_req_enable_lfsr8 <= 0;
            dp_set_random_ratio <= 0;
            if (T_value == 0) begin
                dp_update_tune_val <= 1;
            end
            else begin
                // Update random value for directions use
                sa_mply_req_enable_lfsr8 <= 1;
                // (2) Activate the Multiply
                dp_wait_multiply_done <= 1;
            end
        end
        else if (dp_wait_multiply_done) begin
            sa_mply_req_enable_lfsr8 <= 0;
            // (3) Waiting for the Multiply result
            if (!multiply_is_done) begin
                dp_set_multiply_start <= 1;            
                dp_wait_multiply_done <= 1;
            end
            else begin
                dp_set_multiply_start <= 1;
                dp_update_tune_val <= 1;
                dp_wait_multiply_done <= 0;
            end
        end
        else if (dp_update_tune_val) begin
            // (4) Made change to tune_valX & tune_valY
            dp_set_multiply_start <= 0;
            dp_update_tune_val <= 0;
        end
        else begin
            dp_sa_tune_is_done <= 1;
        end
    end */

    // Simulated Annealing block2: receive ana bits and accept judge
    always @(posedge CLK or negedge RST_N)
    begin
        if (RST_N == 0) begin
            dp_sa_recv_dly <= 0;
            dp_sa_compare_ana_best <= 0;
            dp_update_recent_val_to_reg <= 0;
            sa_div_req_enable_lfsr8 <= 0;
            dp_set_division_start <= 0;
            dp_wait_division_done <= 0;
            dp_sa_recv_is_done <= 0;
        end
        else if (!cp_set_sa_recv) begin
            // (0) Stay here till "cp_set_sa_recv=1"
            dp_sa_recv_dly <= 1;
            dp_sa_compare_ana_best <= 0;
            dp_update_recent_val_to_reg <= 0;
            sa_div_req_enable_lfsr8 <= 0;
            dp_set_division_start <= 0;
            dp_wait_division_done <= 0;
            dp_sa_recv_is_done <= 0;
        end
        else if (dp_sa_recv_dly) begin
            dp_sa_recv_dly <= 0;
            dp_sa_compare_ana_best <= 1;
            // (1) Compare the ana bits
            if (analog_val <= analog_reg) begin
                dp_update_recent_val_to_reg <= 1;
                dp_set_division_start <= 0;
            end
            else if ((analog_val-analog_reg) >= T_value) begin
                dp_set_division_start <= 0;
            end
            else begin
            // (2) Activate the Division
                sa_div_req_enable_lfsr8 <= 1;
                dp_set_division_start <= 0;
                dp_wait_division_done <= 1;
            end
        end
        else if (dp_wait_division_done) begin
            sa_div_req_enable_lfsr8 <= 0;
            dp_set_division_start <= 0;
            dp_sa_compare_ana_best <= 0;
            // (3) Wait the Division to finish
            if (!division_is_done) begin
                dp_wait_division_done <= 1;
                dp_set_division_start <= 1;
            end
            else begin
                // if ((prob_tmp^ALL_ONES) >= random) begin
                if (~prob_tmp >= random) begin
                    dp_update_recent_val_to_reg <= 1;
                end
                dp_wait_division_done <= 0;
                dp_set_division_start <= 0;
            end
        end
        else if (dp_update_recent_val_to_reg) begin
            // (4) Update tune_reg & migrate to better solutions 
            dp_sa_compare_ana_best <= 0;
            dp_update_recent_val_to_reg <= 0;
        end
        else begin
            dp_sa_recv_is_done <= 1;
        end
    end
    
    ///////////////////////////////////////////
    // global and local counters for SS
    ///////////////////////////////////////////
    // for local EA, cp_inc_sa_local_cnt 
    always @(posedge CLK or negedge RST_N)
    begin
        if (RST_N == 0)
            ss_neighbor_cnt <= 0;
        else if (cp_inc_ss_local_cnt)
            ss_neighbor_cnt <= ss_neighbor_cnt + 1;
        else if (cp_rst_ss_local_cnt)
            ss_neighbor_cnt <= 0;
    end
    
    // for global management, cp_inc_global_sa_cnt
    // always @(posedge CLK or negedge RST_N)
    // begin
        // if (RST_N == 0)
            // global_ss_iter_cnt <= 0;
        // else if (cp_inc_ss_global_cnt)
            // global_ss_iter_cnt <= global_ss_iter_cnt + 1;
    // end
    
    // to record the location of the best local minimum 
    always @(posedge CLK or negedge RST_N)
    begin
        if (RST_N == 0) begin
            dp_ss_found_local_min <= 0;
            neighbor_index <= 0;
        end
        else if (cp_rst_ss_local_cnt) begin //cp_rst_found_local_min
            dp_ss_found_local_min <= 0;
            neighbor_index <= 0;
        end
        else if (dp_ss_compare_local_min) begin
            if (analog_val < analog_best) begin
                dp_ss_found_local_min <= 1;
                neighbor_index <= ss_neighbor_cnt;
            end
        end
    end
    
    ///////////////////////////////////////////////////////
    // Sensivitiy block 1:  since activate to ready send 
    ///////////////////////////////////////////////////////
    always @(posedge CLK or negedge RST_N)
    begin
        if (RST_N == 0) begin
            dp_backup_tune_dly <= 0;
            dp_backup_tune_bits_to_reg <= 0;
            dp_chg_neighbor_tune_bits <= 0;
            dp_ss_tune_is_done <= 0;
        end
        else if (!cp_set_ss_start) begin
            // (0) Stay here till "cp_set_ss_start=1"
            dp_backup_tune_dly <= 1;
            dp_backup_tune_bits_to_reg <= 0;
            dp_chg_neighbor_tune_bits <= 0;
            dp_ss_tune_is_done <= 0;
        end
        else if (dp_backup_tune_dly) begin
            dp_backup_tune_dly <= 0;
            dp_backup_tune_bits_to_reg <= 1;
            dp_chg_neighbor_tune_bits <= 0;
            dp_ss_tune_is_done <= 0;
        end
        else if (dp_backup_tune_bits_to_reg) begin
            // (1) backup the best value
            // tune_regX <= tune_bits[(ss_neighbor_cnt>>1)];
            // analog_reg <= analog_best;
            dp_backup_tune_bits_to_reg <= 0;
            dp_chg_neighbor_tune_bits <= 1;
        end
        else if (dp_chg_neighbor_tune_bits) begin
            // (2) change 1 bit of the tune_bits 
            // if (ss_neighbor_cnt[0])
                // tune_bits[(ss_neighbor_cnt>>1)] <= tune_regX + 1;
            // else
                // tune_bits[(ss_neighbor_cnt>>1)] <= tune_regX - 1;
            dp_chg_neighbor_tune_bits <= 0;
            // ss_req_ld_tune_bits <= 1;
        // end
        // else if (ss_req_ld_tune_bits) begin
            // (3) send SA_READY signal without inform middle level
            // ss_req_ld_tune_bits <= 0;
        end
        else begin
            dp_ss_tune_is_done <= 1;
        end
    end

    // Sensivitiy block 2: receive nxt to compare
    always @ (posedge CLK or negedge RST_N)
    begin
        if (RST_N == 0) begin
            dp_ss_recv_dly <= 0;
            dp_ss_compare_local_min <= 0;
            dp_ss_restore_tune_bits <= 0;
            dp_ss_recv_is_done <= 0;
        end
        else if (!cp_set_ss_recv) begin
            // (0) Stay here till "cp_set_ss_recv=1"
            dp_ss_recv_dly <= 1;
            dp_ss_compare_local_min <= 0;
            dp_ss_restore_tune_bits <= 0;
            dp_ss_recv_is_done <= 0;
        end
        else if (dp_ss_recv_dly) begin
            dp_ss_recv_dly <= 0;
            dp_ss_compare_local_min <= 1;
            dp_ss_restore_tune_bits <= 0;
            dp_ss_recv_is_done <= 0;
        end
        else if (dp_ss_compare_local_min) begin
            // (1) Check if a better solution exist 
            //if (analog_val < analog_best) begin
                //analog_best <= analog_val;
                //dp_ss_found_local_min <= 1;
                //neighbor_index <= ss_neighbor_cnt;// record the current neighbor_index
            //end
            dp_ss_compare_local_min <= 0;
            dp_ss_restore_tune_bits <= 1;
            end
        else if (dp_ss_restore_tune_bits) begin
            // (2) Restore changed tune_bits from tune_regX: 
            //  tune_bits[(ss_neighbor_cnt>>1)] <= tune_regX;
            dp_ss_restore_tune_bits <= 0;
        end
        else begin
            dp_ss_recv_is_done <= 1;
        end
    end
    
endmodule

`endif //SA_4D_DATA_PATH_418_V
