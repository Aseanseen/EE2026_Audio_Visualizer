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
    
    input [11:0] VGA_HORZ_COORD,
    input [11:0] VGA_VERT_COORD,
    input [11:0] colour,
    
    output [3:0] VGA_Red_waveform,
    output [3:0] VGA_Green_waveform,
    output [3:0] VGA_Blue_waveform
    );
    
    reg [9:0] memory [7:0];
    reg [9:0] i = 0;
    
    reg [20:0] radius = 0;
    reg [20:0] val;
    reg [20:0] prev;
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
        
        val <= (wave_sample > 512 ? wave_sample - 512 : 512 - wave_sample);
        cur <= (val > cur ? val : cur);
        
        if (circlestate == 1 && SW15 == 0 && LOCK == 0 && counter == 0) begin
            memory[i] <= (cur > 300 ? 300 : cur);
            i <= (i > 7 ? 0 : i + 1);
            //radius <= (val > prev) ? (radius > 200 ? radius : radius + 1) : (radius == 0 ? radius : radius - 1);
            prev <= val;
            cur <= 0;
        end
        
        if (circlestate == 2 && SW15 == 0 && LOCK == 0 && counter == 0) begin
            memory[i] <= (cur > 300 ? 300 : cur);
            i <= (i > 7 ? 0 : i + 1);
            //radius <= (val > prev) ? (radius > 200 ? radius : radius + 1) : (radius == 0 ? radius : radius - 1);
            prev <= val;
            cur <= 0;
        end
        
        /*i <= (i >= 359 ? 0 : i + 1);
        Sample_memory[i] <= prev;
        prev <= wave_sample;*/
    
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
    (((VGA_HORZ_COORD - 639) * (VGA_HORZ_COORD - 639) + (VGA_VERT_COORD - 511) * (VGA_VERT_COORD - 511)) >= (300) &&
    ((VGA_HORZ_COORD - 639) * (VGA_HORZ_COORD - 639) + (VGA_VERT_COORD - 511) * (VGA_VERT_COORD - 511)) <= (305)) 
    ) ? 8 : 0;
    
    assign VGA_Blue_waveform = (
    (((VGA_HORZ_COORD - 639) * (VGA_HORZ_COORD - 639) + (VGA_VERT_COORD - 511) * (VGA_VERT_COORD - 511)) >= (300) &&
    ((VGA_HORZ_COORD - 639) * (VGA_HORZ_COORD - 639) + (VGA_VERT_COORD - 511) * (VGA_VERT_COORD - 511)) <= (305)) &&
    ((i == 0 && arc0) || (i == 1 && arc1) || (i == 2 && arc2) || (i == 3 && arc3) || (i == 4 && arc4) || (i == 5 && arc5) || (i == 6 && arc6) || (i == 7 && arc7))
    ) ? 14 : 0;
    
    
    //code for the original circle waveform
    //assign VGA_Red_waveform   = (((VGA_HORZ_COORD - 639) * (VGA_HORZ_COORD - 639) + (VGA_VERT_COORD - 511) * (VGA_VERT_COORD - 511)) <= (radius * radius)) ? red : 0;
    //assign VGA_Green_waveform = (((VGA_HORZ_COORD - 639) * (VGA_HORZ_COORD - 639) + (VGA_VERT_COORD - 511) * (VGA_VERT_COORD - 511)) <= (radius * radius)) ? green : 0;
    //assign VGA_Blue_waveform  = (((VGA_HORZ_COORD - 639) * (VGA_HORZ_COORD - 639) + (VGA_VERT_COORD - 511) * (VGA_VERT_COORD - 511)) <= (radius * radius)) ? blue : 0;
    
    
        
    
endmodule
