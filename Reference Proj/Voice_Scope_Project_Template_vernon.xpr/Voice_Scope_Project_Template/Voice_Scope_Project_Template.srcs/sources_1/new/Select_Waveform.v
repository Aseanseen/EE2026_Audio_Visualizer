`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.10.2018 10:51:41
// Design Name: 
// Module Name: Select_Waveform
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

module Select_Waveform(
    input SW,
    input [11:0] Test_Wave,
    input [11:0] MIC_in,
    output [11:0] wave_sample
    );
    
    assign wave_sample = SW ? MIC_in : Test_Wave;
endmodule