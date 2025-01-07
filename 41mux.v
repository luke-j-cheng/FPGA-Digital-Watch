`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/22/2024 02:26:54 PM
// Design Name: 
// Module Name: 41mux
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


module quadmux(
    input [3:0] i1,
    input [3:0] i2,
    input [3:0] i3,
    input [1:0] sel,
    output wire [3:0] out
    );
    reg [3:0] outreg;
    always @(*) begin
        case(sel)
            
            2'b00 : outreg = i1;
            2'b01 : outreg = i2;
            2'b10 : outreg = i3;
            2'b11 : outreg = 4'd10;
        
        endcase
    end
    
    assign out = outreg;
    
endmodule
