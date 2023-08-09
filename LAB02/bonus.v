`timescale 1ns / 1ps
module bonus(
    input [7:0] secret,guess,
    output reg[2:0] bulls,cows
    );
    reg[3:0] A,B,a,b;
    always@(*)
    begin
        A = secret%100/10;
        B = secret%10;
        a = guess%100/10;
        b = guess%10;
        if(a==A && b==B)
        begin
            bulls=3'b010;
            cows=3'b000;
        end
        else if(a==A || b==B)
        begin
             bulls=3'b001;
             cows=3'b000;
        end
        else if((a==B && b!=A) || (b==A && a!=B))
        begin
             bulls=3'b000;
             cows=3'b001;
        end
        else if(a==B && b==A)
        begin
             bulls=3'b000;
             cows=3'b010;
        end
        else
        begin
            bulls=3'b000;
            cows=3'b000;
        end             
    end
endmodule
