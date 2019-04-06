`timescale 1ns / 1ps
/**
 * Circle Waveform Visualisation
 * Generates a circle waveform of 8 arcs
 */

module Draw_Waveform_Circle(
    input clk_sample, //20kHz clock
    input SW0, SW15,
    input LOCK,
    input [5:0] mode,
    input [2:0] wavemode,
    input [2:0] waveformstate,
    input [2:0] histstate,
    input [2:0] circlestate,
    
    input [9:0] wave_sample,
    input [9:0] freq_sample,
    
    input [11:0] VGA_HORZ_COORD,
    input [11:0] VGA_VERT_COORD,
    input [11:0] colour,
    
    output [3:0] VGA_Red_waveform,
    output [3:0] VGA_Green_waveform,
    output [3:0] VGA_Blue_waveform,
    
    output reg [5:0] CIRCLECOUNTER
    );
    
    reg [9:0] memory [7:0];
    reg [5:0] i = 0;
    
    reg [20:0] radius = 0;
    reg [20:0] val;
    reg [20:0] prev = 70;
    reg [20:0] cur;
    reg [9:0] counter = 1;
    
    //split circle into 8 parts (clockwise, 0 starts from 12 o'clock)
    wire arc0 = ((VGA_HORZ_COORD + VGA_VERT_COORD) < 1149) && (VGA_HORZ_COORD > 639);
    wire arc1 = ((VGA_HORZ_COORD + VGA_VERT_COORD) > 1149) && (VGA_VERT_COORD < 511);
    wire arc2 = (VGA_HORZ_COORD < (128 + VGA_VERT_COORD)) && (VGA_HORZ_COORD > 639);
    wire arc3 = (VGA_HORZ_COORD > (128 + VGA_VERT_COORD)) && (VGA_VERT_COORD > 511);
    wire arc4 = ((VGA_HORZ_COORD + VGA_VERT_COORD) > 1149) && (VGA_HORZ_COORD < 639);
    wire arc5 = ((VGA_HORZ_COORD + VGA_VERT_COORD) < 1149) && (VGA_VERT_COORD > 511);
    wire arc6 = (VGA_HORZ_COORD < (128 + VGA_VERT_COORD)) && (VGA_VERT_COORD < 511);
    wire arc7 = (VGA_HORZ_COORD > (128 + VGA_VERT_COORD)) && (VGA_HORZ_COORD < 639);
    
    always @ (posedge clk_sample) begin
        counter <= (counter >= 1249 ? 0 : counter + 1); //2Hz overall freq
        
        
        val <= (circlestate <= 2 ? 
        (wave_sample > 512 ? wave_sample - 512 : 512 - wave_sample) : 
        (freq_sample / 3) ); //get absolute diff
        cur <= (val > cur ? val : cur); //get current peak
        
        //volume circle waveform
        if (circlestate == 1 && SW15 == 0 && LOCK == 0 && counter == 0) begin
            memory[i] <= (cur > 500 ? 350 : (cur * 2) / 3);
            i <= (i > 7 ? 0 : i + 1);
            cur <= 0;
        end
        
        //volume circle waveform w. slow falloff
        if (circlestate == 2 && SW15 == 0 && LOCK == 0 && counter == 0) begin
            cur <= (cur * 2) / 3; //current val of peak.
            prev <= (cur > prev ? cur : (prev <= 35 ? 0 : prev - 35));
            //prev <= (cur > prev ? (cur > 350 ? 350 : cur) : (prev <= 40 ? 35 : prev - 35));
            
            memory[i] <= prev + 10;
            i <= (i > 7 ? 0 : i + 1);
            cur <= 0;
        end
        
        //freq circle waveform
        if (circlestate == 3 && SW15 == 0 && LOCK == 0 && counter == 0) begin
            memory[i] <= (cur > 350 ? 350 : cur);
            i <= (i > 7 ? 0 : i + 1);
            cur <= 0;
        end
        
        //freq circle waveform w. slow falloff
        if (circlestate == 4 && SW15 == 0 && LOCK == 0 && counter == 0) begin
            prev <= (cur + 50 > prev ? cur : (prev <= 35 ? 0 : prev - 35));
            //prev <= (cur > prev ? (cur > 350 ? 350 : cur) : (prev <= 40 ? 35 : prev - 35));
            memory[i] <= prev + 10;
            i <= (i > 7 ? 0 : i + 1);
            cur <= 0;
        end
        
        CIRCLECOUNTER <= i; //assign which arc is being colored
        
    end
    
    wire [3:0] red;
    wire [3:0] green;
    wire [3:0] blue;
    
    assign red = colour >> 8;
    assign green = colour << 4 >> 8;
    assign blue = colour << 8 >> 8;
    
    //draw all arcs and include a reference circle of 5 units
    assign VGA_Red_waveform = (
    (arc0 && ((VGA_HORZ_COORD - 639) * (VGA_HORZ_COORD - 639) + (VGA_VERT_COORD - 511) * (VGA_VERT_COORD - 511)) <= (memory[0] * memory[0])) ||
    (arc1 && ((VGA_HORZ_COORD - 639) * (VGA_HORZ_COORD - 639) + (VGA_VERT_COORD - 511) * (VGA_VERT_COORD - 511)) <= (memory[1] * memory[1])) ||
    (arc2 && ((VGA_HORZ_COORD - 639) * (VGA_HORZ_COORD - 639) + (VGA_VERT_COORD - 511) * (VGA_VERT_COORD - 511)) <= (memory[2] * memory[2])) || 
    (arc3 && ((VGA_HORZ_COORD - 639) * (VGA_HORZ_COORD - 639) + (VGA_VERT_COORD - 511) * (VGA_VERT_COORD - 511)) <= (memory[3] * memory[3])) ||
    (arc4 && ((VGA_HORZ_COORD - 639) * (VGA_HORZ_COORD - 639) + (VGA_VERT_COORD - 511) * (VGA_VERT_COORD - 511)) <= (memory[4] * memory[4])) ||
    (arc5 && ((VGA_HORZ_COORD - 639) * (VGA_HORZ_COORD - 639) + (VGA_VERT_COORD - 511) * (VGA_VERT_COORD - 511)) <= (memory[5] * memory[5])) ||
    (arc6 && ((VGA_HORZ_COORD - 639) * (VGA_HORZ_COORD - 639) + (VGA_VERT_COORD - 511) * (VGA_VERT_COORD - 511)) <= (memory[6] * memory[6])) ||
    (arc7 && ((VGA_HORZ_COORD - 639) * (VGA_HORZ_COORD - 639) + (VGA_VERT_COORD - 511) * (VGA_VERT_COORD - 511)) <= (memory[7] * memory[7]))
    ) ? red : 0;
    
    assign VGA_Green_waveform = (
    (arc0 && ((VGA_HORZ_COORD - 639) * (VGA_HORZ_COORD - 639) + (VGA_VERT_COORD - 511) * (VGA_VERT_COORD - 511)) <= (memory[0] * memory[0])) ||
    (arc1 && ((VGA_HORZ_COORD - 639) * (VGA_HORZ_COORD - 639) + (VGA_VERT_COORD - 511) * (VGA_VERT_COORD - 511)) <= (memory[1] * memory[1])) ||
    (arc2 && ((VGA_HORZ_COORD - 639) * (VGA_HORZ_COORD - 639) + (VGA_VERT_COORD - 511) * (VGA_VERT_COORD - 511)) <= (memory[2] * memory[2])) || 
    (arc3 && ((VGA_HORZ_COORD - 639) * (VGA_HORZ_COORD - 639) + (VGA_VERT_COORD - 511) * (VGA_VERT_COORD - 511)) <= (memory[3] * memory[3])) ||
    (arc4 && ((VGA_HORZ_COORD - 639) * (VGA_HORZ_COORD - 639) + (VGA_VERT_COORD - 511) * (VGA_VERT_COORD - 511)) <= (memory[4] * memory[4])) ||
    (arc5 && ((VGA_HORZ_COORD - 639) * (VGA_HORZ_COORD - 639) + (VGA_VERT_COORD - 511) * (VGA_VERT_COORD - 511)) <= (memory[5] * memory[5])) ||
    (arc6 && ((VGA_HORZ_COORD - 639) * (VGA_HORZ_COORD - 639) + (VGA_VERT_COORD - 511) * (VGA_VERT_COORD - 511)) <= (memory[6] * memory[6])) ||
    (arc7 && ((VGA_HORZ_COORD - 639) * (VGA_HORZ_COORD - 639) + (VGA_VERT_COORD - 511) * (VGA_VERT_COORD - 511)) <= (memory[7] * memory[7]))
    ) ? green : 0;
    
    assign VGA_Blue_waveform = (
    (arc0 && ((VGA_HORZ_COORD - 639) * (VGA_HORZ_COORD - 639) + (VGA_VERT_COORD - 511) * (VGA_VERT_COORD - 511)) <= (memory[0] * memory[0])) ||
    (arc1 && ((VGA_HORZ_COORD - 639) * (VGA_HORZ_COORD - 639) + (VGA_VERT_COORD - 511) * (VGA_VERT_COORD - 511)) <= (memory[1] * memory[1])) ||
    (arc2 && ((VGA_HORZ_COORD - 639) * (VGA_HORZ_COORD - 639) + (VGA_VERT_COORD - 511) * (VGA_VERT_COORD - 511)) <= (memory[2] * memory[2])) || 
    (arc3 && ((VGA_HORZ_COORD - 639) * (VGA_HORZ_COORD - 639) + (VGA_VERT_COORD - 511) * (VGA_VERT_COORD - 511)) <= (memory[3] * memory[3])) ||
    (arc4 && ((VGA_HORZ_COORD - 639) * (VGA_HORZ_COORD - 639) + (VGA_VERT_COORD - 511) * (VGA_VERT_COORD - 511)) <= (memory[4] * memory[4])) ||
    (arc5 && ((VGA_HORZ_COORD - 639) * (VGA_HORZ_COORD - 639) + (VGA_VERT_COORD - 511) * (VGA_VERT_COORD - 511)) <= (memory[5] * memory[5])) ||
    (arc6 && ((VGA_HORZ_COORD - 639) * (VGA_HORZ_COORD - 639) + (VGA_VERT_COORD - 511) * (VGA_VERT_COORD - 511)) <= (memory[6] * memory[6])) ||
    (arc7 && ((VGA_HORZ_COORD - 639) * (VGA_HORZ_COORD - 639) + (VGA_VERT_COORD - 511) * (VGA_VERT_COORD - 511)) <= (memory[7] * memory[7]))
    ) ? blue : 0;
    
    
endmodule
