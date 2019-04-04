`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.04.2019 01:24:16
// Design Name: 
// Module Name: char
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


module char(
    input clk,
    input [7:0] ascii,
    input [11:0] xStart,
    input [11:0] yStart,
    input [11:0] xCur,
    input [11:0] yCur,
    output pixel
    );
    
    wire char;
    pc_vga_8x16 c(clk, xCur - xStart, yCur - yStart, ascii, char);
    
    wire inBound = (xCur >= xStart && xCur < xStart + 8) && (yCur >= yStart && yCur < yStart + 16);
    
    assign pixel = char && inBound;
endmodule
