//Author: Narendhar Puttinti, PSID: 2454090
//Counter_1ms
//it will counts 50000 clock cycles 
//if rst is 0 count will be 0
//it starts counting only if it is enabled
module Counter_1ms(clk, rst, enable, TimeOut_1ms);
   input clk, rst, enable;
   output TimeOut_1ms;
   reg TimeOut_1ms;
   reg [15:0] Count;

   always @(posedge clk) begin
   if(rst == 1'b0) begin
      Count <= 16'd0;
      TimeOut_1ms <= 1'b0;
   end
   else if(enable == 1'b1) begin
      if(Count == 16'd50000) begin
         Count <= 16'd0;
         TimeOut_1ms <= 1'b1;
      end
      else begin
         Count <= Count + 1'b1;
         TimeOut_1ms <= 1'b0;
      end
   end
   else begin
         TimeOut_1ms <= 1'b0;
      end
   end
 
endmodule
