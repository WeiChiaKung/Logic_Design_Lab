`timescale 1ns / 1ps
module task1(
    input CLK,
    input rst_n,
    output reg [3:0]b
    );
    wire CLK_temp;
    reg [3:0]b_temp;
    freq_div U0(.CLK(CLK), .rst_n(rst_n), .CLK_out(CLK_temp));
    always@(*)
        b_temp = b-1;
    always@(posedge CLK_temp or negedge rst_n)
    begin
        if(~rst_n)
            b <= 4'b1111;
        else
            b <= b_temp;
    end
endmodule

