`timescale 1ns / 1ps
/**
 * Freq_FlipState
 * Checks if there is a crossing done, and flips FSTATE if so
 * Crossing requires current value to be around 2048, and a previous value of more / less than that threshold
 */

module Freq_FlipState(input CLOCK, clk_wire, [11:0] wave_sample_raw, output FSTATE);
    reg [11:0] prev = 2048;
    reg fstate = 0;
    
    always @ (posedge clk_wire) begin
        fstate <= (wave_sample_raw == 2048 && (prev > 2100 || prev < 2000) ? ~fstate : fstate);
        prev = wave_sample_raw; //update prev
    end
    
    assign FSTATE = fstate;

endmodule
