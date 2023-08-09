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
module upcounter_4d(
  digit3,  // 4nd digit of the up counter
  digit2,  // 3st digit of the up counter
  digit1,  // 2nd digit of the up counter
  digit0,  // 1st digit of the up counter
  clk,  // global clock
  rst,  // high active reset
  en, // enable/disable for the stopwatch
  stop_n
);
output [`BCD_BIT_WIDTH-1:0] digit3; // 4nd digit of the up counter
output [`BCD_BIT_WIDTH-1:0] digit2; // 3st digit of the up counter
output [`BCD_BIT_WIDTH-1:0] digit1; // 2nd digit of the up counter
output [`BCD_BIT_WIDTH-1:0] digit0; // 1st digit of the up counter

input clk;  // global clock
input rst;  // low active reset
input en; // enable/disable for the stopwatch
input stop_n;

wire cr0,cr1,cr2,cr3; // borrow indicator 
wire increase_enable;

assign increase_enable = en && (~((digit0==`BCD_NINE)&&(digit1==`BCD_FIVE)&&(digit2==`BCD_NINE)&&(digit3==`BCD_FIVE)));
  
// 30 sec up counter
upcounter Udc0(
  .value(digit0),  // counter value 
  .carry(cr0),  // carry indicator for counter to next stage
  .clk(clk), // global clock signal
  .rst(rst),  // low active reset
  .stop_n(stop_n),
  .increase(increase_enable),  // increase input from previous stage of counter
  .init_value(`BCD_ZERO),  // initial value for the counter
  .limit(`BCD_NINE)  // limit for the counter
);

upcounter Udc1(
  .value(digit1),  // counter value 
  .carry(cr1),  // carry indicator for counter to next stage
  .clk(clk), // global clock signal
  .rst(rst),  // low active reset
  .stop_n(stop_n),
  .increase(cr0),  // increase input from previous stage of counter
  .init_value(`BCD_ZERO),  // initial value for the counter
  .limit(`BCD_FIVE)  // limit for the counter
);
upcounter Udc2(
  .value(digit2),  // counter value 
  .carry(cr2),  // carry indicator for counter to next stage
  .clk(clk), // global clock signal
  .rst(rst),  // low active reset
  .stop_n(stop_n),
  .increase(cr1),  // increase input from previous stage of counter
  .init_value(`BCD_ZERO),  // initial value for the counter
  .limit(`BCD_NINE)  // limit for the counter
);

upcounter Udc3(
  .value(digit3),  // counter value 
  .carry(cr3),  // carry indicator for counter to next stage
  .clk(clk), // global clock signal
  .rst(rst),  // low active reset
  .stop_n(stop_n),
  .increase(cr2),  // increase input from previous stage of counter
  .init_value(`BCD_ZERO),  // initial value for the counter
  .limit(`BCD_FIVE)  // limit for the counter
);

endmodule
