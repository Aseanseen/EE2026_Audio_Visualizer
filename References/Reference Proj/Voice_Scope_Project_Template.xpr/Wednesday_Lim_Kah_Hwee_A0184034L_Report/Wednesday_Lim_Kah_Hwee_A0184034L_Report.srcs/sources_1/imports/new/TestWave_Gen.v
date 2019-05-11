`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.10.2018 09:25:02
// Design Name: 
// Module Name: TestWave_Gen
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


module TestWave_Gen(
    input CLK_20K,
    output reg [9:0] RAMP_WAVE = 0
    );
    
    always @ (posedge CLK_20K) begin
        RAMP_WAVE <= RAMP_WAVE + 1;
    end
endmodule
