module lab2_ref
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
wire A, B; // encoder signal A,B (async)
wire enswitch; // enable switch
wire [ 7: 0 ] gain; // desired feedback gain value

wire [ 1: 0 ] motor_out; // PWM for locked antiphase driving
wire en; // enable motor

// Connect decoder to steps
wire enable_count, count_up;

// Connect steps to control_system
wire [ 9: 0 ] step_count;

// Connect interface to goal_counter
wire goal_up, goal_down, goal_reset;

// Connect goal_counter to control_system
wire [ 9: 0 ] goal_count;

// Connect reset_load_timer to step_counter and control_system
wire reset_step_count, load_step_count;

// Connect control_system to pwm
wire [ 9: 0 ] controller_result;

wire [ 9: 0 ] measured_speed;

//=======================================================
// Input/Output assignments
//=======================================================
// All unused inout port turn to tri-state
assign GPIO0_D[ 31: 3 ] = 26'hz;

// Unused active-low 7-segment elements to high
assign { HEX0_D, HEX0_DP, HEX1_D, HEX1_DP, HEX2_D, HEX2_DP, HEX3_D, HEX3_DP } = 32'hFF_FF_FF_FF;

// Hold clocks low
assign GPIO0_CLKOUT = 1'b0;

// Assign appropriate connections to GPIO0_D ports
assign A = GPIO0_D [ 5 ];
assign B = GPIO0_D [ 4 ];

assign GPIO0_D[ 1: 0 ] = motor_out;
assign GPIO0_D[ 2 ] = en;

// Assign goal interface buttons, converting to active-high
assign goal_up = ~BUTTON[ 0 ]; // up and down are arbitrary, really are CW/CCW
assign goal_down = ~BUTTON[ 1 ];
assign goal_reset = ~BUTTON[ 2 ]; // use button as reset for goal count

assign enswitch = SW[ 0 ]; // Switch to enable the motor
assign gain = SW[ 9: 2 ]; // Switches that control the motor's gain

assign en = enswitch; // Just pass through the switch for the motor

assign LEDG = SW[ 1 ] ? goal_count : measured_speed; // Debugging

// =======================================================
// Structural coding
// =======================================================

quadrature_decode decoder ( .clk( CLOCK_50 ), .A( A ), .B( B ), .count( enable_count ), .up( count_up ) );

step_counter steps ( .clk( CLOCK_50 ), .reset( reset_step_count ), .enable( enable_count ), .count_up( count_up ), .count( step_count ) );

goal_counter goals ( .clk( CLOCK_50 ), .up( goal_up ), .down( goal_down ), .reset( goal_reset ), .count( goal_count ) );

reset_load_timer timer ( .clk( CLOCK_50 ), .reset_out( reset_step_count ), .load_out( load_step_count ) );

control_system controller ( .clk( CLOCK_50 ), .load_speed( load_step_count ), .speed_count( step_count ), .goal( goal_count ), .gain( gain ), .result( controller_result ), .measured_speed( measured_speed ) );

pwm_output pwm ( .clk( CLOCK_50 ), .set( controller_result ), .outh( motor_out[ 0 ] ), .outl( motor_out[ 1 ] ) );

endmodule
