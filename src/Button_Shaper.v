//ECE6370
//Author: Narendhar Puttinti, PSID: 2454090
//Button_Shaper
//gives or shapes a single cycle pulse
//using Two-Procedure FSM 
//if rst is 0 current state is INIT otherwise Next State
//it is a positive edge triggered System with active low reset
//there are three states namely INIT, PULSE, WAIT
module Button_Shaper(B_In, B_Out, clk, rst);
   input B_In;
   output B_Out;
   input clk, rst;
   reg B_Out;

   parameter INIT = 0, PULSE = 1, WAIT = 2;
   reg [1:0] State, NextState;
 
   //comblogic
   //use blocking assignment
   always @(State, B_In)
     begin
        case(State)
           INIT:  begin
                    B_Out = 1'b0;
                    if(B_In == 1'b0)
                      begin
                         NextState = PULSE;
                      end
                    else
                      begin
                         NextState = INIT;
                      end
                  end
          PULSE:  begin
                      B_Out = 1'b1;
                      NextState = WAIT;
                  end
          WAIT:   begin
                     B_Out = 1'b0;
                     if(B_In == 1'b1)
                      begin
                         NextState = INIT;
                      end
                    else
                      begin
                         NextState = WAIT;
                      end
                  end
          default: begin
                   B_Out = 1'b0;
                   NextState = INIT;
                   end
        endcase
     end

   //stateRegister
   //use non-blocking assignment
   always @(posedge clk)
     begin
       if(rst == 1'b0)
         begin
            State <= INIT;
         end
       else 
         begin
            State <= NextState;
         end
     end

endmodule
