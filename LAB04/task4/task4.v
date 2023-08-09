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
module task4(CLK,rst_n,seg,ssd_ctl);
output reg[3:0] ssd_ctl;
output [7:0] seg;  
input CLK;
input rst_n;
reg [7:0] seg;
reg [3:0] bin,bin2;
wire CLK_temp;
reg [3:0]bin_temp,bin2_temp;
reg [17:0]counter,counter_next;
reg [1:0]state,state_next;
reg [3:0]segnumber;
freq_div U0(.CLK(CLK), .rst_n(rst_n), .CLK_out(CLK_temp));
always@(posedge CLK) begin
  counter <=(counter<=100000) ? (counter_next) : 0;
  state <= (counter==100000) ? (state_next) : state;
   case(state)
	0:begin
	  segnumber <= 4'd0; 
	  ssd_ctl <= 4'b0111;
	end
	1:begin
	  segnumber <=  4'd0;  
	  ssd_ctl <= 4'b1011;
	end
	2:begin
	  segnumber <= bin2 ; 
	  ssd_ctl <= 4'b1101;
	end
	3:begin
	 segnumber <= bin; 
	 ssd_ctl <= 4'b1110;
	end
	default: state <= state;
  endcase 
end
always@(*)
begin
    counter_next = counter +1;
    state_next = state +1;
    if(bin == 4'd9)
    begin
        bin_temp = 4'd0;
        bin2_temp = bin2 + 1; 
    end
    else
        bin_temp = bin+1;
    if(bin2 == 4'd9)
        bin2_temp = 4'd0; 
    else
        bin2_temp = bin2_temp;   
 end
always@(posedge CLK_temp or negedge rst_n)
begin
    if(~rst_n)
    begin
        bin <= 4'b0000;
        bin2 <= 4'b0000;
    end
    else
    begin
        bin <= bin_temp;
        bin2 <= bin2_temp;
    end
end  
always @*
begin
  case (segnumber)
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
    default: seg = 8'b11111111;
  endcase
end
endmodule

