`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.04.2019 22:38:58
// Design Name: 
// Module Name: draw_mao
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


module Draw_Mao(
    input enabled,
    input [8:0] currentX,
    input [8:0] currentY,
    input [8:0] startX,
    input [8:0] startY,
    output black,
    output grey,
    output white,
    output red,
    output pink,
    output yellow
    );
    
    wire [8:0] thisX = currentX - startX;
    wire [8:0] thisY = currentY - startY;
    
    assign black = 
    //check for boundaries and enabled
    (currentY >= startY && currentY < startY + 20 && currentX >= startX && currentY < startY + 32 && enabled) ?
    ((thisY == 0 && thisX >= 8 && thisX <= 24) || 
    (thisY == 1 && (thisX == 7 || thisX == 25)) ||
    ((thisY >= 2 && thisY <= 4) && (thisX == 6 || thisX == 26)) ||
    (thisY == 5 && (thisX == 6 || thisX == 18 || thisX == 19 || thisX == 26 || thisX == 28 || thisX == 29)) || 
    (thisY == 6 && (thisX == 6 || thisX == 17 || thisX == 20 || thisX == 26 || thisX == 27 || thisX == 30)) ||
    (thisY == 7 && ((thisX >= 0 && thisX <= 3) || thisX == 6 || thisX == 17 || thisX == 21 || thisX == 26 || thisX == 30)) ||
    (thisY == 8 && (thisX == 0 || thisX == 3 || thisX == 4 || thisX == 6 || thisX == 17 || (thisX >= 22 && thisX <= 25) || thisX == 30)) ||
    (thisY == 9 && (thisX == 0 || thisX == 1 || thisX == 4 || thisX == 5 || thisX == 6 || thisX == 17 || thisX == 30)) ||
    (thisY == 10 && (thisX == 1 || thisX == 2 || thisX == 5 || thisX == 6 || thisX == 16 || thisX == 31)) ||
    (thisY == 11 && (thisX == 2 || thisX == 3 || thisX == 6 || thisX == 16 || thisX == 21 || thisX == 28 || thisX == 31)) ||
    (thisY == 12 && ((thisX >= 3 && thisX <= 6) || thisX == 16 || thisX == 20 || thisX == 21 || thisX == 25 || thisX == 27 || thisX == 28 || thisX == 31)) ||
    (thisY == 13 && (thisX == 5 || thisX == 6 || thisX == 16 || thisX == 31)) ||
    (thisY == 14 && (thisX == 6 || thisX == 16 || thisX == 21 || thisX == 24 || thisX == 27 || thisX == 31)) ||
    (thisY == 15 && (thisX == 6 || thisX == 17 || (thisX >= 21 && thisX <= 27) || thisX == 30)) ||
    (thisY == 16 && (thisX == 5 || thisX == 6 || thisX == 7 || thisX == 18 || thisX == 29)) ||
    (thisY == 17 && (thisX == 4 || (thisX >= 8 && thisX <= 28))) ||
    (thisY == 18 && (thisX == 4 || thisX == 7 || thisX == 8 || thisX == 10 || thisX == 13 || thisX == 19 || thisX == 22 || thisX == 24 || thisX == 27)) ||
    (thisY == 19 && ((thisX >= 4 && thisX <= 7) || thisX == 10 || thisX == 11 || thisX == 12 || thisX == 20 || thisX == 21 || thisX == 22 || thisX == 25 || thisX == 26))
    ? 1 : 0)
    : 0;
    
    
    assign grey = 
    //check for boundaries and enabled
    (currentY >= startY && currentY < startY + 200 && currentX >= startX && currentY < startY + 320 && enabled) ?
    ((thisY == 6 && (thisX == 18 || thisX == 19 || thisX == 28 || thisX == 29)) ||
    (thisY == 7 && ((thisX >= 18 && thisX <= 20) || (thisX >= 27 && thisX <= 29))) ||
    (thisY == 8 && (thisX == 1 || thisX == 2 || (thisX >= 18 && thisX <= 21) || (thisX >= 26 && thisX <= 29))) ||
    (thisY == 9 && (thisX == 2 || thisX == 3 || (thisX >= 18 && thisX <= 29))) ||
    (thisY == 10 && (thisX == 3 || thisX == 4 || (thisX >= 17 && thisX <= 30))) ||
    (thisY == 11 && (thisX == 4 || thisX == 5 || thisX == 17 || thisX == 18 || thisX == 19 || (thisX >= 22 && thisX <= 26) || thisX == 29 || thisX == 30)) ||
    (thisY == 12 && (thisX == 17 || thisX == 18 || thisX == 19 || (thisX >= 22 && thisX <= 24) || thisX == 26 || thisX == 29 || thisX == 30 )) ||
    (thisY == 13 && (thisX == 17 || (thisX >= 20 && thisX <= 28))) ||
    (thisY == 14 && (thisX == 17 || thisX == 20 || thisX == 22 || thisX == 23 || thisX == 25 || thisX == 26 || thisX == 28)) ||
    (thisY == 15 && (thisX == 18 || thisX == 19 || thisX == 20 || thisX == 28 || thisX == 29)) ||
    (thisY == 16 && (thisX >= 19 && thisX <= 28)) ||
    (thisY == 17 && (thisX == 5 || thisX == 6 || thisX == 7)) ||
    (thisY == 18 && (thisX == 5 || thisX == 6 || thisX == 11 || thisX == 12 || thisX == 20 || thisX == 21 || thisX == 25 || thisX == 26))
    ? 1 : 0)
    : 0;
    
    
    assign white = 
    //check for boundaries and enabled
    (currentY >= startY && currentY < startY + 200 && currentX >= startX && currentY < startY + 320 && enabled) ?
    (thisY == 11 && (thisX == 20 || thisX == 27)) ? 1 : 0
    : 0;
    
    
    assign red = 
    //check for boundaries and enabled
    (currentY >= startY && currentY < startY + 200 && currentX >= startX && currentY < startY + 320 && enabled) ?
    (thisY == 3 && (thisX == 15 || thisX == 18)) ||
    (thisY == 4 && (thisX == 10)) ||
    (thisY == 5 && (thisX == 21)) ||
    (thisY == 7 && (thisX == 14)) ||
    (thisY == 9 && (thisX == 11)) ||
    (thisY == 11 && (thisX == 9)) ||
    (thisY == 12 && (thisX == 14)) ||
    (thisY == 14 && (thisX == 10))
    ? 1 : 0
    : 0;
    
    
    assign pink = 
    //check for boundaries and enabled
    (currentY >= startY && currentY < startY + 200 && currentX >= startX && currentY < startY + 320 && enabled) ?
    (thisY >= 2 && thisY <= 15 && thisX >= 8 && thisX <= 24) ||
    (thisY >= 13 && thisY <= 14 && thisX >= 29 && thisX <= 30)
    ? 1 : 0
    : 0;
    
    
    assign yellow = 
    //check for boundaries and enabled
    (currentY >= startY && currentY < startY + 200 && currentX >= startX && currentY < startY + 320 && enabled) ?
    (thisY == 1 && thisX >= 8 && thisX <= 24) ||
    (thisY == 2 && (thisX == 8 || thisX == 23 || thisX == 24)) ||
    (thisY == 3 && (thisX == 8 || thisX == 24)) ||
    (thisY == 14 && (thisX == 8)) ||
    (thisY == 15 && (thisX == 8 || thisX == 9)) ||
    (thisX == 7 && thisY >= 2 && thisY <= 15) ||
    (thisY == 16 && thisX >= 8 && thisX <= 17) || 
    (thisX == 25 && (thisY >= 2 && thisY <= 7))
    ? 1 : 0
    : 0;
endmodule
