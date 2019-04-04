`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.04.2019 22:50:19
// Design Name: 
// Module Name: Mouse_Controller
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


module Mouse_Controller(
    input clk,
    inout mouseClk,
    inout mouseData,
    output [11:0] mouseXPos,
    output [11:0] mouseYPos,
    output left,
    output middle,
    output right
    );
    
    MouseCtl mc(.clk(clk), .xpos(mouseXPos), .ypos(mouseYPos), .left(left), .middle(middle), .right(right), .ps2_clk(mouseClk), .ps2_data(mouseData));
    
    
endmodule
