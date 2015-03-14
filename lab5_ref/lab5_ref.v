module lab5_ref
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

wire [ 9: 0 ] h_pos, v_pos;
wire valid_draw, v_blank;

wire display_reset;

wire en_switch, dim_sel;
wire [6:0] next_char;

wire [ 7: 0 ] disp_red, disp_green, disp_blue;
wire disp_clk, disp_en, disp_vsync, disp_hsync;

//=======================================================
// Input/Output assignments
//=======================================================
// All inout port turn to tri-state
assign GPIO0_D = 32'hzzzzzzzz;
assign GPIO1_D [ 31: 28 ] = 4'hz;

assign GPIO1_D[ 27: 0 ] = { disp_vsync, disp_hsync, disp_en, disp_clk, disp_blue, disp_green, disp_red };
assign disp_en = pll_lock; // Enable the display just after PLL has locked

assign next_char = SW[9:3];
assign en_switch = SW[ 1 ];
assign dim_sel = SW[0];


// =======================================================
// Structural coding
// =======================================================

video_pll pll(
              .inclk0( CLOCK_50 ),
              .c0( disp_clk ),
              .locked( pll_lock )
          );

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
display_reset_controller reset_control
(
     .clk(disp_clk),
     .reset_in(pll_lock), 
     .v_blank(v_blank),
 .reset_out(display_reset)
);
//

char_array_display display(
                       .clk( disp_clk ),
                       .reset( display_reset ),
                       .enc_A(),
                       .enc_B(),
                       .write_char(),
                       .dim_sel(),
                       .next_char(),
                       .valid_coord( valid_draw ),
                       .pixel_x( h_pos ),
                       .pixel_y( v_pos ),
                       .red_out( disp_red ),
                       .green_out( disp_green ),
                       .blue_out( disp_blue )
                   );

endmodule
