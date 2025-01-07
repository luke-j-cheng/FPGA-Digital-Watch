`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/23/2024 10:31:15 PM
// Design Name: 
// Module Name: display_tb
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


module display_tb();
    reg clk_tb;
    reg [3:0] ones_tb = 3;
    reg [3:0] tens_tb = 5;
    reg [3:0] hundreds_tb = 7;
    reg [3:0] thousands_tb = 8;

    // Outputs from the DUT
    wire [3:0] digit_tb;
    wire [6:0] number_tb;

    // Instantiate the DUT
    display instant(
        .clk(clk_tb),
        .ones(ones_tb),
        .tens(tens_tb),
        .hundreds(hundreds_tb),
        .thousands(thousands_tb),
        .digit(digit_tb),
        .number(number_tb)
    );      
    always begin
        #2;
        clk_tb = ~clk_tb;
    end 
   
    initial begin
        #200;
        $finish;
    end
endmodule
