`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/16/2024 11:14:53 AM
// Design Name: 
// Module Name: top
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


module top(clk, btnL, btnU, btnC, btnR, switch, an, seg, led);
    
    input btnL, btnU, btnC, btnR, clk;
    input [1:0] switch; 
    output [6:0] seg;
    output [3:0] an;
    output [1:0] led;
    
    
    reg [6:0] segreg;
    reg [3:0] anreg;
    
    wire buwire, bcwire, brwire, blwire;
    wire slowclk, anclk, sec;
    
    
    
    wire [3:0] tenhrdc, onehrdc, tenmindc, onemindc;
    wire [3:0] tenhrt, onehrt, tenmint, onemint;
    wire [3:0] tenhrsw, onehrsw, tenminsw, oneminsw;
    
    wire [3:0] digwire;
    wire [6:0] numwire;
    
    wire[3:0] thousands, hundreds, tens, ones;
    
    // Input Datapath
    
    Clockslow       dbclk(.clk(clk), .newclk(btnclk));
    clockdivider    anode_clk(.clk(clk), .newclk(anclk));
    secondclk       secclk(.clk(clk), .newclk(sec));
    
    debouncer       updb(.btn(btnU), .clk(btnclk), .btnsig(buwire));
    debouncer       centerdb(.btn(btnC), .clk(btnclk), .btnsig(bcwire));
    debouncer       rightdb(.btn(btnR), .clk(btnclk), .btnsig(brwire));
    debouncer       leftdb(.btn(btnL), .clk(btnclk), .btnsig(blwire));

    
    
    
    // Digital Clock, Stopwatch, Timer Modules 
    
    
    //SEL = 00
    digital_clock   dc(.minbtn(bcwire), .hrbtn(buwire), .rst(blwire), .tenminbtn(brwire), .clk100MHz(clk), .clk1sec(sec),
                    .sel(switch), .tenhrout(tenhrdc), .onehrout(onehrdc), .tenminout(tenmindc), .oneminout(onemindc));
    
    //SEL = 01
    stopwatch       sw(.rst(bcwire), .pause(blwire), .clk100MHz(clk), .clk1sec(sec),
                    .sel(switch), .tenminout(tenhrsw), .oneminout(onehrsw), .tensecout(tenminsw), .onesecout(oneminsw));
    
    //SEL = 10
    timer           t(.start(bcwire), .minbtn(buwire), .fivesecbtn(blwire), .rst(brwire), .clk100MHz(clk), .clk1sec(sec),
                    .sel(switch), .tenminout(tenhrt), .oneminout(onehrt), .tensecout(tenmint), .onesecout(onemint));
    
    // Output Datapath
    
    quadmux dig4(.i1(tenhrdc), .i2(tenhrsw), .i3(tenhrt), .sel(switch), .out(thousands));
    quadmux dig3(.i1(onehrdc), .i2(onehrsw), .i3(onehrt), .sel(switch), .out(hundreds));
    quadmux dig2(.i1(tenmindc), .i2(tenminsw), .i3(tenmint), .sel(switch), .out(tens));
    quadmux dig1(.i1(onemindc), .i2(oneminsw), .i3(onemint), .sel(switch), .out(ones));


    
    
    

    // 7 Segment Display Controller
    
    display control(.thousands(thousands), .hundreds(hundreds), .tens(tens), .ones(ones), 
                .clk(anclk), .digit(digwire), .number(numwire));

    
// Output Register and Wires

    always @(posedge clk) begin
        segreg <= numwire;
        anreg <= digwire;
    end    


    assign seg = segreg;
    assign an = anreg;
    assign led = switch;

    
endmodule
