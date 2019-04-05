`timescale 1ns / 1ps
/**
 * Feature++
 * Musical Tuner (Only works for high pitch tones)
 */
module Tuner(input [13:0] freq100Hz, [5:0] mode, 
    output [5:0] WORD0, [5:0] WORD1, [5:0] WORD2, [5:0] WORD3
    );
    
    reg [5:0] word0;
    reg [5:0] word1;
    reg [5:0] word2;
    reg [5:0] word3;
    
    assign WORD0 = word0;
    assign WORD1 = word1;
    assign WORD2 = word2;
    assign WORD3 = word3;
    
endmodule
