module char_ram
       (
           input we, read_clock, write_clock,
           input [ 6: 0 ] char_in,
           input [ 5: 0 ] read_h_addr, write_h_addr,
           input [ 4: 0 ] read_v_addr, write_v_addr,
           output reg [ 7: 0 ] char_out
       );

// Combine the addresses
// 480/8 => 60 horizontal character cells used
// 272/16 => 17 vertical caracter cells used
wire [ 10: 0 ] read_addr, write_addr;
assign read_addr = { read_v_addr, read_h_addr };
assign write_addr = { write_v_addr, write_h_addr };

// Resultant memory is 6 bits by 5 bits: 2^11
// Character values are 7 bits
reg [ 6: 0 ] ram[ 2047: 0 ];

always @ ( posedge write_clock ) begin
    // Write
    if ( we ) begin
        ram[ write_addr ] <= char_in;
    end
end

always @ ( posedge read_clock ) begin
    // Read
    char_out <= ram[ read_addr ];
end
endmodule
