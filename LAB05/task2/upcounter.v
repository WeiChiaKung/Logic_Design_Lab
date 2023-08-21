//************************************************************************
// Filename      : upcounter.v
// Author        : hp
// Function      : Basic up counter module for digital watch
// Last Modified : Date: 2009-03-10
// Revision      : Revision: 1
// Copyright (c), Laboratory for Reliable Computing (LaRC), EE, NTHU
// All rights reserved
//************************************************************************
`include "global.v"
module upcounter(
  value,  // counter value 
  carry,  // borrow indicator for counter to next stage
  clk, // global clock signal
  rst,  // low active reset
  increase,  // decrease input from previous stage of counter
  init_value,  // initial value for the counter
  limit  // limit for the counter
);

// outputs
output [`BCD_BIT_WIDTH-1:0] value; // counter value
output carry; // borrow indicator for counter to next stage
// inputs
input clk; // global clock signal
input rst; // low active reset
input increase; // decrease input from previous stage of counter
input [`BCD_BIT_WIDTH-1:0] init_value; // initial value for the counter
input [`BCD_BIT_WIDTH-1:0] limit; // limit for the counter

reg [`BCD_BIT_WIDTH-1:0] value; // counter value
reg [`BCD_BIT_WIDTH-1:0] value_tmp; // D input for counter register
reg carry; // borrow indicator for counter to next stage

// combinational part for BCD counter
always @*
begin  
  if (value == limit && increase)  // reach limit, go back to 0
  begin
    value_tmp = `BCD_ZERO;
    carry = `ENABLED;
  end
  else if (increase) // count enabled
  begin
    value_tmp = value + `INCREMENT;
    carry = `DISABLED;
  end
  else // count disabled
  begin
    value_tmp = value;
    carry = `DISABLED;
  end
end

// register part for BCD counter
always @(posedge clk or posedge rst)
  if (rst) value <= init_value;
  else value <= value_tmp;

endmodule
