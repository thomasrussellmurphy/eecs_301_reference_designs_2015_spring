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

module control_system
       (
           input clk,
           input load_speed,
           input signed [ 9: 0 ] speed_count, goal,
           input [ 7: 0 ] gain,
           output [ 9: 0 ] result,
           output [ 9: 0 ] measured_speed
       );

// Control System Outline
// result = saturate_10_bits( (goal - speed) * gain )
reg signed [ 19: 0 ] signed_result; // 20 bit result of 11 bit by 8+1 bit multiplication
reg signed [ 10: 0 ] error; // 11 bit result of 10 bit subtraction
reg signed [ 9: 0 ] speed;

// Result function
// Preserves sign bit, drops two bits created by error subtraction and conversion of gain to two's complement
assign result = { signed_result[ 19 ], signed_result[ 16: 8 ] } + 10'b10_0000_0000;

assign measured_speed = speed;

always @( posedge clk ) begin
    error <= goal - speed;
    signed_result <= $signed( error ) * $signed( { 1'b0, gain } );

    if ( load_speed ) begin
        speed <= speed_count;
    end
    else begin
        speed <= speed;
    end
end

endmodule
