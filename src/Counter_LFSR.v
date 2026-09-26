//Author: Narendhar Puttinti, PSID: 2454090
//Counter_LFSR
//it is 4-bit counter using LFSR, range from 0000 to 1110
//if rst is 0 Count_Out is 0
//it is a positive edge triggered System with active low reset
//Count_Out is generated randomly only when Count signal is active/enabled and there is no 1111(F)
module Counter_LFSR(clk, rst, Count, Count_Out);
   input clk, rst, Count;
   output [3:0] Count_Out;

   reg [3:0] LFSR;
   wire feedback = LFSR[3];

   always @(posedge clk) begin
   if(rst == 1'b0) begin
      LFSR <= 4'b0000;
   end
   else begin
      if(Count == 1'b1) begin
         LFSR[0] <= feedback;
         LFSR[1] <= LFSR[0] ~^ feedback;
         LFSR[2] <= LFSR[1];
         LFSR[3] <= LFSR[2];
      end
   end
   end
 
   assign Count_Out = LFSR;

endmodule
