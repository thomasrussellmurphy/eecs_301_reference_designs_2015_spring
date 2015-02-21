module quadrature_decode
       (
           input wire clk,
           input wire A,
           input wire B,
           output reg count,
           output reg up
       );

reg sA, sB; // Synchronized versions of A and B
reg last_sA;

always @( posedge clk ) begin
    sA <= A;
    sB <= B;
    last_sA <= sA;

    // Rising edge of A detect
    if ( sA & ~last_sA ) begin
        count <= 1'b1; // send count out
        up <= sB; // sB high is positive rotation, count up
    end
    else begin
        count <= 1'b0;
        up <= 1'b0;
    end
end

endmodule
