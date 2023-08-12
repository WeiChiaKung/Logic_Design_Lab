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
    assign w = (a&~b&~c)|(~a&b&d)|(~a&b&c);
    assign x = (~a&~b&c&d)|(~a&b&~c);
    assign y = (~a&c)|(~a&b);
    assign z = (a&~b&~c&~d)|(~a&~b&d)|(~a&~b&c)|(~a&c&d);
endmodule
