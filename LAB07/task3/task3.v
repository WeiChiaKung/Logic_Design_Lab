`timescale 1ns / 1ps
`include "global.v"
module task3(
    input clk, // clock
    input rst_n, // low active reset 
    input c,
    input d,
    input e,
    input f,
    input g,
    input a,
    input b,
    input C,
    input D,
    input E,
    input F,
    input G,
    input A,
    input B,
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
reg [`BCD_BIT_WIDTH-1:0] digit0;
wire clk_d;
wire [`SSD_SCAN_CTL_BIT_WIDTH-1:0] ssd_ctl_en;
wire [`BCD_BIT_WIDTH-1:0] ssd_in;

always@(*)
begin
    case({c,d,e,f,g,a,b,C,D,E,F,G,A,B})
    14'b10000000000000:
    begin
        note = `Freq_c;
        digit0 = 1;
    end
    14'b01000000000000:
    begin
        note = `Freq_d;
        digit0 = 2;
    end
    14'b00100000000000:
    begin
        note = `Freq_e;
        digit0 = 3;
    end
    14'b00010000000000:
    begin
        note = `Freq_f;
        digit0 = 4;
    end
    14'b00001000000000:
    begin
        note = `Freq_g;
        digit0 = 5;
    end
    14'b00000100000000:
    begin
        note = `Freq_a;
        digit0 = 6;
    end
    14'b00000010000000:
    begin
        note = `Freq_b;
        digit0 = 7;
    end
    14'b00000001000000:
    begin
        note = `Freq_C;
        digit0 = 1;
    end
    14'b00000000100000:
    begin
        note = `Freq_D;
        digit0 = 2;
    end
    14'b00000000010000:
    begin
        note = `Freq_E;
        digit0 = 3;
    end
    14'b00000000001000:
    begin
        note = `Freq_F;
        digit0 = 4;
    end
    14'b00000000000100:
    begin
        note = `Freq_G;
        digit0 = 5;
    end
    14'b00000000000010:
    begin
        note = `Freq_A;
        digit0 = 6;
    end
    14'b00000000000001:
    begin
        note = `Freq_B;
        digit0 = 7;
    end
    default:
    begin
        note = 22'd0;
        digit0 = 0;
    end
    endcase
end
freqdiv27 U_FD(
    .clk_out(clk_d), // divided clock
    .clk_ctl(ssd_ctl_en), // divided clock for scan control 
    .clk(clk), // clock from the crystal
    .rst_n(rst_n) // low active reset
);

speaker U_sp(
    .clk(clk), // clock from crystal
    .rst_n(rst_n), // active low reset
    .note_div(note),
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
