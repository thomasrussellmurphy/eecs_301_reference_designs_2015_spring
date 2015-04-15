module dual_scrolling_display
       (
           input data_clk, display_clk,
           input [ 9: 0 ] h_pos, v_pos,
           input valid_draw,
           input [ 11: 0 ] sink_data_a, sink_data_b,
           input sink_valid_a, sink_valid_b,
           output reg [ 7: 0 ] disp_red, disp_green, disp_blue
       );
//

wire [ 11: 0 ] buffer_a_data, buffer_b_data;
reg [ 11: 0 ] lut_input;
wire [ 7: 0 ] lut_red, lut_green, lut_blue;

// Positions of row boundaries in 272 pixel tall screen
parameter ROW_1 = 10'd70;
parameter ROW_2 = 10'd106;
parameter ROW_3 = 10'd166;
parameter ROW_4 = 10'd202;

wire in_row_1 = v_pos < ROW_1;
wire in_row_2 = ROW_1 <= v_pos && v_pos < ROW_2;
wire in_row_3 = ROW_2 <= v_pos && v_pos < ROW_3;
wire in_row_4 = ROW_3 <= v_pos && v_pos < ROW_4;
wire in_row_5 = ROW_4 <= v_pos;

// Mux between the five rows
always @( in_row_1, in_row_2, in_row_3, in_row_4, in_row_5, buffer_a_data, buffer_b_data ) begin
    case ( { in_row_1, in_row_2, in_row_3, in_row_4, in_row_5 } )  // synthesis full_case
        5'b10000: begin
            lut_input <= 1'b0;
        end
        5'b01000: begin
            lut_input <= buffer_a_data;
        end
        5'b00100: begin
            lut_input <= 1'b0;
        end
        5'b00010: begin
            lut_input <= buffer_b_data;
        end
        5'b00001: begin
            lut_input <= 1'b0;
        end
    endcase
end

// Connect the outputs
always @( posedge display_clk ) begin
    if ( valid_draw ) begin
        { disp_red, disp_green, disp_blue } <= { lut_red, lut_green, lut_blue };
    end
    else begin
        // Blanking in invalid region
        { disp_red, disp_green, disp_blue } <= 24'h000000;
    end
end

scrolling_buffer buffer_a
                 (
                     .data_clk( data_clk ),
                     .display_clk( display_clk ),
                     .sink_data( sink_data_a ),
                     .sink_valid( sink_valid_a ),
                     .read_pos( h_pos ),
                     .source_data( buffer_a_data )
                 );
//

scrolling_buffer buffer_b
                 (
                     .data_clk( data_clk ),
                     .display_clk( display_clk ),
                     .sink_data( sink_data_b ),
                     .sink_valid( sink_valid_b ),
                     .read_pos( h_pos ),
                     .source_data( buffer_b_data )
                 );
//

peak_to_color_lut lut
                  (
                      .display_clk( display_clk ),
                      .in_value( lut_input ),
                      .disp_red( lut_red ),
                      .disp_green( lut_green ),
                      .disp_blue( lut_blue )
                  );
//

endmodule
