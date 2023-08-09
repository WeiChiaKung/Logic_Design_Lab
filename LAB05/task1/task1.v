`timescale 1ns / 1ps
`include "global.v"
module task1(
  segs, // 7 segment display control
  ssd_ctl, // scan control for 7-segment display
  clk, // clock
  rst, // high active reset
  in, // input control for FSM
  LED
);

output [`SSD_BIT_WIDTH-1:0] segs; // 7 segment display control
output [`SSD_DIGIT_NUM-1:0] ssd_ctl; // scan control for 7-segment display
output reg[15:0]LED;
input clk; // clock
input rst; // high active reset
input in; // input control for FSM

wire [`SSD_SCAN_CTL_BIT_WIDTH-1:0] ssd_ctl_en; // divided output for ssd scan control
wire clk_d; // divided clock

wire count_enable; // if count is enabled

wire [`BCD_BIT_WIDTH-1:0] dig0,dig1; // second counter output
wire [`BCD_BIT_WIDTH-1:0] ssd_in; // input to 7-segment display decoder

//**************************************************************
// Functional block
//**************************************************************
// frequency divider 1/(2^27)
freqdiv27 U_FD(
  .clk_out(clk_d), // divided clock
  .clk_ctl(ssd_ctl_en), // divided clock for scan control 
  .clk(clk), // clock from the crystal
  .rst(rst) // low active reset
);

// finite state machine
fsm U_fsm(
  .count_enable(count_enable),  // if counter is enabled 
  .in(in), //input control
  .clk(clk_d), // global clock signal
  .rst(rst)  // low active reset
);

// stopwatch module
downcounter_2d U_sw(
  .digit1(dig1),  // 2nd digit of the down counter
  .digit0(dig0),  // 1st digit of the down counter
  .clk(clk_d),  // global clock
  .rst(rst),  // low active reset
  .en(count_enable) // enable/disable for the stopwatch
);

//**************************************************************
// Display block
//**************************************************************
// BCD to 7-segment display decoding
// seven-segment display decoder for DISP1

// Scan control
scan_ctl U_SC(
  .ssd_ctl(ssd_ctl), // ssd display control signal 
  .ssd_in(ssd_in), // output to ssd display
  .in0(4'b0000), // 1st input
  .in1(4'b0000), // 2nd input
  .in2(dig1), // 3rd input
  .in3(dig0),  // 4th input
  .ssd_ctl_en(ssd_ctl_en) // divided clock for scan control
);
always@(*)
begin
    if(dig0 == 4'd0 && dig1 == 4'd0)
        LED = 16'b1111111111111111;
    else
        LED = 16'd0;
end
// binary to 7-segment display decoder
display U_display(
  .segs(segs), // 7-segment display output
  .bin(ssd_in)  // BCD number input
);

endmodule
