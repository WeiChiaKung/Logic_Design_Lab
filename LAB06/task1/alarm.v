`include "global.v"
module alarm(
  output reg [8:0] led,
  output reg [`BCD_BIT_WIDTH-1:0] alarm_min0,
  output reg [`BCD_BIT_WIDTH-1:0] alarm_min1,
  output reg [`BCD_BIT_WIDTH-1:0] alarm_hour0,
  output reg [`BCD_BIT_WIDTH-1:0] alarm_hour1,
  input [`BCD_BIT_WIDTH-1:0] time_min0,
  input [`BCD_BIT_WIDTH-1:0] time_min1,
  input [`BCD_BIT_WIDTH-1:0] time_hour0,
  input [`BCD_BIT_WIDTH-1:0] time_hour1,
  input load_value_enable,
  input [`BCD_BIT_WIDTH-1:0] load_value_min0,
  input [`BCD_BIT_WIDTH-1:0] load_value_min1,
  input [`BCD_BIT_WIDTH-1:0] load_value_hour0,
  input [`BCD_BIT_WIDTH-1:0] load_value_hour1,
  input alarm_enable,
  input clk,
  input rst_n
);

reg [`BCD_BIT_WIDTH-1:0] alarm_min0_next, alarm_min1_next, alarm_hour0_next, alarm_hour1_next;

always @(posedge clk or negedge rst_n)
  if (~rst_n)
  begin
    alarm_min0 <= 4'd0;
    alarm_min1 <= 4'd0;
    alarm_hour0 <= 4'd0;
    alarm_hour1 <= 4'd0;
  end
  else
  begin
    alarm_min0 <= alarm_min0_next;
    alarm_min1 <= alarm_min1_next;
    alarm_hour0 <= alarm_hour0_next;
    alarm_hour1 <= alarm_hour1_next;
  end

always @*
  if (load_value_enable)
  begin
    alarm_min0_next = load_value_min0;
    alarm_min1_next = load_value_min1;
    alarm_hour0_next = load_value_hour0;
    alarm_hour1_next = load_value_hour1;
  end
  else 
  begin
    alarm_min0_next = alarm_min0;
    alarm_min1_next = alarm_min1;
    alarm_hour0_next = alarm_hour0;
    alarm_hour1_next = alarm_hour1;
  end

always @*
  if (alarm_enable && (alarm_hour0 == time_hour0) && (alarm_hour1 == time_hour1) && (alarm_min0 == time_min0) && (alarm_min1 == time_min1))
    led = 9'b1_1111_1111; 
  else
    led = 9'd0;

endmodule
