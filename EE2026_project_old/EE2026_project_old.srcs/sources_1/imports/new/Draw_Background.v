`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//-------------------------------------------------------------------------  
//                  DRAWING GRID LINES AND TICKS ON SCREEN
// Description:
// Grid lines are drawn at pixel # 320 along the x-axis, and
// pixel #768 along the y-axis

// Note the VGA controller is configured to produce a 1024 x 1280 pixel resolution
//-------------------------------------------------------------------------

//-------------------------------------------------------------------------
// TOOD:    Draw grid lines at every 80-th pixel along the horizontal axis, and every 64th pixel
//          along the vertical axis. This gives us a 16x16 grid on screen. 
//          
//          Further draw ticks on the central x and y grid lines spaced 16 and 8 pixels apart in the 
//          horizontal and vertical directions respectively. This gives us 5 sub-divisions per division 
//          in the horizontal and 8 sub-divisions per divsion in the vertical direction   
//-------------------------------------------------------------------------  
  
//////////////////////////////////////////////////////////////////////////////////


module Draw_Background(
    input [11:0] VGA_HORZ_COORD,
    input [11:0] VGA_VERT_COORD,
    
    input [11:0] background,
    input [11:0] axes,
    input [11:0] grid,
    input [11:0] ticks,
    
    output [3:0] VGA_Red_Grid,
    output [3:0] VGA_Green_Grid,
    output [3:0] VGA_Blue_Grid
    );
    
// The code below draws two grid lines. Modify the codes to draw more grid lines. 
    wire Condition_For_Axes = (VGA_HORZ_COORD == 640) ||  (VGA_VERT_COORD == 512) ;


// Using the gridline example, insert your code below to draw ticks on the x-axis and y-axis.
    wire Condition_For_Ticks = ((VGA_HORZ_COORD % 80 == 0) && (VGA_VERT_COORD > 502 && VGA_VERT_COORD < 522)) || (VGA_VERT_COORD % 64 == 0) && (VGA_HORZ_COORD > 630 && VGA_HORZ_COORD < 650);
    wire Condition_For_SmallT = ((VGA_HORZ_COORD % 20 == 0) && (VGA_VERT_COORD > 507 && VGA_VERT_COORD < 517)) || (VGA_VERT_COORD % 16 == 0) && (VGA_HORZ_COORD > 635 && VGA_HORZ_COORD < 645);
    wire Condition_For_Grid = ((VGA_HORZ_COORD % 80 == 0) && (VGA_VERT_COORD % 5 == 0) || ((VGA_VERT_COORD % 64 == 0) && (VGA_HORZ_COORD % 5 == 0)));

    
// Please modify below codes to change the background color and to display ticks defined above
    wire [3:0] bgR;
    wire [3:0] bgG;
    wire [3:0] bgB;
    
    wire [3:0] axeR;
    wire [3:0] axeG;
    wire [3:0] axeB;
    
    wire [3:0] gridR;
    wire [3:0] gridG;
    wire [3:0] gridB;
    
    wire [3:0] tickR;
    wire [3:0] tickG;
    wire [3:0] tickB;
    
    assign bgR = background >> 8;
    assign bgG = background << 4 >> 8;
    assign bgB = background << 8 >> 8;
    
    assign axeR = axes >> 8;
    assign axeG = axes << 4 >> 8;
    assign axeB = axes << 8 >> 4;
    
    assign gridR = grid >> 8;
    assign gridG = grid  << 4 >> 4;
    assign gridB = grid << 8 >> 8;
    
    assign tickR = ticks >> 8;
    assign tickG = ticks << 4 >> 8;
    assign tickB = ticks << 8 >> 8;
    
    assign VGA_Red_Grid = (Condition_For_Axes) ? axeR : (Condition_For_Ticks || Condition_For_SmallT) ? tickR : Condition_For_Grid ? gridR : bgR;
    assign VGA_Green_Grid = (Condition_For_Axes) ? axeG : (Condition_For_Ticks || Condition_For_SmallT) ? tickG : Condition_For_Grid ? gridG : bgG;
    assign VGA_Blue_Grid = (Condition_For_Axes) ? axeB : (Condition_For_Ticks || Condition_For_SmallT) ? tickB : Condition_For_Grid ? gridB : bgB;
endmodule

