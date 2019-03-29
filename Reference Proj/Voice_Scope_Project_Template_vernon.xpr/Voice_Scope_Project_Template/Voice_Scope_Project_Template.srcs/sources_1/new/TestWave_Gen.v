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
    input clock,
    output reg [11:0] ramp_sample = 0   // 10 or 12 bits?
    );
    
    always @ (posedge clock) begin
        ramp_sample <= (ramp_sample == 639) ? 0 : (ramp_sample + 1);
    end
endmodule