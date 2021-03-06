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

module dac_spi
       (
           input sclk, en,
           input signed [ 11: 0 ] ast_sink_data,
           input ast_sink_valid,
           input [ 1: 0 ] ast_sink_error,
           output cs_n, mosi, clr_n, ldac_n
       );

parameter COMMAND_BITS = 4'b0011; // Command to write and update addressed channel, software LDAC
parameter ADDRESS_BITS = 4'b1111; // Address both DAC channels A and B
parameter X4 = 4'bxxxx;

parameter idle_state = 3'd0;
parameter load_state = 3'd1;
parameter shifting_state = 3'd2;
parameter delay_state = 3'd3; // Implement?

reg [ 2: 0 ] state, next_state;

reg [ 4: 0 ] shift_out_count;

reg [ 31: 0 ] current_command;
wire [ 11: 0 ] unsigned_data;
reg enable_shift, load_shift, enable_out;

assign unsigned_data = ast_sink_data + 12'b1000_0000_0000;
assign ldac_n = 1'b0;
assign clr_n = 1'b1;
assign cs_n = ~enable_out;

// Manual instantiation of the lpm_shiftreg
lpm_shiftreg shiftreg32 (
                 .clock ( sclk ),
                 .data ( current_command ),
                 .load ( load_shift ),
                 .enable ( enable_shift ),
                 .shiftout ( mosi )
                 // synopsys translate_off
                 ,
                 .aclr (),
                 .aset (),
                 .q (),
                 .sclr (),
                 .shiftin (),
                 .sset ()
                 // synopsys translate_on
             );
defparam
    shiftreg32.lpm_direction = "LEFT",
    shiftreg32.lpm_type = "LPM_SHIFTREG",
    shiftreg32.lpm_width = 32;

always @( posedge sclk ) begin
    state <= next_state;

    if ( ast_sink_valid ) begin
        current_command <= { X4, COMMAND_BITS, ADDRESS_BITS, unsigned_data, X4, X4 };
    end
    else begin
        current_command <= current_command;
    end

    case ( state )
        idle_state: begin
            enable_shift <= 1'b0;
            load_shift <= 1'b0;
            enable_out <= 1'b0;
            shift_out_count <= 5'd31;
        end
        load_state: begin
            enable_shift <= 1'b1;
            load_shift <= 1'b1;
            enable_out <= 1'b0;
            shift_out_count <= 5'd31;
        end
        shifting_state: begin
            enable_shift <= 1'b1;
            load_shift <= 1'b0;
            enable_out <= 1'b1;
            shift_out_count <= shift_out_count - 1'b1;
        end
        default: begin
            enable_shift <= 1'b0;
            load_shift <= 1'b0;
            enable_out <= 1'b0;
            shift_out_count <= 5'd31;
        end
    endcase
end

// Combinational always, next-state calculation
always @( state, ast_sink_valid, shift_out_count, en ) begin
    case ( state )
        idle_state: begin
            if ( ast_sink_valid & en ) begin
                next_state = load_state;
            end
            else begin
                next_state = idle_state;
            end
        end
        load_state: begin
            next_state = shifting_state;
        end
        shifting_state: begin
            if ( shift_out_count == 1'b0 ) begin
                next_state = idle_state; // Consider the delay state
            end
            else begin
                next_state = shifting_state;
            end
        end
        default: begin
            next_state = idle_state;
        end
    endcase
end

endmodule
