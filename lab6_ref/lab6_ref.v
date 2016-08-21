// Top Level for Lab 6 Reference Design
module lab6_ref
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
// PLL connections
wire pll_lock;
wire pll_clk_50, pll_clk_20, pll_clk_9;

// Connect timer to ADC
wire sample;

// Global clock for SPI devices and data processing
wire sclk;

// ADC signals
wire adc_mosi, adc_miso, adc_cs_n;

// Connect ADC to filters
wire [ 11: 0 ] adc_data;
wire [ 1: 0 ] adc_error;
wire adc_valid;

// Filter signals; Connect from filters to data sinks
wire [ 11: 0 ] hpf_data, lpf_data;
wire [ 1: 0 ] hpf_error, lpf_error;
wire hpf_valid, lpf_valid;

// DAC signals
wire [ 11: 0 ] dac_sink_data;
wire[ 1: 0 ] dac_sink_error;
wire dac_sink_valid;
wire dac_mosi, dac_cs_n, dac_clr_n, dac_ldac_n;
wire dac_en;

// Motor PWM signals
wire pwm_clk;
wire motor_phase, motor_antiphase, motor_en;

// Peak detector signals
wire [ 11: 0 ] lpf_peak_data, hpf_peak_data;
wire lpf_peak_valid, hpf_peak_valid;

// Display signals
wire [ 9: 0 ] h_pos, v_pos;
wire valid_draw, v_blank;

wire [ 7: 0 ] disp_red, disp_green, disp_blue;
wire disp_clk, disp_en, disp_vsync, disp_hsync;

wire disp_en_sw;

//=======================================================
// Input/Output assignments
//=======================================================
// Forgoing additional tristating for RTL viewer simplicity.
// Plus, it hasn't blown anything up on the boards, yet.

// Assign clock nets
assign disp_clk = pll_clk_9;
assign sclk = pll_clk_20;
assign pwm_clk = pll_clk_50;

// Assign status lights
assign LEDG[ 0 ] = dac_en;
assign LEDG[ 1 ] = motor_en;
assign LEDG[ 2 ] = disp_en_sw;
assign LEDG[ 3 ] = 1'b1; // lit for spatial reference

// ADC Serial Connections
assign GPIO0_D[ 14 ] = adc_cs_n; // active low
assign adc_miso = GPIO0_D[ 13 ];
assign GPIO0_D[ 12 ] = adc_mosi;
assign GPIO0_D[ 11 ] = sclk;

// DAC Serial Connections
assign GPIO0_D[ 10 ] = dac_clr_n;
assign GPIO0_D[ 9 ] = dac_ldac_n;
assign GPIO0_D[ 8 ] = dac_cs_n; // active low
assign GPIO0_D[ 7 ] = dac_mosi;
assign GPIO0_D[ 6 ] = sclk;

// Motor Connections
assign GPIO0_D[ 1: 0 ] = { motor_phase, motor_antiphase };
assign GPIO0_D[ 2 ] = motor_en;

assign motor_en = SW[ 1 ];

// Display Connections
assign GPIO1_D[ 27: 0 ] = { disp_vsync, disp_hsync, disp_en, disp_clk, disp_blue, disp_green, disp_red };
assign disp_en = pll_lock; // Enable the display just after PLL has locked

assign dac_en = SW[ 0 ];
assign disp_en_sw = SW [ 2 ];

// =======================================================
// Structural coding
// =======================================================
system_pll pll
           (
               .inclk0( CLOCK_50 ),
               .locked( pll_lock ),
               .c0( pll_clk_50 ),
               .c1( pll_clk_20 ),
               .c2( pll_clk_9 )
           );
//

sample_timer timer
             (
                 .clk( sclk ),
                 .reset_n( pll_lock ),
                 .sample_trigger( sample )
             );
//

adc_serial adc
           (
               .sclk( sclk ),
               .ast_source_data( adc_data ),
               .ast_source_valid( adc_valid ),
               .ast_source_error( adc_error ),
               .sample( sample ),
               .sdo( adc_mosi ),
               .sdi( adc_miso ),
               .cs( adc_cs_n ) );
//

fir_hpf high_pass_filter
        (
            .clk( sclk ),
            .reset_n( pll_lock ),
            .ast_sink_data( adc_data ),
            .ast_sink_valid( adc_valid ),
            .ast_sink_error( adc_error ),
            .ast_source_data( hpf_data ),
            .ast_source_valid( hpf_valid ),
            .ast_source_error( hpf_error )
        );
//

fir_lpf low_pass_filter
        (
            .clk( sclk ),
            .reset_n( pll_lock ),
            .ast_sink_data( adc_data ),
            .ast_sink_valid( adc_valid ),
            .ast_sink_error( adc_error ),
            .ast_source_data( lpf_data ),
            .ast_source_valid( lpf_valid ),
            .ast_source_error( lpf_error )
        );
//

avalon_io12_4_switcher filter_switcher
                       (
                           .clk ( sclk ), .select ( ~BUTTON[ 2: 1 ] ),
                           .sink_data_0 ( hpf_data ), .sink_valid_0 ( hpf_valid ), .sink_error_0 ( hpf_error ),
                           .sink_data_1 ( lpf_data ), .sink_valid_1 ( lpf_valid ), .sink_error_1 ( lpf_error ),
                           .sink_data_2 ( adc_data ), .sink_valid_2 ( adc_valid ), .sink_error_2 ( adc_error ),
                           .sink_data_3 ( 1'b0 ), .sink_valid_3 ( 1'b0 ), .sink_error_3 ( 1'b0 ),
                           .source_data ( dac_sink_data ), .source_valid ( dac_sink_valid ), .source_error ( dac_sink_error ) );
//

dac_spi dac
        (
            .sclk( sclk ),
            .en( dac_en ),
            .ast_sink_data( dac_sink_data ),
            .ast_sink_valid( dac_sink_valid ),
            .ast_sink_error( dac_sink_error ),
            .cs_n( dac_cs_n ),
            .mosi( dac_mosi ),
            .clr_n( dac_clr_n ),
            .ldac_n( dac_ldac_n )
        );
//

avalon_motor motor
             (
                 .pwm_clk( pwm_clk ),
                 .data_clk( sclk ),
                 .ast_sink_data( lpf_data ),
                 .ast_sink_error( lpf_error ),
                 .ast_sink_valid( lpf_valid ),
                 .outh( motor_phase ),
                 .outl( motor_antiphase ),
                 .update()
             );
//

// Do the peak processing
peak_detector hf_detector
              (
                  .data_clk( sclk ),
                  .display_clk( disp_clk ),
                  .ast_sink_data( hpf_data ),
                  .ast_sink_valid( hpf_valid ),
                  .ast_sink_error( hpf_error ),
                  .v_blank( v_blank ),
                  .source_data( hpf_peak_data ),
                  .source_valid( hpf_peak_valid )
              );
//

peak_detector lf_detector
              (
                  .data_clk( sclk ),
                  .display_clk( disp_clk ),
                  .ast_sink_data( lpf_data ),
                  .ast_sink_valid( lpf_valid ),
                  .ast_sink_error( lpf_error ),
                  .v_blank( v_blank ),
                  .source_data( lpf_peak_data ),
                  .source_valid( lpf_peak_valid )
              );
//


// Control the video side of the world
video_position_sync video_sync
                    (
                        .disp_clk( disp_clk ),
                        .en( pll_lock && disp_en_sw ),
                        .valid_draw( valid_draw ),
                        .v_blank( v_blank ),
                        .h_pos( h_pos ),
                        .v_pos( v_pos ),
                        .disp_hsync( disp_hsync ),
                        .disp_vsync( disp_vsync )
                    );
//

dual_scrolling_display display
                       (
                           .data_clk( sclk ),
                           .display_clk( disp_clk ),
                           .h_pos( h_pos ),
                           .v_pos( v_pos ),
                           .valid_draw( valid_draw ),
                           .sink_data_a( hpf_peak_data ),
                           .sink_data_b( lpf_peak_data ),
                           .sink_valid_a( hpf_peak_valid ),
                           .sink_valid_b( lpf_peak_valid ),
                           .disp_red( disp_red ),
                           .disp_green( disp_green ),
                           .disp_blue( disp_blue )
                       );
//

endmodule
