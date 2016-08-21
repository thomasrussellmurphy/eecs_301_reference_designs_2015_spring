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
assign ast_source_data = { signed_result[ 21 ], signed_result[ 19: 9 ] };

always @ ( posedge clk ) begin
    signed_result <= $signed( ast_sink_data ) * $signed( { 1'b0, amplitude } );
    ast_source_valid <= ast_sink_valid;
    ast_source_error <= ast_sink_error;
end
endmodule
