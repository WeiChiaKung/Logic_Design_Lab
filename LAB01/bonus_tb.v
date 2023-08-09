`timescale 1ns / 1ps
module bonus_tb();
reg [2:0]a,b,c;
wire [2:0]o;
bonus U0(.a(a), .b(b), .c(c), .o(o));
initial
begin
    a = 3'b010;b = 3'b011;c = 3'b001;
    #10 a = 3'b110;b = 3'b111;c = 3'b101;
    #10 a = 3'b010;b = 3'b011;c = 3'b101;
    #10 a = 3'b010;b = 3'b111;c = 3'b001;
    #10 a = 3'b110;b = 3'b011;c = 3'b001;
    #10 a = 3'b110;b = 3'b111;c = 3'b001;
    #10 a = 3'b110;b = 3'b011;c = 3'b101;
    #10 a = 3'b010;b = 3'b111;c = 3'b101;
    #10 a = 3'b001;b = 3'b001;c = 3'b001;
    #10 $finish;
end
endmodule
