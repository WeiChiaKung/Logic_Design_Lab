`include "global.v"
module timedisplay(
  output [`BCD_BIT_WIDTH-1:0] sec0,
  output [`BCD_BIT_WIDTH-1:0] sec1,
  output [`BCD_BIT_WIDTH-1:0] min0,
  output [`BCD_BIT_WIDTH-1:0] min1,
  output [`BCD_BIT_WIDTH-1:0] hour0,
  output [`BCD_BIT_WIDTH-1:0] hour1,
  output day_plus,
  input count_enable,
  input load_value_enable,
  input [`BCD_BIT_WIDTH-1:0] load_value_sec0,
  input [`BCD_BIT_WIDTH-1:0] load_value_sec1,
  input [`BCD_BIT_WIDTH-1:0] load_value_min0,
  input [`BCD_BIT_WIDTH-1:0] load_value_min1,
  input [`BCD_BIT_WIDTH-1:0] load_value_hour0,
  input [`BCD_BIT_WIDTH-1:0] load_value_hour1,
  input clk,
  input rst_n
);

wire carry_sec0, carry_sec1, carry_min0, carry_min1, carry_hour0;

//second0 counter
counterx Usec0(
  .q(sec0), // counter value
  .q_master(4'd0),
  .time_carry(carry_sec0), // counter carry
  .count_enable(count_enable), // counting enabled control signal
  .load_value_enable(load_value_enable), // load setting value control
  .load_value(load_value_sec0), // value to be loaded
  .initial_value(4'd0),
  .count_limit(`NINE), // limit of the up counter
  .time_limit_master(4'd10),
  .time_limit_slave(4'd10),
  .clk(clk), // clock
  .rst_n(rst_n) // low active reset
);

//second1 counter
counterx Usec1(
  .q(sec1), // counter value
  .q_master(4'd0),
  .time_carry(carry_sec1), // counter carry
  .count_enable(carry_sec0), // counting enabled control signal
  .load_value_enable(load_value_enable), // load setting value control
  .initial_value(4'd0),
  .load_value(load_value_sec1), // value to be loaded
  .count_limit(`FIVE), // limit of the up counter
  .time_limit_master(4'd10),
  .time_limit_slave(4'd10),
  .clk(clk), // clock
  .rst_n(rst_n) // low active reset
);

//minute0 counter
counterx Umin0(
  .q(min0), // counter value
  .q_master(4'd0),
  .time_carry(carry_min0), // counter carry
  .count_enable(carry_sec0 && carry_sec1), // counting enabled control signal
  .load_value_enable(load_value_enable), // load setting value control
  .initial_value(4'd0),
  .load_value(load_value_min0), // value to be loaded
  .count_limit(`NINE), // limit of the up counter
  .time_limit_master(4'd10),
  .time_limit_slave(4'd10),
  .clk(clk), // clock
  .rst_n(rst_n) // low active reset
);

//minute1 counter
counterx Umin1(
  .q(min1), // counter value
  .q_master(4'd0),
  .time_carry(carry_min1), // counter carry
  .count_enable(carry_sec0 && carry_sec1 && carry_min0), // counting enabled control signal
  .load_value_enable(load_value_enable), // load setting value control
  .initial_value(4'd0),
  .load_value(load_value_min1), // value to be loaded
  .count_limit(`FIVE), // limit of the up counter
  .time_limit_master(4'd10),
  .time_limit_slave(4'd10),
  .clk(clk), // clock
  .rst_n(rst_n) // low active reset
);
counterx Uhour0(
  .q(hour0), // counter value
  .q_master(hour1),
  .time_carry(carry_hour0), // counter carry
  .count_enable(carry_sec0 && carry_sec1 && carry_min0 && carry_min1), // counting enabled control signal
  .load_value_enable(load_value_enable), // load setting value control
  .initial_value(4'd0),
  .load_value(load_value_hour0), // value to be loaded
  .count_limit(`NINE), // limit of the up counter
  .time_limit_master(4'd2),
  .time_limit_slave(4'd4),
  .clk(clk), // clock
  .rst_n(rst_n) // low active reset
);
counterx Uhour1(
  .q(hour1), // counter value
  .q_master(4'd0),
  .time_carry(day_plus), // counter carry
  .count_enable(carry_sec0 && carry_sec1 && carry_min0 && carry_min1 && carry_hour0), // counting enabled control signal
  .load_value_enable(load_value_enable), // load setting value control
  .initial_value(4'd0),
  .load_value(load_value_hour1), // value to be loaded
  .count_limit(`TWO), // limit of the up counter
  .time_limit_master(4'd10),
  .time_limit_slave(4'd10),
  .clk(clk), // clock
  .rst_n(rst_n) // low active reset
);
endmodule
