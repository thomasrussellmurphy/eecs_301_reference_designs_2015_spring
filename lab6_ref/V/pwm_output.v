module pwm_output
       (
           input wire clk,
           input wire [ 9: 0 ] set,
           output reg outh,
           output reg outl
       );
// Unsigned PWM comparison
// At 50MHz input, division by 2^10 give 48828.125Hz PWM
reg [ 9: 0 ] count, goal;

always @( posedge clk ) begin
    // Always increment counter
    count <= count + 1'b1;

    // Update the comparison goal on counter zero-crossing
    if ( count == 10'b0 ) begin
        goal <= set;
    end
    else begin
        goal <= goal;
    end

    // Create anti-phase PWM outputs
    if ( count <= goal ) begin
        outh <= 1'b1;
        outl <= 1'b0;
    end
    else begin
        outh <= 1'b0;
        outl <= 1'b1;
    end
end

endmodule
