module peak_to_color_lut
       (
           input display_clk,
           input en,
           input [ 11: 0 ] in_value,
           output reg [ 7: 0 ] disp_red, disp_green, disp_blue
       );
//

wire [ 11: 0 ] rebiased_value;

assign rebiased_value = in_value - 12'b0111_1110_0000;

always @( posedge display_clk ) begin
    // Make things something
    if ( en ) begin
        disp_red <= rebiased_value[ 11: 4 ];
        disp_green <= { 2'b00, rebiased_value[ 9: 4 ] };
        disp_blue <= rebiased_value[ 11: 4 ];
    end
    else begin
        disp_red <= 1'b0;
        disp_green <= 1'b0;
        disp_blue <= 1'b0;
    end
end

endmodule
