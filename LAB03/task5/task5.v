`timescale 1ns / 1ps
`define SS_0 8'b00000011
`define SS_1 8'b10011111
`define SS_2 8'b00100101
`define SS_3 8'b00001101
`define SS_4 8'b10011001
`define SS_5 8'b01001001
`define SS_6 8'b01000001
`define SS_7 8'b00011111
`define SS_8 8'b00000001
`define SS_9 8'b00001001
`define SS_10 8'b01100001
`define SS_11 8'b10010001
`define SS_12 8'b11010101
`define SS_13 8'b11100001
`define SS_14 8'b10000011
module task5(
    input CLK,
    input rst_n,
    output reg[3:0] ssd_ctl,
    output reg[7:0] seg
    );
    wire CLK_temp;
    reg [4:0]part10,part9,part8,part7,part6,part5,part4,part3,part2,part1,seg_number;
    reg [17:0] counter;
    reg [17:0] counter_next;
    reg [2:0] state;
    reg [2:0] state_next;
    freq_div U0(.CLK(CLK), .rst_n(rst_n), .CLK_out(CLK_temp));
    always@(posedge CLK_temp or negedge rst_n) 
    begin
        if(~rst_n)
        begin
            part10 <= 4'd12;
            part9 <= 4'd13;
            part8 <= 4'd11;
            part7 <= 4'd14;
            part6 <= 4'd10;
            part5 <= 4'd10;
            part4 <= 4'd2;
            part3 <= 4'd0;
            part2 <= 4'd2;
            part1 <= 4'd3;
        end
        else 
        begin
            part10 <= part9;
            part9 <= part8;
            part8 <= part7;
            part7 <= part6;
            part6 <= part5;
            part5 <= part4;
            part4 <= part3;
            part3 <= part2;
            part2 <= part1;
            part1 <= part10;
        end
     end
     always@(posedge CLK or negedge rst_n) 
     begin
     if(~rst_n)begin
         counter <= 18'd0;
         state <= 3'd0;
         seg_number <= 4'd0; 
         ssd_ctl <= 4'b0000;
     end
     else 
     begin
       counter <=(counter<=100000) ? (counter_next) : 0;
       state <= (counter==100000) ? (state_next) : state ;
        case(state)
         0:
         begin
           seg_number <= part10; 
           ssd_ctl <= 4'b0111;
         end
         1:
         begin
           seg_number <= part9;  
           ssd_ctl <= 4'b1011;
         end
         2:
         begin
           seg_number <= part8; 
           ssd_ctl <= 4'b1101;
         end
         3:
         begin
           seg_number <= part7; 
           ssd_ctl <= 4'b1110;
         end
         endcase
     end
     end
     always@(*) 
     begin
        counter_next = counter+1;
        state_next = state+1;
     end
     always@(*)
     begin
         case(seg_number)
             4'd0:  seg = `SS_0; 
             4'd1:  seg = `SS_1; 
             4'd2:  seg = `SS_2;
             4'd3:  seg = `SS_3;
             4'd4:  seg = `SS_4;
             4'd5:  seg = `SS_5;
             4'd6:  seg = `SS_6;
             4'd7:  seg = `SS_7;
             4'd8:  seg = `SS_8;
             4'd9:  seg = `SS_9;
             4'd10: seg = `SS_10;
             4'd11: seg = `SS_11;
             4'd12: seg = `SS_12;
             4'd13: seg = `SS_13;
             4'd14: seg = `SS_14;
             default: seg = 8'b11111111;
         endcase
     end
endmodule

