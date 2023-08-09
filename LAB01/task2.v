`timescale 1ns / 1ps
module task2(
    input [3:0] a,
    input [3:0] b,
    input m,
    output reg[3:0] s,
    output v
    );
    integer i;
    reg [4:0]c;
    always@(*)
    begin
        c[0] = m;
        for(i=0;i<4;i=i+1)
            {c[i+1],s[i]} = a[i] +(b[i]^m)+c[i];   
    end
    assign v = c[3]^c[4];
endmodule
