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
// --------------------------------------------------------------------

`ifndef SA_4D_DEFINE_418_V
`define SA_4D_DEFINE_418_V

`define RTL_TEST_ON
`define FIND_INIT_ON    // the find_initial value MACRO
`define NEED_ITER_NUM   // the initial iteration number MACRO
//`define SA_DEBUG_ON     // used as the debug info controller

`define DIRECT_WIDTH    2
`define COMMON_WIDTH    5   // Bit-width for Common signals
`define FLAT_VALUE      6   // might decrease this vallue for a flat function; difference of two flat points
`define	MAX_FLAT_CNT    5   // Maximal times of accepting flat points
`define FLAT_WIDTH      3   // Bit-width for flat_cnt, range [0~`MAX_FLAT_CNT-1]
`define INIT_STEP       7   // the step to migrate from current initial points to new ones
`define STEP_CNT_WIDTH  3   // Bit-width for changing initial points

`define VAR_WIDTH       5   // Bit-width of variables
`define INDEX_WIDTH     3   // Bit-width of the index, range [0~VAR_WIDTH-1]
`define VAR_NUM         4   // Number of variables
`define VAL_WIDTH       8   // Bit-width of analog bits (Analog response)
`define ANA_WIDTH       `VAL_WIDTH   // Bit-width of the Analog response
`define MAX_DELAY_CNT   5   // Maximal waiting cycles of the Analog circuit
`define ITER_WIDTH      11  // Bit-width of the iteration
`define MAX_LOCAL_SA    8   // Locally Maximal iteration of the SA algorithm
`define MAX_ITERATION   150 // Globally Maximal iteration of the SA algorithm
`define REANNEAL_WIDTH  5   // Bit-width of REANNEAL_ITER, range [0~REANNEAL_ITER-1]
`define REANNEAL_ITER   32  // Number of iterations before reanneal
//`define REANNEAL_ONE    `REANNEAL_ITER      // The 1st time Reannealing
//`define REANNEAL_TWO    (`REANNEAL_ITER *2) // The 2nd time Reannealing
//`define REANNEAL_3RD    (`REANNEAL_ITER *3) // The 3rd time Reannealing
`define MIN_EXP_VALUE   1   // Minimal expected value
`define STATE_WIDTH     3   // Maximal width of the controller state

`define T_STEP_SIZE     4   //8 Temperature STEP SIZE, T<=T/r or T<=T-r
`define MAX_T_WIDTH     6   // Bit-width of temperature
`define MAX_T_VALUE     32 //255 Maximal initial temperature {8{1'b1}}
`define TUNEREG_WIDTH   (`VAR_WIDTH*`VAR_NUM)   // Bit-width of the solution state
`define POSITION_WIDTH  4   // Bit-width of the position, range [0~TUNEREG_WIDTH-1]
`define RANDOM_WIDTH    8   // Bit-width of the random probability

`endif//SA_4D_DEFINE_418_V
