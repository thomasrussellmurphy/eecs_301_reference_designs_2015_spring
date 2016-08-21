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

// Top Level for Lab 4 Reference Design
module lab4_ref
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
           inout [ 31: 0 ] GPIO0_D,
           input [ 1: 0 ] GPIO1_CLKIN,
           output [ 1: 0 ] GPIO1_CLKOUT,
           inout [ 31: 0 ] GPIO1_D
       );

// =======================================================
// REG/WIRE declarations
// =======================================================
// ADC signals
wire adc_mosi, adc_miso, adc_cs_n;

// DAC signals
wire dac_mosi, dac_cs_n, dac_clr_n, dac_ldac_n;

// Global clock for SPI devices
wire sclk;
wire pll_locked; // Communicate lock

// Connect timer to ADC
wire sample;

// Connect bank selector to filter and saturator
wire [ 1: 0 ] bank_select;

// Connect ADC to filter
wire [ 11: 0 ] adc_data;
wire [ 1: 0 ] adc_error;
wire adc_valid;

// Connect filter to saturator
wire [ 34: 0 ] fir_data;
wire [ 1: 0 ] fir_error;
wire fir_valid;

// Connect saturator to DAC
wire [ 11: 0 ] saturated_data;
wire [ 1: 0 ] saturated_error;
wire saturated_valid;

// Switch control
wire enswitch;

// Button control
wire select1, select2, select3;

//=======================================================
// Input/Output assignments
//=======================================================
// All inout port turn to tri-state
// All unused inout port turn to tri-state
assign { GPIO0_D[ 31: 15 ], GPIO0_D[ 5: 0 ] } = 23'hzzzzzzzz;
assign GPIO1_D = 32'hzzzzzzzz;

// DAC Serial Connections
assign GPIO0_D[ 10 ] = dac_clr_n;
assign GPIO0_D[ 9 ] = dac_ldac_n;
assign GPIO0_D[ 8 ] = dac_cs_n; // active low
assign GPIO0_D[ 7 ] = dac_mosi;
assign GPIO0_D[ 6 ] = sclk;

// ADC Serial Connections
assign GPIO0_D[ 14 ] = adc_cs_n; // active low
assign adc_miso = GPIO0_D[ 13 ];
assign GPIO0_D[ 12 ] = adc_mosi;
assign GPIO0_D[ 11 ] = sclk;

// Switch connections
assign enswitch = SW[ 0 ];

// Button connections
assign select1 = ~BUTTON[ 0 ];
assign select2 = ~BUTTON[ 1 ];
assign select3 = ~BUTTON[ 2 ];


// =======================================================
// Structural coding
// =======================================================

pll sclk_pll
    (
        .inclk0( CLOCK_50 ),
        .c0( sclk ),
        .locked( pll_locked )
    );

sample_timer timer
             (
                 .clk( sclk ),
                 .reset_n( pll_locked ),
                 .sample_trigger( sample )
             );

adc_serial adc (
               .sclk( sclk ),
               .ast_source_data( adc_data ),
               .ast_source_valid( adc_valid ),
               .ast_source_error( adc_error ),
               .sample( sample ),
               .sdo( adc_mosi ),
               .sdi( adc_miso ),
               .cs( adc_cs_n ) );

filter_coordinator coordinator (
                       .clk( sclk ),
                       .sel1( select1 ),
                       .sel2( select2 ),
                       .sel3( select3 ),
                       .bank_select( bank_select )
                   );

quad_bank_fir filter (
                  .clk( sclk ),
                  .reset_n( pll_locked ),
                  .ast_sink_data( { bank_select, adc_data } ),
                  .ast_sink_valid( adc_valid ),
                  .ast_sink_error( adc_error ),
                  .ast_source_data( fir_data ),
                  .ast_source_valid( fir_valid ),
                  .ast_source_error( fir_error )
              );

variable_saturation saturation_array (
                        .clk( sclk ),
                        .reset_n( pll_locked ),
                        .sel( bank_select ),
                        .ast_sink_data( fir_data ),
                        .ast_sink_valid( fir_valid ),
                        .ast_sink_error( fir_error ),
                        .ast_source_data( saturated_data ),
                        .ast_source_valid( saturated_valid ),
                        .ast_source_error( saturated_error )
                    );

dac_spi dac
        (
            .sclk( sclk ),
            .en( enswitch ),
            .ast_sink_data( saturated_data ),
            .ast_sink_valid( saturated_valid ),
            .ast_sink_error( saturated_error ),
            .cs_n( dac_cs_n ),
            .mosi( dac_mosi ),
            .clr_n( dac_clr_n ),
            .ldac_n( dac_ldac_n )
        );

endmodule
