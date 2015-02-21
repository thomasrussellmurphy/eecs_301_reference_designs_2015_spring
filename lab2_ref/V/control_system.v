module control_system
       (
           input clk,
           input load_speed,
           input signed [ 9: 0 ] speed_count, goal,
           input [ 7: 0 ] gain,
           output [ 9: 0 ] result,
           output [ 9: 0 ] measured_speed
       );

// Control System Outline
// result = saturate_10_bits( (goal - speed) * gain )
reg signed [ 19: 0 ] signed_result; // 20 bit result of 11 bit by 8+1 bit multiplication
reg signed [ 10: 0 ] error; // 11 bit result of 10 bit subtraction
reg signed [ 9: 0 ] speed;

// Result function
// Preserves sign bit, drops two bits created by error subtraction and conversion of gain to two's complement
assign result = {signed_result[19], signed_result[16:8]} + 10'b10_0000_0000;

assign measured_speed = speed;

always @( posedge clk ) begin
    error <= goal - speed;
    signed_result <= $signed( error ) * $signed( { 1'b0, gain } );

    if ( load_speed ) begin
        speed <= speed_count;
    end
    else begin
        speed <= speed;
    end
end

endmodule
