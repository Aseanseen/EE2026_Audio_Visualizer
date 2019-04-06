`timescale 1ns / 1ps
/**
 * Draw Waveform (Mode Selectable)
 * Options:
 * 1 - Standard wave w. ramp
 * 2 - Standard wave (Filled) w. ramp
 * 3 - Block wave (Filled)
 */

module Draw_Waveform_Mode(
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
    output [3:0] VGA_Blue_waveform
    );
    
    //The memory represents the memory array used to store the voice samples.
    //There are 1280 points and each point can range from 0 to 1023. 
    reg [9:0] memory[1279:0];
    reg [10:0] i = 1; //counter for memory
    reg [9:0] ramp_count;
    
    reg [5:0] counter = 0;
    reg [9:0] prev;
    reg [9:0] maxWave;
    reg [9:0] curWave;
    
    reg [2:0] prevState;
    
    //declared parameters for block waveform
    parameter BARWIDTH = 36;
    parameter BARSPACE = 4;
    parameter BLKHT = 36;
    parameter BLKSPACE = 4;
    
    //Each wave_sample is displayed on the screen from left to right. 
    always @ (posedge clk_sample) begin
        i = i == 1279 ?  0 : i + 1;
        
        if (SW15 == 1 || LOCK == 1) begin //reset ramp count
            ramp_count <= 0;
            i <= 0;
        end
        
        if (prevState != waveformstate) begin
            ramp_count <= 0;
            i <= 0;
            prev <= 0;
            counter <= 0;
            prevState <= waveformstate;
        end
        
        if (SW15 == 0 && LOCK == 0) begin
            //filled waveform code (so that it doesn't look terrible)
            if (waveformstate == 2) begin
                counter <= (counter >= 1 ? 0 : counter + 1);
                maxWave <= (wave_sample > maxWave ? wave_sample : maxWave);
            end
            
            //bar wave specific code (gets the peak vol per interval)
            if (waveformstate == 3) begin
                counter <= (counter >= 39 ? 0 : counter + 1);
                maxWave <= (wave_sample > maxWave ? wave_sample : maxWave);
            end
            
            //block wave specific code
            if (waveformstate == 4) begin
                counter <= (counter >= 39 ? 0 : counter + 1);
                curWave <= (wave_sample > 512 ? wave_sample - 512 : 512 - wave_sample);
                maxWave <= (curWave > maxWave ? curWave : maxWave);
            end
            
            
            ramp_count = (ramp_count >= 639) ? 0 : ramp_count + 1;
            
            //determine what to assign to each block
            if (waveformstate == 1) begin
                memory[i] <= (SW0 == 1) ? prev : ramp_count;
                prev <= wave_sample;
                prevState <= 1;
            end
            
            if (waveformstate == 2) begin
                memory[i] <= prev;
                if (counter == 0) begin
                    prev <= wave_sample;
                    maxWave <= 0;
                    prevState <= 2;
                end
            end
            
            if (waveformstate == 3) begin
                memory[i] <= (prev <= 512 ? 512 : prev);
                if (counter == 0) begin
                    prev <= maxWave;
                    maxWave <= 0;
                    prevState <= 3;
                end
            end
            
            if (waveformstate == 4) begin
                memory[i] <= prev;
                if (counter == 0) begin
                    prev <= (maxWave >= 450 ? 10 : (maxWave / 50) + 1);
                    maxWave <= 0;
                    prevState <= 4;
                end
            end
            
        end
                      
    end
     
    wire [3:0] red;
    wire [3:0] green;
    wire [3:0] blue;
    
    assign red = colour >> 8;
    assign green = colour << 4 >> 8;
    assign blue = colour << 8 >> 8;
    
    assign VGA_Red_waveform = ((mode <= 4 && VGA_HORZ_COORD < 1280) && 
    ((waveformstate == 1 && VGA_VERT_COORD == (1024 - memory[VGA_HORZ_COORD]))
    
    || (waveformstate == 2 && (memory[VGA_HORZ_COORD] >= 512 ? 
    (VGA_VERT_COORD <= 512 && VGA_VERT_COORD >= (1024 - memory[VGA_HORZ_COORD])) :
    (VGA_VERT_COORD >= 512 && VGA_VERT_COORD <= (1024 - memory[VGA_HORZ_COORD])) ))
    
    || (waveformstate == 3 && VGA_VERT_COORD <= 512 && VGA_VERT_COORD >= (1024 - memory[VGA_HORZ_COORD])))) 
    
    || (waveformstate == 4 && (VGA_HORZ_COORD > 39 && VGA_HORZ_COORD < 1280 && (((VGA_HORZ_COORD / 40) + 1) * (BARWIDTH + BARSPACE) - VGA_HORZ_COORD) < 36) && 
    (VGA_VERT_COORD <= 512 && VGA_VERT_COORD >= (120 + ((10 - memory[((VGA_HORZ_COORD / 40) + 1) * (BARWIDTH + BARSPACE)]) * (BLKHT + BLKSPACE)))) && ((((VGA_VERT_COORD / 40) + 1) * (BLKHT + BLKSPACE) - VGA_VERT_COORD) < 36) )
        
    ? red : 0;
    
    assign VGA_Green_waveform = ((mode <= 4 && VGA_HORZ_COORD < 1280) && 
    ((waveformstate == 1 && VGA_VERT_COORD == (1024 - memory[VGA_HORZ_COORD]))
    
    || (waveformstate == 2 && (memory[VGA_HORZ_COORD] >= 512 ? 
    (VGA_VERT_COORD <= 512 && VGA_VERT_COORD >= (1024 - memory[VGA_HORZ_COORD])) :
    (VGA_VERT_COORD >= 512 && VGA_VERT_COORD <= (1024 - memory[VGA_HORZ_COORD])) ))
    
    || (waveformstate == 3 && VGA_VERT_COORD <= 512 && VGA_VERT_COORD >= (1024 - memory[VGA_HORZ_COORD])))) 
        
    || (waveformstate == 4 && (VGA_HORZ_COORD > 39 && VGA_HORZ_COORD < 1280 && (((VGA_HORZ_COORD / 40) + 1) * (BARWIDTH + BARSPACE) - VGA_HORZ_COORD) < 36) && 
    (VGA_VERT_COORD <= 512 && VGA_VERT_COORD >= (120 + ((10 - memory[((VGA_HORZ_COORD / 40) + 1) * (BARWIDTH + BARSPACE)]) * (BLKHT + BLKSPACE)))) && ((((VGA_VERT_COORD / 40) + 1) * (BLKHT + BLKSPACE) - VGA_VERT_COORD) < 36) )
    
    ? green : 0;
    
    assign VGA_Blue_waveform = ((mode <= 4 && VGA_HORZ_COORD < 1280) && 
    ((waveformstate == 1 && VGA_VERT_COORD == (1024 - memory[VGA_HORZ_COORD]))
    
    || (waveformstate == 2 && (memory[VGA_HORZ_COORD] >= 512 ? 
    (VGA_VERT_COORD <= 512 && VGA_VERT_COORD >= (1024 - memory[VGA_HORZ_COORD])) :
    (VGA_VERT_COORD >= 512 && VGA_VERT_COORD <= (1024 - memory[VGA_HORZ_COORD])) ))
    
    || (waveformstate == 3 && VGA_VERT_COORD <= 512 && VGA_VERT_COORD >= (1024 - memory[VGA_HORZ_COORD])))) 
        
    || (waveformstate == 4 && (VGA_HORZ_COORD > 39 && VGA_HORZ_COORD < 1280 && (((VGA_HORZ_COORD / 40) + 1) * (BARWIDTH + BARSPACE) - VGA_HORZ_COORD) < 36) && 
    (VGA_VERT_COORD <= 512 && VGA_VERT_COORD >= (120 + ((10 - memory[((VGA_HORZ_COORD / 40) + 1) * (BARWIDTH + BARSPACE)]) * (BLKHT + BLKSPACE)))) && ((((VGA_VERT_COORD / 40) + 1) * (BLKHT + BLKSPACE) - VGA_VERT_COORD) < 36) )
    
    ? blue : 0;
    
    //assign VGA_Green_waveform = ((VGA_HORZ_COORD < 1280) && (VGA_VERT_COORD <= 512 && VGA_VERT_COORD >= (1024 - memory[VGA_HORZ_COORD]))) ? green : 0;
    //assign VGA_Blue_waveform = ((VGA_HORZ_COORD < 1280) && (VGA_VERT_COORD <= 512 && VGA_VERT_COORD >= (1024 - memory[VGA_HORZ_COORD]))) ? blue : 0 ;

    
endmodule
