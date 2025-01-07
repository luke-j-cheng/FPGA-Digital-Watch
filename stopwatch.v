module stopwatch(
    input pause, 
    input rst,
    input clk1sec,
    input clk100MHz,
    input [1:0] sel,
    output reg [3:0] tenminout,
    output reg [3:0] oneminout,
    output reg [3:0] tensecout,
    output reg [3:0] onesecout
    );
    reg toggle = 0;
    reg [3:0] tenmin = 0, onemin = 0, tensec = 0, onesec = 0;
    
    
    // Sets toggle to opposite if button is pressed AND stopwatch mode is live
    always @(posedge pause)begin
        if(sel == 2'b01)
            toggle = ~toggle;
    end
    
    always @(posedge clk1sec)begin
        if (rst && sel == 2'b01)begin
            onesec <= 0;
            tensec <= 0;
            onemin <= 0;
            tenmin <= 0;
        end
        else if(toggle)begin
            if (onesec == 9) begin //Increments by one second every clock cycle posedge
                onesec <= 0;
                if (tensec == 5) begin // Edge case handling 
                    tensec <= 0;
                    if (onemin == 9 && tenmin != 9)begin
                        onemin <= 0;
                        tenmin = tenmin + 1;
                    end
                            
                    else if (onemin == 9 && tenmin == 9)begin
                        onemin <= 0;
                        tenmin <= 0;
                    end
                            
                    else begin
                        onemin <= onemin + 1;
                    end
                end
                        
                else begin
                    tensec <= tensec + 1;  
                end
            end
                    
            else begin
                onesec <= onesec + 1;
            end
        end
    end
    
    
    // Update registers every ns to avoid glitches 
    always @(posedge clk100MHz)begin
        tensecout <= tensec;
        onesecout <= onesec;
        tenminout <= tenmin;
        oneminout <= onemin;
    end
    
        
    
endmodule