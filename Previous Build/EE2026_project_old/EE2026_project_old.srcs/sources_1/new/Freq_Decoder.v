`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.03.2019 21:57:45
// Design Name: 
// Module Name: Freq_Decoder
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Freq_Decoder(input clk_wire, [11:0] freq, output [3:0] FREQ0, [3:0] FREQ1, [3:0] FREQ2, [3:0] FREQ3);
    reg [11:0] freq0;
    reg [11:0] freq1;
    reg [11:0] freq2;
    reg [11:0] freq3;
    
    always @ (posedge clk_wire) begin
        freq0 <= freq / 1000;
        freq1 <= (freq % 1000) / 100;
        freq2 <= (freq % 100) / 10;
        freq3 <= freq % 10;
        
        
        /*freq0 <= freq / 1000;
        freq1 <= freq / 100;
        freq2 <= freq / 10;
        freq3 <= freq;*/
        
        /*freq0 <= (freq0 > 10 ? 9 : freq0);
        freq1 <= (freq1 > 10 ? 9 : freq1);
        freq2 <= (freq2 > 10 ? 9 : freq2);
        freq3 <= (freq3 > 10 ? 9 : freq3);*/
        
    end

    assign FREQ0 = freq0;
    assign FREQ1 = freq1;
    assign FREQ2 = freq2;
    assign FREQ3 = freq3;

endmodule