//+FHDR****************************************************************
// ECE department, TAMU
// --------------------------------------------------------------------
// FILE NAME    : tb_Sqrt.v
// AUTHER       : Jiafan Wang
// DATE         : 06/24/2014
// VERSION      : 1.0
// PURPOSE      : the Cordic Algorithm testbench 
// --------------------------------------------------------------------
// ABSTRACT
//
//   Not synthesizable, for simulation only
// --------------------------------------------------------------------

`timescale 1 ns / 100 ps
//`include    "../src/addandsub.v"
//`include    "../src/mysqrt.v"

//`include    "../src/mysqrt2.v"
`include    "../SQRT_POWSUM_418.v"

`define MAX_WIDTH   13
`define CADC_WIDTH  10

module TEST_CORDIC_TOP;	// A simple test bench

    parameter   CLK_DELAY  = 10;

    reg     [`MAX_WIDTH-1:0] X_IN;
    reg     [`MAX_WIDTH-1:0] Y_IN;
    reg     [`CADC_WIDTH-1:0] OFFSET;
 
    reg     CLK, RST_N, enable;
    wire    [`MAX_WIDTH-1:0] FOUT;//, FY;
    wire    [`MAX_WIDTH-1:0] POUT;//, FY;
    wire    cordic_sqrt_is_done;
    integer i,j,k;

    SQRT_POWSUM_418 U2(    
    //MYSQRT    U2(
            .CLK(CLK),
            .RST_N(RST_N),
            .enable(enable),

            .X_IN(X_IN),
            .Y_IN(Y_IN),
            .OFFSET(OFFSET),
            
            .FOUT(FOUT),
            .cordic_sqrt_is_done(cordic_sqrt_is_done)
            );

    // Initial Settings
    initial
    begin
        CLK = 1'b0;
        RST_N = 1'b0;
        #CLK_DELAY RST_N = 1'b1;
        
        ////////////////////// K=0.86 //////////////////////////
        // Test 1_1: |X|>|Y|, X>0 & Y>0 
        OFFSET = `CADC_WIDTH'd512;
        X_IN = 612;// `MAX_WIDTH'd58;//d79;//~(`MAX_WIDTH'd89)+1'b1;
        Y_IN = 212;//`MAX_WIDTH'd50;//d504;//d26; 
        $display($time, " Test 1_1: |X|>|Y|, X>0 & Y>0");
        cordic_test();
$stop();
        // Test 1_2: |X|>|Y|, X<0 & Y>0
        X_IN = 6;//~(`MAX_WIDTH'd58)+1'b1;
        Y_IN = 5;//(`MAX_WIDTH'd50);
        $display($time, " Test 1_2: |X|>|Y|, X<0 & Y>0");
        cordic_test();

        // Test 1_3: |X|>|Y|, X>0 & Y<0
        X_IN = (`MAX_WIDTH'd58);
        Y_IN = ~(`MAX_WIDTH'd50)+1'b1;
        $display($time, " Test 1_3: |X|>|Y|, X>0 & Y<0");
        cordic_test();

        // Test 1_4: |X|>|Y|, X<0 & Y<0
        X_IN = ~(`MAX_WIDTH'd58)+1'b1;
        Y_IN = ~(`MAX_WIDTH'd50)+1'b1;
        $display($time, " Test 1_4: |X|>|Y|, X<0 & Y<0");
        cordic_test();

        //////////// Test 2 ////////////
        // Test 2_1: |X|<|Y|, X>0 & Y>0
        OFFSET = `CADC_WIDTH'd0;
        X_IN = `MAX_WIDTH'd50;//d79;//~(`MAX_WIDTH'd89)+1'b1;
        Y_IN = `MAX_WIDTH'd58;//d504;//d26; 
        $display($time, " Test 2_1: |X|<|Y|, X>0 & Y>0");
        cordic_test();
        
        // Test 2_2: |X|<|Y|, X<0 & Y>0
        X_IN = ~(`MAX_WIDTH'd50)+1'b1;
        Y_IN = (`MAX_WIDTH'd58);
        $display($time, " Test 2_2: |X|<|Y|, X<0 & Y>0");
        cordic_test();

        // Test 2_3: |X|<|Y|, X>0 & Y<0
        X_IN = (`MAX_WIDTH'd50);
        Y_IN = ~(`MAX_WIDTH'd58)+1'b1;
        $display($time, " Test 2_3: |X|<|Y|, X>0 & Y<0");
        cordic_test();

        // Test 2_4: |X|<|Y|, X<0 & Y<0
        X_IN = ~(`MAX_WIDTH'd50)+1'b1;
        Y_IN = ~(`MAX_WIDTH'd58)+1'b1;
        $display($time, " Test 2_4: |X|<|Y|, X<0 & Y<0");
        cordic_test();
        
        $stop();

        //#(125*`MAX_ITERATION) $finish();
    end

    task cordic_test;
        begin
            #CLK_DELAY enable = 0;
            #CLK_DELAY enable = 1;

            //for (i=0; i<=8; i=i+1)  begin
            for (i=0; i<=8*16*2; i=i+1)  begin
                #CLK_DELAY;
                $display($time, " xtemp=%d, ytemp=%d, ztemp=%d", U2.xtemp, U2.ytemp, U2.ztemp);
                if (U2.cordic_sqrt_is_done) begin
                    //$display($time, " Amp Result = %d", FOUT);
                end
            end

            $display($time, " sqrt(pow(%d,2)+pow(%d,2))=%d", X_IN, Y_IN, FOUT);
        end
    endtask
    
    // Clock generation
    always begin
        #(CLK_DELAY/2) CLK = !CLK;
    end
    
    // Dump signals to view waveform
    initial
    begin
        $dumpfile ("wave_cordic_sqrt.dump");
        $dumpvars (0, TEST_CORDIC_TOP);
    end
    
    // Output text messages
    //initial
    //  $monitor($time, " xtemp=%b(%d), ytemp=%b(%d), ztemp=%b(%d)", U2.xtemp, U2.xtemp, U2.ytemp, U2.ytemp, U2.ztemp, U2.ztemp);
    
endmodule

