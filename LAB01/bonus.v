`timescale 1ns / 1ps
module bonus(
    input [2:0] a,
    input [2:0] b,
    input [2:0] c,
    output reg[2:0] o
    );
    always@(*)
    begin
        case({a[2],b[2],c[2]})
        3'b000: begin
                    if(a[1:0]<=b[1:0] && a[1:0]<=c[1:0])
                        o = a;
                    else if(b[1:0]<=a[1:0] && b[1:0]<=c[1:0])
                        o = b;
                    else
                        o = c;
                end
        3'b111: begin
                    if(a[1:0]<=b[1:0] && a[1:0]<=c[1:0])
                        o = a;
                    else if(b[1:0]<=a[1:0] && b[1:0]<=c[1:0])
                        o = b;
                    else
                        o = c;
                end
        3'b001: o = c;
        3'b010: o = b;
        3'b100: o = a;
        3'b011: begin
                    if(b[1:0]<=c[1:0])
                        o = b;
                    else
                        o = c;
                end
        3'b101: begin
                    if(a[1:0]<=c[1:0])
                        o = a;
                    else
                        o = c;
                end
        default: begin
                    if(a[1:0]<=b[1:0])
                        o = a;
                    else
                        o = b;
                 end
        endcase
    end       
endmodule
