`timescale 1ns / 1ps
module detect_case(
    input [7:0]IN,
    input rst,
    input clk,
    output reg upper,
    output reg lower
    );
    reg state;
    always@(posedge clk or  posedge rst)
    begin
        if(rst)
        begin
            state <= 0;
            upper <= 0;
            lower <= 1;
        end
        else
        begin
            case(state)
            0:
            begin 
                if(IN == 8'h58)
                begin
                    state <= 1;
                    upper <= 1;
                    lower <= 0;
                end
                else
                begin 
                    state <= 0;
                    upper <= 0;
                    lower <= 1;   
                end
            end
            1:
            begin 
                if(IN == 8'h58)
                begin
                    state <= 0;
                    upper <= 0;
                    lower <= 1;
                end
                else 
                begin
                    state <= 1;
                    upper <= 1;
                    lower <= 0;   
                end
            end
            default:
            begin
                state <= state;
                upper <= upper;
                lower <= lower;  
            end
            endcase
        end  
    end
endmodule
