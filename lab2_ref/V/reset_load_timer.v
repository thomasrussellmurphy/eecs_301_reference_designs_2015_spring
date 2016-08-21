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

module reset_load_timer
       (
           input clk,
           output reg reset_out, load_out
       );
parameter MAX_COUNT = 22'd2_000_000;
reg [ 21: 0 ] count;

always @( posedge clk ) begin
    // Run the counter up to MAX_COUNT for division
    if ( count >= MAX_COUNT ) begin
        count <= 1'b0;
    end
    else begin
        count <= count + 1'b1;
    end

    // At count 0, send load signal
    if ( count == 1'b0 ) begin
        load_out <= 1'b1;
    end
    else begin
        load_out <= 1'b0;
    end

    // At count 1, send reset signal
    if ( count == 1'b1 ) begin
        reset_out <= 1'b1;
    end
    else begin
        reset_out <= 1'b0;
    end
end

endmodule
