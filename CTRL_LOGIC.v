//Verilog HDL for "amsLib2", "CTRL_4D_LOGIC_V" "verilog"
//+FHDR****************************************************************
// ECE department, TAMU
// --------------------------------------------------------------------
// FILE NAME    : CTRL_LOGIC.v
// AUTHER       : Jiafan Wang
// DATE         : 01/04/2016
// VERSION      : 4.0
// PURPOSE      : the Control logic module of the DATA_PATH of cost function 
// --------------------------------------------------------------------
// ABSTRACT
//
//   this module is deseparted from COST_4D_DATA_PATH module.
// --------------------------------------------------------------------

`ifndef CTRL_LOGIC_V
`define CTRL_LOGIC_V


module CTRL_LOGIC(
        // Input
        CLK,
        set_wait_pll_start,
        set_meas_adc_start,
        
        // Output
        meas_adc_is_done,
        wait_pll_is_done,
        RSTN_ADC,
        CLK_ADC,
        CLRN
);
    // Input
    input       CLK;
    input       set_wait_pll_start;
    input       set_meas_adc_start;

    // Output
    output      meas_adc_is_done;
    output      wait_pll_is_done;
    output      RSTN_ADC;
    output      CLK_ADC;
    output      CLRN;

    wire        cnt_clk_enable;             // scale down the input CLK from 50MHz to 10MHz
    reg [4:0]   cnt_clk_scale;
    reg [7:0]   cnt_wait_pll;               // should be greater than the max wait_pll cnt
    reg [3:0]   cnt_meas_adc;               // should be greater than the max meas_adc cnt
    reg [2:0]   meas_state;
    reg [1:0]   pll_state;
    
    parameter   DEFAULT_CNTFREQ = 24;       // Frequency scale down. if Input 50MHz, then inner clk is 2MHz(0.5us)
    parameter   DEFAULT_CNTWAIT = 140;//140;      // 70 us for waiting PLL
    
    parameter   DEFAULT_CNTCLRN = 7;//99;   // 4us
    parameter   DEFAULT_CNTSMPL = 3;//99;   // 2us
    parameter   DEFAULT_CNTCKAD = 1;//49;   // 1us
    parameter   DEFAULT_CNTRADC = 5;//149;  // 3us
    parameter   DEFAULT_CNTCONV = 9;//249;  // 5us
    
    parameter   MS_IDLE = 3'b000,           // FSM. Measurement. Idle (Wait PLL)
                MS_CLRN = 3'b001,           // FSM. Measurement. Sampler Reset (~CLRN)
                MS_SMPL = 3'b011,           // FSM. Measurement. Sampler Start
                MS_CKAD = 3'b010,           // FSM. Measurement. ADC Sampling (CLK_ADC)
                MS_RADC = 3'b110,           // FSM. Measurement. ADC Reset (~RSTN_ADC)
                MS_CONV = 3'b100,           // FSM. Measurement. ADC Conversion
                MS_MRDY = 3'b101;           // FSM. Measurement. Measurement Ready

    parameter   PLL_IDLE = 2'b00,
                PLL_MRDY = 2'b10;
                
    assign      CLRN        = (set_meas_adc_start)? (~(meas_state == MS_CLRN))  :1'b1;
    assign      CLK_ADC     = (set_meas_adc_start)? (meas_state == MS_CKAD)     :1'b0;
    assign      RSTN_ADC    = (set_meas_adc_start)? (~(meas_state == MS_RADC))  :1'b1;

    assign      cnt_clk_enable      = (!cnt_clk_scale); // scale down the input CLK from 50MHz to 10MHz
    assign      wait_pll_is_done    = (pll_state == PLL_MRDY);//(!cnt_wait_pll);  // 
    assign      meas_adc_is_done    = (meas_state == MS_MRDY);
    
    // Frequency scale down: 
    always @(posedge CLK)// or negedge set_meas_adc_start or negedge set_wait_pll_start)
    begin
        // only activate when "meas_adc" or "wait_pll" is high
        if (set_wait_pll_start || set_meas_adc_start) begin
            if (cnt_clk_enable)
                cnt_clk_scale <= DEFAULT_CNTFREQ;
            else
                cnt_clk_scale <= cnt_clk_scale - 1;
        end
        else begin
        //else if (!set_meas_adc_start || cnt_clk_enable) begin
            cnt_clk_scale <= DEFAULT_CNTFREQ;
        end
    end

    //////////////////////////////////////////////////////
    // Wait PLL 70us
    //////////////////////////////////////////////////////
    always @(posedge CLK or negedge set_wait_pll_start)
    begin
        if (!set_wait_pll_start) begin
            cnt_wait_pll <= DEFAULT_CNTWAIT;
        end
        else if (cnt_clk_enable) begin
            if (!cnt_wait_pll) begin
                //;
            end
            else 
                cnt_wait_pll <= cnt_wait_pll - 1;
        end
    end
    
    always @(posedge CLK or negedge set_wait_pll_start)
    begin
        if (!set_wait_pll_start) begin
            pll_state <= PLL_IDLE;
        end
        else if (cnt_clk_enable) begin
            case (pll_state)
                PLL_IDLE: if (!cnt_wait_pll) pll_state <= PLL_MRDY;
                PLL_MRDY: pll_state <= PLL_MRDY;
            endcase
        end
    end
    
    ///////////////////////////////////////////////////////
    //// Measurement Control Logic ////
    ///////////////////////////////////////////////////////
    always @(posedge CLK or negedge set_meas_adc_start)
    begin
        if (!set_meas_adc_start) begin
            meas_state <= MS_CLRN;//MS_IDLE;
        end
        else if (cnt_clk_enable) begin
            case (meas_state)
                MS_IDLE: meas_state <= MS_CLRN;
                MS_CLRN: if (!cnt_meas_adc)  meas_state <= MS_SMPL;
                MS_SMPL: if (!cnt_meas_adc)  meas_state <= MS_CKAD;
                MS_CKAD: if (!cnt_meas_adc)  meas_state <= MS_RADC;
                MS_RADC: if (!cnt_meas_adc)  meas_state <= MS_CONV;
                MS_CONV: if (!cnt_meas_adc)  meas_state <= MS_MRDY;
                MS_MRDY: meas_state <= MS_MRDY;
            endcase
        end
    end
 
    // Counter count down: cnt_meas_adc 
    always @(posedge CLK or negedge set_meas_adc_start)
    begin
        if (!set_meas_adc_start)
            cnt_meas_adc <= DEFAULT_CNTCLRN;
        else if (cnt_clk_enable) begin
            // only count down every DEFAULT_CNTFREQ clock cycles
            if (!cnt_meas_adc)
            begin
                case (meas_state)
                    MS_CLRN: cnt_meas_adc <= DEFAULT_CNTSMPL;
                    MS_SMPL: cnt_meas_adc <= DEFAULT_CNTCKAD;
                    MS_CKAD: cnt_meas_adc <= DEFAULT_CNTRADC;
                    MS_RADC: cnt_meas_adc <= DEFAULT_CNTCONV;
                    //MS_CONV: cnt_meas_adc <= 0;
                    default: cnt_meas_adc <= 0;
                endcase
            end
            else 
                cnt_meas_adc <= cnt_meas_adc - 1;
        end
    end
endmodule
    
`endif//CTRL_LOGIC_V
    
