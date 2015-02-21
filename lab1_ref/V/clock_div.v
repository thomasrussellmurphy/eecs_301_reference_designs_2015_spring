module clock_div(
           input clk,
           output slow_clk
       );

reg [ 23: 0 ] counter;

assign slow_clk = counter[ 23 ]; // slowed by factor of 2^24

always @( posedge clk ) begin
    counter <= counter + 1'b1;
end

endmodule
