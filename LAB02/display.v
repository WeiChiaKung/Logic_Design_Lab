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

module display(segs, bin);
output [7:0] segs;  
input [3:0] bin;
reg [7:0] segs;  

always @*
  case (bin)
    4'd0: segs = `SS_0;
    4'd1: segs = `SS_1;
    4'd2: segs = `SS_2;
    4'd3: segs = `SS_3;
    4'd4: segs = `SS_4;
    4'd5: segs = `SS_5;
    4'd6: segs = `SS_6;
    4'd7: segs = `SS_7;
    4'd8: segs = `SS_8;
    4'd9: segs = `SS_9;
    4'd10: segs = `SS_10;
    4'd11: segs = `SS_11;
    4'd12: segs = `SS_12;
    4'd13: segs = `SS_13;
    4'd14: segs = `SS_14;
    4'd15: segs = `SS_15;
    default: segs = 8'b0000000;
  endcase
endmodule
