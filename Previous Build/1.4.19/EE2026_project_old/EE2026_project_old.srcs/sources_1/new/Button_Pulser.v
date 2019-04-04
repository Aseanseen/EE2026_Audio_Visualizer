`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.03.2019 15:59:54
// Design Name: 
// Module Name: Button_Pulser
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


module Button_Pulser(input CLOCK, BTN, output STATE);
    wire Q1;
    wire Q2;
    wire pushButton;
    wire Q;
    
    posE_dff dff1(CLOCK, BTN, Q1);
    posE_dff dff2(CLOCK, Q1, Q2);
    
    assign STATE = Q1 & ~Q2; //set

endmodule