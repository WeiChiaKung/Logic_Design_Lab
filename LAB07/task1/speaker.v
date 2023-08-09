`timescale 1ns / 1ps
module speaker(
  clk, // clock from crystal
  rst_n, // active low reset
  audio_mclk, // master clock
  audio_lrck, // left-right clock
  audio_sck, // serial clock
  audio_sdin // serial audio data input
);

// I/O declaration
input clk;  // clock from the crystal
input rst_n;  // active low reset
output audio_mclk; // master clock
output audio_lrck; // left-right clock
output audio_sck; // serial clock
output audio_sdin; // serial audio data input
wire [15:0] audio_left;
wire [15:0] audio_right;

buzzer_control Ubc(
  .clk(clk), 
  .rst_n(rst_n), 
  .note_div(22'd191571), 
  .audio_left(audio_left), 
  .audio_right(audio_right) 
);
speaker_control Usc(
  .clk(clk),  
  .rst_n(rst_n),  
  .audio_left(audio_left), 
  .audio_right(audio_right), 
  .audio_mclk(audio_mclk), 
  .audio_lrck(audio_lrck), 
  .audio_sck(audio_sck), 
  .audio_sdin(audio_sdin) 
);
endmodule
