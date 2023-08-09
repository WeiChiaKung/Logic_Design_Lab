`timescale 1ns / 1ps
`define Counter_bit 4
module up_counter_4bit(
    input CLK,
    input rst_n,
    output reg [`Counter_bit-1:0] count
    );
    reg [`Counter_bit-1:0] count_temp;
    always@(*)
        count_temp = count+1;
    always@(posedge CLK or negedge rst_n)
    begin
        if(~rst_n)
            count <= `Counter_bit'd0;
        else
            count <= count_temp;
    end
endmodule
