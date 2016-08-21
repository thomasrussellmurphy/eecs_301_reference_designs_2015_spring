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

module video_position_sync
       (
           input disp_clk,
           input en,
           output reg disp_hsync, disp_vsync,
           output reg valid_draw, v_blank,
           output reg [ 9: 0 ] h_pos, v_pos
       );

// HSync pattern: 525 clock cycles period; 41 low, 2 front porch, 480 data, 2 back porch
// VSync pattern: 286 lines period; 10 low, 2 front porch, 272 data, 2 pack porch
parameter HORZ_PIXELS = 10'd480; // max (2^10-1) - (front porch + back porch + low width)
parameter VERT_PIXELS = 10'd272; // max (2^10-1) - (front porch + back porch + low width)
parameter HORZ_FRONT_PORCH = 10'd2; // pixels
parameter HORZ_BACK_PORCH = 10'd2; // pixels
parameter VERT_FRONT_PORCH = 10'd2; // horizontal lines
parameter VERT_BACK_PORCH = 10'd2; // horizontal lines
parameter HORZ_LOW_WIDTH = 10'd41; // clock cycles
parameter VERT_LOW_WIDTH = 10'd10; // horizontal lines

// Valid horizontal counts are offset by 2 from display observation
// Valid vertical counts are offset by 1 from display observation
parameter HORZ_DELAY = 10'd2;
parameter VERT_DELAY = 10'd1;

parameter HORZ_MIN_VALID_COUNT = HORZ_LOW_WIDTH + HORZ_FRONT_PORCH - HORZ_DELAY;
parameter HORZ_MAX_VALID_COUNT = HORZ_LOW_WIDTH + HORZ_FRONT_PORCH + HORZ_PIXELS - HORZ_DELAY;
parameter HORZ_MAX_COUNT = HORZ_LOW_WIDTH + HORZ_FRONT_PORCH + HORZ_PIXELS + HORZ_BACK_PORCH;

parameter VERT_MIN_VALID_COUNT = VERT_LOW_WIDTH + VERT_FRONT_PORCH - VERT_DELAY;
parameter VERT_MAX_VALID_COUNT = VERT_LOW_WIDTH + VERT_FRONT_PORCH + VERT_PIXELS - VERT_DELAY;
parameter VERT_MAX_COUNT = VERT_LOW_WIDTH + VERT_FRONT_PORCH + VERT_PIXELS + VERT_BACK_PORCH;

// Internal variables and states for excitation logic
reg [ 9: 0 ] h_count, v_count; // Counters for progression through real and non-display positions
reg [ 9: 0 ] next_h_count, next_v_count;
reg next_hsync, next_vsync;

wire h_valid, v_valid, next_valid_draw, next_v_blank;

// Are the counter states within the valid display bounds?
assign h_valid = ( h_count > HORZ_MIN_VALID_COUNT ) && ( h_count < HORZ_MAX_VALID_COUNT );
assign v_valid = ( v_count > VERT_MIN_VALID_COUNT ) && ( v_count < VERT_MAX_VALID_COUNT );

assign next_v_blank = ~v_valid;
assign next_valid_draw = h_valid && v_valid;

// Excitation logic
always @( * ) begin
    // Modify next_h_count
    if ( h_count == HORZ_MAX_COUNT ) begin // Rollover at this count
        next_h_count <= 1'b0;
    end
    else begin
        next_h_count <= h_count + 1'b1; // Always count horizontal progress
    end

    // Modify next_v_count
    if ( v_count == VERT_MAX_COUNT ) begin // Rollover at this count
        next_v_count <= 1'b0;
    end
    else if ( h_count == HORZ_MAX_COUNT ) begin // Starting next line
        next_v_count <= v_count + 1'b1;
    end
    else begin
        next_v_count <= v_count;
    end

    // Modify next_hsync
    if ( h_count < HORZ_LOW_WIDTH ) begin // hsync low pulse
        next_hsync <= 1'b0;
    end
    else begin
        next_hsync <= 1'b1;
    end

    // Modify next_vysc
    if ( v_count < VERT_LOW_WIDTH ) begin // vsync low pulse
        next_vsync <= 1'b0;
    end
    else begin
        next_vsync <= 1'b1;
    end
end

// Output logic and next-state conversion
always @( posedge disp_clk ) begin
    if ( en ) begin
        valid_draw <= next_valid_draw;
        v_blank <= next_v_blank;

        h_count <= next_h_count;
        v_count <= next_v_count;

        h_pos <= h_count - HORZ_MIN_VALID_COUNT;
        v_pos <= v_count - VERT_MIN_VALID_COUNT;

        disp_hsync <= next_hsync;
        disp_vsync <= next_vsync;
    end
    else begin // Disable state turns everything off
        valid_draw <= 1'b0;
        v_blank <= 1'b0;

        h_count <= 1'b0;
        v_count <= 1'b0;

        h_pos <= 1'b0;
        v_pos <= 1'b0;

        disp_hsync <= 1'b0;
        disp_vsync <= 1'b0;
    end
end

endmodule
