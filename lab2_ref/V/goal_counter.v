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

module goal_counter
       (
           input clk,
           input up, down, reset,
           output reg signed [ 9: 0 ] count
       );

parameter input_wait = 3'd0;
parameter received_up = 3'd1;
parameter received_down = 3'd2;
parameter received_both = 3'd3;
parameter received_reset = 3'd4;

// 10-bit two's complement max/min values for counter saturation
parameter MIN_COUNT = 10'b10_0000_0000;
parameter MAX_COUNT = 10'b01_1111_1111;

reg [ 20: 0 ] wait_counter; //
reg [ 2: 0 ] state, next_state;

reg active_counter;

wire wait_over;

assign wait_over = ( wait_counter == 1'b0 ) ? 1'b1 : 1'b0;

initial begin
    state <= input_wait;
end

always @( posedge clk ) begin
    state <= next_state;

    if ( active_counter ) begin
        wait_counter <= wait_counter + 1'b1;
    end
    else begin
        wait_counter <= 1'b1;
    end

    if ( wait_over ) begin
        case ( state )
            received_up: begin
                if ( count != MAX_COUNT ) begin
                    count <= count + 1'b1;
                end
                else begin
                    count <= count; // Saturate
                end
            end
            received_down: begin
                if ( count != MIN_COUNT ) begin
                    count <= count - 1'b1;
                end
                else begin
                    count <= count; // Saturate
                end
            end
            received_reset: begin
                count <= 1'b0;
            end
            default: begin
                count <= count;
            end
        endcase
    end
    else begin
        count <= count;
    end
end

// Combinational next-state calculation
always @( state, up, down, reset, wait_over ) begin
    case ( state )
        input_wait: begin
            if ( reset ) begin
                next_state = received_reset;
            end
            else if ( up && down ) begin
                next_state = received_both;
            end
            else if ( up ) begin
                next_state = received_up;
            end
            else if ( down ) begin
                next_state = received_down;
            end
            else begin
                next_state = input_wait;
            end
        end
        received_up: begin
            if ( wait_over ) begin
                next_state = input_wait;
            end
            else begin
                next_state = received_up;
            end
        end
        received_down: begin
            if ( wait_over ) begin
                next_state = input_wait;
            end
            else begin
                next_state = received_down;
            end
        end
        received_both: begin
            if ( wait_over ) begin
                next_state = input_wait;
            end
            else begin
                next_state = received_both;
            end
        end
        received_reset: begin
            if ( wait_over ) begin
                next_state = input_wait;
            end
            else begin
                next_state = received_reset;
            end
        end
        default: begin
            next_state = input_wait;
        end
    endcase
end

// Combinational output calculation
always @( state ) begin
    case ( state )
        input_wait: begin
            active_counter = 1'b0;
        end
        received_up: begin
            active_counter = 1'b1;
        end
        received_down: begin
            active_counter = 1'b1;
        end
        received_both: begin
            active_counter = 1'b1;
        end
        received_reset: begin
            active_counter = 1'b1;
        end
    endcase
end

endmodule
