`include "global.v"
module task1(
  output [15:0] led,
  output  [`SSD_BIT_WIDTH-1:0] segs,  // 7-segment display
  output  [`SSD_NUM-1:0] ssd_ctl, // scan control for 7-segment display
  input mode,
  input switch,
  input display_mode,
  input  clk,  // clock from oscillator
  input  rst_n  // active low reset
);

wire clk_1, clk_2k; //divided clock
wire data_load_enable, reg_load_enable;
wire alarm_enable;
wire [2:0] set_hour_min_sec;
reg [`BCD_BIT_WIDTH-1:0] sec0, sec1,min0, min1, hour0, hour1,date0, date1, month0, month1,year0, year1; // Binary counter output
wire [`BCD_BIT_WIDTH-1:0] ssd_in;
wire [`BCD_BIT_WIDTH-1:0] time_sec0, time_sec1,time_min0, time_min1, time_hour0, time_hour1, time_date0, time_date1,time_month0, time_month1, time_year0, time_year1; // Binary counter output
wire [`BCD_BIT_WIDTH-1:0] stopwatch_sec0, stopwatch_sec1, stopwatch_min0, stopwatch_min1; // Binary counter output
wire [`BCD_BIT_WIDTH-1:0] alarm_min0, alarm_min1,alarm_hour0, alarm_hour1; // Binary counter output
wire [`BCD_BIT_WIDTH-1:0] reg_q0, reg_q1, reg_q2, reg_q3, reg_q4, reg_q5; // Binary counter 
wire [`BCD_BIT_WIDTH-1:0] reg_q0_date, reg_q1_date, reg_q2_date, reg_q3_date, reg_q4_date, reg_q5_date; // Binary counter 
reg [`BCD_BIT_WIDTH-1:0] reg_load_q0, reg_load_q1, reg_load_q2, reg_load_q3, reg_load_q4, reg_load_q5; // Binary counter 
wire day_plus;
wire [5:0] state;
wire [5:0] state_led;
wire [8:0] alarm_led;

assign led = {state_led,{alarm_led},alarm_enable};

// clock generator
clock_generator Uclkgen(
  .clk_1(clk_1), // generated 1 Hz clock
  .clk_100(), // generated 100 Hz clock
  .clk_2k(clk_2k), // generated 100 Hz clock
  .clk(clk), // clock from crystal
  .rst_n(rst_n) // active low reset
);

// Time Display Counter
timedisplay Utd(
  .sec0(time_sec0),
  .sec1(time_sec1),
  .min0(time_min0),
  .min1(time_min1),
  .hour0(time_hour0),
  .hour1(time_hour1),
  .day_plus(day_plus),
  .count_enable(`ENABLED),
  .load_value_enable(data_load_enable && (state[4:3] == `TIME)),
  .load_value_sec0(reg_q0),
  .load_value_sec1(reg_q1),
  .load_value_min0(reg_q2),
  .load_value_min1(reg_q3),
  .load_value_hour0(reg_q4),
  .load_value_hour1(reg_q5),
  .clk(clk_1),
  .rst_n(rst_n)
);
timedisplay_date Utd_D(
  .date0(time_date0),
  .date1(time_date1),
  .month0(time_month0),
  .month1(time_month1),
  .year0(time_year0),
  .year1(time_year1),
  .count_enable(day_plus),
  .load_value_enable(data_load_enable && (state[4:3] == `DATE)),
  .load_value_date0(reg_q0_date),
  .load_value_date1(reg_q1_date),
  .load_value_month0(reg_q2_date),
  .load_value_month1(reg_q3_date),
  .load_value_year0(reg_q4_date),
  .load_value_year1(reg_q5_date),
  .clk(clk_1),
  .rst_n(rst_n)
);

// Stopwatch
stopwatch Ustw(
  .sec0(stopwatch_sec0), 
  .sec1(stopwatch_sec1), 
  .min0(stopwatch_min0), 
  .min1(stopwatch_min1), 
  .count_enable(stopwatch_count_enable), 
  .lap(data_load_enable),
  .clk(clk_1), 
  .rst_n(rst_n) 
);
// Alarm
alarm(
  .led(alarm_led),
  .alarm_min0(alarm_min0),
  .alarm_min1(alarm_min1),
  .alarm_hour0(alarm_hour0),
  .alarm_hour1(alarm_hour1),
  .time_min0(time_min0),
  .time_min1(time_min1),
  .time_hour0(time_hour0),
  .time_hour1(time_hour1),
  .load_value_enable(data_load_enable && (state[4:3] == `ALM)),
  .load_value_min0(reg_q2),
  .load_value_min1(reg_q3),
  .load_value_hour0(reg_q4),
  .load_value_hour1(reg_q5),
  .alarm_enable(alarm_enable),
  .clk(clk_1),
  .rst_n(rst_n)
);

// FSM
fsm Ufsm(
  .state_led(state_led),
  .set_enable(set_enable),
  .stopwatch_count_enable(stopwatch_count_enable),
  .data_load_enable(data_load_enable),
  .reg_load_enable(reg_load_enable),
  .alarm_enable(alarm_enable),
  .set_hour_min_sec(set_hour_min_sec),
  .state(state),
  .mode(mode),
  .display_mode(display_mode),
  .switch(switch),
  .clk(clk_1),
  .rst_n(rst_n)
);

// Selection which data to load to setting register
always @*
  case (state[4:3])
  `TIME:
    begin
      reg_load_q0 = time_sec0;
      reg_load_q1 = time_sec1;
      reg_load_q2 = time_min0;
      reg_load_q3 = time_min1;
      reg_load_q4 = time_hour0;
      reg_load_q5 = time_hour1;
    end
  `ALM:
    begin
      reg_load_q0 = 4'd0;
      reg_load_q1 = 4'd0;
      reg_load_q2 = alarm_min0;
      reg_load_q3 = alarm_min1;
      reg_load_q4 = alarm_hour0;
      reg_load_q5 = alarm_hour1;
    end
  `DATE:
    begin
      reg_load_q0 = time_date0;
      reg_load_q1 = time_date1;
      reg_load_q2 = time_month0;
      reg_load_q3 = time_month1;
      reg_load_q4 = time_year0;
      reg_load_q5 = time_year1;
    end
  default:
    begin
      reg_load_q0 = 4'd0;
      reg_load_q1 = 4'd0;
      reg_load_q2 = 4'd0;
      reg_load_q3 = 4'd0;
      reg_load_q4 = 4'd0;
      reg_load_q5 = 4'd0;
    end
  endcase

// Setting Registers
unitset Usreg(
  .sec0(reg_q0),
  .sec1(reg_q1),
  .min0(reg_q2),
  .min1(reg_q3),
  .hour0(reg_q4),
  .hour1(reg_q5),
  .count_enable({set_enable & set_hour_min_sec[2],set_enable & set_hour_min_sec[1],set_enable & set_hour_min_sec[0]}),
  .load_value_enable(reg_load_enable),
  .load_value_sec0(reg_load_q0),
  .load_value_sec1(reg_load_q1),
  .load_value_min0(reg_load_q2),
  .load_value_min1(reg_load_q3),
  .load_value_hour0(reg_load_q4),
  .load_value_hour1(reg_load_q5),
  .clk(clk_1),
  .rst_n(rst_n)
);
unitset_date Udreg(
  .date0(reg_q0_date),
  .date1(reg_q1_date),
  .month0(reg_q2_date),
  .month1(reg_q3_date),
  .year0(reg_q4_date),
  .year1(reg_q5_date),
  .count_enable({set_enable & set_hour_min_sec[2],set_enable & set_hour_min_sec[1],set_enable & set_hour_min_sec[0]}),
  .load_value_enable(reg_load_enable),
  .load_value_date0(reg_load_q0),
  .load_value_date1(reg_load_q1),
  .load_value_month0(reg_load_q2),
  .load_value_month1(reg_load_q3),
  .load_value_year0(reg_load_q4),
  .load_value_year1(reg_load_q5),
  .clk(clk_1),
  .rst_n(rst_n)
);

always @*
  case (state)
  `TIME_DISP:
    begin
      sec0 = time_min0;
      sec1 = time_min1;
      min0 = time_hour0;
      min1 = time_hour1;
    end
  `TIME_DISP1:
    begin
      sec0 = time_sec0;
      sec1 = time_sec1;
      min0 = 4'd0;
      min1 = 4'd0;
    end
  `DATE_DISP:
    begin
      sec0 = time_date0;
      sec1 = time_date1;
      min0 = time_month0;
      min1 = time_month1;
    end
  `DATE_DISP1:
    begin
      sec0 = time_year0;
      sec1 = time_year1;
      min0 = 4'd0;
      min1 = 4'd0;
    end
  `STW_DISP: 
    begin
      sec0 = stopwatch_sec0;
      sec1 = stopwatch_sec1;
      min0 = stopwatch_min0;
      min1 = stopwatch_min1;
    end
  `STW_COUNT:
    begin
      sec0 = stopwatch_sec0;
      sec1 = stopwatch_sec1;
      min0 = stopwatch_min0;
      min1 = stopwatch_min1;
    end
  `STW_LAP_COUNT:
    begin
      sec0 = stopwatch_sec0;
      sec1 = stopwatch_sec1;
      min0 = stopwatch_min0;
      min1 = stopwatch_min1;
    end
  `ALM_DISP:
    begin
      sec0 = alarm_min0;
      sec1 = alarm_min1;
      min0 = alarm_hour0;
      min1 = alarm_hour1;
    end
  `TIME_SETMIN:
    begin
      sec0 = reg_q0;
      sec1 = reg_q1;
      min0 = reg_q2;
      min1 = reg_q3;
    end
  `TIME_SETSEC:
    begin
      sec0 = reg_q0;
      sec1 = reg_q1;
      min0 = reg_q2;
      min1 = reg_q3;
    end
  `TIME_SETHOUR:
    begin
      sec0 = reg_q4;
      sec1 = reg_q5;
      min0 = 4'd0;
      min1 = 4'd0;
    end
  `DATE_SETDATE:
    begin
      sec0 = reg_q0_date;
      sec1 = reg_q1_date;
      min0 = reg_q2_date;
      min1 = reg_q3_date;
    end
  `DATE_SETMONTH:
    begin
      sec0 = reg_q0_date;
      sec1 = reg_q1_date;
      min0 = reg_q2_date;
      min1 = reg_q3_date;
    end
  `DATE_SETYEAR:
    begin
      sec0 = reg_q4_date;
      sec1 = reg_q5_date;
      min0 = 4'd0;
      min1 = 4'd0;
    end
  `ALM_SETMIN:
    begin
      sec0 = reg_q2;
      sec1 = reg_q3;
      min0 = reg_q4;
      min1 = reg_q5;
    end
  `ALM_SETHOUR:
    begin
      sec0 = reg_q2;
      sec1 = reg_q3;
      min0 = reg_q4;
      min1 = reg_q5;
    end
  default:
    begin
      sec0 = time_min0;
      sec1 = time_min1;
      min0 = time_hour0;
      min1 = time_hour1;
    end
  endcase

// Scan control
scan_ctl U_SC(
  .ssd_ctl(ssd_ctl), // ssd display control signal
  .ssd_in(ssd_in), // output to ssd display
  .in0(sec0), // 1st input
  .in1(sec1), // 2nd input
  .in2(min0), // 3rd input
  .in3(min1),  // 4th input
  .ssd_ctl_en(clk_2k), // divided clock for scan control
  .rst_n(rst_n)
);

// binary to 7-segment display decoder
display U_display(
  .segs(segs), // 7-segment display output
  .bin(ssd_in)  // BCD number input
);

endmodule
