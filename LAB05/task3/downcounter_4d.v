//************************************************************************
// Filename      : stopwatch.v
// Author        : hp
// Function      : Basic up counter module for digital watch
// Last Modified : Date: 2009-03-10
// Revision      : Revision: 1
// Copyright (c), Laboratory for Reliable Computing (LaRC), EE, NTHU
// All rights reserved
//************************************************************************
`include "global.v"
module downcounter_4d(
  set_number3,
  set_number2,
  set_number1,
  set_number0,
  digit3,  // 4nd digit of the up counter
  digit2,  // 3st digit of the up counter
  digit1,  // 2nd digit of the up counter
  digit0,  // 1st digit of the up counter
  clk,  // global clock
  rst,  // high active reset
  en, // enable/disable for the stopwatch
  stop
);
output [`BCD_BIT_WIDTH-1:0] digit3; // 4nd digit of the up counter
output [`BCD_BIT_WIDTH-1:0] digit2; // 3st digit of the up counter
output [`BCD_BIT_WIDTH-1:0] digit1; // 2nd digit of the up counter
output [`BCD_BIT_WIDTH-1:0] digit0; // 1st digit of the up counter
input [`BCD_BIT_WIDTH-1:0] set_number3;
input [`BCD_BIT_WIDTH-1:0] set_number2;
input [`BCD_BIT_WIDTH-1:0] set_number1;
input [`BCD_BIT_WIDTH-1:0] set_number0;
input clk;  // global clock
input rst;  // low active reset
input en; // enable/disable for the stopwatch
input stop;

wire br0,br1,br2,br3; // borrow indicator 
wire decrease_enable;

assign decrease_enable = en && (~((digit0==`BCD_ZERO)&&(digit1==`BCD_ZERO)&&(digit2==`BCD_ZERO)&&(digit3==`BCD_ZERO)));
  
// 30 sec up counter
downcounter Udc0(
  .value(digit0),  // counter value 
  .borrow(br0),  // borrrow indicator for counter to next stage
  .clk(clk), // global clock signal
  .rst(rst),  // low active reset
  .stop(stop),
  .decrease(decrease_enable),  // decrease input from previous stage of counter
  .init_value(set_number0),  // initial value for the counter
  .limit(`BCD_NINE)  // limit for the counter
);

downcounter Udc1(
  .value(digit1),  // counter value 
  .borrow(br1),  // borrrow indicator for counter to next stage
  .clk(clk), // global clock signal
  .rst(rst),  // low active reset
  .stop(stop),
  .decrease(br0),  // decrease input from previous stage of counter
  .init_value(set_number1),  // initial value for the counter
  .limit(`BCD_FIVE)  // limit for the counter
);
downcounter Udc2(
  .value(digit2),  // counter value 
  .borrow(br2),  // borrrow indicator for counter to next stage
  .clk(clk), // global clock signal
  .rst(rst),  // low active reset
  .stop(stop),
  .decrease(br1),  // decrease input from previous stage of counter
  .init_value(set_number2),  // initial value for the counter
  .limit(`BCD_NINE)  // limit for the counter
);

downcounter Udc3(
  .value(digit3),  // counter value 
  .borrow(br3),  // borrrow indicator for counter to next stage
  .clk(clk), // global clock signal
  .rst(rst),  // low active reset
  .stop(stop),
  .decrease(br2),  // decrease input from previous stage of counter
  .init_value(set_number3),  // initial value for the counter
  .limit(`BCD_FIVE)  // limit for the counter
);

endmodule
