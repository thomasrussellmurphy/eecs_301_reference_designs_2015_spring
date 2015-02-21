module filter_coordinator(
           input clk,
           input sel1, sel2, sel3,
           output reg [ 1: 0 ] bank_select
       );

always @( posedge clk )
    if ( sel1 ) begin
        bank_select <= 2'h1;
    end
    else if ( sel2 ) begin
        bank_select <= 2'h2;
    end
    else if ( sel3 ) begin
        bank_select <= 2'h3;
    end
    else begin
        bank_select <= 2'h0;
    end

endmodule
