`timescale 1ns / 1ps
module speaker(
  clk, // clock from crystal
  rst_n, // active low reset
  note_div,
  volume,
  audio_mclk, // master clock
  audio_lrck, // left-right clock
  audio_sck, // serial clock
  audio_sdin // serial audio data input
);

// I/O declaration
input clk;  // clock from the crystal
input rst_n;  // active low reset
input [21:0]note_div;
input [3:0]volume;
output audio_mclk; // master clock
output audio_lrck; // left-right clock
output audio_sck; // serial clock
output audio_sdin; // serial audio data input
wire [15:0] audio_left;
wire [15:0] audio_right;

buzzer_control U_bc(
  .clk(clk), 
  .rst_n(rst_n), 
  .note_div(note_div), 
  .volume(volume),
  .audio_left(audio_left), 
  .audio_right(audio_right) 
);
speaker_control U_sc(
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
