module demo_video
       (
           input clk, en,
           input [ 9: 0 ] x_pos, y_pos,
           input valid_region, v_blank,
           output reg [ 7: 0 ] value_red, value_green, value_blue
       );

reg [ 7: 0 ] counter;
reg last_v_blank;

always @( posedge clk ) begin
    last_v_blank <= v_blank;

    if ( v_blank & ~last_v_blank ) begin
        counter <= counter + 1'b1;
    end
    else begin
        counter <= counter;
    end

    if ( valid_region && en ) begin
        value_red <= x_pos[ 7: 0 ];
        value_green <= y_pos[ 8: 1 ];
        value_blue <= counter;
    end
    else begin
        value_red <= 1'b0;
        value_green <= 1'b0;
        value_blue <= 1'b0;
    end

end

endmodule
