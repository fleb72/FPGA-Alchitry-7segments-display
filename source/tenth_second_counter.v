module tenth_second_counter
    #(parameter ticks_1_second = 100_000_000) // fréquence = 100 MHz par défaut
    
    (input rst,
     input clk,
     input enable,
     output reg [13:0] out
    );
    
    reg [24:0] counter;
    
    initial begin
        counter <= 0;
        out <= 0;
    end
    
    always @(posedge clk or posedge rst) begin
        if (rst == 1) begin
            counter <= 0;
            out <= 0;
        end
        else if (enable == 1) begin
                if (counter >= ticks_1_second/10 - 1) begin // 1/10e seconde atteint
                   counter <= 0;
                   out <= out + 1;
                end else
                   counter <= counter + 1;
             end       
    end 
           
endmodule