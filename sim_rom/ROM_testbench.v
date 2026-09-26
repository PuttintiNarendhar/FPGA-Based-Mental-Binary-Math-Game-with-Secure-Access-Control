//ECE6370
//Author: Narendhar Puttinti, PSID: 2454090
//ROM_testbench
//it will provides stimulus to ROM_PSWD module to check the output signal timing 
//by providing different addresses we can get different output data.
`timescale 1 ns/100 ps
module ROM_testbench();
reg clk;
reg [4:0] addr;
wire [3:0] q_ROM;

always
   begin
   clk = 1'b0;
   #10;
   clk = 1'b1;
   #10;
   end

   ROM_PSWD ROM_PSWD_DUT (addr, clk, q_ROM);

   initial begin
      addr = 5'b00000;
      @(posedge clk);
      @(posedge clk);
      @(posedge clk);
      @(posedge clk);
      @(posedge clk);
      @(posedge clk);
      @(posedge clk);
      @(posedge clk);
      @(posedge clk);

      addr = 5'b00001;
      @(posedge clk);
      @(posedge clk);
      @(posedge clk);
      @(posedge clk);
      @(posedge clk);
      @(posedge clk);
      @(posedge clk);
      @(posedge clk);
      @(posedge clk);

      addr = 5'b00010;
      @(posedge clk);
      @(posedge clk);
      @(posedge clk);
      @(posedge clk);
      @(posedge clk);
      @(posedge clk);
      @(posedge clk);
      @(posedge clk);
      @(posedge clk);

      addr = 5'b00011;
      @(posedge clk);
      @(posedge clk);
      @(posedge clk);
      @(posedge clk);
      @(posedge clk);
      @(posedge clk);
      @(posedge clk);
      @(posedge clk);
      @(posedge clk);

      addr = 5'b00100;
      @(posedge clk);
      @(posedge clk);
      @(posedge clk);
      @(posedge clk);
      @(posedge clk);
      @(posedge clk);
      @(posedge clk);
      @(posedge clk);
      @(posedge clk);

      addr = 5'b00101;
      @(posedge clk);
      @(posedge clk);
      @(posedge clk);
      @(posedge clk);
      @(posedge clk);
      @(posedge clk);
      @(posedge clk);
      @(posedge clk);
      @(posedge clk);
   end

endmodule