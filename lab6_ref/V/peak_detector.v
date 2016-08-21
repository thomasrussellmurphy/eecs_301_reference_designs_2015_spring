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

module peak_detector
       (
           input data_clk, display_clk,
           input [ 11: 0 ] ast_sink_data,
           input ast_sink_valid,
           input [ 1: 0 ] ast_sink_error,
           input v_blank,
           output reg [ 11: 0 ] source_data,
           output reg source_valid
       );
//

reg signed [ 11: 0 ] last_max_data;
reg reset_max;

reg blank_sync0, blank_sync1, blank_sync2;
reg last_v_blank;

wire [ 11: 0 ] unsigned_data;

assign unsigned_data = ast_sink_data + 12'b1000_0000_0000;

// Clock domain transfer
// Suggested that f_{display_clk} < f_{data_clk} since v_blank is a slow control signal
always @( posedge display_clk ) begin
    last_v_blank <= v_blank;
end
always @( posedge data_clk ) begin
    blank_sync2 <= blank_sync1;
    blank_sync1 <= blank_sync0;
    blank_sync0 <= last_v_blank;

    // Create the local control signal
    // One cycle to reset and cause output to downstream module
    reset_max <= blank_sync2 & ~ blank_sync1;
end


// Update condition
wire update_max_value = ast_sink_valid && ( unsigned_data > last_max_data );

// Usual operation: detect peak and wait for reset to trigger output
always @( posedge data_clk ) begin
    if ( ~reset_max ) begin
        if ( update_max_value ) begin
            last_max_data <= unsigned_data;
        end
        else begin
            last_max_data <= last_max_data;
        end

        source_data <= source_data;
        source_valid <= 1'b0;
    end
    else begin
        // Reset and output condition
        source_data <= last_max_data;
        source_valid <= 1'b1;
        last_max_data <= 1'b0;
    end
end

endmodule
