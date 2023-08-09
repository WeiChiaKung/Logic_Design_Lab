`timescale 1ns / 1ps
`include "global.v"
module buzzer_control( 
 clk, // clock from crystal 
 rst_n, // active low reset 
 note_div, // div for note generation 
 volume,
 audio_left, // left sound audio 
 audio_right // right sound audio 
); 
// I/O declaration 
input clk; // clock from crystal 
input rst_n; // active low reset 
input [21:0] note_div; // div for note generation 
input [3:0] volume;
output reg[15:0] audio_left; // left sound audio 
output reg[15:0] audio_right; // right sound audio 
// Declare internal signals 
reg [21:0] clk_cnt_next, clk_cnt; 
reg b_clk, b_clk_next;
// Note frequency generation 
always @(posedge clk or negedge rst_n) 
 if (~rst_n) 
 begin 
 clk_cnt <= 22'd0; 
 b_clk <= 1'b0; 
 end 
 else 
 begin 
 clk_cnt <= clk_cnt_next; 
 b_clk <= b_clk_next; 
 end 
always @* 
 if (clk_cnt == note_div) 
 begin 
 clk_cnt_next = 22'd0; 
 b_clk_next = ~b_clk; 
 end 
 else 
 begin 
 clk_cnt_next = clk_cnt + 1'b1; 
 b_clk_next = b_clk; 
 end 
// Assign the amplitude of the note 
always@(*)
begin
case(volume)
4'd15:
begin
    audio_left = (b_clk == 1'b0) ? `Neg_Volume_15 : `Pos_Volume_15; 
    audio_right = (b_clk == 1'b0) ? `Neg_Volume_15 : `Pos_Volume_15;
end
4'd14:
begin
    audio_left = (b_clk == 1'b0) ? `Neg_Volume_14 : `Pos_Volume_14; 
    audio_right = (b_clk == 1'b0) ? `Neg_Volume_14 : `Pos_Volume_14;
end
4'd13:
begin
    audio_left = (b_clk == 1'b0) ? `Neg_Volume_13 : `Pos_Volume_13; 
    audio_right = (b_clk == 1'b0) ? `Neg_Volume_13 : `Pos_Volume_13;
end
4'd12:
begin
    audio_left = (b_clk == 1'b0) ? `Neg_Volume_12 : `Pos_Volume_12; 
    audio_right = (b_clk == 1'b0) ? `Neg_Volume_12 : `Pos_Volume_12;
end
4'd11:
begin
    audio_left = (b_clk == 1'b0) ? `Neg_Volume_11 : `Pos_Volume_11; 
    audio_right = (b_clk == 1'b0) ? `Neg_Volume_11 : `Pos_Volume_11;
end
4'd10:
begin
    audio_left = (b_clk == 1'b0) ? `Neg_Volume_10 : `Pos_Volume_10; 
    audio_right = (b_clk == 1'b0) ? `Neg_Volume_10 : `Pos_Volume_10;
end
4'd9:
begin
    audio_left = (b_clk == 1'b0) ? `Neg_Volume_9 : `Pos_Volume_9; 
    audio_right = (b_clk == 1'b0) ? `Neg_Volume_9 : `Pos_Volume_9;
end
4'd8:
begin
    audio_left = (b_clk == 1'b0) ? `Neg_Volume_8 : `Pos_Volume_8; 
    audio_right = (b_clk == 1'b0) ? `Neg_Volume_8 : `Pos_Volume_8;
end
4'd7:
begin
    audio_left = (b_clk == 1'b0) ? `Neg_Volume_7 : `Pos_Volume_7; 
    audio_right = (b_clk == 1'b0) ? `Neg_Volume_7 : `Pos_Volume_7;
end
4'd6:
begin
    audio_left = (b_clk == 1'b0) ? `Neg_Volume_6 : `Pos_Volume_6; 
    audio_right = (b_clk == 1'b0) ? `Neg_Volume_6 : `Pos_Volume_6;
end
4'd5:
begin
    audio_left = (b_clk == 1'b0) ? `Neg_Volume_5 : `Pos_Volume_5; 
    audio_right = (b_clk == 1'b0) ? `Neg_Volume_5 : `Pos_Volume_5;
end
4'd4:
begin
    audio_left = (b_clk == 1'b0) ? `Neg_Volume_4 : `Pos_Volume_4; 
    audio_right = (b_clk == 1'b0) ? `Neg_Volume_4 : `Pos_Volume_4;
end
4'd3:
begin
    audio_left = (b_clk == 1'b0) ? `Neg_Volume_3 : `Pos_Volume_3; 
    audio_right = (b_clk == 1'b0) ? `Neg_Volume_3 : `Pos_Volume_3;
end
4'd2:
begin
    audio_left = (b_clk == 1'b0) ? `Neg_Volume_2 : `Pos_Volume_2; 
    audio_right = (b_clk == 1'b0) ? `Neg_Volume_2 : `Pos_Volume_2;
end
4'd1:
begin
    audio_left = (b_clk == 1'b0) ? `Neg_Volume_1 : `Pos_Volume_1; 
    audio_right = (b_clk == 1'b0) ? `Neg_Volume_1 : `Pos_Volume_1;
end
4'd0:
begin
    audio_left = (b_clk == 1'b0) ? `Neg_Volume_0 : `Pos_Volume_0; 
    audio_right = (b_clk == 1'b0) ? `Neg_Volume_0 : `Pos_Volume_0;
end
default:
begin
    audio_left = (b_clk == 1'b0) ? `Neg_Volume_7 : `Pos_Volume_7; 
    audio_right = (b_clk == 1'b0) ? `Neg_Volume_7 : `Pos_Volume_7;
end
endcase
end 
endmodule
