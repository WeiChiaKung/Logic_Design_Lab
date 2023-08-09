`include "global.v"
module stopwatch(
  output reg[`BCD_BIT_WIDTH-1:0] sec0, // first digit of second
  output reg[`BCD_BIT_WIDTH-1:0] sec1, // second digit of second
  output reg[`BCD_BIT_WIDTH-1:0] min0, // first digit of minute
  output reg[`BCD_BIT_WIDTH-1:0] min1, // second digit of minute
  input count_enable, // counting enabled control signal
  input lap,
  input clk, // clock
  input rst_n // low active reset
);
wire [`BCD_BIT_WIDTH-1:0] dig0,dig1,dig2,dig3;
reg [`BCD_BIT_WIDTH-1:0] lap0,lap1,lap2,lap3;

// all zero detection

// 1st digit of second
upcounter_4d U_sw(
  .digit3(dig3),  
  .digit2(dig2),
  .digit1(dig1),  // 2nd digit of the down counter
  .digit0(dig0),  // 1st digit of the down counter
  .clk(clk),  // global clock
  .rst_n(rst_n),  // low active reset
  .stop_n(count_enable),
  .en(1'b1) // enable/disable for the stopwatch
);
always@(posedge lap)
begin
  lap0 <= dig0;
  lap1 <= dig1;
  lap2 <= dig2;
  lap3 <= dig3;
end
always@(*)
begin
  if (lap)
  begin
      sec0 = lap0;
      sec1 = lap1;
      min0 = lap2;
      min1 = lap3;
  end
  else
  begin
      sec0 = dig0;
      sec1 = dig1;
      min0 = dig2;
      min1 = dig3;
  end
end

endmodule