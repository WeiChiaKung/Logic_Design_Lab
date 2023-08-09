`timescale 1ns / 1ps
module speaker_control(
  clk,  // clock from the crystal
  rst_n,  // active low reset
  audio_left, // left channel audio data input
  audio_right, // right channel audio data input
  audio_mclk, // master clock
  audio_lrck, // left-right clock, Word Select clock, or sample rate clock
  audio_sck, // serial clock
  audio_sdin // serial audio data input
);

// I/O declaration
input clk;  // clock from the crystal
input rst_n;  // active low reset
input [15:0] audio_left; // left channel audio data input
input [15:0] audio_right; // right channel audio data input
output audio_mclk; // master clock
output audio_lrck; // left-right clock
output audio_sck; // serial clock
output reg audio_sdin; // serial audio data input

reg [8:0]count;
wire [8:0]count_next;
reg [15:0]audio_left_temp;
reg [15:0]audio_right_temp;

assign count_next = count+1;
always @(posedge clk or negedge rst_n)
begin
    if (~rst_n)
        count <= 9'd0;
    else
        count <= count_next;
end
assign audio_mclk = count[1];
assign audio_lrck = count[8];
assign audio_sck = count[3];

always @(posedge count[4] or negedge rst_n)
begin
    if (~rst_n)
    begin
        audio_left_temp <= 16'd0;
        audio_right_temp <= 16'd0;
    end
    else
    begin
        audio_left_temp <= audio_left;
        audio_right_temp <= audio_right;
    end
end
always@(*)
begin
    case (count[8:4])
    5'b00000: audio_sdin = audio_right_temp[0];
    5'b00001: audio_sdin = audio_left_temp[15];
    5'b00010: audio_sdin = audio_left_temp[14];
    5'b00011: audio_sdin = audio_left_temp[13];
    5'b00100: audio_sdin = audio_left_temp[12];
    5'b00101: audio_sdin = audio_left_temp[11];
    5'b00110: audio_sdin = audio_left_temp[10];
    5'b00111: audio_sdin = audio_left_temp[9];
    5'b01000: audio_sdin = audio_left_temp[8];
    5'b01001: audio_sdin = audio_left_temp[7];
    5'b01010: audio_sdin = audio_left_temp[6];
    5'b01011: audio_sdin = audio_left_temp[5];
    5'b01100: audio_sdin = audio_left_temp[4];
    5'b01101: audio_sdin = audio_left_temp[3];
    5'b01110: audio_sdin = audio_left_temp[2];
    5'b01111: audio_sdin = audio_left_temp[1];
    5'b10000: audio_sdin = audio_left_temp[0];
    5'b10001: audio_sdin = audio_right_temp[15];
    5'b10010: audio_sdin = audio_right_temp[14];
    5'b10011: audio_sdin = audio_right_temp[13];
    5'b10100: audio_sdin = audio_right_temp[12];
    5'b10101: audio_sdin = audio_right_temp[11];
    5'b10110: audio_sdin = audio_right_temp[10];
    5'b10111: audio_sdin = audio_right_temp[9];
    5'b11000: audio_sdin = audio_right_temp[8];
    5'b11001: audio_sdin = audio_right_temp[7];
    5'b11010: audio_sdin = audio_right_temp[6];
    5'b11011: audio_sdin = audio_right_temp[5];
    5'b11100: audio_sdin = audio_right_temp[4];
    5'b11101: audio_sdin = audio_right_temp[3];
    5'b11110: audio_sdin = audio_right_temp[2];
    5'b11111: audio_sdin = audio_right_temp[1];
    default: audio_sdin = 1'b0;
  endcase
end
endmodule