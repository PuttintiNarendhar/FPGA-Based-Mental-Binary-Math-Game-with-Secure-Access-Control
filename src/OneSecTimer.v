//Author: Narendhar Puttinti, PSID: 2454090
//OneSecTimer
//it will count one second
//if rst is 0 count will be 0
//it starts counting only if it is enabled
//it is the top module with HundredmsTimer, CountTo10 and raises OneSecTimeOut signal for every second
module OneSecTimer(clk, rst, enable, OneSecTimeOut);
   input clk, rst, enable;
   output OneSecTimeOut;
   wire TimeOut_100ms;
 
   HundredmsTimer DUT_HundredmsTimer (clk, rst, enable, TimeOut_100ms);
   CountTo10 DUT_CountTo10 (clk, rst, TimeOut_100ms, OneSecTimeOut);
endmodule
