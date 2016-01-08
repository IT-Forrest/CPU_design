//Verilog HDL for "amsLib", "SA_MIDDLE_LEVEL" "verilog"
//+FHDR****************************************************************
// ECE department, TAMU
// --------------------------------------------------------------------
// FILE NAME    : SA_4D_TOP_LEVEL_418.v
// AUTHER       : Jiafan Wang
// DATE         : 03/26/2015
// VERSION      : 4.0
// PURPOSE      : the top level of SA logic
// --------------------------------------------------------------------
// ABSTRACT
// just work as the wiring of the CONTROL_PATH & DATA_PATH;
// --------------------------------------------------------------------

//`include "/homes/grad/jiafan0420/cadence/amsLib2/sa_define.v"
//`include "../src/sa_define.v"

`ifndef SA_4D_TOP_LEVEL_418_V
`define SA_4D_TOP_LEVEL_418_V

//`include "../src/SA_4D_DEFINE.v"
//`include "../src/SA_4D_CTRL_PATH.v"
//`include "../src/SA_4D_DATA_PATH.v"
//`include "../src/Q_4D_DIVISION.v"
//`include "../src/Q_4D_MULTIPLY.v"

module SA_4D_TOP_LEVEL_418(
    CLK,
    RST_N,
    NXT,

    // Input
    INIT_TUNE_BITS,
    MAX_SA_ITERATION,
    MAX_SS_ITERATION,       // iteration number for ss
    INITIAL_T_VALUE,       // initial temperature
    STEP_T_VALUE,
    OPT_MODE,               // Algorithm type: 0: SS; 1: SA; 2: SA+SS: 3: GA
    FLAG4D,                 // 1: 4 dimension SA; 0: 2 dimension SA
    RAND_GROUP,             // 1: pseudo random group; 2: parallel group
    SS_THRESHOLD,// SS multi start threshold; only tune_bits with cost value lower than this threshold got processed 
    ANA_BITS,               // cost function value coming from CF

    // Output
    TUNE_READY,
    TUNE_BITS,
    
    dividend,
    dividor,
    division_start,
    signed_division,
    division_done,
    
    //share multiply
    multiplicand,
    multiplier,
    multiply_start,
    //mul_mode(mul_mode_sa),
    multiplication,
    multiply_done
);

    parameter   TUNEREG_WIDTH   = 5'd20,
                CDIV_WIDTH      = 4'd12,
                ITER_WIDTH      = 4'd11,
                ANA_WIDTH       = 4'd8,
                MAX_T_WIDTH     = 4'd6,
                RANDOM_WIDTH    = 4'd8,
                MAX_ITERATION   = 8'd150,
                MAX_LOCAL_SA    = 4'd8;

    parameter   DIVIDEND_WIDTH  = 12,
                DIVIDOR_WIDTH   = 12,
                QUOTIENT_WIDTH  = 9;
                
    input   CLK;
    input   RST_N;
    input   NXT;

    input   [TUNEREG_WIDTH-1:0] INIT_TUNE_BITS;
    input   [ITER_WIDTH-1:0]    MAX_SA_ITERATION;
    input   [ITER_WIDTH-1:0]    MAX_SS_ITERATION;   // iteration number for ss
    input   [MAX_T_WIDTH-1:0]   INITIAL_T_VALUE;    // initial temperature
    input   [2:0]   STEP_T_VALUE;
    input   OPT_MODE;
    input   FLAG4D;
    input   RAND_GROUP;
    input   [ANA_WIDTH-1:0] SS_THRESHOLD;
    input   [ANA_WIDTH-1:0] ANA_BITS;

    output  TUNE_READY;// signal to show tune_bits are ready
    output  [TUNEREG_WIDTH-1:0] TUNE_BITS;

    output  [CDIV_WIDTH-1:0]   dividend;
    output  [CDIV_WIDTH-1:0]   dividor;
    output  division_start;
    input   [QUOTIENT_WIDTH-1:0]    signed_division;
    input   division_done;
    
    input   [CDIV_WIDTH-1:0]    multiplication;
    input   multiply_done;
    output  [MAX_T_WIDTH-1:0]   multiplicand;
    output  [RANDOM_WIDTH-1:0]  multiplier;
    output  multiply_start;
    assign  multiply_start = 1'b0;
    
    // wires declare
    //wire    division_is_done;
    //wire    [QUOTIENT_WIDTH-1:0] signed_division;    //provide the division result
    //wire    multiply_is_done;
    //wire    [MAX_T_WIDTH-1:0] multiplication;
    //
    //wire    [RANDOM_WIDTH-1:0] multiplicand;
    //wire    [MAX_T_WIDTH-1:0]  multiplier;
    // wire    [DIVIDEND_WIDTH-1:0]    dividend;
    // wire    [DIVIDOR_WIDTH-1:0] dividor;

    // wires from CP
    wire    cp_sa_set_find_minimum;    
    wire    cp_ld_init_T_value;    
    //wire    cp_rst_sa_local_cnt; 
    wire    cp_set_group_start;    
    wire    cp_set_sa_start;
    wire    cp_dim_update_tune_bits;    
    wire    cp_sa_req_ld_tune_bits;   
    wire    cp_init_update_reg_best;    
    wire    cp_rst_first_flag;    
    wire    cp_set_sa_recv;
    wire    cp_inc_sa_global_cnt;    
    //wire    cp_inc_sa_local_cnt;    
    wire    cp_update_T_value;    
    wire    cp_ss_update_tune_bits;    
    wire    cp_set_ss_start;
    wire    cp_set_multi_start;
    wire    cp_rst_multi_start_flag;
    wire    cp_rst_ss_local_cnt; 
    wire    cp_rst_global_cnt;
    wire    cp_ss_req_ld_tune_bits;   
    wire    cp_set_ss_recv;
    wire    cp_inc_ss_global_cnt;
    wire    cp_inc_ss_local_cnt;
    wire    cp_ss_update_tune_best;
    wire    cp_ss_output_tune_best;

    // wires from DP
    wire    dp_sa_reach_max_iter;  
    wire    dp_sa_reach_min_exp;   
    wire    dp_sa_need_chg_dim;    
    wire    dp_ss_reach_max_iter;  
    wire    dp_ss_chk_all_neighbor;
    wire    dp_ss_threshold_accept;
    wire    dp_group_is_done;
    wire    dp_multi_start_is_done;
    wire    dp_multi_start_flag;
    wire    dp_first_time_flag;    
    wire    dp_sa_tune_is_done;    
    wire    dp_sa_recv_is_done;    
    wire    dp_ss_found_local_min; 
    wire    dp_ss_tune_is_done;    
    wire    dp_ss_recv_is_done;    
    //wire    multiply_start;
    //wire    division_start;
    
    // module invoke
    SA_4D_CTRL_PATH_418    inst_ctrlpath(
    // Input ports
    .CLK(CLK),
    .RST_N(RST_N),
    .NXT(NXT),
    .OPT_MODE(OPT_MODE),
    
    // Input ports from DATA_PATH
    .dp_sa_reach_max_iter(dp_sa_reach_max_iter),  
    .dp_sa_reach_min_exp(dp_sa_reach_min_exp),   
    .dp_sa_need_chg_dim(dp_sa_need_chg_dim),    
    .dp_ss_reach_max_iter(dp_ss_reach_max_iter),  
    .dp_ss_chk_all_neighbor(dp_ss_chk_all_neighbor),
    .dp_ss_threshold_accept(dp_ss_threshold_accept),
    .dp_group_is_done(dp_group_is_done),
    .dp_multi_start_is_done(dp_multi_start_is_done),
    .dp_multi_start_flag(dp_multi_start_flag),
    .dp_first_time_flag(dp_first_time_flag),
    .dp_sa_tune_is_done(dp_sa_tune_is_done),
    .dp_sa_recv_is_done(dp_sa_recv_is_done),
    .dp_ss_found_local_min(dp_ss_found_local_min),
    .dp_ss_tune_is_done(dp_ss_tune_is_done),
    .dp_ss_recv_is_done(dp_ss_recv_is_done),

    // Output to Multiply and Division
    .TUNE_READY(TUNE_READY),
    .cp_sa_set_find_minimum(cp_sa_set_find_minimum),    
    .cp_ld_init_T_value(cp_ld_init_T_value),    
    //.cp_rst_sa_local_cnt(cp_rst_sa_local_cnt), 
    .cp_set_group_start(cp_set_group_start),    
    .cp_set_sa_start(cp_set_sa_start),
    .cp_dim_update_tune_bits(cp_dim_update_tune_bits),    
    .cp_sa_req_ld_tune_bits(cp_sa_req_ld_tune_bits),   
    .cp_init_update_reg_best(cp_init_update_reg_best),    
    .cp_rst_first_flag(cp_rst_first_flag),    
    .cp_set_sa_recv(cp_set_sa_recv),
    .cp_inc_sa_global_cnt(cp_inc_sa_global_cnt),    
    //.cp_inc_sa_local_cnt(cp_inc_sa_local_cnt),    
    .cp_update_T_value(cp_update_T_value),    
    .cp_ss_update_tune_bits(cp_ss_update_tune_bits),    
    .cp_set_ss_start(cp_set_ss_start),
    .cp_set_multi_start(cp_set_multi_start),
    .cp_rst_multi_start_flag(cp_rst_multi_start_flag),
    .cp_rst_ss_local_cnt(cp_rst_ss_local_cnt),
    .cp_rst_global_cnt(cp_rst_global_cnt),
    .cp_ss_req_ld_tune_bits(cp_ss_req_ld_tune_bits),   
    .cp_set_ss_recv(cp_set_ss_recv),
    .cp_inc_ss_global_cnt(cp_inc_ss_global_cnt),
    .cp_inc_ss_local_cnt(cp_inc_ss_local_cnt),
    .cp_ss_update_tune_best(cp_ss_update_tune_best),
    .cp_ss_output_tune_best(cp_ss_output_tune_best)
    );
    
    SA_4D_DATA_PATH_418       inst_datapath(
    // Input ports
    .CLK(CLK),
    .RST_N(RST_N),
    .NXT(NXT),
    
    // Input ports from CONTROLLER
    .INIT_TUNE_BITS(INIT_TUNE_BITS),
    //`ifdef  NEED_ITER_NUM
    .MAX_SA_ITERATION(MAX_SA_ITERATION),
    .MAX_SS_ITERATION(MAX_SS_ITERATION),    // iteration number for ss
    //`endif
    .INITIAL_T_VALUE(INITIAL_T_VALUE),    // initial temperature
    .STEP_T_VALUE(STEP_T_VALUE),
    .FLAG4D(FLAG4D),
    .RAND_GROUP(RAND_GROUP),
    .SS_THRESHOLD(SS_THRESHOLD),
    .ana_bits(ANA_BITS),

    .cp_sa_set_find_minimum(cp_sa_set_find_minimum),
    .cp_ld_init_T_value(cp_ld_init_T_value),    
    //.cp_rst_sa_local_cnt(cp_rst_sa_local_cnt),    
    .cp_set_group_start(cp_set_group_start),    
    .cp_set_sa_start(cp_set_sa_start),    
    .cp_dim_update_tune_bits(cp_dim_update_tune_bits), 
    .cp_sa_req_ld_tune_bits(cp_sa_req_ld_tune_bits),  
    .cp_init_update_reg_best(cp_init_update_reg_best), 
    .cp_rst_first_flag(cp_rst_first_flag),    
    .cp_set_sa_recv(cp_set_sa_recv),    
    .cp_inc_sa_global_cnt(cp_inc_sa_global_cnt),    
    //.cp_inc_sa_local_cnt(cp_inc_sa_local_cnt),    
    .cp_update_T_value(cp_update_T_value),    
    .cp_ss_update_tune_bits(cp_ss_update_tune_bits),  
    .cp_set_ss_start(cp_set_ss_start),
    .cp_set_multi_start(cp_set_multi_start),
    .cp_rst_multi_start_flag(cp_rst_multi_start_flag),
    .cp_rst_ss_local_cnt(cp_rst_ss_local_cnt),
    .cp_rst_global_cnt(cp_rst_global_cnt),
    .cp_ss_req_ld_tune_bits(cp_ss_req_ld_tune_bits),  
    .cp_set_ss_recv(cp_set_ss_recv),    
    .cp_inc_ss_global_cnt(cp_inc_ss_global_cnt),    
    .cp_inc_ss_local_cnt(cp_inc_ss_local_cnt), 
    .cp_ss_update_tune_best(cp_ss_update_tune_best),
    .cp_ss_output_tune_best(cp_ss_output_tune_best),

    .division_is_done(division_done),//division_is_done
    .prob_tmp(signed_division),//signed_division
    .multiply_is_done(multiply_done),//multiply_is_done
    .multiplication(multiplication[MAX_T_WIDTH-1:0]),

    // output ports
    .dp_sa_reach_max_iter(dp_sa_reach_max_iter),  
    .dp_sa_reach_min_exp(dp_sa_reach_min_exp),   
    .dp_sa_need_chg_dim(dp_sa_need_chg_dim),    
    .dp_ss_reach_max_iter(dp_ss_reach_max_iter),  
    .dp_ss_chk_all_neighbor(dp_ss_chk_all_neighbor),
    .dp_ss_threshold_accept(dp_ss_threshold_accept),
    .dp_group_is_done(dp_group_is_done),
    .dp_multi_start_is_done(dp_multi_start_is_done),
    .dp_multi_start_flag(dp_multi_start_flag),
    .dp_first_time_flag(dp_first_time_flag),
    .dp_sa_tune_is_done(dp_sa_tune_is_done),
    .dp_sa_recv_is_done(dp_sa_recv_is_done),
    .dp_ss_found_local_min(dp_ss_found_local_min),
    .dp_ss_tune_is_done(dp_ss_tune_is_done),
    .dp_ss_recv_is_done(dp_ss_recv_is_done),
    
    //.dp_set_multiply_start(multiply_start),
    .multiplicand(multiplicand),
    .multiplier(multiplier),
    .dp_set_division_start(division_start),
    .dividend(dividend),
    .dividor(dividor),
    .TUNE_BITS_OUT(TUNE_BITS)
    );

    // Q_4D_DIVISION      inst_division(
    // .CLK(CLK),
    // .RST_N(RST_N),
    // .dividend(dividend),
    // .dividor(dividor),
    // .division_start(division_start),
    //.length(length),

    // .signed_division(signed_division),
    // .division_done(division_is_done)
    // );

    // SHARE_DIVISION      inst_division(
    // .CLK(CLK),
    // .RST_N(RST_N),
    // .dividend(dividend),
    // .dividor(dividor),
    // .division_start(division_start),
    // .div_mode(div_mode),//2'b00
    
    // .signed_division(signed_division),
    // .division_done(division_is_done)
    // );
    
    
    //Q_4D_MULTIPLY_418      inst_multiply(
    //.CLK(CLK),
    //.RST_N(RST_N),
    //.multiplicand(multiplicand),
    //.multiplier(multiplier),
    //.multiply_start(multiply_start),
    ////.length(length),
    //
    //.multiplication(multiplication),
    //.multiply_done(multiply_is_done)
    //);

endmodule

`endif//SA_4D_TOP_LEVEL_418_V
