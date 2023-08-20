`timescale 1ns / 1ps
module task1_tb();
reg clk;
reg rst_n;
wire audio_mclk;
wire audio_lrck;
wire audio_sck;
wire audio_sdin;
task1 U0(
  .clk(clk), // clock from crystal
  .rst_n(rst_n), // active low reset
  .audio_mclk(audio_mclk), // master clock
  .audio_lrck(audio_lrck), // left-right clock
  .audio_sck(audio_sck), // serial clock
  .audio_sdin(audio_sdin) // serial audio data input
);
initial
begin
    rst_n = 0;
    clk = 0;
    #3 rst_n = 1;
end
always
begin
    #5 clk = ~clk;
end
endmodule
