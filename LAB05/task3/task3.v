`timescale 1ns / 1ps
`include "global.v"
module task3(
  segs, // 7 segment display control
  ssd_ctl, // scan control for 7-segment display
  clk, // clock
  rst, // high active reset
  in, // input control for FSM
  in1,
  in2,
  in3,
  set_mode,
  LED
);

output [`SSD_BIT_WIDTH-1:0] segs; // 7 segment display control
output [`SSD_DIGIT_NUM-1:0] ssd_ctl; // scan control for 7-segment display
output reg[15:0] LED;
input clk; // clock
input rst; // high active reset
input in; // input control for FSM
input in1;
input in2;
input in3;
input set_mode;
wire [`SSD_SCAN_CTL_BIT_WIDTH-1:0] ssd_ctl_en; // divided output for ssd scan control
wire clk_d; // divided clock
wire count_enable; // if count is enabled
wire stop;
reg [`BCD_BIT_WIDTH-1:0] segnumber0,segnumber1,segnumber2,segnumber3;
wire [`BCD_BIT_WIDTH-1:0] dig0,dig1,dig2,dig3; // second counter output
wire [`BCD_BIT_WIDTH-1:0] setnumber0,setnumber1,setnumber2,setnumber3; // second counter output
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
  .set_mode(set_mode),
  .in(in), //input control
  .in1(in1),
  .clk(clk_d), // global clock signal
  .rst(rst),  // low active reset
  .stop(stop)
);
upcounter_setting U_up(
  .digit3(setnumber3),  // 4nd digit of the up counter
  .digit2(setnumber2),  // 3st digit of the up counter
  .digit1(setnumber1),  // 2nd digit of the up counter
  .digit0(setnumber0),  // 1st digit of the up counter
  .clk(clk_d),  // global clock
  .rst(rst),  // high active reset
  .en(in2), // enable/disable for the stopwatch
  .en1(in3)
);
// stopwatch module
downcounter_4d U_sw(
  .set_number3(setnumber3),
  .set_number2(setnumber2),
  .set_number1(setnumber1),
  .set_number0(setnumber0),
  .digit3(dig3),  
  .digit2(dig2),
  .digit1(dig1),  // 2nd digit of the down counter
  .digit0(dig0),  // 1st digit of the down counter
  .clk(clk_d),  // global clock
  .rst(rst),  // low active reset
  .stop(stop),
  .en(count_enable) // enable/disable for the stopwatch
);
always@(*)
begin
  if(dig0 == 4'd0 && dig1 == 4'd0 && dig2 == 4'd0 && dig3 == 4'd0)
      LED = 16'b1111111111111111;
  else
      LED = 16'd0;
end
always@(*)
begin
  if (set_mode)
  begin
      segnumber0 = setnumber0;
      segnumber1 = setnumber1;
      segnumber2 = setnumber2;
      segnumber3 = setnumber3;
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
