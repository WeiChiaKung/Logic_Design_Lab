`timescale 1ns / 1ps
module task1_tb();
wire w,x,y,z;
reg [3:0]inp;
task1 U0(.a(inp[3]), .b(inp[2]), .c(inp[1]), .d(inp[0]), .w(w), .x(x), .y(y), .z(z));
initial
    inp = 4'd0;
always
begin
    #10 inp = 4'd1;
    #10 inp = 4'd2;
    #10 inp = 4'd3;
    #10 inp = 4'd4;
    #10 inp = 4'd5;
    #10 inp = 4'd6;
    #10 inp = 4'd7;
    #10 inp = 4'd8;
    #10 inp = 4'd9;
    #10 inp = 4'd0;
end
endmodule
