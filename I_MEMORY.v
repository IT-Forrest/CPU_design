`timescale 1ns / 1ps
`include "DEFINE_CPU.v"

`ifndef I_MEMORY_V
`define I_MEMORY_V

module I_MEMORY(
    input clk,
    input rst_n,
    input [7:0] addr,
    input d_we,
    input [15:0] datain,
    output [15:0] dataout
    );

    reg [15:0] I_RAM[255:0];
    
    assign dataout = I_RAM[addr];
    always @(posedge clk or negedge rst_n)
        begin
            if (!rst_n)
                begin
                    // The initialization is moved to the top-level test bench
                    // I_RAM[0] <= {`LOAD, `gr1, 1'b0, `gr0, 4'b0000};
                    // I_RAM[1] <= {`LOAD, `gr2, 1'b0, `gr0, 4'b0001};
                    // I_RAM[2] <= {`NOP, 11'b000_0000_0000};
                    // I_RAM[3] <= {`NOP, 11'b000_0000_0000};
                    // I_RAM[4] <= {`NOP, 11'b000_0000_0000};
                    // I_RAM[5] <= {`ADD, `gr3, 1'b0, `gr1, 1'b0, `gr2};
                    // I_RAM[6] <= {`NOP, 11'b000_0000_0000};
                    // I_RAM[7] <= {`NOP, 11'b000_0000_0000};
                    // I_RAM[8] <= {`NOP, 11'b000_0000_0000};
                    // I_RAM[9] <= {`STORE, `gr3, 1'b0, `gr0, 4'b0010};
                    // I_RAM[10] <= {`BNZ, `gr1, 8'b0001_0000};
                    // I_RAM[11] <= {`NOP, 11'b000_0000_0000};
                    // I_RAM[12] <= {`NOP, 11'b000_0000_0000};
                    // I_RAM[13] <= {`NOP, 11'b000_0000_0000};
                    // I_RAM[187] <= {`CMP, 4'b0000, `gr1, 1'b0, `gr2};
                    // I_RAM[188] <= {`HALT, 11'b000_0000_0000};
                end
            else if (d_we)
                I_RAM[addr] <= datain;
        end

endmodule
`endif//I_MEMORY_V