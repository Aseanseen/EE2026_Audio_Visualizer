`timescale 1ns / 1ps
/**
 * Mode Selector
 * Handles different mode switching via btnU and btnD
 * Changing of options is done via btnL and btnR
 */
module Mode_Selector(
    input CLOCK, clk_wire, wave_sample_raw,
    btnC, btnU, btnD, btnL, btnR, 
    [5:0] SEG_VOL0, [5:0] SEG_VOL1, 
    [3:0] FREQ0, [3:0] FREQ1,  [3:0] FREQ2, [3:0] FREQ3, 
    [5:0] SPERCENT0, [5:0] SPERCENT1, [5:0] SPERCENT2,  
    output [7:0] SEG, [3:0] AN, [4:0] MODE, [2:0] CLRSTATE);
    
    wire USTATE; //state of button up
    wire DSTATE; //state of button down
    wire LSTATE; //state of button left
    wire RSTATE; //state of button right
    
    wire [5:0] WORD0; //words to print in decoder
    wire [5:0] WORD1;
    wire [5:0] WORD2;
    wire [5:0] WORD3;
    
    reg [5:0] word0; //temp assign to word
    reg [5:0] word1;
    reg [5:0] word2;
    reg [5:0] word3;
    
    reg [4:0] mode = 5'b00010;
    reg [2:0] clrstate = 1; //state of color display options
    
    //state of parameter displays
    reg [2:0] displaystate = 1;
    reg [29:0] display1Hz = 0; //parameter menu word displays (1 sec)
    
    Button_Pulser up(CLOCK, btnU, USTATE); //single pulser for button presses
    Button_Pulser down(CLOCK, btnD, DSTATE);
    Button_Pulser left(CLOCK, btnL, LSTATE);                                      
    Button_Pulser right(CLOCK, btnR, RSTATE);
    
    SEG_Decoder seg_d(CLOCK, WORD0, WORD1, WORD2, WORD3, SEG, AN);
    
    always @ (posedge CLOCK) begin
        if (USTATE == 1 && ~btnD) begin //button press up
            mode <= (mode == 5'b10000 ? mode : mode << 1);
            //display1Hz <= display1Hz >= 400000000 ? 0 : display1Hz;
            display1Hz = 0;
        end
        
        if (DSTATE == 1 && ~btnU) begin //button press down
            mode <= (mode == 5'b00001 ? mode : mode >> 1);
            //display1Hz <= display1Hz >= 400000000 ? 0 : display1Hz;
            display1Hz = 0;
        end
        
        //color state button change
        if (LSTATE == 1 && ~btnR && mode == 5'b00100) begin //button press left
            clrstate <= (clrstate >= 5 ? clrstate : clrstate + 1);  
        end
        
        if (RSTATE == 1 && ~btnL && mode == 5'b00100) begin //button press right
            clrstate <= (clrstate == 1 ? clrstate : clrstate - 1);
        end
        
        //parameter display options
        if (LSTATE == 1 && ~btnR && mode == 5'b01000) begin //button press left
            displaystate <= (displaystate >= 5 ? displaystate : displaystate + 1);
            //display1Hz <= display1Hz >= 400000000 ? 0 : display1Hz;
            display1Hz = 0;
        end
        
        if (RSTATE == 1 && ~btnL && mode == 5'b01000) begin //button press right
            displaystate <= (displaystate == 1 ? displaystate : displaystate - 1);
            //display1Hz <= display1Hz >= 400000000 ? 0 : display1Hz;
            display1Hz = 0;
        end
        
        display1Hz <= (display1Hz >= 400000000 ? display1Hz : display1Hz + 1);
        
        if (mode == 5'b01000) begin
        case (displaystate)
            1: begin
                word0 <= (display1Hz >= 400000000 ? (FREQ0 == 0 ? 15 : FREQ0) : 15);
                word1 <= (display1Hz >= 400000000 ? FREQ1 : 27);
                word2 <= (display1Hz >= 400000000 ? FREQ2 : 14);
                word3 <= (display1Hz >= 400000000 ? FREQ3 : 26);
            end
            
            2: begin
                word0 <= (display1Hz >= 400000000 ? SPERCENT0 : 31);
                word1 <= (display1Hz >= 400000000 ? SPERCENT1 : 24);
                word2 <= (display1Hz >= 400000000 ? SPERCENT2 : 21);
                word3 <= (display1Hz >= 400000000 ? 37 : 37);
            end
            
        endcase
        
        end
        
        case (mode) 
            //LOCK
            5'b00001: begin word0 = 21; word1 = 24; word2 = 12; word3 = 20; end
            //Display sound level
            5'b00010: begin word0 = 0; word1 = 0; word2 = SEG_VOL0; word3 = SEG_VOL1; end
            //Change screen color scheme
            5'b00100: begin word0 = 12; word1 = 21; word2 = 27; word3 = clrstate; end
            //Display parameters - Freq / Vol %
            5'b01000: begin word0 = (FREQ0 == 0 ? 15 : FREQ0); word1 = FREQ1; word2 = FREQ2; word3 = FREQ3; end
                        
        endcase
    
    end
    
    assign WORD0 = word0;
    assign WORD1 = word1;
    assign WORD2 = word2;
    assign WORD3 = word3;
    
    assign MODE = mode;
    assign CLRSTATE = clrstate;
    
endmodule
