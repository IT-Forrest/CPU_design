//`ifndef SC_CELL_V3_V
//`define SC_CELL_V3_V

module SC_CELL_V3(
    SIN, PIN, SO, PO, SEL, LAT, BYP_N, SCK1, SCK2
);
    input       SIN;    // Serial Input
    input       PIN;    // Parallel Input
    
    output      SO;     // Serial Output
    output      PO;     // Parallel Output
    
    input       SEL;    // PO Source (0-Latched, 1-Bypassed if BYP=0)
    input       LAT;    // PO Latch Signal
    input       BYP_N;  // Bypassable (0-Bypassable, 1-Non-bypassable), INTERNAL USE ONLY
    input       SCK1;   // Shift Clock Phase 1
    input       SCK2;   // Shift Clock Phase 2
    
//                           -------    0 ---
//                        +->|reg_s|----->|M|----> PO
//                        |  -------   +->|X|
//       0 ---   -------  |  -------   |  ---
//  SIN -->|M|-->|reg_1|--+->|reg_2|-------------> SO
//      +->|X|   -------     -------   |
//      |  ---                         |
//      +------------------------------+-- PIN

    reg         reg_1;  // Shift Phase 1 (SCK1) Latch
    reg         reg_2;  // Shift Phase 2 (SCK2) Latch
    reg         reg_s;  // Parallel Output (LAT) Latch
    
    wire        reg_1_mux;

    assign      reg_1_mux = SEL ? PIN : SIN;
    assign      PO = BYP_N ? reg_s : ( SEL ? PIN : reg_s );
    assign      SO = reg_2;
    
    always @(LAT  or reg_1)     
    begin 
        if (LAT) reg_s <= reg_1; 
    end
    
    always @(SCK1 or reg_1_mux) 
    begin 
        if (SCK1) reg_1 <= reg_1_mux; 
    end
    
    always @(SCK2 or reg_1) 
    begin 
        if (SCK2) reg_2 <= reg_1;
    end
    
endmodule
//`endif

