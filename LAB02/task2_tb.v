`timescale 1ns / 1ps
module task2_tb();
reg [3:0]i;
wire [3:0]d;
wire [3:0] ssd_ctl;
wire [7:0] seg;
task2 U0(.i(i), .d(d), .ssd_ctl(ssd_ctl), .seg(seg));
integer j;
initial
begin
    i = 4'b0000;
    for(j=1;j<16;j=j+1)
        #10 i = j;
    #10 $finish;
end
endmodule