`timescale 1ns / 1ps
/**
 * Freq Sampler
 * Counts how many "crossings" are done by the waveform, and calc the frequency
 * A crossing is defined as passing through the x-axis (value == 2048)
 * 
 */
module Freq_Sampler(input CLOCK, clk_wire, [11:0] wave_sample_raw, output [11:0] FCOUNTER);
     wire FSTATE = 0;
     wire clk_wire_1Hz = 0;
     wire [11:0] counter = 0;
     reg [11:0] fcounter = 0;
     
     //call flip state counter
     Freq_Counter fc(CLOCK, clk_wire, wave_sample_raw, counter);
     clk_1Hz clk_1(CLOCK, clk_wire_1Hz);
     
     always @ (posedge clk_wire_1Hz) begin
         fcounter <= counter / 100;
     
     end
     
     assign FCOUNTER = fcounter;
 
 endmodule

