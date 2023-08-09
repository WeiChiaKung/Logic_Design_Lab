`timescale 1ns / 1ps
module task3(
    input CLK,
    input rst_n,
    output [3:0]q
    );
    wire CLK_temp;
    freq_div U0(.CLK(CLK), .rst_n(rst_n), .CLK_out(CLK_temp));
    up_counter_4bit U1(.CLK(CLK_temp), .rst_n(rst_n), .count(q));
endmodule

