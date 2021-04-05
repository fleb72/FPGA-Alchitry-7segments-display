module seven_seg_multiplexing(
    input rst,
    input clk,
    input [13:0] displayed_number,
    output reg [3:0] digit,
    output reg [7:0] segments
    );
    
    reg [18:0] counter; 
    wire [1:0] digit_activating_counter;
    wire third_digit;
    reg [3:0] figure;
    reg [7:0] activating_dp;
      
    initial begin 
        counter <= 0;
    end 
    
    always @(posedge clk or posedge rst) begin 
        if (rst == 1)
            counter <= 0;
        else
            counter <= counter + 1;
    end
   
    assign digit_activating_counter = counter[18:17];
    
    always @(digit_activating_counter) begin
        case (digit_activating_counter)
          2'b00: begin
                   digit = ~4'b1000; // activer le 1er digit seulement
                   figure = displayed_number / 1000; // chiffre des milliers
                 end
          2'b01: begin
                   digit = ~4'b0100; // activer le 2e digit seulement
                   figure = (displayed_number % 1000) / 100; // chiffre des centaines
                 end
          2'b10: begin
                   digit = ~4'b0010; // activer le 3e digit seulement
                   figure = ((displayed_number % 1000) % 100) / 10; // chiffre des dizaines
                 end
          2'b11: begin
                   digit = ~4'b0001; // activer le 4e digit seulement
                   figure = ((displayed_number % 1000) % 100) % 10; // chiffre des unités
                 end   
          default: begin
                     digit = ~4'b1000; // activer le 1er digit seulement
                   end
        endcase
    end
    
    assign third_digit = digit_activating_counter == 2'b10;
    
    always @(*) begin
        activating_dp = third_digit ? ~8'b10000000 : ~8'h00 ; // activation du point si 3e digit
        case (figure)           
                                   //pgfedcba			
            4'b0000: segments <= ~8'b00111111 & activating_dp; // "0"
            4'b0001: segments <= ~8'b00000110 & activating_dp; // "1" 
            4'b0010: segments <= ~8'b01011011 & activating_dp; // "2" 
            4'b0011: segments <= ~8'b01001111 & activating_dp; // "3" 
            4'b0100: segments <= ~8'b01100110 & activating_dp; // "4" 
            4'b0101: segments <= ~8'b01101101 & activating_dp; // "5" 
            4'b0110: segments <= ~8'b01111101 & activating_dp; // "6" 
            4'b0111: segments <= ~8'b00000111 & activating_dp; // "7" 
            4'b1000: segments <= ~8'b01111111 & activating_dp; // "8"     
            4'b1001: segments <= ~8'b01101111 & activating_dp; // "9" 
            default: segments <= ~8'b00111111 & activating_dp; // "0"
        endcase            
    end
    
endmodule