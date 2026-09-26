//ECE6370
//Author: Narendhar Puttinti, PSID: 2454090
//Decoder_7seg
//7 segment display decoder(common anode), 1ogic-1 for OFF and logic-0 for ON
//with one 4-bit vector/bus input Num_In and one 7-bit vector/bus output Num_Out
//it follows segments g f e d c b a from MSB to LSB
//each case is decoded to their corresponding 7-segment display symbols
//any other cases or non matching cases will be decoded to all 1's or display OFF
module Decoder_7seg (Num_In, Num_Out);
    input [3:0] Num_In;
    output reg [6:0] Num_Out;
  
    always @(Num_In)
      begin
         case(Num_In)
         4'b0000 : begin
		   Num_Out = 7'b1000000;
                   end
         4'b0001 : begin
		   Num_Out = 7'b1111001;
                   end
         4'b0010 : begin
		   Num_Out = 7'b0100100;
                   end
         4'b0011 : begin
		   Num_Out = 7'b0110000;
                   end
         4'b0100 : begin
		   Num_Out = 7'b0011001;
                   end
         4'b0101 : begin
		   Num_Out = 7'b0010010;
                   end
         4'b0110 : begin
		   Num_Out = 7'b0000010;
                   end
         4'b0111 : begin
		   Num_Out = 7'b1111000;
                   end
         4'b1000 : begin
		   Num_Out = 7'b0000000;
                   end
         4'b1001 : begin
		   Num_Out = 7'b0010000;
                   end
         4'b1010 : begin
		   Num_Out = 7'b0001000;
                   end
         4'b1011 : begin
		   Num_Out = 7'b0000011;
                   end
         4'b1100 : begin
		   Num_Out = 7'b1000110;
                   end
         4'b1101 : begin
		   Num_Out = 7'b0100001;
                   end
         4'b1110 : begin
		   Num_Out = 7'b0000110;
                   end
         4'b1111 : begin
		   Num_Out = 7'b0001110;
                   end
         default : begin
		   Num_Out = 7'b1111111;
                   end
         endcase
      end

endmodule
