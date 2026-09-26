//Author: Narendhar Puttinti, PSID: 2454090
//Counter
//it is 4-bit counter, range from 0000 to 1111
//if rst is 0 Count_Out is 0
//it is a positive edge triggered System with active low reset
//Count_Out is incremented by 1 only when Count signal is active/enabled 
module Counter(clk, rst, Count, Count_Out);
   input clk, rst, Count;
   output [3:0] Count_Out;
   reg [3:0] Count_Out;

   always @(posedge clk) begin
   if(rst == 1'b0) begin
      Count_Out <= 4'b0000;
   end
   else begin
      if(Count == 1'b1) begin
         Count_Out <= Count_Out + 1'b1;
      end
   end
   end
 
endmodule
