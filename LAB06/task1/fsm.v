module fsm(
  output reg [5:0] state_led,
  output reg set_enable,
  output reg stopwatch_count_enable,
  output reg data_load_enable,
  output reg reg_load_enable,
  output reg alarm_enable,
  output reg [2:0] set_hour_min_sec,
  output reg [5:0] state,
  input mode,
  input display_mode,
  input switch,
  input clk,
  input rst_n
);

reg [5:0] state_next;
reg [1:0] press_count; 
wire [1:0] press_count_next;
reg mode_delay;
wire long_press, short_press;
reg alarm_enable_next;

//  Counter for press time
assign press_count_next = (mode) ? (press_count + 1'b1) : 2'd0;
always @(posedge clk or negedge rst_n)
  if (~rst_n)
    press_count <= 2'b00;
  else
    press_count <= press_count_next;

// Mode delay
always @(posedge clk or negedge rst_n)
  if (~rst_n)
    mode_delay <= 1'b0;
  else
    mode_delay <= mode;

// Determine short press or long press
assign short_press = (~mode) & mode_delay & (~(press_count[1]&press_count[0]));
assign long_press = (press_count == 2'b11);

// Alarm enable register
always @(posedge clk or negedge rst_n)
  if (~rst_n)
    alarm_enable = 1'b0;
  else
    alarm_enable = alarm_enable_next;

// state transition
always @*
begin
  set_enable = `DISABLED;
  stopwatch_count_enable = `DISABLED;
  data_load_enable = `DISABLED;
  set_hour_min_sec = {3{`DISABLED}};
  reg_load_enable = `DISABLED;
  state_next = `TIME_DISP;
  alarm_enable_next = alarm_enable;
  state_led = state;
  case (state)
  `TIME_DISP:
    begin
      state_led = `TIME_DISP;
      if (long_press)
      begin
        state_next = `TIME_SETMIN;
        reg_load_enable = `ENABLED;
      end
      else if (short_press)
        state_next = `STW_DISP;
      else if (display_mode)
        state_next = `TIME_DISP1;
      else 
        state_next = `TIME_DISP;
    end
  `TIME_DISP1:
      begin
        state_led = `TIME_DISP1;
        if (display_mode)
          state_next = `TIME_DISP;
        else 
          state_next = `TIME_DISP1;
      end
  `TIME_SETMIN:
    begin
      state_led = `TIME_SETMIN;
      set_enable = switch;
      set_hour_min_sec = `SETMIN;
      if (short_press)
        state_next = `TIME_SETSEC;
      else if (long_press)
      begin
        state_next =  `TIME_DISP;
        data_load_enable = `ENABLED;
      end
      else
        state_next = `TIME_SETMIN;
    end
  `TIME_SETSEC:
    begin
      state_led = `TIME_SETSEC;
      set_enable = switch;
      set_hour_min_sec = `SETSEC;
      if (short_press)
        state_next = `TIME_SETHOUR;
      else if (long_press)
      begin
        state_next =  `TIME_DISP;
        data_load_enable = `ENABLED;
      end
      else
        state_next = `TIME_SETSEC;
    end
   `TIME_SETHOUR:
      begin
        state_led = `TIME_SETHOUR;
        set_enable = switch;
        set_hour_min_sec = `SETHOUR;
        if (short_press)
          state_next = `TIME_SETMIN;
        else if (long_press)
        begin
          state_next =  `TIME_DISP;
          data_load_enable = `ENABLED;
        end
        else
          state_next = `TIME_SETHOUR;
      end
  `STW_DISP:
   begin
      state_led = `STW_DISP;
      if (switch)
      begin
        state_next = `STW_COUNT;
        data_load_enable = `DISABLED;
        stopwatch_count_enable = `ENABLED;
      end
      else if(short_press)
        state_next = `ALM_DISP;
      else
        state_next = `STW_DISP;
        data_load_enable = `DISABLED;
        stopwatch_count_enable = `DISABLED;
    end
  `STW_COUNT:
    begin
      state_led = `STW_COUNT;
      if (switch)
      begin
        state_next = `STW_DISP;
        data_load_enable = `DISABLED;
        stopwatch_count_enable = `DISABLED;
      end
      else if (display_mode)
      begin
        state_next =  `STW_LAP_COUNT;
        data_load_enable = `ENABLED;
        stopwatch_count_enable = `ENABLED;
      end
      else
      begin
        state_next = `STW_COUNT;
        data_load_enable = `DISABLED;
        stopwatch_count_enable = `ENABLED;
      end
    end
  `STW_LAP_COUNT:
    begin
      state_led = `STW_LAP_COUNT;
      if (switch)
      begin
        state_next = `STW_DISP;
        data_load_enable = `DISABLED;
        stopwatch_count_enable = `DISABLED;
      end
      else if (display_mode)
      begin
        state_next =  `STW_COUNT;
        data_load_enable = `DISABLED;
        stopwatch_count_enable = `ENABLED;
      end
      else
      begin
        state_next = `STW_LAP_COUNT;
        data_load_enable = `ENABLED;
        stopwatch_count_enable = `ENABLED;
      end
    end
  `ALM_DISP:
    begin
      state_led = `ALM_DISP;
      if (long_press)
      begin
        state_next = `ALM_SETMIN;
        reg_load_enable = `ENABLED;
      end
      else if (short_press)
        state_next = `DATE_DISP;
      else if (switch)
      begin
        state_next = `ALM_DISP;
        alarm_enable_next = ~ alarm_enable;
      end
      else
        state_next = `ALM_DISP;
    end
  `ALM_SETMIN:
    begin
      state_led = `ALM_SETMIN;
      set_enable = switch;
      set_hour_min_sec = `SETMIN;
      if (short_press)
        state_next = `ALM_SETSEC;
      else if (long_press)
      begin
        state_next =  `ALM_DISP;
        data_load_enable = `ENABLED;
      end
      else
        state_next = `ALM_SETMIN;
    end
  `ALM_SETSEC:
    begin
      state_led = `ALM_SETSEC;
      set_enable = switch;
      set_hour_min_sec = `SETSEC;
      if (short_press)
        state_next = `ALM_SETMIN;
      else if (long_press)
      begin
        state_next =  `ALM_DISP;
        data_load_enable = `ENABLED;
      end
      else
        state_next = `ALM_SETSEC;
    end
  `DATE_DISP:
      begin
        state_led = `DATE_DISP;
        if (long_press)
        begin
          state_next = `DATE_SETDATE;
          reg_load_enable = `ENABLED;
        end
        else if (short_press)
          state_next = `TIME_DISP;
        else if (display_mode)
          state_next = `DATE_DISP1;
        else 
          state_next = `DATE_DISP;
      end
    `DATE_DISP1:
        begin
          state_led = `DATE_DISP1;
          if (display_mode)
            state_next = `DATE_DISP;
          else 
            state_next = `DATE_DISP1;
        end
    `DATE_SETMONTH:
      begin
        state_led = `DATE_SETMONTH;
        set_enable = switch;
        set_hour_min_sec = `SETMONTH;
        if (short_press)
          state_next = `DATE_SETDATE;
        else if (long_press)
        begin
          state_next =  `DATE_DISP;
          data_load_enable = `ENABLED;
        end
        else
          state_next = `DATE_SETMONTH;
      end
    `DATE_SETDATE:
      begin
        state_led = `DATE_SETDATE;
        set_enable = switch;
        set_hour_min_sec = `SETDATE;
        if (short_press)
          state_next = `DATE_SETYEAR;
        else if (long_press)
        begin
          state_next =  `DATE_DISP;
          data_load_enable = `ENABLED;
        end
        else
          state_next = `DATE_SETDATE;
      end
     `DATE_SETYEAR:
        begin
          state_led = `DATE_SETYEAR;
          set_enable = switch;
          set_hour_min_sec = `SETYEAR;
          if (short_press)
            state_next = `DATE_SETMONTH;
          else if (long_press)
          begin
            state_next =  `DATE_DISP;
            data_load_enable = `ENABLED;
          end
          else
            state_next = `DATE_SETYEAR;
        end
  endcase
end

// state register
always @(posedge clk or negedge rst_n)
  if (~rst_n)
    state <=6'd0;
  else
    state <= state_next;    

endmodule
