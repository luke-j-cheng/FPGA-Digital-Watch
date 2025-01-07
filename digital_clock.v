`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/02/2024 11:30:47 AM
// Design Name: 
// Module Name: digital_clock
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

///TRY DOING ALWAYS @ POSEDGES WITH CONDITIONALS i.e.
/// if(min && ten && ....)


module digital_clock(
    input minbtn,
    input tenminbtn,
    input hrbtn, 
    input rst,
    input clk100MHz,
    input clk1sec,
    input [1:0] sel,
    output reg [3:0] tenhrout,
    output reg [3:0] onehrout,
    output reg [3:0] tenminout,
    output reg [3:0] oneminout
    );
    
    reg [5:0] counter = 0;
    reg minute = 0; //Ticks every min
    reg [3:0] tenhour = 1, onehour = 2, tenmin = 0, onemin = 0; // Clock will always start at 12:00
    reg tentick = 0, hrtick = 0; //Ticks every ten minutes, ticks every hour
    
   
    

    always @(posedge clk1sec)begin
        if(rst && sel == 0)begin
            onemin <= 0;   
            tenmin <= 0;
            onehour <= 2;
            tenhour <= 1;
        end
        else
        if(rst && sel == 0)begin
                counter <= 0;
                onemin <= 0;
                tenmin <= 0;
                onehour <= 0;
                tenhour <= 0;
            end
            else if (minbtn && sel == 2'b00)begin
                if(onemin == 9)
                    onemin <= 0;
                else
                    onemin <= onemin + 1;
            end
            else if (tenminbtn && sel == 2'b00)begin
                if(tenmin == 5)
                    tenmin <= 0;
                else
                    tenmin <= tenmin + 1;
            end
            else if(hrbtn && sel == 2'b00)begin
                if (onehour == 9 && tenhour == 0) begin
                    onehour <= 0;
                    tenhour <= 1;
                end
                else if (onehour == 2 && tenhour == 1) begin
                    onehour <= 1;
                    tenhour <= 0;
                end
                else begin
                    onehour <= onehour + 1;
                end           
            end
            else begin                
                if (counter == 59)begin //Creates a positive edge every minute every 60 seconds)
                    counter <= 0;
                    if (onemin == 9) begin // Increments by one minute every clock cycle posedge
                        onemin <= 0;
                        if (tenmin == 5) begin // Edge case handling 
                            tenmin <= 0;
                            if (onehour == 9 && tenhour == 0) begin
                                onehour <= 0;
                                tenhour <= 1;
                            end
                            else if (onehour == 2 && tenhour == 1) begin
                                onehour <= 1;
                                tenhour <= 0;
                            end
                            else begin
                                onehour <= onehour + 1;
                            end
                        end
                        else begin
                            tenmin <= tenmin + 1;  
                        end
                    end
                    else begin
                        onemin <= onemin + 1;
                    end
                
                end
                
                else begin
                    counter <= counter + 1;   
                end
          end    
    end
    
    
    // Same logic applies for ten minute column and hour column as above always statement 
   

    //Output register updates every 100 MHz clock cycle (avoid glitches)

    always @(posedge clk100MHz)begin
        tenhrout <= tenhour;
        onehrout <= onehour;
        tenminout <= tenmin;
        oneminout <= onemin;
    end
    
endmodule
