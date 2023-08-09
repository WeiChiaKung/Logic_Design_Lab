`timescale 1ns / 1ps
`define freq_div2_bit 2
module freq_div2(
    input CLK,
    input rst_n,
    output CLK_out
    );
    wire [`freq_div2_bit-2:0]temp;
    reg [`freq_div2_bit-1:0] count;
    reg [`freq_div2_bit-1:0] count_temp;
        always@(*)
            count_temp = count+1;
        always@(posedge CLK or negedge rst_n)
        begin
            if(~rst_n)
                count <= `freq_div2_bit'd0;
            else
                count <= count_temp;
        end
     assign {CLK_out,temp} = count;
endmodule