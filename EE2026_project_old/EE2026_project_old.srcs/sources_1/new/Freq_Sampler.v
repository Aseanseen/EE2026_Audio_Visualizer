`timescale 1ns / 1ps
/**
 * Freq Sampler
 * Counts how many "crossings" are done by the waveform, and calc the frequency
 * A crossing is defined as passing through the x-axis (value == 2048)
 * 
 */
module Freq_Sampler(input CLOCK, clk_wire, [11:0] wave_sample_raw, output [11:0] FREQ);
    reg [11:0] freq = 0;
    wire [11:0] FCOUNTER = 0;
    
    //counter for crossings
    Freq_Counter fc(CLOCK, clk_wire, wave_sample_raw, FCOUNTER);
    
    always @ (posedge clk_wire) begin
        freq <= FCOUNTER / 100;
    end
    
    assign FREQ = freq;

endmodule
