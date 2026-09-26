//ECE6370
//Author: Narendhar Puttinti, PSID: 2454090
//Game_Controller
//controls the load signals and two digit timer
//using One-Procedure FSM 
//if rst is 0 current state is INIT otherwise Next State
//it is a positive edge triggered System with active low reset
//there are 6 states namely INIT, RECONFIGTIMER, GAMESTART, GAMEPLAY, GAMEOVER and LOGOUTWAIT
//provides game logout signal to logging out from the game and it will starts only if the player's authentication is passed.
module Game_Controller(Passed, GameEnter, Load_P_In, RNG_Gen_In, TimeOut, clk, rst, Load_P_Out, RNG_Gen_Out, Timer_Reconfig, Timer_Enable, LogOutGame);
   input clk, rst;
   input Load_P_In, Passed, GameEnter, RNG_Gen_In, TimeOut;
   output Load_P_Out, RNG_Gen_Out, Timer_Reconfig, Timer_Enable, LogOutGame;
   reg Load_P_Out, RNG_Gen_Out, Timer_Reconfig, Timer_Enable, LogOutGame;
   
   parameter INIT = 0, RECONFIGTIMER = 1, GAMESTART = 2, GAMEPLAY = 3, GAMEOVER = 4, LOGOUTWAIT = 5;
   reg [3:0] State;

   always @(posedge clk) begin
      if(rst == 1'b0) begin
         Load_P_Out <= 1'b0;
         RNG_Gen_Out <= 1'b1;
         Timer_Reconfig <= 1'b0;
         Timer_Enable <= 1'b0;
         LogOutGame <= 1'b0;
         State <= INIT;
      end
      else begin
         case(State)
              INIT: begin
                    Load_P_Out <= 1'b0;
                    RNG_Gen_Out <= 1'b1;
                    Timer_Reconfig <= 1'b0;
                    Timer_Enable <= 1'b0;
                    LogOutGame <= 1'b0;
                    if(Passed == 1'b1) begin
                       State <= RECONFIGTIMER;
                    end
                    else begin
                       State <= INIT;
                    end
                    end
     RECONFIGTIMER: begin
                    Load_P_Out <= 1'b0;
                    RNG_Gen_Out <= 1'b1;
                    Timer_Reconfig <= 1'b1;
                    Timer_Enable <= 1'b0;
                    LogOutGame <= 1'b0;
                    State <= GAMESTART;
                    end
         GAMESTART: begin
                    Load_P_Out <= 1'b0;
                    RNG_Gen_Out <= 1'b1;
                    Timer_Reconfig <= 1'b0;
                    LogOutGame <= 1'b0;
                    if(GameEnter == 1'b1) begin
                       Timer_Enable <= 1'b1;
                       State <= GAMEPLAY;
                    end
                    else begin
                       State <= GAMESTART;
                    end
                    end
          GAMEPLAY: begin
                    Load_P_Out <= Load_P_In;
                    RNG_Gen_Out <= RNG_Gen_In;
                    Timer_Reconfig <= 1'b0;
                    Timer_Enable <= 1'b1;
                    LogOutGame <= 1'b0;
                    if(TimeOut == 1'b1) begin
                       State <= GAMEOVER;
                    end
                    else begin
                       State <= GAMEPLAY;
                    end
                    end
          GAMEOVER: begin
                    Load_P_Out <= 1'b0;
                    RNG_Gen_Out <= 1'b1;
                    Timer_Reconfig <= 1'b0;
                    Timer_Enable <= 1'b0;
                    if(Load_P_In == 1'b1) begin
                       LogOutGame <= 1'b1;
                       State <= LOGOUTWAIT;
                    end
                    else begin
                       LogOutGame <= 1'b0;
                       if(GameEnter == 1'b1) begin
                          State <= RECONFIGTIMER;
                       end
                       else begin
                          State <= GAMEOVER;
                       end
                    end
                    end
	     LOGOUTWAIT: begin
                    Load_P_Out <= 1'b0;
                    RNG_Gen_Out <= 1'b1;
                    Timer_Reconfig <= 1'b0;
                    Timer_Enable <= 1'b0;
		              LogOutGame <= 1'b0;
                    if(Passed == 1'b0) begin
                       State <= INIT;
                    end
                    else begin
                       State <= LOGOUTWAIT;
                    end
                    end
           default: begin
                    Load_P_Out <= 1'b0;
                    RNG_Gen_Out <= 1'b1;
                    Timer_Reconfig <= 1'b0;
                    Timer_Enable <= 1'b0;
                    LogOutGame <= 1'b0;
                    State <= INIT;
                    end
         endcase
      end
    end


endmodule
