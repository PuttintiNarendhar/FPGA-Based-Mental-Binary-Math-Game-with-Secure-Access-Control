//Author: Narendhar Puttinti, PSID: 2454090
//CountTo100
//it will count to 100
//if rst is 0 count will be 0
//it starts counting only if TimeIn_1ms is 1
module CountTo100(clk, rst, TimeIn_1ms, TimeOut_100ms);
   input clk, rst, TimeIn_1ms;
   output TimeOut_100ms;
   reg TimeOut_100ms;
   reg [6:0] Count;

   always @(posedge clk) begin
   if(rst == 1'b0) begin
      Count <= 7'd0;
      TimeOut_100ms <= 1'b0;
   end
   else if(TimeIn_1ms == 1'b1) begin
      if(Count == 7'd100) begin
         Count <= 7'd0;
         TimeOut_100ms <= 1'b1;
      end
      else begin
         Count <= Count + 1'b1;
         TimeOut_100ms <= 1'b0;
      end
   end
   else begin
         TimeOut_100ms <= 1'b0;
      end
   end
 
endmodule
