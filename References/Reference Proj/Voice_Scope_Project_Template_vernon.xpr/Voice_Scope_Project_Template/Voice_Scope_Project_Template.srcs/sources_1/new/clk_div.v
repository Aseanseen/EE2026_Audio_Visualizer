`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.10.2018 09:15:14
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
    input CLK,
    input [22:0] CLK_DIVIDER,
    output reg SLOW_CLK = 0
    );
    
    reg [22:0] counter = 0;
    
    always @ (posedge CLK) begin
        counter <= (counter == CLK_DIVIDER) ? 0 : (counter + 1);
        SLOW_CLK <= (counter == 0) ? ~SLOW_CLK : SLOW_CLK;
    end
endmodule