`timescale 1ns / 1ps
`include "global.v"
module task3(
	output [`SSD_BIT_WIDTH-1:0]segs,
    output [`SSD_DIGIT_NUM-1:0]ssd_ctl,
	inout wire PS2_DATA,
	inout wire PS2_CLK,
	input wire rst,
	input wire clk
    );
    wire key_valid;
    wire [511:0] key_down;
    wire [8:0] last_change;
    wire add,sub,mult,result;
    reg [`BCD_BIT_WIDTH-1:0] digit3,digit2,digit1,digit0;
    reg [`BCD_BIT_WIDTH-1:0] firstnum_dig1,secondnum_dig1;
    reg [`BCD_BIT_WIDTH-1:0] firstnum_dig2,secondnum_dig2;
    reg [6:0] firstnum,secondnum;
    reg [14:0] number;
    reg [14:0] sign_number;
    reg sign_flag;
    reg [2:0]count1;
    reg [2:0]count1_next;
    reg clk_d;
    wire [`SSD_SCAN_CTL_BIT_WIDTH-1:0] ssd_ctl_en;
    wire [`BCD_BIT_WIDTH-1:0] ssd_in;
    freqdiv27 U_FD(
        .clk_out(), // divided clock
        .clk_ctl(ssd_ctl_en), // divided clock for scan control 
        .clk(clk), // clock from the crystal
        .rst(rst) // low active reset
    );
    KeyboardDecoder(
        .key_down(key_down),
        .last_change(last_change),
        .key_valid(key_valid),
        .PS2_DATA(PS2_DATA),
        .PS2_CLK(PS2_CLK),
        .rst(rst),
        .clk(clk)
    );
    detect_calculate Ucal(
        .IN(last_change[7:0]),
        .rst(rst),
        .clk(clk),
        .add(add),
        .sub(sub),
        .mult(mult),
        .result(result)
    );
    always@(*)
    begin
        if(key_down==512'd0)
            clk_d = 0;
        else
            clk_d = 1;
    end
    always@(*)
    begin
        if(rst)
        begin
            firstnum = 7'd0;
            secondnum = 7'd0;
            count1 = 3'd0;
        end
        else
        begin
            count1 = count1_next;
            firstnum = firstnum_dig1*10 + firstnum_dig2;
            secondnum = secondnum_dig1*10 + secondnum_dig2;
        end    
    end
    
    always@(posedge clk_d or posedge rst)
    begin
        if(rst)
        begin
            firstnum_dig1 <= 4'd0;
            firstnum_dig2 <= 4'd0;
            secondnum_dig1 <= 4'd0; 
            secondnum_dig2 <= 4'd0;
            number <= 15'd0;
            count1_next <= 3'd0;
        end
        else if(~add && ~sub && ~mult && ~result && (count1 == 3'd0))
        begin
            firstnum_dig2 <= 4'd0;
            secondnum_dig1 <= 4'd0;
            secondnum_dig2 <= 4'd0;
            if(key_down[8'h70])
            begin
                firstnum_dig1 <= 4'd0;
                number <= 15'd0;
                count1_next <= 3'd1;
            end
            else if(key_down[8'h69])
            begin
                firstnum_dig1 <= 4'd1; 
                number <= 15'd0;
                count1_next <= 3'd1;
            end
            else if(key_down[8'h72])
            begin
                firstnum_dig1 <= 4'd2;
                number <= 15'd0;
                count1_next <= 3'd1;
            end
            else if(key_down[8'h7A])
            begin
                firstnum_dig1 <= 4'd3;
                number <= 15'd0;
                count1_next <= 3'd1;
            end
            else if(key_down[8'h6B])
            begin
                firstnum_dig1 <= 4'd4; 
                number <= 15'd0;
                count1_next <= 3'd1;
            end
            else if(key_down[8'h73])
            begin
                firstnum_dig1 <= 4'd5; 
                number <= 15'd0;
                count1_next <= 3'd1;
            end
            else if(key_down[8'h74])
            begin
                firstnum_dig1 <= 4'd6;
                number <= 15'd0;
                count1_next <= 3'd1;
            end
            else if(key_down[8'h6C])
            begin
                firstnum_dig1 <= 4'd7; 
                number <= 15'd0;
                count1_next <= 3'd1;
            end
            else if(key_down[8'h75])
            begin
                firstnum_dig1 <= 4'd8;
                number <= 15'd0;
                count1_next <= 3'd1;
            end
            else if(key_down[8'h7D])
            begin
                firstnum_dig1 <= 4'd9; 
                number <= 15'd0;
                count1_next <= 3'd1;
            end
            else
            begin
                firstnum_dig1 <= firstnum_dig1;
                number <= 15'd0;
                count1_next <= 3'd0;
            end
        end
        else if(~add && ~sub && ~mult && ~result && (count1 == 3'd1))
        begin
            firstnum_dig1 <= firstnum_dig1;
            secondnum_dig1 <= 4'd0;
            secondnum_dig2 <= 4'd0;
            if(key_down[8'h70])
            begin
                firstnum_dig2 <= 4'd0;
                number <= 15'd0;
                count1_next <= 3'd2;
            end
            else if(key_down[8'h69])
            begin
                firstnum_dig2 <= 4'd1; 
                number <= 15'd0;
                count1_next <= 3'd2;
            end
            else if(key_down[8'h72])
            begin
                firstnum_dig2 <= 4'd2;
                number <= 15'd0;
                count1_next <= 3'd2;
            end
            else if(key_down[8'h7A])
            begin
                firstnum_dig2 <= 4'd3;
                number <= 15'd0;
                count1_next <= 3'd2;
            end
            else if(key_down[8'h6B])
            begin
                firstnum_dig2 <= 4'd4; 
                number <= 15'd0;
                count1_next <= 3'd2;
            end
            else if(key_down[8'h73])
            begin
                firstnum_dig2 <= 4'd5; 
                number <= 15'd0;
                count1_next <= 3'd2;
            end
            else if(key_down[8'h74])
            begin
                firstnum_dig2 <= 4'd6;
                number <= 15'd0;
                count1_next <= 3'd2;
            end
            else if(key_down[8'h6C])
            begin
                firstnum_dig2 <= 4'd7; 
                number <= 15'd0;
                count1_next <= 3'd2;
            end
            else if(key_down[8'h75])
            begin
                firstnum_dig2 <= 4'd8;
                number <= 15'd0;
                count1_next <= 3'd2;
            end
            else if(key_down[8'h7D])
            begin
                firstnum_dig2 <= 4'd9; 
                number <= 15'd0;
                count1_next <= 3'd2;
            end
            else
            begin
                firstnum_dig2 <= firstnum_dig2;
                number <= 15'd0;
                count1_next <= 3'd1;
            end
        end
        else if((add || sub || mult) && ~result && (count1 == 3'd2))
        begin
            firstnum_dig1 <= firstnum_dig1;
            firstnum_dig2 <= firstnum_dig2;
            secondnum_dig2 <= 4'd0;
            case(last_change[7:0])
            8'h70:
            begin
                secondnum_dig1 <= 4'd0; 
                number <= 15'd0;
                count1_next <= 3'd3;
            end
            8'h69:
            begin
                secondnum_dig1 <= 4'd1;
                number <= 15'd0;
                count1_next <= 3'd3;
            end
            8'h72:
            begin
                secondnum_dig1 <= 4'd2;
                number <= 15'd0;
                count1_next <= 3'd3;
            end
            8'h7A:
            begin
                secondnum_dig1 <= 4'd3;
                number <= 15'd0;
                count1_next <= 3'd3;
            end
            8'h6B:
            begin
                secondnum_dig1 <= 4'd4;
                number <= 15'd0;
                count1_next <= 3'd3;
            end
            8'h73:
            begin
                secondnum_dig1 <= 4'd5;
                number <= 15'd0;
                count1_next <= 3'd3;
            end
            8'h74:
            begin
                secondnum_dig1 <= 4'd6;
                number <= 15'd0;
                count1_next <= 3'd3;
            end
            8'h6C:
            begin
                secondnum_dig1 <= 4'd7;
                number <= 15'd0;
                count1_next <= 3'd3;
            end
            8'h75:
            begin
                secondnum_dig1 <= 4'd8;
                number <= 15'd0;
                count1_next <= 3'd3;
            end
            8'h7D:
            begin
                secondnum_dig1 <= 4'd9;
                number <= 15'd0;
                count1_next <= 3'd3;
            end
            default:
            begin
                secondnum_dig1 <= secondnum_dig1;
                number <= 15'd0;
                count1_next <= 3'd2;
            end
            endcase        
        end
        else if((add || sub || mult) && ~result && (count1_next == 3'd3))
        begin
            firstnum_dig1 <= firstnum_dig1;
            firstnum_dig2 <= firstnum_dig2;
            secondnum_dig1 <= secondnum_dig1;
            case(last_change[7:0])
            8'h70:
            begin
                secondnum_dig2 <= 4'd0; 
                number <= 15'd0;
                count1_next <= 3'd4;
            end
            8'h69:
            begin
                secondnum_dig2 <= 4'd1;
                number <= 15'd0;
                count1_next <= 3'd4;
            end
            8'h72:
            begin
                secondnum_dig2 <= 4'd2;
                number <= 15'd0;
                count1_next <= 3'd4;
            end
            8'h7A:
            begin
                secondnum_dig2 <= 4'd3;
                number <= 15'd0;
                count1_next <= 3'd4;
            end
            8'h6B:
            begin
                secondnum_dig2 <= 4'd4;
                number <= 15'd0;
                count1_next <= 3'd4;
            end
            8'h73:
            begin
                secondnum_dig2 <= 4'd5;
                number <= 15'd0;
                count1_next <= 3'd4;
            end
            8'h74:
            begin
                secondnum_dig2 <= 4'd6;
                number <= 15'd0;
                count1_next <= 3'd4;
            end
            8'h6C:
            begin
                secondnum_dig2 <= 4'd7;
                number <= 15'd0;
                count1_next <= 3'd4;
            end
            8'h75:
            begin
                secondnum_dig2 <= 4'd8;
                number <= 15'd0;
                count1_next <= 3'd4;
            end
            8'h7D:
            begin
                secondnum_dig2 <= 4'd9;
                number <= 15'd0;
                count1_next <= 3'd4;
            end
            default:
            begin
                secondnum_dig2 <= secondnum_dig2;
                number <= 15'd0;
                count1_next <= 3'd3;
            end
            endcase        
        end
        else if(add && result) 
        begin
            firstnum_dig1 <= firstnum_dig1;
            firstnum_dig2 <= firstnum_dig2;
            secondnum_dig1 <= secondnum_dig1;
            secondnum_dig2 <= secondnum_dig2;
            number <= firstnum + secondnum;
            count1_next <= 3'd0;
        end
        else if(sub && result) 
        begin
            firstnum_dig1 <= firstnum_dig1;
            firstnum_dig2 <= firstnum_dig2;
            secondnum_dig1 <= secondnum_dig1;
            secondnum_dig2 <= secondnum_dig2;
            number <= firstnum - secondnum;
            count1_next <= 3'd0;
        end
        else if(mult && result) 
        begin
            firstnum_dig1 <= firstnum_dig1;
            firstnum_dig2 <= firstnum_dig2;
            secondnum_dig1 <= secondnum_dig1;
            secondnum_dig2 <= secondnum_dig2;
            number <= firstnum * secondnum;
            count1_next <= 3'd0;
        end
        else 
        begin
            firstnum_dig1 <= firstnum_dig1;
            firstnum_dig2 <= firstnum_dig2;
            secondnum_dig1 <= secondnum_dig1;
            secondnum_dig2 <= secondnum_dig2;
            number <= number;
            count1_next <= count1;
        end  
    end
    always@(*)
    begin
        if(rst)
        begin
            sign_number = 15'd0;
            sign_flag =0;
        end
        else if(number[14] == 1)
        begin
            sign_number = (~number)+1;
            sign_flag = 1;
        end
        else
        begin
            sign_number = number;
            sign_flag =0;
        end                
    end
    always@(posedge clk or posedge rst)
    begin
        if(rst)
        begin
            digit0 <= 4'd0;
            digit1 <= 4'd0;
            digit2 <= 4'd0;
            digit3 <= 4'd0;
        end
        else if(result && ~sign_flag)
        begin
            digit0 <= number%10;
            digit1 <= (number%100)/10;
            digit2 <= (number%1000)/100;
            digit3 <= (number%10000)/1000;
        end
        else if(result && sign_flag)
        begin
            digit0 <= sign_number%10;
            digit1 <= sign_number/10;
            digit2 <= 4'd0;
            digit3 <= 4'd15;
        end
        else if(~add && ~sub && ~mult && ~result)
        begin
            digit0 <= firstnum%10;
            digit1 <= firstnum/10;
            digit2 <= 4'd0;
            digit3 <= 4'd0;
        end
        else if((add || sub || mult) && ~result)
        begin
            digit0 <= secondnum%10;
            digit1 <= secondnum/10;
            digit2 <= 4'd0;
            digit3 <= 4'd0;
        end
        else 
        begin
            digit0 <= digit0;
            digit1 <= digit1;
            digit2 <= digit2;
            digit3 <= digit3;
        end
    end
    scan_ctl U_SC(
        .ssd_ctl(ssd_ctl), // ssd display control signal 
        .ssd_in(ssd_in), // output to ssd display
        .in0(digit3), // 1st input
        .in1(digit2), // 2nd input
        .in2(digit1), // 3rd input
        .in3(digit0),  // 4th input
        .ssd_ctl_en(ssd_ctl_en) // divided clock for scan control
      );
    display U_display(
        .segs(segs), // 7-segment display output
        .bin(ssd_in)  // BCD number input
      );   
endmodule

