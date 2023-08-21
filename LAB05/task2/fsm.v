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
  reset,
  in, //input control
  in1,
  clk, // global clock signal
  rst  // high active reset
);

// outputs
output count_enable;  // if counter is enabled 
output show_time;
output reset;
// inputs
input clk; // global clock signal
input rst; // low active reset
input in,in1; //input control

reg count_enable;  // if counter is enabled 
reg show_time;
reg reset;
reg [1:0]state; // state of FSM
reg [1:0]next_state; // next state of FSM
// ***************************
// FSM
// ***************************
// FSM state decision
always @*
  case (state)
    `STAT_INITIAL:
    begin
      count_enable = `DISABLED;
      show_time = `DISABLED;
      reset = `ENABLED;
      if (in && ~in1)
        next_state = `STAT_COUNT;
      else 
        next_state = `STAT_INITIAL;
    end
    `STAT_STOP:
    begin
      count_enable = `DISABLED;
      show_time = `ENABLED;
      reset = `DISABLED;
      if (~in && in1)
        next_state = `STAT_INITIAL;
      else
        next_state = `STAT_STOP;
    end
    `STAT_COUNT:
    begin
      count_enable = `ENABLED;
      show_time = `DISABLED;
      reset = `DISABLED;
      if (in && ~in1)
        next_state = `STAT_STOP;
      else if (~in && ~in1)
        next_state = `STAT_COUNT;
      else
        next_state = `STAT_LAP_count;
    end
    `STAT_LAP_count:
    begin
      count_enable = `ENABLED;
      show_time = `ENABLED;
      reset = `DISABLED;
      if (in && ~in1)
        next_state = `STAT_STOP;
      else if (~in && ~in1)
        next_state = `STAT_LAP_count;
      else
        next_state = `STAT_COUNT;
    end
   default:
      begin
        next_state = `STAT_INITIAL;
        count_enable = `DISABLED;
        show_time = `DISABLED;
      end     
  endcase

// FSM state transition
always @(posedge clk or posedge rst)
  if (rst)
    state <= `STAT_INITIAL;
  else
    state <= next_state;
endmodule
