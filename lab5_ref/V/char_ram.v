//
// Copyright (c) 2015 Thomas R. Murphy and Case Western Reserve University
// All Rights Reserved
//
// Developed by Thomas Russell Murphy (trm70) during employment as teaching
// assistant of EECS 301 at CWRU.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS ``AS IS''
// AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
// IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
// DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR
// ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
// (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
// LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
// ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
// (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
// SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//

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
