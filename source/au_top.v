module au_top(
    input clk,              // horloge 100 MHz
    input rst_n,            // bouton Reset, actif à l'état bas
    output [7:0] led,       // jeu de LED x 8
    input  usb_rx,          // liaison série USB : Rx          
    output usb_tx,          // liaison série USB : Tx
                            // ---- Io shield E/S ----------------------
    output [23:0] io_led,   // jeu de 8 LED x 3
    output [7:0] io_seg,    // 7-segments : cathodes x (7 segments + dp)
    output [3:0] io_sel,    // 7-segments : anode x 4
    input  [4:0] io_button, // boutons-poussoirs x 5
    input  [23:0] io_dip    // interrupteurs dip switches x 24
  );
    
    wire rst;
    
    // Conditionnement du signal Reset, synchronisation avec l'horloge
    reset_conditioner rst_cond(
         .clk(clk),
         .in(!rst_n),
         .out(rst)
         );
    
    assign led = 8'h00;             // LED x 8 éteintes
    assign io_led = 24'h000000;     // LED x 24 du shield Io éteintes

    assign usb_tx = usb_rx;         // retransmission Rx vers Tx
        
        
    wire [13:0] displayed_number;   // nombre à afficher                         
                                            
    seven_seg_multiplexing seven_seg_multiplexing_inst( 
        .clk(clk),
        .rst(rst),
        .displayed_number(displayed_number),
        .digit(io_sel),
        .segments(io_seg)
        );
        
    tenth_second_counter tenth_second_counter_inst(   
        .rst(rst),
        .clk(clk),
        .enable(~io_button[1]),  // appui sur le bouton pour arrêter le chrono
        .out(displayed_number)
        );
                                 
endmodule