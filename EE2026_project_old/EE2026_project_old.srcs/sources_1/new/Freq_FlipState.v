`timescale 1ns / 1ps
/**
 * Freq_FlipState
 * Checks if there is a crossing done, and flips FSTATE if so
 * Crossing requires current value to be around 2048, and a previous value of more / less than that threshold
 */

module Freq_FlipState(input CLOCK, clk_wire, [11:0] wave_sample_raw, output [11:0] COUNTER);
    reg [11:0] prev = 2048;
    reg [11:0] counter = 0;
    
    always @ (posedge clk_wire) begin
        counter <= (wave_sample_raw > 2048 && prev < 2048 ? (counter >= 5000 ? 0 : counter + 1) : counter);
        prev = wave_sample_raw; //update prev
    end
    
    assign COUNTER = counter;

endmodule
