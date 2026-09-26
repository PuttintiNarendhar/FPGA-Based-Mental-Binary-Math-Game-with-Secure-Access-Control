//ECE6370
//Author: Narendhar Puttinti, PSID: 2454090
//Adder
//Addition of two 4-bit numbers
//with two inputs Num1, Num2 and one output 4-bit Sum
//Sum will be in the range of 0-15(F)
//any value greater than 15 will be rounded into same range.
module Adder(Num1, Num2, Sum);
   input [3:0] Num1, Num2;
   output [3:0] Sum;
   reg [3:0] Sum;
   
   always @(Num1, Num2)
      begin
         Sum = Num1 + Num2;
      end

endmodule
