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

module pwm_output
       (
           input wire clk,
           input wire [ 9: 0 ] set,
           output reg outh,
           output reg outl
       );
// Unsigned PWM comparison
// At 50MHz input, division by 2^10 give 48828.125Hz PWM
reg [ 9: 0 ] count, goal;

always @( posedge clk ) begin
    // Always increment counter
    count <= count + 1'b1;

    // Update the comparison goal on counter zero-crossing
    if ( count == 10'b0 ) begin
        goal <= set;
    end
    else begin
        goal <= goal;
    end

    // Create anti-phase PWM outputs
    if ( count <= goal ) begin
        outh <= 1'b1;
        outl <= 1'b0;
    end
    else begin
        outh <= 1'b0;
        outl <= 1'b1;
    end
end

endmodule
