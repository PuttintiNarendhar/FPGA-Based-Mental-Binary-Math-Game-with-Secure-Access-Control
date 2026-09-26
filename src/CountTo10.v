//Author: Narendhar Puttinti, PSID: 2454090
//CountTo10
//it will count to 10
//if rst is 0 count will be 0
//it starts counting only if TimeIn_100ms is 1
module CountTo10(clk, rst, TimeIn_100ms, TimeOut_1s);
   input clk, rst, TimeIn_100ms;
   output TimeOut_1s;
   reg TimeOut_1s;
   reg [3:0] Count;

   always @(posedge clk) begin
   if(rst == 1'b0) begin
      Count <= 4'd0;
      TimeOut_1s <= 1'b0;
   end
   else if(TimeIn_100ms == 1'b1) begin
      if(Count == 4'd10) begin
         Count <= 4'd0;
         TimeOut_1s <= 1'b1;
      end
      else begin
         Count <= Count + 1'b1;
         TimeOut_1s <= 1'b0;
      end
   end
   else begin
         TimeOut_1s <= 1'b0;
      end
   end
 
endmodule
