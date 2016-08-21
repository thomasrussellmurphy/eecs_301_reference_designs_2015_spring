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

module demo_video
       (
           input clk, en,
           input [ 9: 0 ] x_pos, y_pos,
           input valid_region, v_blank,
           output reg [ 7: 0 ] value_red, value_green, value_blue
       );

reg [ 7: 0 ] counter;
reg last_v_blank;

always @( posedge clk ) begin
    last_v_blank <= v_blank;

    if ( v_blank & ~last_v_blank ) begin
        counter <= counter + 1'b1;
    end
    else begin
        counter <= counter;
    end

    if ( valid_region && en ) begin
        value_red <= x_pos[ 7: 0 ];
        value_green <= y_pos[ 8: 1 ];
        value_blue <= counter;
    end
    else begin
        value_red <= 1'b0;
        value_green <= 1'b0;
        value_blue <= 1'b0;
    end

end

endmodule
