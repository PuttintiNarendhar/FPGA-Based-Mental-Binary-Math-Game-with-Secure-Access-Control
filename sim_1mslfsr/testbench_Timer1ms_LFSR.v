//Author: Narendhar Puttinti, PSID: 2454090
//testbench_Timer1ms_LFSR
//it will provides stimulus to Counter_1ms and Timer1ms_LFSR modules by instatiating them
//if rst is 0 TimeOut_Old1ms, TimeOut_LFSR1ms will be 0
//provides enable signal to control the Counter_1ms and Timer1ms_LFSR
`timescale 1 ns/100 ps
module testbench_Timer1ms_LFSR();
   reg clk, rst, enable;
   wire TimeOut_Old1ms, TimeOut_LFSR1ms;

   always
       begin
         clk = 1'b0;
         #10;
         clk = 1'b1;
         #10;
       end

   Counter_1ms DUT_Counter_1ms (clk, rst, enable, TimeOut_Old1ms);
   Timer1ms_LFSR DUT_Timer1ms_LFSR (clk, rst, enable, TimeOut_LFSR1ms);
 
   integer i;
   initial 
      begin  
        rst = 1'b1;
        enable = 1'b0;
 
        @(posedge clk);
        @(posedge clk);
        #5 rst = 1'b0;
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        #5 rst = 1'b1;
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        #5 enable = 1'b1;
        for(i = 0; i < 50010; i = i + 1) begin
           @(posedge clk);
        end
        @(posedge clk);
        #5 enable = 1'b0;
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        #5 enable = 1'b1;
        for(i = 0; i < 50010; i = i + 1) begin
           @(posedge clk);
        end
        @(posedge clk);
        #5 enable = 1'b0;
        @(posedge clk);
      end

endmodule
