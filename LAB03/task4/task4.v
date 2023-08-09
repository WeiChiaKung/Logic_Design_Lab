`timescale 1ns / 1ps
module task4(
    input CLK,
    input rst_n,
    output [7:0]s
    );
    wire CLK_temp;
    freq_div U0(.CLK(CLK), .rst_n(rst_n), .CLK_out(CLK_temp));
    ring_counter(.CLK(CLK_temp), .rst_n(rst_n), .s(s));
endmodule

