`include "global.v"
module upcounter_4d(
  digit3,  // 4nd digit of the up counter
  digit2,  // 3st digit of the up counter
  digit1,  // 2nd digit of the up counter
  digit0,  // 1st digit of the up counter
  clk,  // global clock
  rst_n,  // high active reset
  en, // enable/disable for the stopwatch
  stop_n
);
output [`BCD_BIT_WIDTH-1:0] digit3; // 4nd digit of the up counter
output [`BCD_BIT_WIDTH-1:0] digit2; // 3st digit of the up counter
output [`BCD_BIT_WIDTH-1:0] digit1; // 2nd digit of the up counter
output [`BCD_BIT_WIDTH-1:0] digit0; // 1st digit of the up counter

input clk;  // global clock
input rst_n;  // low active reset
input en; // enable/disable for the stopwatch
input stop_n;

wire cr0,cr1,cr2,cr3; // borrow indicator 
wire increase_enable;

assign increase_enable = en && (~((digit0==`NINE)&&(digit1==`FIVE)&&(digit2==`NINE)&&(digit3==`FIVE)));
  
// 30 sec up counter
upcounter Udc0(
  .value(digit0),  // counter value 
  .carry(cr0),  // carry indicator for counter to next stage
  .clk(clk), // global clock signal
  .rst_n(rst_n),  // low active reset
  .stop_n(stop_n),
  .increase(increase_enable),  // increase input from previous stage of counter
  .init_value(4'd0),  // initial value for the counter
  .limit(`NINE)  // limit for the counter
);

upcounter Udc1(
  .value(digit1),  // counter value 
  .carry(cr1),  // carry indicator for counter to next stage
  .clk(clk), // global clock signal
  .rst_n(rst_n),  // low active reset
  .stop_n(stop_n),
  .increase(cr0),  // increase input from previous stage of counter
  .init_value(4'd0),  // initial value for the counter
  .limit(`FIVE)  // limit for the counter
);
upcounter Udc2(
  .value(digit2),  // counter value 
  .carry(cr2),  // carry indicator for counter to next stage
  .clk(clk), // global clock signal
  .rst_n(rst_n),  // low active reset
  .stop_n(stop_n),
  .increase(cr1),  // increase input from previous stage of counter
  .init_value(4'd0),  // initial value for the counter
  .limit(`NINE)  // limit for the counter
);

upcounter Udc3(
  .value(digit3),  // counter value 
  .carry(cr3),  // carry indicator for counter to next stage
  .clk(clk), // global clock signal
  .rst_n(rst_n),  // low active reset
  .stop_n(stop_n),
  .increase(cr2),  // increase input from previous stage of counter
  .init_value(4'd0),  // initial value for the counter
  .limit(`FIVE)  // limit for the counter
);

endmodule
