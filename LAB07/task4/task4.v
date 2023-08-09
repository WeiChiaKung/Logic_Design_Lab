`timescale 1ns / 1ps
`include "global.v"
module task3(
    input clk, // clock
    input rst_n, // low active reset 
    input C,
    input D,
    input E,
    input F,
    input G,
    input switch,
    output audio_mclk, // master clock
    output audio_lrck, // left-right clock
    output audio_sck, // serial clock
    output audio_sdin // serial audio data input
    );
reg [21:0]note_left;
reg [21:0]note_right;

always@(*)
begin
    case({switch,C,D,E,F,G})
    6'b110000:
    begin
        note_left = `Freq_C;
        note_right = `Freq_E;
    end
    6'b101000:
    begin
        note_left = `Freq_D;
        note_right = `Freq_F;
    end
    6'b100100:
    begin
        note_left = `Freq_E;
        note_right = `Freq_G;
    end
    6'b100010:
    begin
        note_left = `Freq_F;
        note_right = `Freq_A;
    end
    6'b100001:
    begin
        note_left = `Freq_G;
        note_right = `Freq_B;
    end
    6'b010000:
    begin
        note_left = `Freq_C;
        note_right = `Freq_C;
    end
    6'b001000:
    begin
        note_left = `Freq_D;
        note_right = `Freq_D;
    end
    6'b000100:
    begin
        note_left = `Freq_E;
        note_right = `Freq_E;
    end
    6'b000010:
    begin
        note_left = `Freq_F;
        note_right = `Freq_F;
    end
    6'b000001:
    begin
        note_left = `Freq_G;
        note_right = `Freq_G;
    end
    default:
    begin
        note_left = 22'd0;
        note_right = 22'd0;
    end
    endcase
end
speaker U_sp(
    .clk(clk), // clock from crystal
    .rst_n(rst_n), // active low reset
    .note_div_left(note_left),
    .note_div_right(note_right),
    .audio_mclk(audio_mclk), // master clock
    .audio_lrck(audio_lrck), // left-right clock
    .audio_sck(audio_sck), // serial clock
    .audio_sdin(audio_sdin) // serial audio data input
);
endmodule
