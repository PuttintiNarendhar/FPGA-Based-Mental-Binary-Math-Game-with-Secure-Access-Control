//ECE6370
//Author: Narendhar Puttinti, PSID: 2454090
//LoadRegister
//Loading a 4-bit number into a register
//with four inputs clk, rst, D_in, Load and one output D_out
//if rst is 1 and Load is 1 then the register is loaded with a input 4-bit number
//it is a positive edge triggered register
module LoadRegister(D_in, D_out, clk, rst, Load);
   input [3:0] D_in;
   output [3:0] D_out;
   input clk, rst;
   input Load;
   reg [3:0] D_out;

   always@(posedge clk)
      begin
         if(rst == 1'b0)
           begin
             D_out <= 4'b0000;
           end
         else
         //normal operation after reset
           begin
             if(Load == 1'b1)
               begin
                  D_out <= D_in;
               end

           end
      end

endmodule
