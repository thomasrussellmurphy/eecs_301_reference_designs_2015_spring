module char_array_display
       (
           input wire clk,
           input wire reset,
           input wire enc_A, enc_B, write_char, dim_sel,
           input wire [ 6: 0 ] next_char,
           input wire valid_coord,
           input wire [ 9: 0 ] pixel_x, pixel_y,
           output reg [ 7: 0 ] red_out, green_out, blue_out
       );
// *** Parameter declarations
// ***
parameter MAX_X = 7'd60; // actually horizontal tiles
parameter MAX_Y = 7'd17; // actually vertical tiles

// Display color definitions
parameter FONT_RED = 8'hf4;
parameter FONT_GREEN = 8'h11;
parameter FONT_BLUE = 8'h00;

// *** Internal register and wire declarations
// ***
wire font_bit;
wire [ 5: 0 ] read_cell_x_addr, write_cell_x_addr;
wire [ 4: 0 ] read_cell_y_addr, write_cell_y_addr;
wire [ 2: 0 ] font_word_column_addr;
wire [ 6: 0 ] font_char_addr;
wire [ 3: 0 ] font_char_row_addr;
wire [ 10: 0 ] font_rom_addr;
wire [ 7: 0 ] font_rom_word;

// Output color selection
wire cursor_on;
wire [ 7: 0 ] font_red_out, font_green_out, font_blue_out;
wire [ 7: 0 ] font_rev_red_out, font_rev_green_out, font_rev_blue_out; 


// *** Structural design (assign and module)
// ***
// Manipulate read port of the RAM
assign read_cell_x_addr = pixel_x[8:3]; // 6 bits above 3 LSB are cell x address
assign read_cell_y_addr = pixel_y[8:4]; // 5 bits above 4 LSB are cell y address


// Everything to read from the ROM and get a 1-bit pixel value out
assign font_word_column_addr = pixel_x[ 2: 0 ]; // LSB of x position are char column
assign font_char_row_addr = pixel_y[ 3: 0 ]; // LSB of y position are char row
assign font_rom_addr = { font_char_addr, font_char_row_addr };
assign font_bit = font_rom_word[ font_word_column_addr ];

// green over black and reversed video for cursor
assign font_red_out = ( font_bit ) ? FONT_RED : 8'h00;
assign font_green_out = ( font_bit ) ? FONT_GREEN : 8'h00;
assign font_blue_out = ( font_bit ) ? FONT_BLUE : 8'h00;

assign font_rev_red_out = ( font_bit ) ? 8'h00 : FONT_RED;
assign font_rev_green_out = ( font_bit ) ? 8'h00 : FONT_GREEN;
assign font_rev_blue_out = ( font_bit ) ? 8'h00 : FONT_BLUE;

font_rom ROM (
             .clk( clk ),
             .addr( font_rom_addr ),
             .data( font_rom_word )
         );
//

char_ram RAM (
             .we(write_char),
             .read_clock( clk ),
             .write_clock( clk ),
             .char_in( next_char ),
             .read_h_addr(read_cell_x_addr),
             .write_h_addr(),
             .read_v_addr(read_cell_y_addr),
             .write_v_addr(),
             .char_out( font_char_addr )
         );
//

// *** Behavioral design

// RGB multiplexing circuit
always @ ( * ) begin
    if ( ~valid_coord || reset ) begin
        red_out <= 8'h00; // Blank
        green_out <= 8'h00; // Blank
        blue_out <= 8'h00; // Blank
    end
    else begin
        if ( cursor_on ) begin
            // Use reversed colors
            red_out <= font_rev_red_out;
            green_out <= font_rev_green_out;
            blue_out <= font_rev_blue_out;
        end
        else begin
            // Use straight colors
            red_out <= font_red_out;
            green_out <= font_green_out;
            blue_out <= font_blue_out;
        end
    end
end

endmodule
