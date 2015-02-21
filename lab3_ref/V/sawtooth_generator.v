module sawtooth_generator
       (
           input clk, reset_n,
           input clken,
           input [ 19: 0 ] increment,
           output signed [ 11: 0 ] wave,
           output reg out_valid
       );
//

reg signed [ 19: 0 ] accumulator;
assign wave = accumulator[ 19: 8 ];

always @( posedge clk or negedge reset_n ) begin
    if ( ~reset_n ) begin
        accumulator <= 1'b0;
        out_valid <= 1'b0;
    end
    else if ( clken ) begin
        accumulator <= accumulator + increment;
        out_valid <= 1'b1;
    end
    else begin
        accumulator <= accumulator;
        out_valid <= 1'b0;
    end
end

endmodule
