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

// Dumb SPI Driver for 16 bits transmitted in each direction
// 4 wire interface to peripheral: sclk, cs, sdi, sdo
// Data moves:
//   sdi => pdo
//   pdi => sdo

module spi_16i_16o( sclk, pdi, pdo, send, data_valid, cs, sdi, sdo );
input wire sclk;
input wire [ 15: 0 ] pdi;
input wire send;
input wire sdi;

output reg cs;
output wire sdo;
output reg [ 15: 0 ] pdo;
output reg data_valid;

reg last_send; // for edge detection of send
reg [ 4: 0 ] sent_bit; // count of last bit sent_bit
reg [ 15: 0 ] shift_out; // register for shifting out

assign sdo = shift_out[ 15 ];

initial begin
    last_send <= 1'b0;
    sent_bit <= 5'b0;
    cs <= 1'b1;
    shift_out <= 16'b0;
    data_valid <= 1'b0;
end

always @( posedge sclk ) begin
    last_send <= send;

    // start serial transmission on rising edge of send
    if ( ~last_send & send ) begin
        cs <= 1'b0;
        shift_out <= pdi;
        sent_bit <= 5'd15; // starting with msb
        data_valid <= 1'b0; // set data not-valid
        pdo <= 1'b0; // zero internal storage register
    end

    // continuing transmission
    if ( cs == 1'b0 ) begin
        pdo <= { pdo[ 14: 0 ], sdi }; // shifting data into storage
        shift_out <= { shift_out[ 14: 0 ], 1'b0 }; // shifting data out
        sent_bit <= sent_bit - 1'b1;
    end

    // ending transmission
    if ( sent_bit == 1'b0 ) begin
        cs <= 1'b1;
        data_valid <= 1'b1;
    end

end

endmodule
