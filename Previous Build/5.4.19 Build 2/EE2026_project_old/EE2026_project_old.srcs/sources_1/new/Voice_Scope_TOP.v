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
    
    inout mouseData,
    inout mouseClk,
    
    output JA1,
    output JA4,
    output [11:0] LED,
    output LOCKLED,
    output [3:0] vgaRed,
    output [3:0] vgaGreen,
    output [3:0] vgaBlue,
    output Hsync,
    output Vsync,
    output [7:0] SEG,
    output [3:0] AN
    );
    
    wire clk_wire, clk_30Hz;
    wire [11:0] wave_sample_raw;
    wire [9:0] wave_sample;
    
    clk_div my_clk(CLOCK, clk_wire);
    clk_30hz clk_30(CLOCK, clk_30Hz);
    Voice_Capturer vc(CLOCK, clk_wire, JA3, JA1, JA4, wave_sample_raw);
    
    //Volume Indicator via LED / 7SEG
    wire [5:0] SEG_VOL0;
    wire [5:0] SEG_VOL1;
    
    //freq sampler
    wire [13:0] freq;
    wire [13:0] freq100Hz;
    wire [3:0] freq0; //freq SEG display
    wire [3:0] freq1;
    wire [3:0] freq2;
    wire [3:0] freq3;
    
    wire [9:0] freq_sample;
    assign freq_sample = (freq100Hz / 10); //reduced value to feed into memory for waveforms
    
    Freq_Counter fc(CLOCK, clk_wire, wave_sample_raw, freq, freq100Hz, freq0, freq1, freq2, freq3);
    
    wire [5:0] SPERCENT0;
    wire [5:0] SPERCENT1;
    wire [5:0] SPERCENT2;
    
    Sound_Lvl_Converter sound_converter(CLOCK, wave_sample_raw, freq, LED, SEG_VOL0, SEG_VOL1, SPERCENT0, SPERCENT1, SPERCENT2);
    
    //mouse
    wire [11:0] mouseXPos;
    wire [11:0] mouseYPos;
    wire mouseLeft;
    wire mouseMiddle;
    wire mouseRight;
    
    Mouse_Controller mc(CLOCK, mouseClk, mouseData, mouseXPos, mouseYPos, mouseLeft, mouseMiddle, mouseRight);
    
    //mode selector
    wire [5:0] MODE;
    wire [2:0] WAVEMODE;
    wire [2:0] CLRSTATE;
    wire [2:0] WAVEFORMSTATE;
    wire [2:0] HISTSTATE;
    wire [2:0] CIRCLESTATE;
    
    wire LOCK; //waveform lock status (via 7SEG)
    assign LOCKLED = LOCK || SW15;
    
    Mode_Selector mode_s(CLOCK, clk_wire, clk_30Hz, wave_sample_raw, 
    btnC, btnU, btnD, btnL, btnR, 
    SEG_VOL0, SEG_VOL1, freq0, freq1, freq2, freq3, SPERCENT0, SPERCENT1, SPERCENT2,  
    mouseLeft, mouseXPos, mouseYPos,
    SEG, AN, MODE, WAVEMODE, CLRSTATE, WAVEFORMSTATE, HISTSTATE, CIRCLESTATE, LOCK);
    
    assign wave_sample = wave_sample_raw >> 2;
    
    wire [11:0] VGA_HORZ_COORD;
    wire [11:0] VGA_VERT_COORD;
    
    //color selector wire
    wire [11:0] background;
    wire [11:0] waveform;
    wire [11:0] axes;
    wire [11:0] grid;
    wire [11:0] ticks;
    
    //if clk_wire does not work, default back to 30Hz clock
    Colour_Selector cs(clk_wire, CLRSTATE, background, waveform, axes, grid, ticks);
   
    //VGA Waveforms
    wire [3:0] VGA_Red_waveform; //overall waveform
    wire [3:0] VGA_Green_waveform;
    wire [3:0] VGA_Blue_waveform;   
    
    wire [3:0] VGA_Red_wave; //waveform mode
    wire [3:0] VGA_Green_wave;
    wire [3:0] VGA_Blue_wave;   
    
    wire [3:0] VGA_Red_hist; //waveform history mode
    wire [3:0] VGA_Green_hist;
    wire [3:0] VGA_Blue_hist;   
    
    wire [3:0] VGA_Red_circle; //circle waveform mode
    wire [3:0] VGA_Green_circle;
    wire [3:0] VGA_Blue_circle;
    
    wire CLK_VGA;
    wire [5:0] circleCounter;
    
    //Waveform modules
    Draw_Waveform_Mode wave(clk_wire, SW0, SW15, LOCK, MODE, WAVEMODE, WAVEFORMSTATE, HISTSTATE, CIRCLESTATE, wave_sample, freq_sample, VGA_HORZ_COORD, VGA_VERT_COORD, waveform, VGA_Red_wave, VGA_Green_wave, VGA_Blue_wave);
    Draw_Waveform_History wave_h(clk_wire, SW0, SW15, LOCK, MODE, WAVEMODE, WAVEFORMSTATE, HISTSTATE, CIRCLESTATE, wave_sample, freq_sample, VGA_HORZ_COORD, VGA_VERT_COORD, waveform, VGA_Red_hist, VGA_Green_hist, VGA_Blue_hist);
    Draw_Waveform_Circle wave_c(clk_wire, SW0, SW15, LOCK, MODE, WAVEMODE, WAVEFORMSTATE, HISTSTATE, CIRCLESTATE, wave_sample, freq_sample, VGA_HORZ_COORD, VGA_VERT_COORD, waveform, VGA_Red_circle, VGA_Green_circle, VGA_Blue_circle, circleCounter);
        
    //Waveform selection logic
    assign VGA_Red_waveform = (WAVEMODE == 1 ? VGA_Red_wave : (WAVEMODE == 2 ? VGA_Red_hist : VGA_Red_circle));
    assign VGA_Green_waveform = (WAVEMODE == 1 ? VGA_Green_wave : (WAVEMODE == 2 ? VGA_Green_hist : VGA_Green_circle));
    assign VGA_Blue_waveform = (WAVEMODE == 1 ? VGA_Blue_wave : (WAVEMODE == 2 ? VGA_Blue_hist : VGA_Blue_circle));
    
    //VGA Background Grid 
    wire [3:0] VGA_Red_grid;
    wire [3:0] VGA_Green_grid;
    wire [3:0] VGA_Blue_grid;
        
    Draw_Background dbg(CLOCK, VGA_HORZ_COORD, VGA_VERT_COORD, mouseXPos, mouseYPos, mouseLeft, CLRSTATE, WAVEMODE, circleCounter, background, axes, grid, ticks, VGA_Red_grid, VGA_Green_grid, VGA_Blue_grid);   
           
    //VGA Display
    VGA_DISPLAY vga(CLOCK, VGA_Red_waveform, VGA_Green_waveform, VGA_Blue_waveform, VGA_Red_grid, VGA_Green_grid, VGA_Blue_grid,
    VGA_HORZ_COORD, VGA_VERT_COORD, vgaRed, vgaGreen, vgaBlue, Vsync, Hsync, CLK_VGA);
    
endmodule
