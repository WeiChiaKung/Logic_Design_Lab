`timescale 1ns / 1ps
module detect_calculate(
    input [7:0]IN,
    input rst,
    input clk,
    output reg calculate,
    output reg result
    );
    always@(posedge clk or  posedge rst)
    begin
        if(rst)
        begin
            calculate <= 0;
            result <= 0;
        end
        else if(IN == 8'h79)
        begin
            calculate <= 1;
            result <= result;
        end
        else if(IN == 8'h5A)
        begin
            calculate <= calculate;
            result <= 1;
        end
        else
        begin
            calculate <= calculate;
            result <= result;
        end    
    end
endmodule
