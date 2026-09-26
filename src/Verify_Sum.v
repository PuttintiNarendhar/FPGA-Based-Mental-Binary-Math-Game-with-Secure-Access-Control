//ECE6370
//Author: Narendhar Puttinti, PSID: 2454090
//Verify_Sum
//Compares the input number with 1111
//and drives Matching and NonMatching signals
//either ON or OFF based on the comparsion between the input with 1111
module Verify_Sum (Sum, Matching, NonMatching);
   input [3:0] Sum;
   output Matching, NonMatching;
   reg Matching, NonMatching;
 
   always @(Sum)
     begin
        if(Sum == 4'b1111)
          begin
             Matching <= 1'b1;
             NonMatching <= 1'b0;
          end
        else
          begin
             Matching <= 1'b0;
             NonMatching <= 1'b1;
          end
     end

endmodule