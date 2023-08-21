`timescale 1ns / 1ps
`include "global.v"
module task2(
  segs, // 7 segment display control
  ssd_ctl, // scan control for 7-segment display
  clk, // clock
  rst, // high active reset
  in, // input control for FSM
  in1
);

output [`SSD_BIT_WIDTH-1:0] segs; // 7 segment display control
output [`SSD_DIGIT_NUM-1:0] ssd_ctl; // scan control for 7-segment display
input clk; // clock
input rst; // high active reset
input in; // input control for FSM
input in1;
wire [`SSD_SCAN_CTL_BIT_WIDTH-1:0] ssd_ctl_en; // divided output for ssd scan control
wire clk_d; // divided clock

wire count_enable; // if count is enabled
wire show_time;
wire reset;
reg [`BCD_BIT_WIDTH-1:0] segnumber0,segnumber1,segnumber2,segnumber3;
wire [`BCD_BIT_WIDTH-1:0] dig0,dig1,dig2,dig3; // second counter output
reg [`BCD_BIT_WIDTH-1:0] lap0,lap1,lap2,lap3; // second counter output
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
  .show_time(show_time),
  .reset(reset),
  .in(in), //input control
  .in1(in1),
  .clk(clk_d), // global clock signal
  .rst(rst)  // low active reset
);

// stopwatch module
upcounter_4d U_sw(
  .digit3(dig3),  
  .digit2(dig2),
  .digit1(dig1),  // 2nd digit of the down counter
  .digit0(dig0),  // 1st digit of the down counter
  .clk(clk_d),  // global clock
  .rst(rst),  // low active reset
  .en(count_enable), // enable/disable for the stopwatch
  .reset(reset)
);
always@(posedge show_time)
begin
  lap0 <= dig0;
  lap1 <= dig1;
  lap2 <= dig2;
  lap3 <= dig3;
end
always@(*)
begin
  if (show_time)
  begin
      segnumber0 = lap0;
      segnumber1 = lap1;
      segnumber2 = lap2;
      segnumber3 = lap3;
  end
  else
  begin
      segnumber0 = dig0;
      segnumber1 = dig1;
      segnumber2 = dig2;
      segnumber3 = dig3;
  end
end
//**************************************************************
// Display block
//**************************************************************
// BCD to 7-segment display decoding
// seven-segment display decoder for DISP1

// Scan control
scan_ctl U_SC(
  .ssd_ctl(ssd_ctl), // ssd display control signal 
  .ssd_in(ssd_in), // output to ssd display
  .in0(segnumber3), // 1st input
  .in1(segnumber2), // 2nd input
  .in2(segnumber1), // 3rd input
  .in3(segnumber0),  // 4th input
  .ssd_ctl_en(ssd_ctl_en) // divided clock for scan control
);
// binary to 7-segment display decoder
display U_display(
  .segs(segs), // 7-segment display output
  .bin(ssd_in)  // BCD number input
);

endmodule
