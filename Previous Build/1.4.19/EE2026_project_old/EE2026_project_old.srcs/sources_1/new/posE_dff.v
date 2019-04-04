`timescale 1ns / 1ps

//basic D flip flop, check on posEdge CLOCK
module posE_dff(input CLOCK, D, output reg Q = 0);
    always @ (posedge CLOCK) begin
        Q <= D;
    end

endmodule