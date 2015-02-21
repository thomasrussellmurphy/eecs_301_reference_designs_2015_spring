module settings_controller
       (
           input clk, reset_n,
           input count_en, count_up, select,
           output reg [ 19: 0 ] phi_inc,
           output reg [ 9: 0 ] amplitude
       );
//

parameter INCREMENT_MINIMUM = 20'd210;
parameter INCREMENT_MAXIMUM = 20'd20975;

parameter INITIAL_PHI_INC = 20'd10_000;
parameter INITIAL_AMPLITUDE = 10'h3FF;

always @( posedge clk or negedge reset_n ) begin
    if ( ~reset_n ) begin
        phi_inc <= INITIAL_PHI_INC;
        amplitude <= INITIAL_AMPLITUDE;
    end
    else begin
        if ( select ) begin
            // Change amplitude

            if ( count_en & count_up & amplitude < 10'h3_FF ) begin
                amplitude <= amplitude + 1'b1;
            end
            else if ( count_en & ~count_up & amplitude > 0 ) begin
                amplitude <= amplitude - 1'b1;
            end
            else begin
                amplitude <= amplitude;
            end

            phi_inc <= phi_inc;
        end
        else begin
            // Change phi_inc

            if ( count_en & count_up & phi_inc < INCREMENT_MAXIMUM ) begin
                phi_inc <= phi_inc + 1'b1;
            end
            else if ( count_en & ~count_up & phi_inc > INCREMENT_MINIMUM ) begin
                phi_inc <= phi_inc - 1'b1;
            end
            else begin
                phi_inc <= phi_inc;
            end

            amplitude <= amplitude;
        end
    end
end

endmodule
