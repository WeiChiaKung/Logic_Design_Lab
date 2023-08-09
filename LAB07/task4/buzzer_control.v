`timescale 1ns / 1ps
module buzzer_control( 
 clk, // clock from crystal 
 rst_n, // active low reset 
 note_div_left, // div for note generation 
 note_div_right,
 audio_left, // left sound audio 
 audio_right // right sound audio 
); 
// I/O declaration 
input clk; // clock from crystal 
input rst_n; // active low reset 
input [21:0] note_div_left; // div for note generation 
input [21:0] note_div_right;
output [15:0] audio_left; // left sound audio 
output [15:0] audio_right; // right sound audio 
// Declare internal signals 
reg [21:0] clk_cnt_next, clk_cnt; 
reg [21:0] clk_cnt_next1, clk_cnt1; 
reg bl_clk, bl_clk_next;
reg br_clk, br_clk_next;
// Note frequency generation 
always @(posedge clk or negedge rst_n) 
 if (~rst_n) 
 begin 
 clk_cnt <= 22'd0; 
 clk_cnt1 <= 22'd0;
 bl_clk <= 1'b0; 
 br_clk <= 1'b0;
 end 
 else 
 begin 
 clk_cnt <= clk_cnt_next; 
 clk_cnt1 <= clk_cnt_next1; 
 bl_clk <= bl_clk_next; 
 br_clk <= br_clk_next; 
 end 
always @* 
 if (clk_cnt == note_div_left) 
 begin 
 clk_cnt_next = 22'd0; 
 bl_clk_next = ~bl_clk; 
 end 
 else 
 begin 
 clk_cnt_next = clk_cnt + 1'b1; 
 bl_clk_next = bl_clk; 
 end 
 always @* 
  if (clk_cnt1 == note_div_right) 
  begin 
  clk_cnt_next1 = 22'd0; 
  br_clk_next = ~br_clk; 
  end 
  else 
  begin 
  clk_cnt_next1 = clk_cnt1 + 1'b1; 
  br_clk_next = br_clk; 
  end 
// Assign the amplitude of the note 
assign audio_left = (bl_clk == 1'b0) ? 16'hB000 : 16'h5FFF; 
assign audio_right = (br_clk == 1'b0) ? 16'hB000 : 16'h5FFF; 
endmodule
