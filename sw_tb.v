`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/21/2024 04:46:06 PM
// Design Name: 
// Module Name: sw_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module sw_tb();
reg pause_tb;              // Pause signal
reg rst_tb;                // Reset signal
reg clk1sec_tb;            // 1-second clock input
reg clk100MHz_tb;          // 100 MHz clock input
wire [3:0] tenminout_tb;  // Output for tens of minutes
wire [3:0] oneminout_tb;  // Output for ones of minutes
wire [3:0] tensecout_tb;  // Output for tens of seconds
wire [3:0] onesecout_tb;  // Output for ones of seconds

stopwatch instant(
    .pause(pause_tb),            // Connect pause_tb
    .rst(rst_tb),                // Connect rst_tb
    .clk1sec(clk1sec_tb),        // Connect clk1sec_tb
    .clk100MHz(clk100MHz_tb),    // Connect clk100MHz_tb
    .tenminout(tenminout_tb),    // Connect tenminout_tb
    .oneminout(oneminout_tb),    // Connect oneminout_tb
    .tensecout(tensecout_tb),    // Connect tensecout_tb
    .onesecout(onesecout_tb)     // Connect onesecout_tb
);

always begin
    #2;
    clk1sec_tb <= ~clk1sec_tb;
end
always begin
    #2;
    clk100MHz_tb <= ~clk100MHz_tb;
end
initial begin
    clk1sec_tb = 0;
    clk100MHz_tb = 0;
    #15;
    pause_tb = 1;
    #90;
    pause_tb = 0;
    #30;
    rst_tb = 1;
    #15;
    $finish;
end
endmodule
