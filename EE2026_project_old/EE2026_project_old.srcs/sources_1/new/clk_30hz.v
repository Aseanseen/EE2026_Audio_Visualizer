`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.03.2019 07:23:05
// Design Name: 
// Module Name: clk_30hz
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

module clk_30hz(
    input clk,
    output reg clk_new
    );
    
    reg [17:0] count = 0;
    
    always @(posedge clk) begin
        clk_new <= (count >= 166666) ? ~clk_new : clk_new;
        count <= (count >= 166666) ? 0 : (count + 1);
    end
endmodule
