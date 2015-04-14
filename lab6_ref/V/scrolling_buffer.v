module scrolling_buffer
       (
           input data_clk, display_clk,
           input [ 11: 0 ] sink_data,
           input sink_valid,
           input [ 9: 0 ] read_pos,
           output reg [ 11: 0 ] source_data
       );
//

reg [ 9: 0 ] top_pixel; // virtual zero-index for scrolling
reg [ 11: 0 ] ram [ 1023: 0 ]; // 12-bit data, 10-bit address RAM

// This will synthesize a two-clock RAM with undefined read-on-write behavior

// Write-side behavior
always @( posedge data_clk ) begin
    // When a new sample arrives for the buffer, make in the new 'top' of the buffer
    if ( sink_valid ) begin
        ram[ top_pixel - 1'b1 ] <= sink_data;
        top_pixel <= top_pixel - 1'b1;
    end
    else begin
        top_pixel <= top_pixel;
    end
end

// Read-side behavior
always @( posedge display_clk ) begin
    // Read out the desired position in the buffer
    source_data <= ram[ top_pixel + read_pos ];
end

endmodule
