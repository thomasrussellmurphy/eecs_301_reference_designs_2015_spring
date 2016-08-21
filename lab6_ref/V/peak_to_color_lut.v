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

module peak_to_color_lut
       (
           input display_clk,
           input en,
           input [ 11: 0 ] in_value,
           output reg [ 7: 0 ] disp_red, disp_green, disp_blue
       );
//

wire [ 11: 0 ] rebiased_value;

assign rebiased_value = in_value - 12'b0111_1110_0000;

always @( posedge display_clk ) begin
    // Make things something
    if ( en ) begin
        disp_red <= rebiased_value[ 11: 4 ];
        disp_green <= { 2'b00, rebiased_value[ 9: 4 ] };
        disp_blue <= rebiased_value[ 11: 4 ];
    end
    else begin
        disp_red <= 1'b0;
        disp_green <= 1'b0;
        disp_blue <= 1'b0;
    end
end

endmodule
