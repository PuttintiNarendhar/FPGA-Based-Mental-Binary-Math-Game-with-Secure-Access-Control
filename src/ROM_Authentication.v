//ECE6370
//Author: Narendhar Puttinti, PSID: 2454090
//ROM_Authentication
//controls the login and logout by verifing the password entered with the password stored in the ROM
//using High level FSM 
//if rst is 0 current state is INIT otherwise Next State
//it is a positive edge triggered System with active low reset
//there are 10 states namely INIT, CHECKBUTTON, FETCHROMWD, ROMCYC1, ROMCYC2, ROMCATCH, COMPARE, CHECK4DIGITS, VERIFY and SUCCESS
//it will control game controller module to start or not by the signal called Passed
module ROM_Authentication(PasswordEnter, PasswordDigit, ROM_Data, LogOutGame, clk, rst, Logged_In, Logged_Out, Passed, ROM_Addr);
   input clk, rst;
   input PasswordEnter, LogOutGame;
   input [3:0] ROM_Data;
   input [3:0] PasswordDigit;
   output [4:0] ROM_Addr;
   output Logged_In, Logged_Out, Passed;
   reg Logged_In, Logged_Out, Passed;
   reg [4:0] ROM_Addr;
   
   parameter INIT = 0, CHECKBUTTON = 1, FETCHROMWD = 2, ROMCYC1 = 3, ROMCYC2 = 4, ROMCATCH = 5, COMPARE = 6, CHECK4DIGITS = 7, VERIFY = 8, SUCCESS = 9;
   reg SoFarSoGood;
   reg [3:0] State;
   reg [3:0] Store_ROMD;
   reg [1:0] Count;

   always @(posedge clk) begin
      if(rst == 1'b0) begin
         Logged_In <= 1'b0;
         Logged_Out <= 1'b1;
         Passed <= 1'b0;
         SoFarSoGood <= 1'b1;
         State <= INIT;
         ROM_Addr <= 5'b00000;
         Store_ROMD <= 4'b0000;
         Count <= 2'b00;
      end
      else begin
         case(State)
              INIT: begin
                    Logged_In <= 1'b0;
                    Logged_Out <= 1'b1;
                    Passed <= 1'b0;
                    SoFarSoGood <= 1'b1;
                    ROM_Addr <= 5'b00000;
                    Store_ROMD <= 4'b0000;
                    Count <= 2'b00;
                    State <= CHECKBUTTON;
                    end
       CHECKBUTTON: begin
                    Logged_In <= 1'b0;
                    Logged_Out <= 1'b1;
                    Passed <= 1'b0;
                    if(PasswordEnter == 1'b1) begin
                       State <= FETCHROMWD;
                    end
                    else begin
                       State <= CHECKBUTTON;
                    end
                    end
        FETCHROMWD: begin
                    Logged_In <= 1'b0;
                    Logged_Out <= 1'b1;
                    Passed <= 1'b0;
                    ROM_Addr <= {3'b000 , Count};
                    State <= ROMCYC1;
                    end
           ROMCYC1: begin
                    Logged_In <= 1'b0;
                    Logged_Out <= 1'b1;
                    Passed <= 1'b0;
                    State <= ROMCYC2;
                    end
           ROMCYC2: begin
                    Logged_In <= 1'b0;
                    Logged_Out <= 1'b1;
                    Passed <= 1'b0;
                    State <= ROMCATCH;
                    end
          ROMCATCH: begin
                    Logged_In <= 1'b0;
                    Logged_Out <= 1'b1;
                    Passed <= 1'b0;
                    Store_ROMD <= ROM_Data;
                    State <= COMPARE;
                    end
           COMPARE: begin
                    Logged_In <= 1'b0;
                    Logged_Out <= 1'b1;
                    Passed <= 1'b0;
                    State <= CHECK4DIGITS;
                    if(Store_ROMD == PasswordDigit) begin
                       //digit entered is correct
                    end
                    else begin
                       //digit entered is wrong
                       SoFarSoGood <= 1'b0;
                    end
                    end
      CHECK4DIGITS: begin
                    Logged_In <= 1'b0;
                    Logged_Out <= 1'b1;
                    Passed <= 1'b0;
                    if(Count == 2'b11) begin
                       State <= VERIFY;
                    end
                    else begin
                       Count <= Count + 1'b1;
                       State <= CHECKBUTTON;
                    end
                    end
            VERIFY: begin
                    Logged_In <= 1'b0;
                    Logged_Out <= 1'b1;
                    Passed <= 1'b0;
                    if(SoFarSoGood == 1'b1) begin
                       State <= SUCCESS;
                    end
                    else begin
                       State <= INIT;
                    end
                    end
           SUCCESS: begin
                    Logged_In <= 1'b1;
                    Logged_Out <= 1'b0;
                    Passed <= 1'b1;
                    if(LogOutGame == 1'b1) begin
                       State <= INIT;
                    end
                    else begin
                       State <= SUCCESS;
                    end
                    end
            default: begin
                    Logged_In <= 1'b0;
                    Logged_Out <= 1'b1;
                    Passed <= 1'b0;
                    State <= INIT;
                    end
         endcase
      end
   end

endmodule
