`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/14/2019 09:39:09 AM
// Design Name: 
// Module Name: clk_div
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


module clk_div(
    input clk,
    output reg clk_new
    );
    
    reg [11:0] count = 0;
    
    always @(posedge clk) begin
        clk_new <= (count >= 2499) ? ~clk_new : clk_new;
        count <= (count >= 2499) ? 0 : (count + 1);
    end
endmodule
