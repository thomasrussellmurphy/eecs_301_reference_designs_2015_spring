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

module brake_sm(
           input wire clk,
           input wire brake,
           input wire [ 2: 0 ] left_signal,
           input wire [ 2: 0 ] right_signal,
           output reg [ 2: 0 ] left_lights,
           output reg [ 1: 0 ] center_lights,
           output reg [ 2: 0 ] right_lights
       );

// State parameters
parameter idle_state = 2'd0;
parameter brake_state = 2'd1;
parameter brake_timeout1 = 2'd2;
parameter brake_timeout2 = 2'd3;

// Output parameters
parameter center_0 = 2'b00;
parameter center_2 = 2'b11;

reg brake_active;
reg [ 1: 0 ] state, next_state;

initial begin
    state = idle_state;
end

// Registered always block
always @( posedge clk ) begin
    state <= next_state;
end

// Combinational always block
// Next state logic
always @( brake, state ) begin
    case ( state )
        idle_state: begin
            if ( brake ) begin
                next_state = brake_state;
            end
            else begin
                next_state = idle_state;
            end
        end

        brake_state: begin
            if ( brake ) begin
                next_state = brake_state;
            end
            else begin
                next_state = brake_timeout1;
            end
        end

        brake_timeout1: begin
            if ( brake ) begin
                next_state = brake_state;
            end
            else begin
                next_state = brake_timeout2;
            end
        end

        brake_timeout2: begin
            if ( brake ) begin
                next_state = brake_state;
            end
            else begin
                next_state = idle_state;
            end
        end

        default: begin
            next_state = idle_state;
        end
    endcase
end

// Combinational always block
// Internal logic, Moore Machine
always @( state ) begin
    case ( state )
        idle_state:
            brake_active = 1'b0;
        brake_state:
            brake_active = 1'b1;
        brake_timeout1:
            brake_active = 1'b1;
        brake_timeout2:
            brake_active = 1'b1;
        default:
            brake_active = 1'b0;
    endcase
end

// Combinational always block
// Output logic, Mealy Machine
always @( left_signal, right_signal, brake_active ) begin
    // When brakes are active, invert turn signals, turn on center
    if ( brake_active ) begin
        left_lights = ~left_signal;
        center_lights = center_2;
        right_lights = ~right_signal;
    end
    // When inactive, pass through turn signal, turn off center
    else begin
        left_lights = left_signal;
        center_lights = center_0;
        right_lights = right_signal;
    end
end

endmodule
