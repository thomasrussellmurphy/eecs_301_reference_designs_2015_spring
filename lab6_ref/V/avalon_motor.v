module avalon_motor
       (
           input pwm_clk, data_clk,
           input [ 11: 0 ] ast_sink_data,
           input [ 1: 0 ] ast_sink_error,
           input ast_sink_valid,
           output reg outh, outl,
           output reg update
       );
//

reg [ 11: 0 ] last_valid_data;

reg [ 11: 0 ] data_sync0, data_sync1, data_sync2;
reg signed [ 9: 0 ] pwm_counter;

reg signed [ 9: 0 ] pwm_target, next_pwm_target;

// Accept AST input in data_clk domain
always @( posedge data_clk ) begin
    if ( ast_sink_valid ) begin
        last_valid_data <= ast_sink_data;
    end
    else begin
        last_valid_data <= last_valid_data;
    end
end

// Clock domain transfer
// Requires f_{data_clk} < f_{pwm_clk} since ast_sink_valid is 1-cycle data_clk pulses
// Assumes that ast_sink_valid has infrequent edges since it's pulses
always @( posedge pwm_clk ) begin
    data_sync2 <= data_sync1;
    data_sync1 <= data_sync0;
    data_sync0 <= last_valid_data;

    // Resultant signal for transfer, truncated down to 10 bits
    next_pwm_target <= data_sync2[ 11: 2 ];
end

// PWM generation
always @( posedge pwm_clk ) begin
    pwm_counter <= pwm_counter + 1'b1;

    // Transfer to pwm_target at PWM cycle's desired value
    if ( pwm_counter == 0 ) begin
        pwm_target <= next_pwm_target;
        update <= 1'b1; // Indicate that the PWM updated
    end
    else begin
        pwm_target <= pwm_target;
        update <= 1'b0;
    end

    // PWM comparator
    if ( pwm_counter < pwm_target ) begin
        outh <= 1'b0;
        outl <= 1'b1;
    end
    else begin
        outh <= 1'b1;
        outl <= 1'b0;
    end
end

endmodule
