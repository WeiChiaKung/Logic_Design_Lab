`timescale 1ns / 1ps
`define freq_div_bit 27
module freq_div(
    input CLK,
    input rst_n,
    output CLK_out
    );
    wire [`freq_div_bit-2:0]temp;
    up_counter U0(.CLK(CLK), .rst_n(rst_n), .count({CLK_out,temp}));
endmodule