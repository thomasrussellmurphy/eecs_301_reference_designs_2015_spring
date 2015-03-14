module input_position_controller
       (
           input clk,
           input enc_A, enc_B, dim_sel, to_zero,
           output reg [ 5: 0 ] cell_x_addr,
           output reg [ 4: 0 ] cell_y_addr
       );
// Max cell counts, minus 1 to deal with indexing
parameter MAX_X = 6'd60 - 1'b1; // actually horizontal tiles
parameter MAX_Y = 5'd17 - 1'b1; // actually vertical tiles

reg last_enc_A;
wire count_en;
wire count_dir;

assign count_en = enc_A && ~last_enc_A;
assign count_dir = enc_B;

always @( posedge clk ) begin
    last_enc_A <= enc_A;

    if ( to_zero ) begin
        cell_x_addr <= 1'b0;
        cell_y_addr <= 1'b0;
    end
    else if ( dim_sel ) begin
        cell_x_addr <= cell_x_addr;

        if ( count_en && count_dir && ( cell_y_addr < MAX_Y ) ) begin
            cell_y_addr <= cell_y_addr + 1'b1;
        end
        else if ( count_en && ~count_dir && ( cell_y_addr > 1'b0 ) ) begin
            cell_y_addr <= cell_y_addr - 1'b1;
        end
        else begin
            cell_y_addr <= cell_y_addr;
        end
    end
    else begin
        cell_y_addr <= cell_y_addr;

        if ( count_en && count_dir && ( cell_x_addr < MAX_X ) ) begin
            cell_x_addr <= cell_x_addr + 1'b1;
        end
        else if ( count_en && ~count_dir && ( cell_x_addr > 1'b0 ) ) begin
            cell_x_addr <= cell_x_addr - 1'b1;
        end
        else begin
            cell_x_addr <= cell_x_addr;
        end

    end
end

endmodule
