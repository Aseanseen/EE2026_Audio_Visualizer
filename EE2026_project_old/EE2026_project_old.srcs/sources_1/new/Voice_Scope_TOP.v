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
    input btnU,
    input btnD,
    input btnL,
    input btnR,
    
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
    wire [11:0] wave_sample_raw;
    wire [9:0] wave_sample;
    
    //7SEG wires for decoder
    wire [5:0] WORD0 = 0;
    wire [5:0] WORD1 = 0;
    wire [5:0] WORD2 = 0;
    wire [5:0] WORD3 = 0;   
    
    clk_div my_clk(CLOCK, clk_wire);
    Voice_Capturer vc(CLOCK, clk_wire, JA3, JA1, JA4, wave_sample_raw);
    
    //Volume Indicator via LED / 7SEG
    wire [5:0] SEG_VOL0;
    wire [5:0] SEG_VOL1;
    
    //Sound_Lvl_Converter sound_converter(CLOCK, wave_sample_raw, LED, SEG_VOL0, SEG_VOL1);
    
    //freq sampler
    wire [11:0] freq;
    wire [3:0] freq0; //freq SEG0
    wire [3:0] freq1;
    wire [3:0] freq2;
    wire [3:0] freq3;
    
    
    Freq_Counter fc(CLOCK, clk_wire, wave_sample_raw, freq, freq0, freq1, freq2, freq3);
    //Freq_Decoder fd(clk_wire, freq, freq0, freq1, freq2, freq3);
    
    //Freq_Sampler fs(CLOCK, clk_wire, wave_sample_raw, freq);

    //SEG_Decoder seg(CLOCK, freq0, freq1, freq2, freq3, SEG, AN);
    Sound_Lvl_Converter sound_converter(CLOCK, wave_sample_raw, LED, SEG_VOL0, SEG_VOL1);
    //assign LED = freq;
    
    //mode selector
    wire [2:0] MODE;
    wire [2:0] CLRSTATE;
    
    Mode_Selector mode_s(CLOCK, btnC, btnU, btnD, btnL, btnR, SEG_VOL0, SEG_VOL1, freq0, freq1, freq2, freq3, SEG, AN, MODE, CLRSTATE);
    
    //LED_display ld(CLOCK, wave_sample_raw, LED);
    assign wave_sample = wave_sample_raw >> 2;
    
    //assign LED = wave_sample_raw;
    
    wire [11:0] VGA_HORZ_COORD;
    wire [11:0] VGA_VERT_COORD;
    
    
    //30Hz clock for switch in original color selector
    wire clk_wire_30hz;
    clk_30hz slow_clk(CLOCK, clk_wire_30hz);
    
    //color selector wire
    wire [11:0] background;
    wire [11:0] waveform;
    wire [11:0] axes;
    wire [11:0] grid;
    wire [11:0] ticks;
    
    //if clk_wire does not work, default back to 30Hz clock
    Colour_Selector cs(clk_wire, CLRSTATE, background, waveform, axes, grid, ticks);
    
    //VGA Waveform   
    wire [3:0] VGA_Red_waveform;
    wire [3:0] VGA_Green_waveform;
    wire [3:0] VGA_Blue_waveform;
        
    Draw_Waveform dw(clk_wire, SW0, wave_sample, VGA_HORZ_COORD, VGA_VERT_COORD, waveform, VGA_Red_waveform, VGA_Green_waveform, VGA_Blue_waveform);
            
    //VGA Background Grid 
    wire [3:0] VGA_Red_grid;
    wire [3:0] VGA_Green_grid;
    wire [3:0] VGA_Blue_grid;
        
    Draw_Background dbg(VGA_HORZ_COORD, VGA_VERT_COORD, background, axes, grid, ticks, VGA_Red_grid, VGA_Green_grid, VGA_Blue_grid);   
           
    //VGA Display
    VGA_DISPLAY vga(CLOCK, VGA_Red_waveform, VGA_Green_waveform, VGA_Blue_waveform, VGA_Red_grid, VGA_Green_grid, VGA_Blue_grid,
    VGA_HORZ_COORD, VGA_VERT_COORD, vgaRed, vgaGreen, vgaBlue, Vsync, Hsync);
    
endmodule
