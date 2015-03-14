module display_reset_controller
       (
           input clk,
           input reset_in, v_blank,
           output reg reset_out
       );
//

parameter MAX_FRAME_COUNT = 13;

reg last_v_blank;
reg [ 4: 0 ] frame_counter;

initial begin
    frame_counter <= 1'b0;
end

always @( posedge clk ) begin
    last_v_blank <= v_blank;

    if ( reset_in ) begin
        reset_out <= 1'b1;
        frame_counter <= 1'b0;
    end
    else if ( frame_counter < MAX_FRAME_COUNT ) begin
        reset_out <= 1'b1; // active high reset
        if ( v_blank && ~last_v_blank ) begin
            frame_counter <= frame_counter + 1'b1;
        end
        else begin
            frame_counter <= frame_counter;
        end
    end
    else begin
        reset_out <= 1'b0;
        frame_counter <= frame_counter;
    end
end

endmodule
