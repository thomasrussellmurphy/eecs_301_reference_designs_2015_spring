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

// Top Level for Lab 3 Reference Design
module lab3_ref
       (
           //////////////////////// Clock Input ////////////////////////
           input CLOCK_50,
           input CLOCK_50_2,
           //////////////////////// Push Button ////////////////////////
           input [ 2: 0 ] BUTTON,
           //////////////////////// DPDT Switch ////////////////////////
           input [ 9: 0 ] SW,
           //////////////////////// 7-SEG Display ////////////////////////
           output [ 6: 0 ] HEX0_D,
           output HEX0_DP,
           output [ 6: 0 ] HEX1_D,
           output HEX1_DP,
           output [ 6: 0 ] HEX2_D,
           output HEX2_DP,
           output [ 6: 0 ] HEX3_D,
           output HEX3_DP,
           //////////////////////// LED ////////////////////////
           output [ 9: 0 ] LEDG,
           //////////////////////// GPIO ////////////////////////
           input [ 1: 0 ] GPIO0_CLKIN,
           output [ 1: 0 ] GPIO0_CLKOUT,
           inout [ 31: 0 ] GPIO0_D
       );

// =======================================================
// REG/WIRE declarations
// =======================================================
// DAC signals
wire dac_mosi, dac_cs_n, dac_clr_n, dac_ldac_n;

// Encoder inputs
wire A, B;

// Button and switch controls
wire enswitch, modeswitch, resetbutton_n;

// Connect decoder to settings
wire count_en, count_up;

// Connect settings to ampl
wire [ 9: 0 ] amplitude;

// Connect settings to saw/oscillator
wire [ 19: 0 ] phi_inc;

// Connect timer to saw/oscillator
wire sample_clk;

// Connect saw to ampl
wire [ 11: 0 ] saw_data;
wire saw_data_valid;

// Connect oscillator to ampl
wire [ 11: 0 ] sine_data;
wire sine_data_valid;

// Connect ampl to dac
wire [ 11: 0 ] dac_data;
wire dac_data_valid;

//=======================================================
// Input/Output assignments
//=======================================================
// All unused inout port turn to tri-state
assign { GPIO0_D[ 31: 11 ], GPIO0_D[ 3: 0 ] } = 25'hzzzzzzzz;

// DAC Serial Connections
assign GPIO0_D[ 10 ] = dac_clr_n;
assign GPIO0_D[ 9 ] = dac_ldac_n;
assign GPIO0_D[ 8 ] = dac_cs_n; // active low
assign GPIO0_D[ 7 ] = dac_mosi;
assign GPIO0_D[ 6 ] = CLOCK_50; // sclk


// Motor encoder inputs
assign A = GPIO0_D [ 5 ];
assign B = GPIO0_D [ 4 ];

// Button and switch inputs
assign enswitch = SW[ 1 ];
assign modeswitch = SW[ 0 ];
assign resetbutton_n = BUTTON[ 0 ]; // active-low button


// =======================================================
// Structural coding
// =======================================================

quadrature_decode decoder
                  (
                      .clk( CLOCK_50 ),
                      .A( A ),
                      .B( B ),
                      .count( count_en ),
                      .up( count_up )
                  );

settings_controller settings
                    (
                        .clk( CLOCK_50 ),
                        .reset_n( resetbutton_n ),
                        .count_en( count_en ),
                        .count_up( count_up ),
                        .select( modeswitch ),
                        .phi_inc( phi_inc ),
                        .amplitude( amplitude )
                    );

sample_timer timer
             (
                 .clk( CLOCK_50 ),
                 .reset_n( resetbutton_n ),
                 .sample_trigger( sample_clk )
             );

sawtooth_generator saw
                   (
                       .clk( CLOCK_50 ),
                       .reset_n( resetbutton_n ),
                       .clken( sample_clk ),
                       .increment( phi_inc ),
                       .wave( saw_data ),
                       .out_valid( saw_data_valid )
                   );

nco oscillator
    (
        .clk( CLOCK_50 ),
        .reset_n( resetbutton_n ),
        .clken( sample_clk ),
        .phi_inc_i( phi_inc ),
        .fsin_o( sine_data ),
        .out_valid( sine_data_valid )
    );

amplitude_adjust ampl
                 (
                     .clk( CLOCK_50 ),
                     .amplitude( amplitude ),
                     .ast_sink_data( sine_data ),
                     .ast_sink_valid( sample_clk ),
                     .ast_sink_error( 2'b0 ),
                     .ast_source_data( dac_data ),
                     .ast_source_valid( dac_data_valid ),
                     .ast_source_error()
                 );

dac_spi dac
        (
            .sclk( CLOCK_50 ),
            .en( enswitch ),
            .ast_sink_data( dac_data ),
            .ast_sink_valid( dac_data_valid ),
            .ast_sink_error( 2'b0 ),
            .cs_n( dac_cs_n ),
            .mosi( dac_mosi ),
            .clr_n( dac_clr_n ),
            .ldac_n( dac_ldac_n )
        );

endmodule
