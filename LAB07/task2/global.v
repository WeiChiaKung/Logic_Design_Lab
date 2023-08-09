`define Freq_Do 22'd191571
`define Freq_Re 22'd170648
`define Freq_Mi 22'd151515
`define Pos_Volume_15 16'h3FFF
`define Pos_Volume_14 16'h3EEE
`define Pos_Volume_13 16'h3DDD
`define Pos_Volume_12 16'h3CCC
`define Pos_Volume_11 16'h3BBB
`define Pos_Volume_10 16'h3AAA
`define Pos_Volume_9 16'h3999
`define Pos_Volume_8 16'h3888
`define Pos_Volume_7 16'h3777
`define Pos_Volume_6 16'h3666
`define Pos_Volume_5 16'h3555
`define Pos_Volume_4 16'h3444
`define Pos_Volume_3 16'h3333
`define Pos_Volume_2 16'h3222
`define Pos_Volume_1 16'h3111
`define Pos_Volume_0 16'h0000
`define Neg_Volume_15 16'hB000
`define Neg_Volume_14 16'hB111
`define Neg_Volume_13 16'hB222
`define Neg_Volume_12 16'hB333
`define Neg_Volume_11 16'hB444
`define Neg_Volume_10 16'hB555
`define Neg_Volume_9 16'hB666
`define Neg_Volume_8 16'hB777
`define Neg_Volume_7 16'hB888
`define Neg_Volume_6 16'hB999
`define Neg_Volume_5 16'hBAAA
`define Neg_Volume_4 16'hBBBB
`define Neg_Volume_3 16'hBCCC
`define Neg_Volume_2 16'hBDDD
`define Neg_Volume_1 16'hBEEE
`define Neg_Volume_0 16'h0000
// Frequency divider
`define SSD_SCAN_CTL_BIT_WIDTH 2 // number of bits for ftsd scan control
`define FREQ_DIV_BIT 27

// SSD scan
`define SSD_DIGIT_NUM 4 // number of SSD digit
`define SSD_SCAN_CTL_DISP1 4'b0111 // set the value of SSD 1
`define SSD_SCAN_CTL_DISP2 4'b1011 // set the value of SSD 2
`define SSD_SCAN_CTL_DISP3 4'b1101 // set the value of SSD 3
`define SSD_SCAN_CTL_DISP4 4'b1110 // set the value of SSD 4
`define SSD_SCAN_CTL_DISPALL 4'b0000 // set the value of SSD to ALL

// 7-segment display
`define SSD_BIT_WIDTH 8 // 7-segment display control
`define SSD_NUM 4 //number of 7-segment display
`define BCD_BIT_WIDTH 4 // BCD bit width
`define SSD_ZERO   `SSD_BIT_WIDTH'b0000_0011 // 0
`define SSD_ONE    `SSD_BIT_WIDTH'b1001_1111 // 1
`define SSD_TWO    `SSD_BIT_WIDTH'b0010_0101 // 2
`define SSD_THREE  `SSD_BIT_WIDTH'b0000_1101 // 3
`define SSD_FOUR   `SSD_BIT_WIDTH'b1001_1001 // 4
`define SSD_FIVE   `SSD_BIT_WIDTH'b0100_1001 // 5
`define SSD_SIX    `SSD_BIT_WIDTH'b0100_0001 // 6
`define SSD_SEVEN  `SSD_BIT_WIDTH'b0001_1111 // 7
`define SSD_EIGHT  `SSD_BIT_WIDTH'b0000_0001 // 8
`define SSD_NINE   `SSD_BIT_WIDTH'b0000_1001 // 9
`define SSD_A   `SSD_BIT_WIDTH'b0000_0101 // a
`define SSD_B   `SSD_BIT_WIDTH'b1100_0001 // b
`define SSD_C   `SSD_BIT_WIDTH'b1110_0101 // c
`define SSD_D   `SSD_BIT_WIDTH'b1000_0101 // d
`define SSD_E   `SSD_BIT_WIDTH'b0110_0001 // e
`define SSD_F   `SSD_BIT_WIDTH'b0111_0001 // f
`define SSD_DEF    `SSD_BIT_WIDTH'b0000_0000 // default, all LEDs being lighted

// BCD counter
`define BCD_BIT_WIDTH 4 // BCD bit width 
`define ENABLED 1 // ENABLE indicator
`define DISABLED 0 // EIDABLE indicator
`define INCREMENT 1'b1 // increase by 1
`define BCD_ZERO 4'd0 // 1 for BCD
`define BCD_ONE 4'd1 // 1 for BCD
`define BCD_TWO 4'd2 // 2 for BCD
`define BCD_THREE 4'd3 // 2 for BCD
`define BCD_FOUR 4'd4 // 2 for BCD
`define BCD_FIVE 4'd5 // 5 for BCD
`define BCD_SIX 4'd6 // 2 for BCD
`define BCD_SEVEN 4'd7 // 2 for BCD
`define BCD_EIGHT 4'd8 // 2 for BCD
`define BCD_NINE 4'd9 // 9 for BCD
`define BCD_DEF 4'd15 // all 1