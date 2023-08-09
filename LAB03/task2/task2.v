`timescale 1ns / 1ps
`define freq_div_bit 26
module task2(
    input CLK,
    input rst_n,
    output CLK_out
    );
    wire [`freq_div_bit-2:0]temp;
    wire CLK_temp;
    reg count,count_temp;
    up_counter U0(.CLK(CLK), .rst_n(rst_n), .count({CLK_temp,temp}));
    always@(*)
        count_temp = count+1;
    always@(posedge CLK_temp or negedge rst_n)
    begin
        if(~rst_n)
            count <= 0;
        else
            count <= count_temp;
    end
    assign CLK_out = count;
endmodule
