`include "global.v"
module updowncounter(
  value,  // counter value 
  carry,  // borrow indicator for counter to next stage
  borrow,
  clk, // global clock signal
  rst_n,  // low active reset
  increase,  // decrease input from previous stage of counter
  decrease,
  init_value,  // initial value for the counter
  limit  // limit for the counter
);

// outputs
output [`BCD_BIT_WIDTH-1:0] value; // counter value
output carry; // borrow indicator for counter to next stage
output borrow;
// inputs
input clk; // global clock signal
input rst_n; // low active reset
input increase; // decrease input from previous stage of counter
input decrease;
input [`BCD_BIT_WIDTH-1:0] init_value; // initial value for the counter
input [`BCD_BIT_WIDTH-1:0] limit; // limit for the counter

reg [`BCD_BIT_WIDTH-1:0] value; // counter value
reg [`BCD_BIT_WIDTH-1:0] value_tmp; // D input for counter register
reg carry; // borrow indicator for counter to next stage
reg borrow;
// combinational part for BCD counter
always @*
  if (value == limit && (increase) && (~decrease))  // reach limit, go back to 0
  begin
    value_tmp = `BCD_ZERO;
    carry = `ENABLED;
    borrow = `DISABLED;
  end
  else if (value == `BCD_ZERO && (~increase) && (decrease))  // reach limit, go back to 0
  begin
    value_tmp = limit;
    carry = `DISABLED;
    borrow = `ENABLED;
  end
 else  if (increase && (~decrease)) // count enabled
  begin
    value_tmp = value + `INCREMENT;
    carry = `DISABLED;
    borrow = `DISABLED;
  end
  else if ((~increase) && decrease) // count enabled
  begin
    value_tmp = value - `INCREMENT;
    carry = `DISABLED;
    borrow = `DISABLED;
  end
  else // count disabled
  begin
    value_tmp = value;
    carry = `DISABLED;
    borrow = `DISABLED;
  end

// register part for BCD counter
always @(posedge clk or negedge rst_n)
  if (~rst_n) value <= init_value;
  else value <= value_tmp;

endmodule