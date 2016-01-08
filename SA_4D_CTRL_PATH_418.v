//+FHDR****************************************************************
// ECE department, TAMU
// --------------------------------------------------------------------
// FILE NAME    : SA_4D_CTRL_PATH_418_V.v
// AUTHER       : Jiafan Wang
// DATE         : 03/26/2015
// VERSION      : 4.0
// PURPOSE      : the controller of SA algorithm 
// --------------------------------------------------------------------
// ABSTRACT
//
//   Include both 4D standalone SA and Sensitivity process
//   PS: *_reg denotes the current value, *_val denotes the new value
// --------------------------------------------------------------------

//`include "/homes/grad/jiafan0420/cadence/amsLib2/sa_define.v"
//`include "../src/SA_4D_DEFINE.v"

`ifndef SA_4D_CTRL_PATH_418_V
`define SA_4D_CTRL_PATH_418_V

module  SA_4D_CTRL_PATH_418(
    // Input ports
    CLK,
    RST_N,
    NXT,
    OPT_MODE,
    
    // Input ports from DATA_PATH
    dp_sa_reach_max_iter,   //global_sa_iter_cnt == max_sa_iteration
    dp_sa_reach_min_exp,    //analog_best <= MIN_EXP_VALUE
    dp_sa_need_chg_dim,     //local_sa_iter_cnt == MAX_LOCAL_SA
    dp_ss_reach_max_iter,   //global_ss_iter_cnt == max_ss_iteration
    dp_ss_chk_all_neighbor, //ss_neighbor_cnt == (VAR_NUM<<1)
    dp_ss_threshold_accept, //analog_val <= SS_MULTI_START_THRESHOLD
    dp_group_is_done,
    dp_multi_start_is_done,
    dp_multi_start_flag,
    dp_first_time_flag,
    dp_sa_tune_is_done,
    dp_sa_recv_is_done,
    dp_ss_found_local_min,
    dp_ss_tune_is_done,
    dp_ss_recv_is_done,
    
    // Output ports to DATA_PATH
    TUNE_READY,
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
    cp_rst_ss_local_cnt, 
    cp_rst_global_cnt,
    cp_set_multi_start,
    cp_rst_multi_start_flag,
    cp_ss_req_ld_tune_bits,   
    cp_set_ss_recv,
    cp_inc_ss_global_cnt,
    cp_inc_ss_local_cnt,
    cp_ss_update_tune_best,
    cp_ss_output_tune_best
);

    parameter   ANA_WIDTH       = 4'd8,
                RANDOM_WIDTH    = 4'd8,
                MAX_T_WIDTH     = 4'd6,
                ITER_WIDTH      = 4'd11,
                STATE_WIDTH     = 4'd4,
                MIN_EXP_VALUE   = 4'd1,
                MAX_LOCAL_SA    = 4'd8;
                //VAR_NUM         = 4'd4;

    // HLSM State description 
    parameter   INIT_STATE      = 4'b0000,
                SA_JUDGE_NEXT   = 4'b0001,// Wait Analog circuit to get the response
                DIVIDE_GROUP    = 4'b0011,
                ACTIVATE_SA     = 4'b0010,// Just used to wait till the values are ready
                SA_WAITING_CF   = 4'b0110,
                SA_RECEIVE      = 4'b0111,
                SA_INC_CNT      = 4'b0101,
                SENSITIVITY     = 4'b0100,
                SS_JUDGE_NEXT   = 4'b1100,
                SS_IMPROVEMENT  = 4'b1101,
                SS_MULTI_START  = 4'b1111,
                ACTIVATE_SS     = 4'b1110,
                SS_WAITING_CF   = 4'b1010,
                SS_RECEIVE      = 4'b1011,
                SS_INC_CNT      = 4'b1001,
                GAME_OVER       = 4'b1000;

    parameter   OPT_MODE_SA     = 1,
                OPT_MODE_SS     = 0;

    input   CLK;
    input   RST_N;
    input   NXT;
    input   OPT_MODE;

    // Input ports from DATA_PATH
    input   dp_sa_reach_max_iter;   //global_sa_iter_cnt == max_sa_iteration
    input   dp_sa_reach_min_exp;    //analog_best <= MIN_EXP_VALUE
    input   dp_sa_need_chg_dim;     //local_sa_iter_cnt == MAX_LOCAL_SA
    input   dp_ss_reach_max_iter;   //global_ss_iter_cnt == max_ss_iteration
    input   dp_ss_chk_all_neighbor; //ss_neighbor_cnt == (VAR_NUM<<1)
    input   dp_ss_threshold_accept; //analog_val <= SS_MULTI_START_THRESHOLD
    input   dp_group_is_done;
    input   dp_multi_start_is_done;
    input   dp_multi_start_flag;
    input   dp_first_time_flag;
    input   dp_sa_tune_is_done;
    input   dp_sa_recv_is_done;
    input   dp_ss_found_local_min;
    input   dp_ss_tune_is_done;
    input   dp_ss_recv_is_done;
    
    // Output ports to DATA_PATH
    output  reg     TUNE_READY;
    output  reg     cp_sa_set_find_minimum;
    output  reg     cp_ld_init_T_value;
    //output  reg     cp_rst_sa_local_cnt;
    output  cp_set_group_start;
    output  reg     cp_set_sa_start;
    output  reg     cp_dim_update_tune_bits;
    output  reg     cp_sa_req_ld_tune_bits;
    output  reg     cp_init_update_reg_best;
    output  reg     cp_rst_first_flag;
    output  reg     cp_set_sa_recv;
    output  reg     cp_inc_sa_global_cnt;
    //output  reg     cp_inc_sa_local_cnt;
    output  reg     cp_update_T_value;
    output  reg     cp_ss_update_tune_bits;
    output  reg     cp_set_ss_start;
    output  reg     cp_rst_ss_local_cnt;
    output  reg     cp_rst_global_cnt;
    output  cp_set_multi_start;
    output  reg     cp_rst_multi_start_flag;
    output  reg     cp_ss_req_ld_tune_bits;
    output  reg     cp_set_ss_recv;
    output  reg     cp_inc_ss_global_cnt;
    output  reg     cp_inc_ss_local_cnt;
    output  reg     cp_ss_update_tune_best;
    output  reg     cp_ss_output_tune_best;
    
    
    // Register declaration
    reg     [STATE_WIDTH-1:0] state;
    reg     [STATE_WIDTH-1:0] next_state;
    reg     sa_req_init_tune_bits;
    reg     ss_req_init_tune_bits;
   
    assign  cp_set_group_start = (state == DIVIDE_GROUP);
    assign  cp_set_multi_start = (state == SS_MULTI_START);
 
    // Every model needs to request TUNE_READY signal to CF module
    always @(posedge CLK or negedge RST_N)
    begin
        if (RST_N == 0)
            TUNE_READY <= 0;
        else if (cp_sa_req_ld_tune_bits)
            TUNE_READY <= 1;
        else if (cp_ss_req_ld_tune_bits)
            TUNE_READY <= 1;
        else if (sa_req_init_tune_bits)
            TUNE_READY <= 1;
        else if (ss_req_init_tune_bits)
            TUNE_READY <= 1;
        else
            TUNE_READY <= 0;
    end

    always @(posedge CLK or negedge RST_N)
    begin
        if (RST_N == 0) begin
            state <= INIT_STATE;
        end
        else begin
            state <= next_state;
        end
    end
    
    // Combinational Circuit of the next_state
    always @*   begin
        cp_sa_set_find_minimum  = 0;
        cp_ld_init_T_value      = 0;
        //cp_rst_sa_local_cnt     = 0;
        //cp_set_group_start      = 0;
        cp_set_sa_start         = 0;
        cp_dim_update_tune_bits = 0;
        cp_sa_req_ld_tune_bits  = 0;
        cp_init_update_reg_best = 0;
        cp_rst_first_flag       = 0;
        cp_set_sa_recv          = 0;
        cp_inc_sa_global_cnt    = 0;
        //cp_inc_sa_local_cnt     = 0;
        cp_update_T_value       = 0;
        cp_ss_update_tune_bits  = 0;
        cp_set_ss_start         = 0;
        cp_rst_ss_local_cnt     = 0;
        cp_rst_global_cnt       = 0;
        //cp_set_multi_start      = 0;
        cp_rst_multi_start_flag = 0;
        cp_ss_req_ld_tune_bits  = 0;
        //cp_init_update_reg_best = 0;
        cp_set_ss_recv          = 0;
        cp_inc_ss_global_cnt    = 0;
        cp_inc_ss_local_cnt     = 0;
        cp_ss_update_tune_best  = 0;
        cp_ss_output_tune_best  = 0;
        
 
        sa_req_init_tune_bits   = 0;
        ss_req_init_tune_bits   = 0;
 
        case (state)
            INIT_STATE      :begin
                if (OPT_MODE == OPT_MODE_SA) begin //condition1
                sa_req_init_tune_bits = 1;
                next_state = SA_WAITING_CF;
                end
                else if (OPT_MODE == OPT_MODE_SS) begin //condition2f 
                    ss_req_init_tune_bits = 1;
                    next_state = SS_WAITING_CF;
                end
            end
            SA_JUDGE_NEXT   :begin
                // the stopping criteria for SA
                if (dp_sa_reach_max_iter || dp_sa_reach_min_exp) begin
                //if (global_sa_iter_cnt == max_sa_iteration || analog_best <= MIN_EXP_VALUE) begin
                    cp_sa_set_find_minimum = 1;
                    $display($time, " \t\t Begin Sensitivity Search");
                    next_state = SENSITIVITY;
                end
                else if (dp_sa_need_chg_dim) begin
                //else if (local_sa_iter_cnt == MAX_LOCAL_SA) begin
                    //need change dimension
                    cp_ld_init_T_value = 1;//restore the temperature
                    //cp_rst_sa_local_cnt = 1;
                    cp_sa_set_find_minimum = 1;
                    //cp_set_group_start = 1;
                    next_state = DIVIDE_GROUP;
                end
                else begin
                    //cp_set_sa_start = 1;
                    next_state = ACTIVATE_SA;
                end
            end
            DIVIDE_GROUP    :begin
                // cp_set_group_start = 1;
                // next_state = GROUP_DONE;
            // end
            // GROUP_DONE      :begin
                if (!dp_group_is_done) begin
                    //cp_set_group_start = 1;
                    next_state = DIVIDE_GROUP;//GROUP_DONE;
                end
                else begin
                    //load tune_reg & tune_best after dimension change
                    cp_dim_update_tune_bits = 1;
                    //cp_set_group_start = 1;
                    next_state = ACTIVATE_SA;
                end
            end
            ACTIVATE_SA     :begin//this state can be omitted !!
                // cp_set_sa_start = 1;
                // next_state = ACTIVATE_DONE;
            // end
            // ACTIVATE_DONE   :begin
                if (!dp_sa_tune_is_done) begin
                    cp_set_sa_start = 1;
                    next_state = ACTIVATE_SA;//ACTIVATE_DONE;
                end
                else begin
                    cp_set_sa_start = 1;
                    cp_sa_req_ld_tune_bits = 1;
                    next_state = SA_WAITING_CF;
                end
            end
            SA_WAITING_CF   :begin
                if (!NXT) begin
                    next_state = SA_WAITING_CF;
                end
                else if (dp_first_time_flag) begin
                    // only for the first tune after poweron
                    cp_init_update_reg_best = 1;
                    cp_rst_first_flag = 1;
                    next_state = SA_JUDGE_NEXT;
                end
                else begin
                    //cp_set_sa_recv = 1;
                    next_state = SA_RECEIVE;
                end
            end
            SA_RECEIVE     :begin
                // Activate part2 of SA process
                if (!dp_sa_recv_is_done) begin
                    cp_set_sa_recv = 1;
                    next_state = SA_RECEIVE;
                end
                else begin
                    cp_set_sa_recv = 0;
                    next_state = SA_INC_CNT;
                end
            end
            SA_INC_CNT      :begin
                cp_inc_sa_global_cnt = 1;
                //cp_inc_sa_local_cnt = 1;
                cp_update_T_value = 1;
                next_state = SA_JUDGE_NEXT;
            end
            SENSITIVITY     :begin
                // keep this state for furture use
                cp_ss_update_tune_best = 1;
                //cp_rst_ss_local_cnt = 1;
                cp_rst_global_cnt = 1;
                next_state = SS_JUDGE_NEXT;
            end
            SS_JUDGE_NEXT   :begin
                // Stopping criteria for SS
                if (dp_ss_reach_max_iter) begin
                //if (global_ss_iter_cnt == max_ss_iteration) begin
                    //if (dp_ss_found_local_min) begin
                    //    cp_ss_update_tune_bits = 1;
                    cp_ss_output_tune_best = 1;
                    next_state = GAME_OVER;
                end
                else if (dp_multi_start_flag) begin
                    // jump out MULTI_START state when multi-start tune_bits accept
                    if (dp_ss_threshold_accept) begin
                        cp_rst_multi_start_flag = 1;
                        next_state = ACTIVATE_SS;
                    end
                    else begin
                        // skip unpromissing tune_bits; 
                        // keep on stay in MULTI_START state
                        next_state = SS_MULTI_START;
                    end
                end
                else if (dp_ss_chk_all_neighbor) begin
                //else if (ss_neighbor_cnt == (VAR_NUM<<1)) begin
                    // finish checking all neigbors (max_ss_neighbor)
                    //cp_rst_ss_local_cnt = 1;
                    next_state = SS_IMPROVEMENT;
                end
                else begin
                    //cp_set_ss_start = 1;
                    next_state = ACTIVATE_SS;
                end
            end
            SS_IMPROVEMENT  :begin
                if (dp_ss_found_local_min) begin
                    // use local min as new starting point and then clear all local info
                    cp_ss_update_tune_bits = 1;
                    cp_rst_ss_local_cnt = 1;
                    next_state = SS_JUDGE_NEXT;//SENSITIVITY
                end
                else begin
                    cp_rst_ss_local_cnt = 1;
                    if (OPT_MODE == OPT_MODE_SA) begin
                        cp_ss_output_tune_best = 1;
                        next_state = GAME_OVER;
                    end
                    else if (OPT_MODE == OPT_MODE_SS) begin
                        next_state = SS_MULTI_START;// multi-start SS could do something here
                    end
                end
            end
            SS_MULTI_START  :begin
                if (!dp_multi_start_is_done) begin
                    //cp_set_multi_start = 1;
                    next_state = SS_MULTI_START;
                end
                else begin
                    //cp_set_multi_start = 1;
                    cp_ss_req_ld_tune_bits = 1;
                    next_state = SS_WAITING_CF;//// we need to save the best tune bits.........
                end
            end
            ACTIVATE_SS     :begin
                if (!dp_ss_tune_is_done) begin
                    cp_set_ss_start = 1;
                    next_state = ACTIVATE_SS;
                end
                else begin
                    cp_set_ss_start = 0;
                    cp_ss_req_ld_tune_bits = 1;
                    next_state = SS_WAITING_CF;
                end
            end
            SS_WAITING_CF   :begin
                if (!NXT) begin
                    next_state = SS_WAITING_CF;
                end
                else if (dp_first_time_flag) begin
                    // only for the first tune after poweron
                    cp_init_update_reg_best = 1;
                    // it's OK to reuse this signal "cp_init_update_reg_best";
                    // since only tune_regX is used in SS, tune_regY ignored
                    cp_rst_first_flag = 1;
                    next_state = SS_JUDGE_NEXT;
                end
                else if (dp_multi_start_flag) begin
                    //cp_rst_multi_start_flag = 1;
                    //cp_inc_ss_global_cnt = 1;
                    next_state = SS_RECEIVE;
                end
                else begin
                    //cp_set_ss_recv = 1;
                    next_state = SS_RECEIVE;
                end
            end
            SS_RECEIVE      :begin
                if (!dp_ss_recv_is_done) begin
                    cp_set_ss_recv = 1;
                    next_state = SS_RECEIVE;
                end
                else begin
                    cp_set_ss_recv = 0;
                    next_state = SS_INC_CNT;
                end
            end
            SS_INC_CNT      :begin
                cp_inc_ss_global_cnt = 1;
                if (dp_multi_start_flag) begin
                    // for the multi-start tune bits, no need to increase ss local
                    //cp_rst_multi_start_flag = 1;
                end
                else begin
                    cp_inc_ss_local_cnt = 1;
                end
                next_state = SS_JUDGE_NEXT;
            end
            GAME_OVER       :begin
                $display($time, " \t\t GAME_OVER");
                next_state = GAME_OVER;
            end
            default         :begin
                next_state = GAME_OVER;
            end
        endcase
    end
    
endmodule

`endif //SA_4D_CTRL_PATH_418_V.v
