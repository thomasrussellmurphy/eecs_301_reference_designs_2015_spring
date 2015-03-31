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
wire pll_lock;

// Connect timer to ADC
wire sample;

// ADC signals
wire adc_mosi, adc_miso, adc_cs_n;

// Connect ADC to filters
wire [ 11: 0 ] adc_data;
wire [ 1: 0 ] adc_error;
wire adc_valid;

// DAC signals
wire dac_mosi, dac_cs_n, dac_clr_n, dac_ldac_n;

// Global clock for SPI devices
wire sclk;

wire [ 9: 0 ] h_pos, v_pos;
wire valid_draw, v_blank;

wire [ 7: 0 ] disp_red, disp_green, disp_blue;
wire disp_clk, disp_en, disp_vsync, disp_hsync;

//=======================================================
// Input/Output assignments
//=======================================================
// All unused inout port turn to tri-state
assign { GPIO0_D[ 31: 15 ], GPIO0_D[ 5: 0 ] } = 23'hzzzzzzzz;
assign GPIO1_D [ 31: 28 ] = 4'hz;

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

assign GPIO1_D[ 27: 0 ] = { disp_vsync, disp_hsync, disp_en, disp_clk, disp_blue, disp_green, disp_red };
assign disp_en = pll_lock; // Enable the display just after PLL has locked


// =======================================================
// Structural coding
// =======================================================
sample_timer timer
             (
                 .clk( sclk ),
                 .reset_n( pll_locked ),
                 .sample_trigger( sample )
             );
//

adc_serial adc (
               .sclk( sclk ),
               .ast_source_data( adc_data ),
               .ast_source_valid( adc_valid ),
               .ast_source_error( adc_error ),
               .sample( sample ),
               .sdo( adc_mosi ),
               .sdi( adc_miso ),
               .cs( adc_cs_n ) );
//

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
//

// Control the video side of the world
video_position_sync video_sync (
                        .disp_clk( disp_clk ),
                        .en( pll_lock ),
                        .valid_draw( valid_draw ),
                        .v_blank( v_blank ),
                        .h_pos( h_pos ),
                        .v_pos( v_pos ),
                        .disp_hsync( disp_hsync ),
                        .disp_vsync( disp_vsync )
                    );
//

endmodule
