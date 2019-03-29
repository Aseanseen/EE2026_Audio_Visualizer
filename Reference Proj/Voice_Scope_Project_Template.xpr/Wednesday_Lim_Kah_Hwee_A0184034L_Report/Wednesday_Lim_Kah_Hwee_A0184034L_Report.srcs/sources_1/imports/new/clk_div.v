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
    output reg CLK_20K = 0
    );
    
    reg [12:0] counter = 0;
    
    always @ (posedge CLK) begin
        counter <= (counter == 2499) ? 0 : (counter + 1);
        CLK_20K <= (counter == 0) ? ~CLK_20K : CLK_20K;
    end
endmodule