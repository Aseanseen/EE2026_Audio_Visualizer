`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.03.2019 07:25:49
// Design Name: 
// Module Name: colour_selector
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


module colour_selector(
    input slow_clk,
    input btnC,
    
    output reg [11:0] background,
    output reg [11:0] waveform,
    output reg [11:0] axes,
    output reg [11:0] grid,
    output reg [11:0] ticks
    );
    wire output1;
    wire output2;
    wire single_pulse;
    
    reg [2:0] state;
    
    dff dff1(slow_clk, btnC, output1);
    dff dff2(slow_clk, output1, output2);
    assign single_pulse = output1 && ~output2;
    
    always @ (posedge slow_clk)
    begin
        state <= single_pulse ? (state >= 4) ? 0 : (state + 1) : state;
        if (state == 0)
        begin
            background <= 1;
            waveform <= 12'hFFF;
            axes <= 12'h050;
            grid <= 12'h030;
            ticks <= 12'h009;
        end
        else if (state == 1)
        begin
            background <= 12'h333;
            waveform <= 12'hF00;
            axes <= 12'h050;
            grid <= 12'h00F;
            ticks <= 12'h333;
        end
        else if (state == 2)
        begin
            background <= 12'h060;
            waveform <= 12'hDDD;
            axes <= 12'h202;
            grid <= 12'h030;
            ticks <= 12'h202;
        end
        else if (state == 3)
        begin
            background <= 12'h007;
            waveform <= 12'hF00;
            axes <= 12'hAA0;
            grid <= 12'h550;
            ticks <= 12'h444;
        end
        else
        begin
            background <= 12'h770;
            waveform <= 12'h666;
            axes <= 12'h00F;
            grid <= 12'h00A;
            ticks <= 12'h3B6;
        end
        
    end
endmodule
