`timescale 1ns / 1ps
`include "global.v"
module task2(
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
    wire calculate,result;
    reg [`BCD_BIT_WIDTH-1:0] addend,augend,digit1,digit0;
    reg [`BCD_BIT_WIDTH:0] number;
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
        .calculate(calculate),
        .result(result)
    );
    always@(posedge clk or posedge rst)
    begin
        if(rst)
        begin
            addend <= `BCD_ZERO;
            augend <= `BCD_ZERO; 
            number <= 5'd0;
        end
        else if(~calculate && ~result)
        begin
           case(last_change[7:0])
            8'h70:
            begin
                addend <= `BCD_ZERO;
                augend <= `BCD_ZERO;
                number <= 5'd0;
            end
            8'h69:
            begin
                addend <= `BCD_ONE;
                augend <= `BCD_ZERO;
                number <= 5'd0;
            end
            8'h72:
            begin
                addend <= `BCD_TWO;
                augend <= `BCD_ZERO;
                number <= 5'd0;
            end
            8'h7A:
            begin
                addend <= `BCD_THREE;
                augend <= `BCD_ZERO;
                number <= 5'd0;
            end
            8'h6B:
            begin
                addend <= `BCD_FOUR;
                augend <= `BCD_ZERO;
                number <= 5'd0;
            end
            8'h73:
            begin
                addend <= `BCD_FIVE;
                augend <= `BCD_ZERO;
                number <= 5'd0;
            end
            8'h74:
            begin
                addend <= `BCD_SIX;
                augend <= `BCD_ZERO;
                number <= 5'd0;
            end
            8'h6C:
            begin
                addend <= `BCD_SEVEN;
                augend <= `BCD_ZERO;
                number <= 5'd0;
            end
            8'h75:
            begin
                addend <= `BCD_EIGHT;
                augend <= `BCD_ZERO;
                number <= 5'd0;
            end
            8'h7D:
            begin
                addend <= `BCD_NINE;
                augend <= `BCD_ZERO;
                number <= 5'd0;
            end
            default:
            begin
                addend <= addend;
                augend <= augend;
                number <= 5'd0;
            end
            endcase
        end
        else if(calculate && ~result)
        begin
            case(last_change[7:0])
            8'h70:
            begin
                augend <= `BCD_ZERO;
                addend <= addend;
                number <= 5'd0;
            end
            8'h69:
            begin
                augend <= `BCD_ONE;
                addend <= addend;
                number <= 5'd0;
            end
            8'h72:
            begin
                augend <= `BCD_TWO;
                addend <= addend;
                number <= 5'd0;
            end
            8'h7A:
            begin
                augend <= `BCD_THREE;
                addend <= addend;
                number <= 5'd0;
            end
            8'h6B:
            begin
                augend <= `BCD_FOUR;
                addend <= addend;
                number <= 5'd0;
            end
            8'h73:
            begin
                augend <= `BCD_FIVE;
                addend <= addend;
                number <= 5'd0;
            end
            8'h74:
            begin
                augend <= `BCD_SIX;
                addend <= addend;
                number <= 5'd0;
            end
            8'h6C:
            begin
                augend <= `BCD_SEVEN;
                addend <= addend;
                number <= 5'd0;
            end
            8'h75:
            begin
                augend <= `BCD_EIGHT;
                addend <= addend;
                number <= 5'd0;
            end
            8'h7D:
            begin
                augend <= `BCD_NINE;
                addend <= addend;
                number <= 5'd0;
            end
            default:
            begin
                augend <= augend;
                addend <= addend;
                number <= 5'd0;
            end
            endcase        
        end
        else
        begin
            augend <= augend;
            addend <= addend;
            number <= addend + augend;
        end
    end
    always@(posedge clk or posedge rst)
    begin
        if(rst)
        begin
            digit0 <= 4'd0;
            digit1 <= 4'd0;
        end
        else if(result)
        begin
            digit0 <= number%10;
            digit1 <= number/10;
        end
        else
        begin
            digit0 <= digit0;
            digit1 <= digit1;
        end
    end
    scan_ctl U_SC(
        .ssd_ctl(ssd_ctl), // ssd display control signal 
        .ssd_in(ssd_in), // output to ssd display
        .in0(addend), // 1st input
        .in1(augend), // 2nd input
        .in2(digit1), // 3rd input
        .in3(digit0),  // 4th input
        .ssd_ctl_en(ssd_ctl_en) // divided clock for scan control
      );
    display U_display(
        .segs(segs), // 7-segment display output
        .bin(ssd_in)  // BCD number input
      );   
endmodule

