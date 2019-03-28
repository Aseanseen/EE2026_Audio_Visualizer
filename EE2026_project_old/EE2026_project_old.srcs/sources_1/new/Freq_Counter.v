`timescale 1ns / 1ps
/**
 */

module Freq_Counter(input CLOCK, clk_wire, [11:0] wave_sample_raw, output [11:0] FCOUNTER);
    wire FSTATE = 0;
    reg [11:0] fcounter = 0;
    
    //call flip state counter
    Freq_FlipState fs(CLOCK, clk_wire, wave_sample_raw, FSTATE);
    
    always @ (posedge FSTATE) begin
        fcounter <= (fcounter > 1000 ? 0 : fcounter + 1);    
    
    end
    
    assign FCOUNTER = fcounter;

endmodule
