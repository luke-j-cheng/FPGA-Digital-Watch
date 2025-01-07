`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/23/2024 02:30:08 PM
// Design Name: 
// Module Name: top_tb
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


module top_tb();
    reg btnL_tb, btnU_tb, btnC_tb, btnR_tb, clk_tb = 0;
    reg [1:0] switch_tb = 2'b0; 
    wire [6:0] seg_tb;
    wire [3:0] an_tb;
    wire [3:0] thous, hun, ten, one;
    // Instantiation of the top module
    top instant(
        .btnL(btnL_tb), 
        .btnU(btnU_tb), 
        .btnC(btnC_tb), 
        .btnR(btnR_tb), 
        .clk(clk_tb),
        .switch(switch_tb), 
        .seg(seg_tb), 
        .an(an_tb),
        .thousands(thous),
        .hundreds(hun),
        .tens(ten),
        .ones(one)
    );
    always begin
        #2;
        clk_tb = ~clk_tb;
    end
    initial begin
        #20;
        btnU_tb = 1;
        #100;
        switch_tb = 2'b01;
        #20;
        btnL_tb = 1;
        #100;
        switch_tb = 2'b0;
        #80;
        switch_tb = 2'b01;
        #70;
        switch_tb = 2'b10;
        #50;
        switch_tb = 2'b11;
        #15;
        $finish;
    
    end
    
    
    
endmodule
