<h1>  ⌚ Digital FPGA Watch ⌚</h1>
<h3>Made using Verilog in AMD Xilinix Vivado
<br/> FPGA Board: Basys 3 (Digilent)</h3>

<br/>
<b>
This project is a digital watch that is made on my FPGA board using the 7 segment display<br/>
The watch has a digital clock, stopwatch, and a timer<br/>
Below I have some brief descriptions of the modules I have made<br/>
Click
<a href="https://youtu.be/NJnX_LAqaFY"> here</a> to see the watch being used
</b>

<h2> 
  Modules 
</h2>
<h3>
  Debouncer
</h3>
This module simply is used to prevent any "bouncing" of the buttons which could lead to unintended actions/button presses on the board<br/>
It is a shift register that is triggered by a clock cycle of 5 Hz
<h3>
  Clock Dividers
</h3>
Each clock divider serves to create a slower clock that triggers every so often. Each has a different purpose<br/>
Debounce Clock: A clock used for the debouncing modules/shift registers<br/>
Anode Clock: A clock used to change which number is lit up on the seven segement display<br/>
Second Clock: A clock that has a positive edge every second 

<h3>
  Digital Clock Module
</h3>
  This Clock module updates the clock every minute<br/>
  There are butttons to adjust the hours/minutes to the desired time, and these can only be triggered when on clock mode (enable signals)<br/>
  The clock continues to run when on other modes and the buttons don't affect the digital clock module<br/>
<h3>
  Stopwatch Module
</h3>
  The stopwatch module keeps tracks of seconds/minutes and goes up to 99:00 before resetting to 00:00 (will continue counting)<br/>
  There is a register that keeps track of if the module is toggled. Only when toggled will the clock increment <br/>
  Like the digital clock, the module increments the time regardless of the current module used<br/>
  Pushbuttons only affect the stopwatch when used on stopwatch mode<br/>
<h3>
  Timer Module
</h3>
  Operates similar to the stopwatch module but in the opposite direction<br/>
  Has a register to keep track of the toggle that will count down when toggled AND when the clock is not 00:00<br/>
  When not toggled, the user is free to add minutes and increments of five seconds to the clock<br/>

<h3>
  Display Control
</h3>
  The previous 3 modules have 4 4-bit outputs, each corresponding to a digit (i.e. ones, tens)<br/>
  These digits are input into a mux and the proper digit is selected based on the selected mode <br/>
  These digits are then converted into their 7 segment display representation<br/>
  Depending on the anode chosen, this digit is then shown on the display<br/>
  A null digit was also added for when none of the 3 modes were chosen (lights off)<br/>
















