module turn_sm(
           input wire clk,
           input wire left,
           input wire right,
           output reg error,
           output reg [ 2: 0 ] left_signal,
           output reg [ 2: 0 ] right_signal
       );

reg [ 4: 0 ] state, next_state;

// State Parameters
parameter idle_state = 5'd0;

parameter left0 = 5'd1;
parameter left1_1 = 5'd2;
parameter left1_2 = 5'd3;
parameter left1_3 = 5'd4;
parameter left2_1 = 5'd5;
parameter left2_2 = 5'd6;
parameter left2_3 = 5'd7;
parameter left3_1 = 5'd8;
parameter left3_2 = 5'd9;
parameter left3_3 = 5'd10;

parameter right0 = 5'd11;
parameter right1_1 = 5'd12;
parameter right1_2 = 5'd13;
parameter right1_3 = 5'd14;
parameter right2_1 = 5'd15;
parameter right2_2 = 5'd16;
parameter right2_3 = 5'd17;
parameter right3_1 = 5'd18;
parameter right3_2 = 5'd19;
parameter right3_3 = 5'd20;

parameter error_state = 5'd21;

// Output Parameters
parameter left_0 = 3'b000;
parameter left_1 = 3'b001;
parameter left_2 = 3'b011;
parameter left_3 = 3'b111;

parameter right_0 = 3'b000;
parameter right_1 = 3'b100;
parameter right_2 = 3'b110;
parameter right_3 = 3'b111;

initial begin
    state = idle_state;
end

// Registered always block
always @( posedge clk ) begin
    state <= next_state;
end

// Combinational always block
// Next state logic
always @( left, right, state ) begin
    case ( state )
        idle_state: begin
            if ( left && right ) begin
                next_state = error_state;
            end
            else if ( left ) begin
                next_state = left0;
            end
            else if ( right ) begin
                next_state = right0;
            end
            else begin
                next_state = idle_state;
            end
        end

        // Progression through left states
        // Check for input correctness only when changing # of lights turned on
        left0: begin
            if ( left && right ) begin
                next_state = error_state;
            end
            else if ( left ) begin
                next_state = left1_1;
            end
            else begin
                next_state = idle_state;
            end
        end
        left1_1: begin
            next_state = left1_2;
        end
        left1_2: begin
            next_state = left1_3;
        end
        left1_3: begin
            if ( left && right ) begin
                next_state = error_state;
            end
            else if ( left ) begin
                next_state = left2_1;
            end
            else begin
                next_state = idle_state;
            end
        end
        left2_1: begin
            next_state = left2_2;
        end
        left2_2: begin
            next_state = left2_3;
        end
        left2_3: begin
            if ( left && right ) begin
                next_state = error_state;
            end
            else if ( left ) begin
                next_state = left3_1;
            end
            else begin
                next_state = idle_state;
            end
        end
        left3_1: begin
            next_state = left3_2;
        end
        left3_2: begin
            next_state = left3_3;
        end
        left3_3: begin
            if ( left && right ) begin
                next_state = error_state;
            end
            else if ( left ) begin
                next_state = left0;
            end
            else begin
                next_state = idle_state;
            end
        end

        // Progression through right states
        // Check for input correctness only when changing # of lights turned on
        right0: begin
            if ( right && left ) begin
                next_state = error_state;
            end
            else if ( right ) begin
                next_state = right1_1;
            end
            else begin
                next_state = idle_state;
            end
        end
        right1_1: begin
            next_state = right1_2;
        end
        right1_2: begin
            next_state = right1_3;
        end
        right1_3: begin
            if ( right && left ) begin
                next_state = error_state;
            end
            else if ( right ) begin
                next_state = right2_1;
            end
            else begin
                next_state = idle_state;
            end
        end
        right2_1: begin
            next_state = right2_2;
        end
        right2_2: begin
            next_state = right2_3;
        end
        right2_3: begin
            if ( right && left ) begin
                next_state = error_state;
            end
            else if ( right ) begin
                next_state = right3_1;
            end
            else begin
                next_state = idle_state;
            end
        end
        right3_1: begin
            next_state = right3_2;
        end
        right3_2: begin
            next_state = right3_3;
        end
        right3_3: begin
            if ( right && left ) begin
                next_state = error_state;
            end
            else if ( right ) begin
                next_state = right0;
            end
            else begin
                next_state = idle_state;
            end
        end

        // Operation of the error state
        error_state: begin
            if ( left && right ) begin
                next_state = error_state;
            end
            else begin
                next_state = idle_state;
            end
        end

        // Safety, default to the idle state
        default: begin
            next_state = idle_state;
        end
    endcase
end

// Combinational always block
// Output logic, Moore Machine
always @( state ) begin
    case ( state )
        // Cover each count of lights turned on, left
        left1_1: begin
            left_signal = left_1;
            right_signal = right_0;
            error = 1'b0;
        end
        left1_2: begin
            left_signal = left_1;
            right_signal = right_0;
            error = 1'b0;
        end
        left1_3: begin
            left_signal = left_1;
            right_signal = right_0;
            error = 1'b0;
        end
        left2_1: begin
            left_signal = left_2;
            right_signal = right_0;
            error = 1'b0;
        end
        left2_2: begin
            left_signal = left_2;
            right_signal = right_0;
            error = 1'b0;
        end
        left2_3: begin
            left_signal = left_2;
            right_signal = right_0;
            error = 1'b0;
        end
        left3_1: begin
            left_signal = left_3;
            right_signal = right_0;
            error = 1'b0;
        end
        left3_2: begin
            left_signal = left_3;
            right_signal = right_0;
            error = 1'b0;
        end
        left3_3: begin
            left_signal = left_3;
            right_signal = right_0;
            error = 1'b0;
        end

        // Cover each count of lights turned on, right
        right1_1: begin
            right_signal = right_1;
            left_signal = left_0;
            error = 1'b0;
        end
        right1_2: begin
            right_signal = right_1;
            left_signal = left_0;
            error = 1'b0;
        end
        right1_3: begin
            right_signal = right_1;
            left_signal = left_0;
            error = 1'b0;
        end
        right2_1: begin
            right_signal = right_2;
            left_signal = left_0;
            error = 1'b0;
        end
        right2_2: begin
            right_signal = right_2;
            left_signal = left_0;
            error = 1'b0;
        end
        right2_3: begin
            right_signal = right_2;
            left_signal = left_0;
            error = 1'b0;
        end
        right3_1: begin
            right_signal = right_3;
            left_signal = left_0;
            error = 1'b0;
        end
        right3_2: begin
            right_signal = right_3;
            left_signal = left_0;
            error = 1'b0;
        end
        right3_3: begin
            right_signal = right_3;
            left_signal = left_0;
            error = 1'b0;
        end

        // Error case, no lights are turned on
        error_state: begin
            left_signal = left_0;
            right_signal = right_0;
            error = 1'b1;
        end

        // In all other cases, all lights are off
        default: begin
            left_signal = left_0;
            right_signal = right_0;
            error = 1'b0;
        end
    endcase
end

endmodule
