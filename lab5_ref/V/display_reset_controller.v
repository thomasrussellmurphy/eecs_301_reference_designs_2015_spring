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

module display_reset_controller
       (
           input clk,
           input reset_in, v_blank,
           output reg reset_out
       );
//

parameter MAX_FRAME_COUNT = 13;

reg last_v_blank;
reg [ 4: 0 ] frame_counter;

initial begin
    frame_counter <= 1'b0;
end

always @( posedge clk ) begin
    last_v_blank <= v_blank;

    if ( reset_in ) begin
        reset_out <= 1'b1;
        frame_counter <= 1'b0;
    end
    else if ( frame_counter < MAX_FRAME_COUNT ) begin
        reset_out <= 1'b1; // active high reset
        if ( v_blank && ~last_v_blank ) begin
            frame_counter <= frame_counter + 1'b1;
        end
        else begin
            frame_counter <= frame_counter;
        end
    end
    else begin
        reset_out <= 1'b0;
        frame_counter <= frame_counter;
    end
end

endmodule
