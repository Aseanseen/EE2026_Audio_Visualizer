`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.04.2019 18:23:48
// Design Name: 
// Module Name: nyan_clk
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


`timescale 1ns / 1ps
/**
 * 30 Hz Clock for color selector
 */

module nyan_clk(
    input clk,
    output reg nyan
    );
    
    reg [24:0] count = 0;
    
    always @(posedge clk) begin
        nyan <= (count >= 25000000) ? ~nyan : nyan;
        count <= (count >= 25000000) ? 0 : (count + 1);
    end
endmodule
