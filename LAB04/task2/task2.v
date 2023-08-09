`timescale 1ns / 1ps
`define SS_0 8'b00000011
`define SS_1 8'b10011111
`define SS_2 8'b00100101
`define SS_3 8'b00001101
`define SS_4 8'b10011001
`define SS_5 8'b01001001
`define SS_6 8'b01000001
`define SS_7 8'b00011111
`define SS_8 8'b00000001
`define SS_9 8'b00001001
`define SS_10 8'b00010001
`define SS_11 8'b11000001
`define SS_12 8'b01100011
`define SS_13 8'b10000101
`define SS_14 8'b01100001
`define SS_15 8'b01110001
module task2(CLK,rst_n,seg,ssd_ctl);
output [3:0] ssd_ctl;
output [7:0] seg;  
input CLK;
input rst_n;
reg [7:0] seg;
reg [3:0] bin;
wire CLK_temp;
reg [3:0]bin_temp;
freq_div U0(.CLK(CLK), .rst_n(rst_n), .CLK_out(CLK_temp));
assign ssd_ctl = 4'b1110;
always@(*)
    bin_temp = bin-1;
always@(posedge CLK_temp or negedge rst_n)
begin
    if(~rst_n)
        bin <= 4'b1111;
    else
        bin <= bin_temp;
end  
always @*
  case (bin)
    4'd0: seg = `SS_0;
    4'd1: seg = `SS_1;
    4'd2: seg = `SS_2;
    4'd3: seg = `SS_3;
    4'd4: seg = `SS_4;
    4'd5: seg = `SS_5;
    4'd6: seg = `SS_6;
    4'd7: seg = `SS_7;
    4'd8: seg = `SS_8;
    4'd9: seg = `SS_9;
    4'd10: seg = `SS_10;
    4'd11: seg = `SS_11;
    4'd12: seg = `SS_12;
    4'd13: seg = `SS_13;
    4'd14: seg = `SS_14;
    4'd15: seg = `SS_15;
    default: seg = 8'b0000000;
  endcase
endmodule


