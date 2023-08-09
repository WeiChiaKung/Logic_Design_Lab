`timescale 1ns / 1ps
`include "global.v"
module task2(
    input clk, // clock
    input rst_n, // low active reset 
    input volume_plus,
    input volume_minus,
    input Do,
    input Re,
    input Mi,
    output [`SSD_BIT_WIDTH-1:0]segs, // 7 segment display control
    output [`SSD_DIGIT_NUM-1:0]ssd_ctl, // scan control for 7-segment display
    output audio_mclk, // master clock
    output audio_lrck, // left-right clock
    output audio_sck, // serial clock
    output audio_sdin // serial audio data input
    );
reg [21:0]note;
wire increase_enable;
wire decrease_enable;
wire [`BCD_BIT_WIDTH-1:0] digit0;
wire clk_d;
wire [`SSD_SCAN_CTL_BIT_WIDTH-1:0] ssd_ctl_en;
wire [`BCD_BIT_WIDTH-1:0] ssd_in;
assign increase_enable = volume_plus && (~(digit0==`BCD_DEF));
assign decrease_enable = volume_minus && (~(digit0==`BCD_ZERO)); 
always@(*)
begin
    if(Do && (~Re) && (~Mi))
        note = `Freq_Do;
    else if((~Do) && Re && (~Mi))
        note = `Freq_Re;
    else if((~Do) && (~Re) && Mi)
        note = `Freq_Mi;
    else
        note = 22'd0;
end
freqdiv27 U_FD(
    .clk_out(clk_d), // divided clock
    .clk_ctl(ssd_ctl_en), // divided clock for scan control 
    .clk(clk), // clock from the crystal
    .rst_n(rst_n) // low active reset
);
updowncounter U_udc(
    .value(digit0), 
    .carry(), 
    .borrow(), 
    .clk(clk_d), // global clock signal
    .rst_n(rst_n),  // low active reset
    .increase(increase_enable),  // decrease input from previous stage of counter
    .decrease(decrease_enable),
    .init_value(`BCD_SEVEN),  // initial value for the counter
    .limit(`BCD_DEF)
);
speaker U_sp(
    .clk(clk), // clock from crystal
    .rst_n(rst_n), // active low reset
    .note_div(note),
    .volume(digit0),
    .audio_mclk(audio_mclk), // master clock
    .audio_lrck(audio_lrck), // left-right clock
    .audio_sck(audio_sck), // serial clock
    .audio_sdin(audio_sdin) // serial audio data input
);
scan_ctl U_SC(
    .ssd_ctl(ssd_ctl), // ssd display control signal 
    .ssd_in(ssd_in), // output to ssd display
    .in0(4'd0), // 1st input
    .in1(4'd0), // 2nd input
    .in2(4'd0), // 3rd input
    .in3(digit0),  // 4th input
    .ssd_ctl_en(ssd_ctl_en) // divided clock for scan control
  );
display U_display(
    .segs(segs), // 7-segment display output
    .bin(ssd_in)  // BCD number input
  );
endmodule

