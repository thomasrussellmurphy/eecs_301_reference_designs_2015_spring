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

module scrolling_buffer
       (
           input data_clk, display_clk,
           input [ 11: 0 ] sink_data,
           input sink_valid,
           input [ 9: 0 ] read_pos,
           output reg [ 11: 0 ] source_data
       );
//

reg [ 9: 0 ] top_pixel; // virtual zero-index for scrolling
reg [ 11: 0 ] ram [ 1023: 0 ]; // 12-bit data, 10-bit address RAM

// This will synthesize a two-clock RAM with undefined read-on-write behavior

// Write-side behavior
always @( posedge data_clk ) begin
    // When a new sample arrives for the buffer, make in the new 'top' of the buffer
    if ( sink_valid ) begin
        ram[ top_pixel - 1'b1 ] <= sink_data;
        top_pixel <= top_pixel - 1'b1;
    end
    else begin
        top_pixel <= top_pixel;
    end
end

// Read-side behavior
always @( posedge display_clk ) begin
    // Read out the desired position in the buffer
    source_data <= ram[ top_pixel + read_pos ];
end

endmodule
