`timescale 1ns / 1ps
/**
 * Color Selector Module
 * Gets input state from Mode_Selector module
 * Outputs relevant 12bit color reg for printing
 */

module Colour_Selector(
    input CLOCK,
    input [2:0] STATE,
    
    output reg [11:0] background,
    output reg [11:0] waveform,
    output reg [11:0] axes,
    output reg [11:0] grid,
    output reg [11:0] ticks
    );
    
    reg [2:0] state;
    
    always @ (posedge CLOCK) begin
    state <= STATE;
    case (state)
        1: begin 
            background <= 1;
            waveform <= 12'hFFF;
            axes <= 12'h050;
            grid <= 12'h030;
            ticks <= 12'h009;
        end
        
        2: begin
            background <= 12'h333;
            waveform <= 12'hF00;
            axes <= 12'h050;
            grid <= 12'h00F;
            ticks <= 12'h333;
        end
        
        3: begin
            background <= 12'h060;
            waveform <= 12'hDDD;
            axes <= 12'h202;
            grid <= 12'h030;
            ticks <= 12'h202;
        end
        
        4: begin
            background <= 12'h007;
            waveform <= 12'hF00;
            axes <= 12'hAA0;
            grid <= 12'h550;
            ticks <= 12'h444;
        end
        
        5: begin
            background <= 12'h550;
            waveform <= 12'h888;
            axes <= 12'h00F;
            grid <= 12'h00A;
            ticks <= 12'h3B6;
        end
    endcase
        
    end
endmodule