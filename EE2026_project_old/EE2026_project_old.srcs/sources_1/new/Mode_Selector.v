`timescale 1ns / 1ps
/**
 * Mode Selector
 * Handles different mode switching via btnU and btnD
 * Changing of options is done via btnL and btnR
 */
module Mode_Selector(
    input CLOCK, btnC, btnU, btnD, btnL, btnR, 
    [5:0] SEG_VOL0, [5:0] SEG_VOL1, 
    [3:0] FREQ0, [3:0] FREQ1,  [3:0] FREQ2, [3:0] FREQ3, 
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
    
    Button_Pulser up(CLOCK, btnU, USTATE); //single pulser for button presses
    Button_Pulser down(CLOCK, btnD, DSTATE);
    Button_Pulser left(CLOCK, btnL, LSTATE);                                      
    Button_Pulser right(CLOCK, btnR, RSTATE);
    
    SEG_Decoder seg_d(CLOCK, WORD0, WORD1, WORD2, WORD3, SEG, AN);
    
    always @ (posedge CLOCK) begin
        if (USTATE == 1 && ~btnD) begin //button press up
            mode <= (mode == 5'b10000 ? mode : mode << 1);
        end
        
        if (DSTATE == 1 && ~btnU) begin //button press down
            mode <= (mode == 5'b00001 ? mode : mode >> 1);
        end
        
        //color state button change
        if (LSTATE == 1 && ~btnR && mode == 5'b00100) begin //button press left
            clrstate <= (clrstate >= 5 ? clrstate : clrstate + 1);  
        end
        
        
        if (RSTATE == 1 && ~btnL && mode == 5'b00100) begin //button press right
            clrstate <= (clrstate == 1 ? clrstate : clrstate - 1);
        end
    
        case (mode) 
            //LOCK
            5'b00001: begin word0 = 21; word1 = 24; word2 = 12; word3 = 20; end
            //Display sound level
            5'b00010: begin word0 = 0; word1 = 0; word2 = SEG_VOL0; word3 = SEG_VOL1; end
            //Change screen color scheme
            5'b00100: begin word0 = 12; word1 = 21; word2 = 27; word3 = clrstate; end
            //Display freq level
            5'b01000: begin word0 = (FREQ0 == 0 ? 15 : FREQ0) ; word1 = FREQ1; word2 = FREQ2; word3 = FREQ3; end
        endcase
    
    end
    
    assign WORD0 = word0;
    assign WORD1 = word1;
    assign WORD2 = word2;
    assign WORD3 = word3;
    
    assign MODE = mode;
    assign CLRSTATE = clrstate;
    
endmodule
