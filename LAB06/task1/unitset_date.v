`include "global.v"
module unitset_date(
  output [`BCD_BIT_WIDTH-1:0] date0,
  output [`BCD_BIT_WIDTH-1:0] date1,
  output [`BCD_BIT_WIDTH-1:0] month0,
  output [`BCD_BIT_WIDTH-1:0] month1,
  output [`BCD_BIT_WIDTH-1:0] year0,
  output [`BCD_BIT_WIDTH-1:0] year1,
  input [2:0]count_enable,
  input load_value_enable,
  input [`BCD_BIT_WIDTH-1:0] load_value_date0,
  input [`BCD_BIT_WIDTH-1:0] load_value_date1,
  input [`BCD_BIT_WIDTH-1:0] load_value_month0,
  input [`BCD_BIT_WIDTH-1:0] load_value_month1,
  input [`BCD_BIT_WIDTH-1:0] load_value_year0,
  input [`BCD_BIT_WIDTH-1:0] load_value_year1,
  input clk,
  input rst_n
);

wire carry_date0, carry_month0, carry_year0;
reg [`BCD_BIT_WIDTH-1:0]date_strict_dig0, date_strict_dig1;
always@(*)
begin
    case({month1,month0})
    8'h01:
    begin
        date_strict_dig0 = 4'd1;
        date_strict_dig1 = 4'd3;
    end
    8'h02:
    begin
        date_strict_dig0 = 4'd8;
        date_strict_dig1 = 4'd2;
    end
    8'h03:
    begin
        date_strict_dig0 = 4'd1;
        date_strict_dig1 = 4'd3;
    end
    8'h04:
    begin
        date_strict_dig0 = 4'd0;
        date_strict_dig1 = 4'd3;
    end
    8'h05:
    begin
        date_strict_dig0 = 4'd1;
        date_strict_dig1 = 4'd3;
    end
    8'h06:
    begin
        date_strict_dig0 = 4'd0;
        date_strict_dig1 = 4'd3;
    end
    8'h07:
    begin
        date_strict_dig0 = 4'd1;
        date_strict_dig1 = 4'd3;
    end
    8'h08:
    begin
        date_strict_dig0 = 4'd1;
        date_strict_dig1 = 4'd3;
    end
    8'h09:
    begin
        date_strict_dig0 = 4'd0;
        date_strict_dig1 = 4'd3;
    end
    8'h10:
    begin
        date_strict_dig0 = 4'd1;
        date_strict_dig1 = 4'd3;
    end
    8'h11:
    begin
        date_strict_dig0 = 4'd0;
        date_strict_dig1 = 4'd3;
    end
    8'h12:
    begin
        date_strict_dig0 = 4'd1;
        date_strict_dig1 = 4'd3;
    end
    default:
    begin
        date_strict_dig0 = 4'd1;
        date_strict_dig1 = 4'd3;
    end
    endcase
end
//dateond0 counter
counterx Udate0(
  .q(date0), // counter value
  .q_master(date1),
  .time_carry(carry_date0), // counter carry
  .count_enable(count_enable[0]), // counting enabled control signal
  .load_value_enable(load_value_enable), // load setting value control
  .initial_value(4'd1),
  .load_value(load_value_date0), // value to be loaded
  .count_limit(`NINE), // limit of the up counter
  .time_limit_master(date_strict_dig1),
  .time_limit_slave(date_strict_dig0),
  .clk(clk), // clock
  .rst_n(rst_n) // low active reset
);

//dateond1 counter
counterx Udate1(
  .q(date1), // counter value
  .q_master(4'd0),
  .time_carry(), // counter carry
  .count_enable(carry_date0), // counting enabled control signal
  .load_value_enable(load_value_enable), // load setting value control
  .initial_value(4'd0),
  .load_value(load_value_date1), // value to be loaded
  .count_limit(date_strict_dig1), // limit of the up counter
  .time_limit_master(4'd10),
  .time_limit_slave(4'd10),
  .clk(clk), // clock
  .rst_n(rst_n) // low active reset
);

//monthute0 counter
counterx Umonth0(
  .q(month0), // counter value
  .q_master(month1),
  .time_carry(carry_month0), // counter carry
  .count_enable(count_enable[1]), // counting enabled control signal
  .load_value_enable(load_value_enable), // load setting value control
  .initial_value(4'd1),
  .load_value(load_value_month0), // value to be loaded
  .count_limit(`NINE), // limit of the up counter
  .time_limit_master(4'd1),
  .time_limit_slave(4'd2),
  .clk(clk), // clock
  .rst_n(rst_n) // low active reset
);

//monthute1 counter
counterx Umonth1(
  .q(month1), // counter value
  .q_master(4'd0),
  .time_carry(), // counter carry
  .count_enable(carry_month0), // counting enabled control signal
  .load_value_enable(load_value_enable), // load setting value control
  .initial_value(4'd0),
  .load_value(load_value_month1), // value to be loaded
  .count_limit(`ONE), // limit of the up counter
  .time_limit_master(4'd10),
  .time_limit_slave(4'd10),
  .clk(clk), // clock
  .rst_n(rst_n) // low active reset
);
counterx Uyear0(
  .q(year0), // counter value
  .q_master(4'd0),
  .time_carry(carry_year0), // counter carry
  .count_enable(count_enable[2]), // counting enabled control signal
  .load_value_enable(load_value_enable), // load setting value control
  .initial_value(4'd0),
  .load_value(load_value_year0), // value to be loaded
  .count_limit(`NINE), // limit of the up counter
  .time_limit_master(4'd10),
  .time_limit_slave(4'd10),
  .clk(clk), // clock
  .rst_n(rst_n) // low active reset
);
counterx Uyear1(
  .q(year1), // counter value
  .q_master(4'd0),
  .time_carry(), // counter carry
  .count_enable(carry_year0), // counting enabled control signal
  .load_value_enable(load_value_enable), // load setting value control
  .initial_value(4'd0),
  .load_value(load_value_year1), // value to be loaded
  .count_limit(`NINE), // limit of the up counter
  .time_limit_master(4'd10),
  .time_limit_slave(4'd10),
  .clk(clk), // clock
  .rst_n(rst_n) // low active reset
);
endmodule
