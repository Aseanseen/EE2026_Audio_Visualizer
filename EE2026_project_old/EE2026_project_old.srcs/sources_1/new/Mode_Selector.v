`timescale 1ns / 1ps
/**
 * Mode Selector
 * Handles different mode switching via btnU and btnD
 * Changing of options is done via btnL and btnR
 */
module Mode_Selector(
    input CLOCK, clk_wire, clk_30Hz, wave_sample_raw,
    btnC, btnU, btnD, btnL, btnR, 
    [5:0] SEG_VOL0, [5:0] SEG_VOL1, 
    [3:0] FREQ0, [3:0] FREQ1,  [3:0] FREQ2, [3:0] FREQ3, 
    [5:0] SPERCENT0, [5:0] SPERCENT1, [5:0] SPERCENT2,
    MOUSELEFT, [11:0] MOUSEX, [11:0] MOUSEY,
    output [7:0] SEG, [3:0] AN, [5:0] MODE, [2:0] WAVEMODE, 
    [2:0] CLRSTATE, [2:0] WAVEFORMSTATE, [2:0] HISTSTATE, [2:0] CIRCLESTATE, 
    LOCK);
    
    wire USTATE; //state of button up
    wire DSTATE; //state of button down
    wire LSTATE; //state of button left
    wire RSTATE; //state of button right
    wire CSTATE; //state of button center
    
    reg lock = 0; //locking reg
    reg [5:0] option = 1; //num in option selector
    
    wire [5:0] WORD0; //words to print in decoder
    wire [5:0] WORD1;
    wire [5:0] WORD2;
    wire [5:0] WORD3;
    
    reg [5:0] word0; //temp assign to word
    reg [5:0] word1;
    reg [5:0] word2;
    reg [5:0] word3;
    
    reg [5:0] mode = 1;
    reg [2:0] clrstate = 1; //state of color display options
    reg [2:0] clrprev = 1;
    
    //state of parameter displays
    reg [2:0] displaystate = 1;
    reg [29:0] display1Hz = 0; //parameter menu word displays (1 sec)
    
    //which waveform to display
    reg [2:0] wavemode = 1;
    reg [2:0] wavemodeprev = 1;
    
    //state of waveform display
    reg [2:0] waveformstate = 1;
    reg [2:0] waveformprev = 1;
    
    //state of waveform history display
    reg [2:0] histstate = 1;
    reg [2:0] histprev = 1;
    
    //state of circle waveform display
    reg [2:0] circlestate = 1;
    reg [2:0] circleprev = 1;
    
    //mouse last state
    reg mouseLastState = 0;
    
    Button_Pulser up(clk_30Hz, btnU, USTATE); //single pulser for button presses
    Button_Pulser down(clk_30Hz, btnD, DSTATE);
    Button_Pulser left(clk_30Hz, btnL, LSTATE);                                      
    Button_Pulser right(clk_30Hz, btnR, RSTATE);
    Button_Pulser ctr(clk_30Hz, btnC, CSTATE);
    
    SEG_Decoder seg_d(CLOCK, WORD0, WORD1, WORD2, WORD3, SEG, AN);
    
    always @ (posedge clk_30Hz) begin
        if (MOUSELEFT && ~mouseLastState) begin
            if (MOUSEX >= 1184 && MOUSEX < 1265 && MOUSEY >= 868 && MOUSEY < 894) begin
                clrstate <= 1;
            end
            else if (MOUSEX >= 1184 && MOUSEX < 1265 && MOUSEY >= 898 && MOUSEY < 924) begin
                clrstate <= 2;
            end
            else if (MOUSEX >= 1184 && MOUSEX < 1265 && MOUSEY >= 928 && MOUSEY < 954) begin
                clrstate <= 3;
            end
            else if (MOUSEX >= 1184 && MOUSEX < 1265 && MOUSEY >= 958 && MOUSEY < 984) begin
                clrstate <= 4;
            end
            else if (MOUSEX >= 1184 && MOUSEX < 1265 && MOUSEY >= 988 && MOUSEY < 1014) begin
                clrstate <= 5;
            end
        end
        
        //mode changing logic
        if (USTATE == 1 && ~btnD) begin //button press up
            mode <= (mode >= 6 ? mode : mode + 1);
            display1Hz = 0;
            
            //change back to original settings
            clrstate <= clrprev;
            waveformstate <= waveformprev;
            histstate <= histprev;
            circlestate <= circleprev;
        end
        
        if (DSTATE == 1 && ~btnU) begin //button press down
            mode <= (mode == 0 ? mode : mode - 1);
            display1Hz = 0;
            
            //change back to original settings
            clrstate <= clrprev;
            waveformstate <= waveformprev;
            histstate <= histprev;
            circlestate <= circleprev;
        end
        
        //lock waveform mode
        if (mode == 0) begin //set logic when btnC is pressed
            wavemode <= wavemodeprev;
            if (CSTATE == 1) begin
                lock <= ~lock;
                mode <= 1; //switch back to base mode
            end
        end
        
        if (mode == 1) begin
            clrstate <= clrprev;
            wavemode <= wavemodeprev;
            waveformstate <= waveformprev;
            histstate <= histprev;
            circlestate <= circleprev;
        end
        
        //parameter display mode
        if (LSTATE == 1 && ~btnR && mode == 2) begin //button press left
            displaystate <= (displaystate >= 2 ? displaystate : displaystate + 1);
            display1Hz = 0;
        end
        
        if (RSTATE == 1 && ~btnL && mode == 2) begin //button press right
            displaystate <= (displaystate == 1 ? displaystate : displaystate - 1);
            display1Hz = 0;
        end
        
        if (mode == 2) begin
            clrstate <= clrprev;
            wavemode <= wavemodeprev;
            waveformstate <= waveformprev;
            histstate <= histprev;
            circlestate <= circleprev;
        end
        
        //parameter display counter, shows FREQ / VOL at the start
        display1Hz <= (display1Hz >= 61 ? display1Hz : display1Hz + 1);
        
        //color state mode
        if (LSTATE == 1 && ~btnR && mode == 3) begin //button press left
            option <= (option >= 5 ? option : option + 1);  
        end
        
        if (RSTATE == 1 && ~btnL && mode == 3) begin //button press right
            option <= (option == 1 ? option : option - 1);
        end
        
        if (mode == 3) begin //set logic when btnC is pressed
            clrstate <= option;
            wavemode <= wavemodeprev;
            waveformstate <= waveformprev;
            histstate <= histprev;
            circlestate <= circleprev;
            
            if (CSTATE == 1) begin
                clrstate <= option;
                clrprev <= option;
                option <= 1;
                mode <= 1;
            end
        end
        
        //waveform mode
        if (LSTATE == 1 && ~btnR && mode == 4) begin //button press left
            option <= (option >= 5 ? option : option + 1);
            display1Hz = 0;
        end
        
        if (RSTATE == 1 && ~btnL && mode == 4) begin //button press right
            option <= (option == 1 ? option : option - 1);
            display1Hz = 0;
        end
        
        if (mode == 4) begin //set logic when btnC is pressed
            waveformstate <= option;
            wavemode <= 1;
            clrstate <= clrprev;
            histstate <= histprev;
            circlestate <= circleprev;
            
            if (CSTATE == 1) begin
                wavemode <= 1;
                wavemodeprev <= 1;
                waveformstate <= option;
                waveformprev <= option;
                option <= 1;
                mode <= 1;
            end
        end
        
        //history mode
        if (LSTATE == 1 && ~btnR && mode == 5) begin //button press left
            option <= (option >= 3 ? option : option + 1);
            display1Hz = 0;
        end
        
        if (RSTATE == 1 && ~btnL && mode == 5) begin //button press right
            option <= (option == 1 ? option : option - 1);
            display1Hz = 0;
        end
        
        if (mode == 5) begin //set logic when btnC is pressed
            wavemode <= 2;
            waveformstate <= waveformprev;
            clrstate <= clrprev;
            histstate <= option;
            circlestate <= circleprev;
            
            if (CSTATE == 1) begin
                wavemode <= 2;
                wavemodeprev <= 2;
                histstate <= option;
                histprev <= option;
                option <= 1;
                mode <= 1;
            end
        end
        
        //circle waveform mode
        if (LSTATE == 1 && ~btnR && mode == 6) begin //button press left
            option <= (option >= 4 ? option : option + 1);
            display1Hz = 0;
        end
        
        if (RSTATE == 1 && ~btnL && mode == 6) begin //button press right
            option <= (option == 1 ? option : option - 1);
            display1Hz = 0;
        end
        
        if (mode == 6) begin //set logic when btnC is pressed
            wavemode <= 3;
            circlestate <= option;
            waveformstate <= waveformprev;
            clrstate <= clrprev;
            histstate <= histprev;
            
            if (CSTATE == 1) begin
                wavemode <= 3;
                wavemodeprev <= 3;
                circlestate <= option;
                circleprev <= option;
                option <= 1;
                mode <= 1;
            end
        end
        
        
        if (mode == 2) begin
        case (displaystate)
            1: begin
                word0 <= (display1Hz >= 60 ? (FREQ0 == 0 ? 15 : FREQ0) : 15);
                word1 <= (display1Hz >= 60 ? FREQ1 : 27);
                word2 <= (display1Hz >= 60 ? FREQ2 : 14);
                word3 <= (display1Hz >= 60 ? FREQ3 : 26);
            end
            
            2: begin
                word0 <= (display1Hz >= 60 ? SPERCENT0 : 31);
                word1 <= (display1Hz >= 60 ? SPERCENT1 : 24);
                word2 <= (display1Hz >= 60 ? SPERCENT2 : 21);
                word3 <= (display1Hz >= 60 ? 37 : 37);
            end
            
        endcase
        
        end
        
        //display on 7SEG
        case (mode) 
            //LOCK
            0: begin word0 = 21; word1 = 24; word2 = 12; word3 = 20; end
            //Display sound level
            1: begin word0 = 0; word1 = 0; word2 = SEG_VOL0; word3 = SEG_VOL1; end
            //Display parameters - Freq / Vol %
            2: begin word0 = (FREQ0 == 0 ? 15 : FREQ0); word1 = FREQ1; word2 = FREQ2; word3 = FREQ3; end
            //Change screen color scheme
            3: begin word0 = 12; word1 = 21; word2 = 27; word3 = option; end
            //Waveform display mode
            4: begin word0 = 32; word1 = 10; word2 = 31; word3 = option; end
            //History display mode
            5: begin word0 = 32; word1 = 10; word2 = 31; word3 = 17; end
            //Circle display mode
            6: begin word0 = 32; word1 = 10; word2 = 31; word3 = 12; end
                        
        endcase
    
    end
    
    assign WORD0 = word0;
    assign WORD1 = word1;
    assign WORD2 = word2;
    assign WORD3 = word3;
    
    assign LOCK = lock;
    
    assign MODE = mode;
    assign CLRSTATE = clrstate;
    
    assign WAVEMODE = wavemode;
    
    assign WAVEFORMSTATE = waveformstate;
    assign HISTSTATE = histstate;
    assign CIRCLESTATE = circlestate;
    
endmodule
