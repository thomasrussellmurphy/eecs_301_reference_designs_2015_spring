module reset_load_timer
       (
           input clk,
           output reg reset_out, load_out
       );
parameter MAX_COUNT = 22'd2_000_000;
reg [ 21: 0 ] count;

always @( posedge clk ) begin
    // Run the counter up to MAX_COUNT for division
    if ( count >= MAX_COUNT ) begin
        count <= 1'b0;
    end
    else begin
        count <= count + 1'b1;
    end

    // At count 0, send load signal
    if ( count == 1'b0 ) begin
        load_out <= 1'b1;
    end
    else begin
        load_out <= 1'b0;
    end

    // At count 1, send reset signal
    if ( count == 1'b1 ) begin
        reset_out <= 1'b1;
    end
    else begin
        reset_out <= 1'b0;
    end
end

endmodule
