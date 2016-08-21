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

// Top Level for Lab 1 Reference Design
module lab1_ref
       (
           //////////////////// Clock Input ////////////////////
           input CLOCK_50,
           input CLOCK_50_2,
           //////////////////// Push Button ////////////////////
           input [ 2: 0 ] BUTTON,
           //////////////////// DPDT Switch ////////////////////
           input [ 9: 0 ] SW,
           //////////////////// 7-SEG Display ////////////////////
           output HEX0_DP,
           output HEX1_DP,
           output HEX2_DP,
           output HEX3_DP,
           //////////////////////// LED ////////////////////////
           output [ 9: 0 ] LEDG
       );

// =======================================================
// REG/WIRE declarations
// =======================================================
// == Derived Clocks
wire slow_clk;

// == Inputs
wire left_sw, right_sw;
wire brake_button;

assign left_sw = SW[ 1 ];
assign right_sw = SW[ 0 ];

assign brake_button = ~BUTTON[ 2 ]; // Button is active low input

// == Outputs
wire turn_error;
wire [ 1: 0 ] center_lights;
wire [ 2: 0 ] left_lights, right_lights;

assign HEX0_DP = ~turn_error; // Active low LED
assign HEX3_DP = ~slow_clk; // Active low LED
assign LEDG[ 9: 7 ] = left_lights;
assign LEDG[ 5: 4 ] = center_lights;
assign LEDG[ 2: 0 ] = right_lights;

// Unused output signals
assign { LEDG[ 6 ], LEDG[ 3 ] } = 2'b0;
assign { HEX1_DP, HEX2_DP } = 2'b11; // Active low

// == Internal Signals
wire [ 2: 0 ] left_signal, right_signal;

// =======================================================
// Structural coding
// =======================================================

clock_div divider( .clk( CLOCK_50 ), .slow_clk( slow_clk ) );
turn_sm turn_machine( .clk( slow_clk ), .left( left_sw ), .right( right_sw ), .error( turn_error ), .left_signal( left_signal ), .right_signal( right_signal ) );
brake_sm brake_machine( .clk( slow_clk ), .brake( brake_button ), .left_signal( left_signal ), .right_signal( right_signal ),
                        .left_lights( left_lights ), .center_lights( center_lights ), .right_lights( right_lights ) );

endmodule
