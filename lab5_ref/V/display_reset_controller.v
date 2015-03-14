module display_reset_controller
(
    input clk,
    input reset_in, v_blank,
    output reg reset_out
);
//

reg last_v_blank;

always @(posedge clk) begin
    last_v_blank <= v_blank;
end

endmodule
