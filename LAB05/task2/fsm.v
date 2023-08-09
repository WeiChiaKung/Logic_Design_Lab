//************************************************************************
// Filename      : FSM.v
// Author        : hp
// Function      : FSM module for digital watch
// Last Modified : Date: 2009-03-10
// Revision      : Revision: 1
// Copyright (c), Laboratory for Reliable Computing (LaRC), EE, NTHU
// All rights reserved
//************************************************************************
`include "global.v"
module fsm(
  count_enable,  // if counter is enabled 
  show_time,
  in, //input control
  in1,
  clk, // global clock signal
  rst  // high active reset
);

// outputs
output count_enable;  // if counter is enabled 
output show_time;
// inputs
input clk; // global clock signal
input rst; // low active reset
input in,in1; //input control

reg count_enable;  // if counter is enabled 
reg show_time;
reg [1:0]state; // state of FSM
reg [1:0]next_state; // next state of FSM

// ***************************
// FSM
// ***************************
// FSM state decision
always @*
  case (state)
    `STAT_STOP:
      if (in && ~in1)
      begin
        next_state = `STAT_COUNT;
        count_enable = `ENABLED;
        show_time = `DISABLED;
      end
      else if (in && in1)
      begin
        next_state = `STAT_LAP_count;
        count_enable = `ENABLED;
        show_time = `ENABLED;
      end
      else if (~in && ~in1)
      begin
        next_state = `STAT_STOP;
        count_enable = `DISABLED;
        show_time = `DISABLED;
      end
      else
      begin
        next_state = `STAT_LAP_stop;
        count_enable = `DISABLED;
        show_time = `ENABLED;
      end
    `STAT_COUNT:
      if (in && ~in1)
      begin
        next_state = `STAT_STOP;
        count_enable = `DISABLED;
        show_time = `DISABLED;
      end
      else if (in && in1)
      begin
        next_state = `STAT_LAP_stop;
        count_enable = `DISABLED;
        show_time = `ENABLED;
      end
      else if (~in && ~in1)
      begin
        next_state = `STAT_COUNT;
        count_enable = `ENABLED;
        show_time = `DISABLED;
      end
      else
      begin
        next_state = `STAT_LAP_count;
        count_enable = `ENABLED;
        show_time = `ENABLED;
      end
    `STAT_LAP_stop:
      if (in && ~in1)
      begin
        next_state = `STAT_LAP_count;
        count_enable = `ENABLED;
        show_time = `ENABLED;
      end
      else if (in && in1)
      begin
        next_state = `STAT_COUNT;
        count_enable = `ENABLED;
        show_time = `DISABLED;
      end
      else if (~in && ~in1)
      begin
        next_state = `STAT_LAP_stop;
        count_enable = `DISABLED;
        show_time = `ENABLED;
      end
      else
      begin
        next_state = `STAT_STOP;
        count_enable = `DISABLED;
        show_time = `DISABLED;
      end
    `STAT_LAP_count:
      if (in && ~in1)
      begin
        next_state = `STAT_LAP_stop;
        count_enable = `DISABLED;
        show_time = `ENABLED;
      end
      else if (in && in1)
      begin
        next_state = `STAT_STOP;
        count_enable = `DISABLED;
        show_time = `DISABLED;
      end
      else if (~in && ~in1)
      begin
        next_state = `STAT_LAP_count;
        count_enable = `ENABLED;
        show_time = `ENABLED;
      end
      else
      begin
        next_state = `STAT_COUNT;
        count_enable = `ENABLED;
        show_time = `DISABLED;
      end
  endcase

// FSM state transition
always @(posedge clk or posedge rst)
  if (rst)
    state <= `STAT_STOP;
  else
    state <= next_state;

endmodule
