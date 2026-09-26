//Author: Narendhar Puttinti, PSID: 2454090
//DigitTimer
//it is used for 1's digit, 10's digit and any digit Timer 
//it has Reconfig, BorrowDN, NoBorrowUp, clk, rst input signals
//and generates BorrowUp, NoBorrowDN, DigitCount output signals
//This is a one digit count down timer that counts from 9 to 0 every one second
//it generates a borrow signal when it reaches 0 and set a NoBorrowDN signal high if it can't borrow a number from higher level
module DigitTimer(Reconfig, BorrowDN, NoBorrowUp, clk, rst, BorrowUp, NoBorrowDN, DigitCount);
   input clk, rst, Reconfig;
   input BorrowDN, NoBorrowUp;
   output BorrowUp, NoBorrowDN;
   output [3:0] DigitCount;

   reg BorrowUp, NoBorrowDN;
   reg [3:0] DigitCount;

   always @(posedge clk) begin
      if(rst == 1'b0) begin
         DigitCount <= 4'd0;
         BorrowUp <= 1'b0;
         NoBorrowDN <= 1'b1;
      end
      else if(Reconfig == 1'b1) begin
         DigitCount <= 4'd9;
         BorrowUp <= 1'b0;
         NoBorrowDN <= 1'b0;
      end
      else if(BorrowDN == 1'b1) begin
         if(DigitCount == 4'd0 && NoBorrowUp == 1'b0) begin
            NoBorrowDN <= 1'b0;
            BorrowUp <= 1'b1;
            DigitCount <= 4'd9;
         end
         else if(DigitCount == 4'd0 && NoBorrowUp == 1'b1) begin
            NoBorrowDN <= 1'b1;
            BorrowUp <= 1'b0;
            DigitCount <= 4'd0;
         end
         else begin
            DigitCount <= DigitCount - 4'd1;
            BorrowUp <= 1'b0;
            NoBorrowDN <= 1'b0;
         end
      end
      else begin
         if(DigitCount == 4'd0 && NoBorrowUp == 1'b1) begin
            NoBorrowDN <= 1'b1;
            BorrowUp <= 1'b0;
            DigitCount <= 4'd0;
         end
         else begin
            BorrowUp <= 1'b0;
            NoBorrowDN <= 1'b0;
         end
      end
      
   end

endmodule
