module sample_timer
       (
           input clk, reset_n,
           output reg sample_trigger
       );

parameter MAX_COUNT = 9'd400;

reg [ 8: 0 ] count;

always @( posedge clk or negedge reset_n ) begin
    if ( ~reset_n ) begin
        count <= 1'b0;
        sample_trigger <= 1'b0;
    end
    else begin
        // Run the counter up to MAX_COUNT for division
        if ( count >= MAX_COUNT ) begin
            count <= 1'b0;
        end
        else begin
            count <= count + 1'b1;
        end

        if ( count == 1'b0 ) begin
            sample_trigger <= 1'b1;
        end
        else begin
            sample_trigger <= 1'b0;
        end
    end
end

endmodule
