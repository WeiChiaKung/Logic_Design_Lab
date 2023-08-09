`timescale 1ns / 1ps
module task2_tb();
reg [3:0]a,b;
reg m;
wire [3:0]s;
wire v;
task2 U0(.a(a), .b(b), .m(m), .s(s), .v(v));
initial
begin
    a = 4'b0010;b = 4'b0101;m = 0;
    #10 a = 4'b0010;b = 4'b0101;m = 1;
    #10 a = 4'b0101;b = 4'b0100;m = 0;
    #10 a = 4'b1101;b = 4'b0110;m = 1;
    #10 a = 4'b1010;b = 4'b1001;m = 0;
    #10 a = 4'b0101;b = 4'b1011;m = 1;
    #10 $finish;
end
endmodule
