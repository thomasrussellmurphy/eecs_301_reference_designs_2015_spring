module peak_to_color_lut
       (
           input display_clk,
           input [ 11: 0 ] in_value,
           output reg [ 7: 0 ] disp_red, disp_green, disp_blue
       );

always @( posedge display_clk ) begin
    // Make things grayscale
    disp_red <= in_value[ 10: 3 ];
    disp_green <= in_value[ 10: 3 ];
    disp_blue <= in_value[ 10: 3 ];
end

endmodule
