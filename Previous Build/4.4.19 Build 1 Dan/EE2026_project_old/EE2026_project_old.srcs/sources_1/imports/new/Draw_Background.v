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
    input clk,
    input [11:0] VGA_HORZ_COORD,
    input [11:0] VGA_VERT_COORD,
    
    input [11:0] mouseXPos,
    input [11:0] mouseYPos,
    input mouseLeft,
    input [2:0] clrstate,
    
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
    wire Condition_For_Mouse =  (mouseXPos < 10 && VGA_HORZ_COORD < mouseXPos + 10 && VGA_VERT_COORD < mouseYPos + 2 && VGA_VERT_COORD > mouseYPos - 2)
    || (mouseXPos == 0 && VGA_HORZ_COORD < 2 && VGA_VERT_COORD < mouseYPos + 10 && VGA_VERT_COORD > mouseYPos - 10) 
    || (mouseYPos == 0 && VGA_VERT_COORD < 2 && VGA_HORZ_COORD < mouseXPos + 10 && VGA_HORZ_COORD > mouseXPos - 10) 
    || (mouseYPos < 10 && VGA_VERT_COORD < mouseYPos + 10 && VGA_HORZ_COORD < mouseXPos + 2 && VGA_HORZ_COORD > mouseXPos - 2)
    || ( VGA_HORZ_COORD < mouseXPos + 10 && VGA_HORZ_COORD > mouseXPos - 10 && VGA_VERT_COORD < mouseYPos + 2 && VGA_VERT_COORD > mouseYPos - 2) 
    || ( VGA_VERT_COORD < mouseYPos + 10 && VGA_VERT_COORD > mouseYPos - 10 && VGA_HORZ_COORD < mouseXPos + 2 && VGA_HORZ_COORD > mouseXPos - 2);
    
    wire a1, a2, a3, a4, a5 ,a6, a7, a8, a9, a10, a11, a12 , a13, a14, a15;
    wire c1, c2, c3, c4, c5, c6, c7, c8;
    wire d1, d2, d3, d4, d5, d6, d7, d8;
    wire e1, e2, e3, e4, e5, e6, e7, e8;
    wire f1, f2, f3, f4, f5, f6, f7, f8;
    wire g1, g2, g3, g4, g5, g6, g7, g8;
    
    char ahar1(clk, 69, 20, 20, VGA_HORZ_COORD, VGA_VERT_COORD, a1);
    char ahar2(clk, 69, 29, 20, VGA_HORZ_COORD, VGA_VERT_COORD, a2);
    char ahar3(clk, 50, 38, 20, VGA_HORZ_COORD, VGA_VERT_COORD, a3);
    char ahar4(clk, 48, 47, 20, VGA_HORZ_COORD, VGA_VERT_COORD, a4);
    char ahar5(clk, 50, 56, 20, VGA_HORZ_COORD, VGA_VERT_COORD, a5);
    char ahar6(clk, 54, 65, 20, VGA_HORZ_COORD, VGA_VERT_COORD, a6);
    char ahar7(clk, 66, 83, 20, VGA_HORZ_COORD, VGA_VERT_COORD, a7);
    char ahar8(clk, 89, 92, 20, VGA_HORZ_COORD, VGA_VERT_COORD, a8);
    char ahar9(clk, 74, 110, 20, VGA_HORZ_COORD, VGA_VERT_COORD, a9);
    char ahar10(clk, 89, 119, 20, VGA_HORZ_COORD, VGA_VERT_COORD, a10);
    char ahar11(clk, 38, 137, 20, VGA_HORZ_COORD, VGA_VERT_COORD, a11);
    char ahar12(clk, 68, 155, 20, VGA_HORZ_COORD, VGA_VERT_COORD, a12);
    char ahar13(clk, 65, 164, 20, VGA_HORZ_COORD, VGA_VERT_COORD, a13);
    char ahar14(clk, 78, 173, 20, VGA_HORZ_COORD, VGA_VERT_COORD, a14);
    char ahar15(clk, 1, 191, 20, VGA_HORZ_COORD, VGA_VERT_COORD, a15);
    
    char char1(clk, 67, 1189, 873, VGA_HORZ_COORD, VGA_VERT_COORD, c1);
    char char2(clk, 111, 1198, 873, VGA_HORZ_COORD, VGA_VERT_COORD, c2);
    char char3(clk, 108, 1207, 873, VGA_HORZ_COORD, VGA_VERT_COORD, c3);
    char char4(clk, 111, 1216, 873, VGA_HORZ_COORD, VGA_VERT_COORD, c4);
    char char5(clk, 117, 1225, 873, VGA_HORZ_COORD, VGA_VERT_COORD, c5);
    char char6(clk, 114, 1234, 873, VGA_HORZ_COORD, VGA_VERT_COORD, c6);
    char char7(clk, 32, 1243, 873, VGA_HORZ_COORD, VGA_VERT_COORD, c7);
    char char8(clk, 49, 1252, 873, VGA_HORZ_COORD, VGA_VERT_COORD, c8);
    
    char dhar1(clk, 67, 1189, 903, VGA_HORZ_COORD, VGA_VERT_COORD, d1);
    char dhar2(clk, 111, 1198, 903, VGA_HORZ_COORD, VGA_VERT_COORD, d2);
    char dhar3(clk, 108, 1207, 903, VGA_HORZ_COORD, VGA_VERT_COORD, d3);
    char dhar4(clk, 111, 1216, 903, VGA_HORZ_COORD, VGA_VERT_COORD, d4);
    char dhar5(clk, 117, 1225, 903, VGA_HORZ_COORD, VGA_VERT_COORD, d5);
    char dhar6(clk, 114, 1234, 903, VGA_HORZ_COORD, VGA_VERT_COORD, d6);
    char dhar7(clk, 32, 1243, 903, VGA_HORZ_COORD, VGA_VERT_COORD, d7);
    char dhar8(clk, 50, 1252, 903, VGA_HORZ_COORD, VGA_VERT_COORD, d8);
        
    char ehar1(clk, 67, 1189, 933, VGA_HORZ_COORD, VGA_VERT_COORD, e1);
    char ehar2(clk, 111, 1198, 933, VGA_HORZ_COORD, VGA_VERT_COORD, e2);
    char ehar3(clk, 108, 1207, 933, VGA_HORZ_COORD, VGA_VERT_COORD, e3);
    char ehar4(clk, 111, 1216, 933, VGA_HORZ_COORD, VGA_VERT_COORD, e4);
    char ehar5(clk, 117, 1225, 933, VGA_HORZ_COORD, VGA_VERT_COORD, e5);
    char ehar6(clk, 114, 1234, 933, VGA_HORZ_COORD, VGA_VERT_COORD, e6);
    char ehar7(clk, 32, 1243, 933, VGA_HORZ_COORD, VGA_VERT_COORD, e7);
    char ehar8(clk, 51, 1252, 933, VGA_HORZ_COORD, VGA_VERT_COORD, e8);
            
    char fhar1(clk, 67, 1189, 963, VGA_HORZ_COORD, VGA_VERT_COORD, f1);
    char fhar2(clk, 111, 1198, 963, VGA_HORZ_COORD, VGA_VERT_COORD, f2);
    char fhar3(clk, 108, 1207, 963, VGA_HORZ_COORD, VGA_VERT_COORD, f3);
    char fhar4(clk, 111, 1216, 963, VGA_HORZ_COORD, VGA_VERT_COORD, f4);
    char fhar5(clk, 117, 1225, 963, VGA_HORZ_COORD, VGA_VERT_COORD, f5);
    char fhar6(clk, 114, 1234, 963, VGA_HORZ_COORD, VGA_VERT_COORD, f6);
    char fhar7(clk, 32, 1243, 963, VGA_HORZ_COORD, VGA_VERT_COORD, f7);
    char fhar8(clk, 52, 1252, 963, VGA_HORZ_COORD, VGA_VERT_COORD, f8);
                
    char ghar1(clk, 67, 1189, 993, VGA_HORZ_COORD, VGA_VERT_COORD, g1);
    char ghar2(clk, 111, 1198, 993, VGA_HORZ_COORD, VGA_VERT_COORD, g2);
    char ghar3(clk, 108, 1207, 993, VGA_HORZ_COORD, VGA_VERT_COORD, g3);
    char ghar4(clk, 111, 1216, 993, VGA_HORZ_COORD, VGA_VERT_COORD, g4);
    char ghar5(clk, 117, 1225, 993, VGA_HORZ_COORD, VGA_VERT_COORD, g5);
    char ghar6(clk, 114, 1234, 993, VGA_HORZ_COORD, VGA_VERT_COORD, g6);
    char ghar7(clk, 32, 1243, 993, VGA_HORZ_COORD, VGA_VERT_COORD, g7);
    char ghar8(clk, 53, 1252, 993, VGA_HORZ_COORD, VGA_VERT_COORD, g8);
    
    wire Condition_For_Text = c1 || c2 || c3 || c4 || c5 || c6 || c7 || c8 
    || d1 || d2 || d3 || d4 || d5 || d6 || d7 || d8 
    || e1 || e2 || e3 || e4 || e5 || e6 || e7 || e8 
    || f1 || f2 || f3 || f4 || f5 || f6 || f7 || f8 
    || g1 || g2 || g3 || g4 || g5 || g6 || g7 || g8;
    wire Condition_For_Title = a1 || a2 || a3 || a4 || a5 || a6 || a7 || a8 || a9 || a10 || a11 || a12 || a13 || a14 || a15;
    
    wire Condition_For_Box = (VGA_HORZ_COORD >= 1184 && VGA_HORZ_COORD < 1265) && 
    ((VGA_VERT_COORD >= 868 && VGA_VERT_COORD < 894) ||
    (VGA_VERT_COORD >= 898 && VGA_VERT_COORD < 924) ||
    (VGA_VERT_COORD >= 928 && VGA_VERT_COORD < 954) ||
    (VGA_VERT_COORD >= 958 && VGA_VERT_COORD < 984) ||
    (VGA_VERT_COORD >= 988 && VGA_VERT_COORD < 1014)) ? 1 : 0;
    
    wire Condition_For_HBox = (clrstate == 1 && VGA_HORZ_COORD >= 1184 && VGA_HORZ_COORD < 1265 && VGA_VERT_COORD >= 868 && VGA_VERT_COORD < 894)
    || (clrstate == 2 && VGA_HORZ_COORD >= 1184 && VGA_HORZ_COORD < 1265 && VGA_VERT_COORD >= 898 && VGA_VERT_COORD < 924)
    || (clrstate == 3 && VGA_HORZ_COORD >= 1184 && VGA_HORZ_COORD < 1265 && VGA_VERT_COORD >= 928 && VGA_VERT_COORD < 954)
    || (clrstate == 4 && VGA_HORZ_COORD >= 1184 && VGA_HORZ_COORD < 1265 && VGA_VERT_COORD >= 958 && VGA_VERT_COORD < 984)
    || (clrstate == 5 && VGA_HORZ_COORD >= 1184 && VGA_HORZ_COORD < 1265 && VGA_VERT_COORD >= 988 && VGA_VERT_COORD < 1014);
    
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
    
    assign VGA_Red_Grid = Condition_For_Title ? 4'b1111 : Condition_For_Mouse ? 4'b1111 : (Condition_For_HBox) ? 4'b0010 : (Condition_For_Box) ? 4'b0100 : (Condition_For_Axes) ? axeR : (Condition_For_Ticks || Condition_For_SmallT) ? tickR : Condition_For_Grid ? gridR : bgR;
    assign VGA_Green_Grid = Condition_For_Title ? 4'b1111 : Condition_For_Mouse ? (mouseLeft ? 4'b1000 : 4'b1111) : (Condition_For_Text) ? 4'b1111 : (Condition_For_HBox) ? 4'b0010 : (Condition_For_Box) ? 4'b0100 : (Condition_For_Axes) ? axeG : (Condition_For_Ticks || Condition_For_SmallT) ? tickG : Condition_For_Grid ? gridG : bgG;
    assign VGA_Blue_Grid = Condition_For_Title ? 4'b1111 : Condition_For_Mouse ? mouseLeft ? 4'b1000 : 4'b1111 : (Condition_For_HBox) ? 4'b0010 : (Condition_For_Box) ? 4'b0100 : (Condition_For_Axes) ? axeB : (Condition_For_Ticks || Condition_For_SmallT) ? tickB : Condition_For_Grid ? gridB : bgB;
endmodule
