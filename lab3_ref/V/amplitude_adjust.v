module amplitude_adjust
       (
           input clk,
           input [ 9: 0 ] amplitude,
           input signed [ 11: 0 ] ast_sink_data,
           input ast_sink_valid,
           input [ 1: 0 ] ast_sink_error,
           output signed [ 11: 0 ] ast_source_data,
           output reg ast_source_valid,
           output reg [ 1: 0 ] ast_source_error
       );
//

reg signed [ 21: 0 ] signed_result;
// Keep sign bit
// Drop bit created by conversion of unsigned amplitude
assign ast_source_data = {signed_result[ 21 ], signed_result[ 19: 9 ]};

always @ ( posedge clk ) begin
    signed_result <= $signed( ast_sink_data ) * $signed( { 1'b0, amplitude } );
    ast_source_valid <= ast_sink_valid;
    ast_source_error <= ast_sink_error;
end
endmodule
