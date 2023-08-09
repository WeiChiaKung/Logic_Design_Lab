`timescale 1ns / 1ps
module ring_counter(
    input CLK,
    input rst_n,
    output reg [7:0]s
    );
    always@(posedge CLK or negedge rst_n)
    begin
        if(~rst_n)
            s <= 8'b11011101;
        else
        begin
            s[0] <= s[7];
            s[1] <= s[0];
            s[2] <= s[1];
            s[3] <= s[2];
            s[4] <= s[3];
            s[5] <= s[4];
            s[6] <= s[5];
            s[7] <= s[6];
        end
    end
endmodule
