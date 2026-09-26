//Author: Narendhar Puttinti, PSID: 2454090
//TwoDigitTimer
//it instantiates OneSecTimer, DigitTimer for 1's digit and 10's digit
//it will provides Reconfig, Timer_Enable, clk, rst input signals
//and generates Digit_1s, Digit_10s output signals
module TwoDigitTimer(Reconfig, Timer_Enable, clk, rst, TimeOut, Digit_1s, Digit_10s);
   input Reconfig, Timer_Enable, clk, rst;
   output TimeOut;
   output [3:0] Digit_1s, Digit_10s;

   wire OneSecTimeOut, Borrow_1sAnd10s, NoBorrow_10sAnd1s, BorrowUp;

   OneSecTimer DUT_OneSecTimer (clk, rst, Timer_Enable, OneSecTimeOut);

   DigitTimer DUT_DigitTimer_1s  (Reconfig, OneSecTimeOut, NoBorrow_10sAnd1s, clk, rst, Borrow_1sAnd10s, TimeOut, Digit_1s);
   DigitTimer DUT_DigitTimer_10s (Reconfig, Borrow_1sAnd10s, 1'b1, clk, rst, BorrowUp, NoBorrow_10sAnd1s, Digit_10s);

   assign BorrowUp = 1'b0;

endmodule
