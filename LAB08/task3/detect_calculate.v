`timescale 1ns / 1ps
module detect_calculate(
    input [7:0]IN,
    input rst,
    input clk,
    output reg add,
    output reg sub,
    output reg mult,
    output reg result
    );
    always@(posedge clk or  posedge rst)
    begin
        if(rst)
        begin
            add <= 0;
            sub <= 0;
            mult <= 0;
            result <= 0;
        end
        else if(IN == 8'h79)
        begin
            add <= 1;
            sub <= 0;
            mult <= 0;
            result <= 0;
        end
        else if(IN == 8'h7B)
        begin
            add <= 0;
            sub <= 1;
            mult <= 0;
            result <= 0;
        end
        else if(IN == 8'h7C)
        begin
            add <= 0;
            sub <= 0;
            mult <= 1;
            result <= 0;
        end
        else if(IN == 8'h5A)
        begin
            add <= add;
            sub <= sub;
            mult <= mult;
            result <= 1;
        end
        else
        begin
            add <= add;
            sub <= sub;
            mult <= mult;
            result <= result;
        end    
    end
endmodule
