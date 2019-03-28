`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/14/2019 09:47:45 AM
// Design Name: 
// Module Name: Voice_Scope_TOP
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


module Voice_Scope_TOP(
    input CLOCK,
    input SW0,
    input SW15,
    input JA3,
    input btnC,
    
    output JA1,
    output JA4,
    output [11:0] LED,
    output [3:0] vgaRed,
    output [3:0] vgaGreen,
    output [3:0] vgaBlue,
    output Hsync,
    output Vsync,
    output [7:0] SEG,
    output [3:0] AN
    );
    
    wire clk_wire;
    wire clk_wire_30hz;
    wire [11:0] wave_sample_raw;
    wire [9:0] wave_sample;
    
    clk_div my_clk(CLOCK, clk_wire);
    clk_30hz slow_clk(CLOCK, clk_wire_30hz);
    
    Voice_Capturer vc(CLOCK, clk_wire, JA3, JA1, JA4, wave_sample_raw);
    LED_display ld(CLOCK, wave_sample_raw, LED);
    assign wave_sample = wave_sample_raw >> 2;
    //assign LED = wave_sample_raw;
    
    wire [11:0] VGA_HORZ_COORD;
    wire [11:0] VGA_VERT_COORD; 
    
   wire [11:0] background;
   wire [11:0] waveform;
   wire [11:0] axes;
   wire [11:0] grid;
   wire [11:0] ticks;
    
    colour_selector cs(clk_wire_30hz, btnC, background, waveform, axes, grid, ticks);
        
    // Please instantiate the waveform drawer module below
        
    wire [3:0] VGA_Red_waveform;
    wire [3:0] VGA_Green_waveform;
    wire [3:0] VGA_Blue_waveform;
        
    Draw_Waveform dw(clk_wire, SW0, wave_sample, VGA_HORZ_COORD, VGA_VERT_COORD, waveform, VGA_Red_waveform, VGA_Green_waveform, VGA_Blue_waveform);
    
    // Please instantiate the background drawing module below   
    wire [3:0] VGA_Red_grid;
    wire [3:0] VGA_Green_grid;
    wire [3:0] VGA_Blue_grid;
        
    Draw_Background dbg(VGA_HORZ_COORD, VGA_VERT_COORD, background, axes, grid, ticks, VGA_Red_grid, VGA_Green_grid, VGA_Blue_grid);   
        
    // Please instantiate the VGA display module below     
    
    VGA_DISPLAY vga(CLOCK, VGA_Red_waveform, VGA_Green_waveform, VGA_Blue_waveform, VGA_Red_grid, VGA_Green_grid, VGA_Blue_grid,
    VGA_HORZ_COORD, VGA_VERT_COORD, vgaRed, vgaGreen, vgaBlue, Vsync, Hsync);
    
endmodule
