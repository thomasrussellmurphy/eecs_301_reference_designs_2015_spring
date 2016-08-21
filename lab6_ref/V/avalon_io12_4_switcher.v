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

module avalon_io12_4_switcher( clk, select,
                               sink_data_0, sink_valid_0, sink_error_0,
                               sink_data_1, sink_valid_1, sink_error_1,
                               sink_data_2, sink_valid_2, sink_error_2,
                               sink_data_3, sink_valid_3, sink_error_3,
                               source_data, source_valid, source_error );

input wire clk;
input wire [ 1: 0 ] select;

input wire [ 11: 0 ] sink_data_0, sink_data_1, sink_data_2, sink_data_3;
input wire sink_valid_0, sink_valid_1, sink_valid_2, sink_valid_3;
input wire [ 1: 0 ] sink_error_0, sink_error_1, sink_error_2, sink_error_3;

output reg [ 11: 0 ] source_data;
output reg source_valid;
output reg [ 1: 0 ] source_error;

// Mux between the four input Avalon data sinks
always @( posedge clk ) begin
    case ( select )
        2'b00 : begin
            source_data <= sink_data_0;
            source_valid <= sink_valid_0;
            source_error <= sink_error_0;
        end
        2'b01 : begin
            source_data <= sink_data_1;
            source_valid <= sink_valid_1;
            source_error <= sink_error_1;
        end
        2'b10 : begin
            source_data <= sink_data_2;
            source_valid <= sink_valid_2;
            source_error <= sink_error_2;
        end
        2'b11 : begin
            source_data <= sink_data_3;
            source_valid <= sink_valid_3;
            source_error <= sink_error_3;
        end
        default: begin
            source_data <= sink_data_0;
            source_valid <= sink_valid_0;
            source_error <= sink_error_0;
        end
    endcase
end

endmodule
