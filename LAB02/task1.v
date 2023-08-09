`timescale 1ns / 1ps
module task1(
    input a,
    input b,
    input c,
    input d,
    output w,
    output x,
    output y,
    output z
    );
    assign w = a;
    assign x = a^b;
    assign y = b^c;
    assign z = c^d;
endmodule
