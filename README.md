# FPGA-Based Mental Binary Math Game with Secure Access Control
### ECE6370 Advanced Digital Design : ROM-Based Game Access Control on FPGA

*Developer:* Narendhar Puttinti  
*UHID:* 2454090  

---

## 🛠️ System Overview

The system implements a single-player hardware-based mental math game deployed on an *Altera Cyclone V (DE0-CV)* FPGA board. It operates across two core structural states: *Authentication Mode* and *Gameplay Mode*, utilizing specialized submodules to manage security and game logic on-chip.

### 1. Secure Access Control (Authentication)
* *ROM Storage:* Stores a default 4-digit verification profile mapped from a hardcoded ROM memory file (default password is set using the last four digits of the PeopleSoft ID: 4090).
* *Multi-Stage Entry:* The player sequentializes password digits using 4-bit binary switch states, confirming each input using a hardware pulse flag.
* *Status Indication:* Real-time state registers track successful verification or incorrect match attempts, gating access to downstream game functions.
* *Visual Status Flags:*
  * *Logged In (Rightmost LED - LED0):* Illuminates upon successful 4-digit code entry.
  * *Logged Out (Second Rightmost LED - LED1):* Remains continuously active when unauthorized or when a timeout occurs.

### 2. Mental Binary Math Engine & Game State
* *Hardware LFSR PRNG:* Implements a fast 4-bit Linear Feedback Shift Register running at an un-shaped 50 MHz clock domain. It cycles through pseudorandom configurations between 0 and 14 (excluding 15 / 4'b1111) to prevent fixed guessing.
* *Game Verification Logic:* 
  * The system generates a random number (\(N_{rand}\)).
  * The user reads the display, mentally computes the complementary value required to sum up to exactly 1111 in binary (15 or 4'hF), inputs their 4-bit choice via toggle switches, and presses the *LOAD* button.
  * *Matching LED (LED9):* Illuminates if \(N_{player} + N_{rand} == 15\) (4'hF), indicating a correct answer.
  * *Non-Matching LED (LED8):* Illuminates if the target sum is missed.
* *Timer Subsystem:* A countdown module running from 99 seconds down to 00 seconds that dictates active play sessions.

---

## 🗺️ FPGA Hardware Interface Mapping

Based on the *DE0-CV development board specification* profile, the design leverages peripheral I/O pins mapped as follows:

| Hardware Component | Functional Designation | Operational Behavior / Purpose |
| :--- | :--- | :--- |
| *HEX 5* | Timer (Tens Digit) | Displays tens place of the active game window time countdown. |
| *HEX 4* | Timer (Units Digit) | Displays units place of the active game window time countdown. |
| *HEX 3* | Score Display (Bonus) | Accumulates successfully completed match evaluation counts. |
| *HEX 2* | Target / Sum State | Displays current computational arithmetic results (F or E). |
| *HEX 1* | Random Number Display | Shows the current LFSR pseudorandom generated value (\(0 \dots 14\)). |
| *HEX 0* | Player Input Display | Mirrors the latched 4-bit input configuration set by the user. |
| *SW3 ~ SW0* | Data Input Switches | Shared 4-bit bus for entering Password Digits and Player Math Answers. |
| *BUTTON 0* | RESET Button | Hard system reset / Manual Log Out command. |
| *BUTTON 1* | Password / Game Start | Validates current password digit entry / Initializes the game timer. |
| *BUTTON 2* | Random Number Gen | Triggers high-frequency LFSR capture loop to lock a new puzzle. |
| *BUTTON 3* | Player LOAD Button | Latches the input switches to verify the binary complementary sum. |
| *LED 0* | Logged-In Flag | High state indicates authentication pass. |
| *LED 1* | Logged-Out Flag | High state indicates systemic user lockout. |
| *LED 8* | Non-Matching Error | Illuminates on incorrect sum verification attempt. |
| *LED 9* | Matching Success | Illuminates on successful balance match (Sum = 15). |

---

## 🕹️ Operational Procedure (How to Play)

### Phase 1: Authentication Loop
1. Initialize the target device by driving all user toggle switches to 0 (Down position). 
2. Press *BUTTON 1* (Game Start/Password Entry) to configure default variables.
3. Enter the target authentication profile (4090) sequentially using *SW3 to SW0*:
   * Set switches to the binary equivalent of the first digit → Press *BUTTON 1*.
   * Repeat execution order for all remaining target indices.
4. If authentication matches, *LED 0* illuminates. If authentication fails, *LED 1* illuminates, blocking input pipelines.

### Phase 2: Game Engagement Loop
1. Ensure system state reads *Logged In* (LED 0 Active).
2. Press *BUTTON 1* to initialize the game clock window to 99 seconds.
3. Press and release *BUTTON 2* to engage the free-running LFSR module and load a target arithmetic challenge onto *HEX 1*.
4. Mentally determine the missing binary component required to balance the equation to 15 (4'b1111).
5. Configure the balance value on *SW3 to SW0* and press *BUTTON 3* (LOAD).
   * *Correct Match:* LED 9 fires, HEX 2 drives to F, and your score increment counter advances.
   * *Incorrect Match:* LED 8 fires, and HEX 2 displays an error value (E).
6. Cycle through steps 3–5 to maximize target score metrics before the system clock drives down to 00.

---

## 💻 Compilation & Deployment Setup

Follow these steps to synthesize your design into a non-volatile configuration file using *Intel Quartus Prime* and flash it to the non-volatile memory device on your *DE0-CV Altera Cyclone V* board using Active Serial mode.

### 1. Generating the .pof File
1. Launch *Intel Quartus Prime* (Lite or Standard Edition).
2. Go to *File ➔ Open Project, browse to your project directory, select the .qpf file, and click **Open*.
3. Before compiling, ensure your project settings are configured to auto-generate a .pof file:
   * Go to *Assignments ➔ Device...*
   * Click the *Device and Pin Options...* button.
   * Under the *Configuration* category, change the Configuration Scheme to *Active Serial x1* (or Active Serial x4 depending on toolchain recommendation).
   * Set the Configuration Device to the board's matching flash memory (typically *EPCS64* or equivalent).
   * Click *OK* to close options.
4. Double-click *Start Compilation* in the tasks window (or press Ctrl + L). 
5. Once compilation reaches 100% without structural errors, verify that a .pof file has been written into your project's output_files/ directory.

### 2. Flashing the Onboard Memory Chip via AS Mode
Because you are writing your code permanently to the hardware memory layer rather than the temporary volatile layer, you must toggle the physical board mode switch:

1. Connect your *Terasic DE0-CV Board* to your computer via the native *USB-Blaster Port* using a USB cable.
2. Locate the slide toggle switch labeled *SW10 (RUN/PROG)* next to the 7-segment displays.
3. Slide the *SW10 switch to the PROG position*.
4. In Quartus, navigate to the top utility menu bar and select *Tools ➔ Programmer*.
5. Click *Hardware Setup...* at the top left corner, choose *USB-Blaster [USB-0]* from the drop-down menu selection list, and close the sub-window.
6. Change the *Mode drop-down menu from JTAG to Active Serial Programming*.
7. Click *Add File..., open the auto-generated output_files/ directory, choose your compiled *.pof file**, and click Open.
8. Check the *Program/Configure* box corresponding to your target row chip interface.
9. Click *Start* to initiate the flash program cycle. Wait until the progress bar reaches *100% (Successful)*.
10. Once the programming operation finishes successfully, *slide the SW10 switch back to the RUN position* to boot up the game. The hardware digits will instantly initialize in the *Logged Out* state, waiting for your security passcode input logic sequence.

---

## 🛠️ Software Environment & Toolchain
* *Design Environment:* Intel Quartus Prime (Lite/Standard Edition)
* *Target Hardware:* Altera Cyclone V 28-nm FPGA (5CEBA4F23C7N)
* *Hardware Description Language:* Verilog / VHDL
