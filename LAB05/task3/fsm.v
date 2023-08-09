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
  set_mode,
  stop,
  in, //input control
  in1,
  clk, // global clock signal
  rst  // high active reset
);

// outputs
output count_enable;  // if counter is enabled 
output stop;
// inputs
input clk; // global clock signal
input rst; // low active reset
input in,in1; //input control
input set_mode;
reg count_enable;  // if counter is enabled 
reg stop;
reg [1:0]state; // state of FSM
reg [1:0]next_state; // next state of FSM

// ***************************
// FSM
// ***************************
// FSM state decision
always @*
if(set_mode)
begin
  next_state = `STAT_INITIAL;
  count_enable = `DISABLED;
  stop = `ENABLED;
end
else
begin
  case (state)
    `STAT_INITIAL:
      if (in)
      begin
        next_state = `STAT_COUNT;
        count_enable = `ENABLED;
        stop = `DISABLED;
      end
      else
      begin
        next_state = `STAT_INITIAL;
        count_enable = `DISABLED;
        stop = `ENABLED;
      end
    `STAT_COUNT:
      if (in)
      begin
        next_state = `STAT_INITIAL;
        count_enable = `DISABLED;
        stop = `ENABLED;
      end
      else if (~in && in1)
      begin
        next_state = `STAT_PAUSE;
        count_enable = `DISABLED;
        stop = `DISABLED;
      end
      else
      begin
        next_state = `STAT_COUNT;
        count_enable = `ENABLED;
        stop = `DISABLED;
      end
    `STAT_PAUSE:
      if (in)
      begin
        next_state = `STAT_INITIAL;
        count_enable = `DISABLED;
        stop = `ENABLED;
      end
      else if (~in && in1)
      begin
        next_state = `STAT_COUNT;
        count_enable = `ENABLED;
        stop = `DISABLED;
      end
      else
      begin
        next_state = `STAT_PAUSE;
        count_enable = `DISABLED;
        stop = `DISABLED;
      end
      default:
      begin
        next_state = `STAT_PAUSE;
        count_enable = `DISABLED;
        stop = `DISABLED;
      end
  endcase
end

// FSM state transition
always @(posedge clk or posedge rst)
  if (rst)
    state <= `STAT_INITIAL;
  else
    state <= next_state;

endmodule
