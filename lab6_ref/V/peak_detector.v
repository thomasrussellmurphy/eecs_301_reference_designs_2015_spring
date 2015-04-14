module peak_detector
       (
           input data_clk, display_clk,
           input [ 11: 0 ] ast_sink_data,
           input ast_sink_valid,
           input [ 1: 0 ] ast_sink_error,
           input v_blank,
           output reg [ 11: 0 ] source_data,
           output reg source_valid
       );
//

reg signed [ 11: 0 ] last_max_data;
reg reset_max;

reg blank_sync0, blank_sync1, blank_sync2;
reg last_v_blank;

// Clock domain transfer
// Suggested that f_{display_clk} < f_{data_clk} since v_blank is a slow control signal
always @( posedge display_clk ) begin
    last_v_blank <= v_blank;
end
always @( posedge data_clk ) begin
    blank_sync2 <= blank_sync1;
    blank_sync1 <= blank_sync0;
    blank_sync0 <= last_v_blank;

    // Create the local control signal
    // One cycle to reset and cause output to downstream module
    reset_max <= blank_sync2 & ~ blank_sync1;
end


// Update condition
wire update_max_value = ast_sink_valid && ( ast_sink_data > last_max_data );

// Usual operation: detect peak and wait for reset to trigger output
always @( posedge data_clk ) begin
    if ( ~reset_max ) begin
        if ( update_max_value ) begin
            last_max_data <= ast_sink_data;
        end
        else begin
            last_max_data <= last_max_data;
        end

        source_data <= source_data;
        source_valid <= 1'b0;
    end
    else begin
        // Reset and output condition
        source_data <= last_max_data;
        source_valid <= 1'b1;
        last_max_data <= 1'b0; // Assume DC-balanced signal, so don't care about negatives
    end
end

endmodule
