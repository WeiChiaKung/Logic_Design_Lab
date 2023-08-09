`timescale 1ns / 1ps
module task2(
    input [3:0] i,
    output [3:0] d,
    output [3:0] ssd_ctl,
    output [7:0] seg
    );
    assign ssd_ctl = 4'b1110;
    assign d = i;
    display U0(.segs(seg), .bin(i));
endmodule
