`timescale 1ns / 1ps
`include "global.v"
module task1(
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
    reg [`BCD_BIT_WIDTH-1:0] number;
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
    always@(*)
    begin
        case(last_change)
        8'h70:
            number = `BCD_ZERO;
        8'h69:
            number = `BCD_ONE;
        8'h72:
            number = `BCD_TWO;
        8'h7A:
            number = `BCD_THREE;
        8'h6B:
            number = `BCD_FOUR;
        8'h73:
            number = `BCD_FIVE;
        8'h74:
            number = `BCD_SIX;
        8'h6C:
            number = `BCD_SEVEN;
        8'h75:
            number = `BCD_EIGHT;
        8'h7D:
            number = `BCD_NINE;
        8'h1C:
            number = 4'd10;
        8'h1B:
            number = 4'd11;
        8'h3A:
            number = 4'd12;
        default:
            number = 0;
        endcase
    end
    scan_ctl U_SC(
        .ssd_ctl(ssd_ctl), // ssd display control signal 
        .ssd_in(ssd_in), // output to ssd display
        .in0(4'd0), // 1st input
        .in1(4'd0), // 2nd input
        .in2(4'd0), // 3rd input
        .in3(number),  // 4th input
        .ssd_ctl_en(ssd_ctl_en) // divided clock for scan control
      );
    display U_display(
        .segs(segs), // 7-segment display output
        .bin(ssd_in)  // BCD number input
      );   
endmodule

