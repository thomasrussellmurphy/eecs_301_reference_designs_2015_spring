module step_counter
       (
           input clk, reset,
           input enable, count_up,
           output reg signed [ 9: 0 ] count
       );

// Reset if needed, increment or decrement if counting is enabled
always @ ( posedge clk or posedge reset ) begin
    if ( reset ) begin
        count <= 10'b0;
    end
    else if ( enable == 1'b1 ) begin
        count <= count + ( count_up ? 10'd1 : -10'd1 );
    end
    else begin
        count <= count;
    end
end

endmodule
