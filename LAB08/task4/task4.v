`timescale 1ns / 1ps
`include "global.v"
module task4(
	output reg[6:0] ASCII,
	inout wire PS2_DATA,
	inout wire PS2_CLK,
	input wire rst,
	input wire clk
    );
    wire key_valid;
    wire [511:0] key_down;
    wire [8:0] last_change;
    wire upper,lower;
    KeyboardDecoder(
        .key_down(key_down),
        .last_change(last_change),
        .key_valid(key_valid),
        .PS2_DATA(PS2_DATA),
        .PS2_CLK(PS2_CLK),
        .rst(rst),
        .clk(clk)
    );
    detect_case Udcase(
        .IN(last_change[7:0]),
        .rst(rst),
        .clk(clk),
        .upper(upper),
        .lower(lower)
    );
    always@(*)
    begin
        if(rst)
        begin
            ASCII = 7'd0;
        end
        else if(lower)
        begin
            if(key_down[8'h12])
            begin
                if(key_down[8'h1C])//A
                    ASCII = 7'd65;
                else if(key_down[8'h32])//B
                    ASCII = 7'd66;
                else if(key_down[8'h21])//C
                    ASCII = 7'd67;
                else if(key_down[8'h23])//D
                    ASCII = 7'd68;
                else if(key_down[8'h24])//E
                    ASCII = 7'd69;
                else if(key_down[8'h2B])//F
                    ASCII = 7'd70;
                else if(key_down[8'h34])//G
                    ASCII = 7'd71;
                else if(key_down[8'h33])//H
                    ASCII = 7'd72;
                else if(key_down[8'h43])//I
                    ASCII = 7'd73;
                else if(key_down[8'h3B])//J
                    ASCII = 7'd74;
                else if(key_down[8'h42])//K
                    ASCII = 7'd75;
                else if(key_down[8'h4B])//L
                    ASCII = 7'd76;
                else if(key_down[8'h3A])//M
                    ASCII = 7'd77;
                else if(key_down[8'h31])//N
                    ASCII = 7'd78;
                else if(key_down[8'h44])//O
                    ASCII = 7'd79;
                else if(key_down[8'h4D])//P
                    ASCII = 7'd80;
                else if(key_down[8'h15])//Q
                    ASCII = 7'd81;
                else if(key_down[8'h2D])//R
                    ASCII = 7'd82;
                else if(key_down[8'h1B])//S
                    ASCII = 7'd83;
                else if(key_down[8'h2C])//T
                    ASCII = 7'd84;
                else if(key_down[8'h3C])//U
                    ASCII = 7'd85;
                else if(key_down[8'h2A])//V
                    ASCII = 7'd86;
                else if(key_down[8'h1D])//W
                    ASCII = 7'd87;
                else if(key_down[8'h22])//X
                    ASCII = 7'd88;
                else if(key_down[8'h35])//Y
                    ASCII = 7'd89;
                else if(key_down[8'h1A])//Z
                    ASCII = 7'd90;
                else
                    ASCII = 7'd0;
            end
            else
            begin
                if(key_down[8'h1C])//a
                    ASCII = 7'd97;
                else if(key_down[8'h32])//b
                    ASCII = 7'd98;
                else if(key_down[8'h21])//c
                    ASCII = 7'd99;
                else if(key_down[8'h23])//d
                    ASCII = 7'd100;
                else if(key_down[8'h24])//e
                    ASCII = 7'd101;
                else if(key_down[8'h2B])//f
                    ASCII = 7'd102;
                else if(key_down[8'h34])//g
                    ASCII = 7'd103;
                else if(key_down[8'h33])//h
                    ASCII = 7'd104;
                else if(key_down[8'h43])//i
                    ASCII = 7'd105;
                else if(key_down[8'h3B])//j
                    ASCII = 7'd106;
                else if(key_down[8'h42])//k
                    ASCII = 7'd107;
                else if(key_down[8'h4B])//l
                    ASCII = 7'd108;
                else if(key_down[8'h3A])//m
                    ASCII = 7'd109;
                else if(key_down[8'h31])//n
                    ASCII = 7'd110;
                else if(key_down[8'h44])//o
                    ASCII = 7'd111;
                else if(key_down[8'h4D])//p
                    ASCII = 7'd112;
                else if(key_down[8'h15])//q
                    ASCII = 7'd113;
                else if(key_down[8'h2D])//r
                    ASCII = 7'd114;
                else if(key_down[8'h1B])//s
                    ASCII = 7'd115;
                else if(key_down[8'h2C])//t
                    ASCII = 7'd116;
                else if(key_down[8'h3C])//u
                    ASCII = 7'd117;
                else if(key_down[8'h2A])//v
                    ASCII = 7'd118;
                else if(key_down[8'h1D])//w
                    ASCII = 7'd119;
                else if(key_down[8'h22])//x
                    ASCII = 7'd120;
                else if(key_down[8'h35])//y
                    ASCII = 7'd121;
                else if(key_down[8'h1A])//z
                    ASCII = 7'd122;
                else
                    ASCII = 7'd0;
            end
        end
        else if(upper)
        begin
            if(~key_down[8'h12])
            begin
                if(key_down[8'h1C])//A
                    ASCII = 7'd65;
                else if(key_down[8'h32])//B
                    ASCII = 7'd66;
                else if(key_down[8'h21])//C
                    ASCII = 7'd67;
                else if(key_down[8'h23])//D
                    ASCII = 7'd68;
                else if(key_down[8'h24])//E
                    ASCII = 7'd69;
                else if(key_down[8'h2B])//F
                    ASCII = 7'd70;
                else if(key_down[8'h34])//G
                    ASCII = 7'd71;
                else if(key_down[8'h33])//H
                    ASCII = 7'd72;
                else if(key_down[8'h43])//I
                    ASCII = 7'd73;
                else if(key_down[8'h3B])//J
                    ASCII = 7'd74;
                else if(key_down[8'h42])//K
                    ASCII = 7'd75;
                else if(key_down[8'h4B])//L
                    ASCII = 7'd76;
                else if(key_down[8'h3A])//M
                    ASCII = 7'd77;
                else if(key_down[8'h31])//N
                    ASCII = 7'd78;
                else if(key_down[8'h44])//O
                    ASCII = 7'd79;
                else if(key_down[8'h4D])//P
                    ASCII = 7'd80;
                else if(key_down[8'h15])//Q
                    ASCII = 7'd81;
                else if(key_down[8'h2D])//R
                    ASCII = 7'd82;
                else if(key_down[8'h1B])//S
                    ASCII = 7'd83;
                else if(key_down[8'h2C])//T
                    ASCII = 7'd84;
                else if(key_down[8'h3C])//U
                    ASCII = 7'd85;
                else if(key_down[8'h2A])//V
                    ASCII = 7'd86;
                else if(key_down[8'h1D])//W
                    ASCII = 7'd87;
                else if(key_down[8'h22])//X
                    ASCII = 7'd88;
                else if(key_down[8'h35])//Y
                    ASCII = 7'd89;
                else if(key_down[8'h1A])//Z
                    ASCII = 7'd90;
                else
                    ASCII = 7'd0;
            end
            else
            begin
                if(key_down[8'h1C])//a
                    ASCII = 7'd97;
                else if(key_down[8'h32])//b
                    ASCII = 7'd98;
                else if(key_down[8'h21])//c
                    ASCII = 7'd99;
                else if(key_down[8'h23])//d
                    ASCII = 7'd100;
                else if(key_down[8'h24])//e
                    ASCII = 7'd101;
                else if(key_down[8'h2B])//f
                    ASCII = 7'd102;
                else if(key_down[8'h34])//g
                    ASCII = 7'd103;
                else if(key_down[8'h33])//h
                    ASCII = 7'd104;
                else if(key_down[8'h43])//i
                    ASCII = 7'd105;
                else if(key_down[8'h3B])//j
                    ASCII = 7'd106;
                else if(key_down[8'h42])//k
                    ASCII = 7'd107;
                else if(key_down[8'h4B])//l
                    ASCII = 7'd108;
                else if(key_down[8'h3A])//m
                    ASCII = 7'd109;
                else if(key_down[8'h31])//n
                    ASCII = 7'd110;
                else if(key_down[8'h44])//o
                    ASCII = 7'd111;
                else if(key_down[8'h4D])//p
                    ASCII = 7'd112;
                else if(key_down[8'h15])//q
                    ASCII = 7'd113;
                else if(key_down[8'h2D])//r
                    ASCII = 7'd114;
                else if(key_down[8'h1B])//s
                    ASCII = 7'd115;
                else if(key_down[8'h2C])//t
                    ASCII = 7'd116;
                else if(key_down[8'h3C])//u
                    ASCII = 7'd117;
                else if(key_down[8'h2A])//v
                    ASCII = 7'd118;
                else if(key_down[8'h1D])//w
                    ASCII = 7'd119;
                else if(key_down[8'h22])//x
                    ASCII = 7'd120;
                else if(key_down[8'h35])//y
                    ASCII = 7'd121;
                else if(key_down[8'h1A])//z
                    ASCII = 7'd122;
                else
                    ASCII = 7'd0;
            end
        end
        else
            ASCII = 7'd0;
    end
endmodule

