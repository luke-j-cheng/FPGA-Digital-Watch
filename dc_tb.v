`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/20/2024 07:08:55 PM
// Design Name: 
// Module Name: dc_tb
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


module dc_tb();
    reg clk100MHz_tb = 0, clk1sec_tb = 0, rst_tb = 0, minbtn_tb = 0, tenminbtn_tb = 0;
    wire [3:0] tenhrout_tb, onehrout_tb, tenminout_tb, oneminout_tb;
    integer sec = 0;
    
    digital_clock instant(
        .clk100MHz(clk100MHz_tb),
        .clk1sec(clk1sec_tb),
        .rst(rst_tb),
        .minbtn(minbtn_tb),
        .tenminbtn(tenminbtn_tb),
        .tenhrout(tenhrout_tb),
        .onehrout(onehrout_tb),
        .tenminout(tenminout_tb),
        .oneminout(oneminout_tb)
    );
    
    always begin
        #1;
        clk100MHz_tb = ~clk100MHz_tb;
    end
    always begin
        #3;
        clk1sec_tb = ~clk1sec_tb;
    end
    always @(posedge clk1sec_tb)begin
        sec = sec + 1;
    end
    
    always @(oneminout_tb)begin
        $display ("%s%d " ," Seocnds Elapsed :" , sec);
        sec = 0;
    end
    
    initial begin
        #800;
        $finish;
    end
    
    
endmodule
