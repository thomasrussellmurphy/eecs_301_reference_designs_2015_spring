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

module input_position_controller
       (
           input clk,
           input enc_A, enc_B, dim_sel, to_zero,
           output reg [ 5: 0 ] cell_x_addr,
           output reg [ 4: 0 ] cell_y_addr
       );
// Max cell counts, minus 1 to deal with indexing
parameter MAX_X = 6'd60 - 1'b1; // actually horizontal tiles
parameter MAX_Y = 5'd17 - 1'b1; // actually vertical tiles

reg last_enc_A;
wire count_en;
wire count_dir;

assign count_en = enc_A && ~last_enc_A;
assign count_dir = enc_B;

always @( posedge clk ) begin
    last_enc_A <= enc_A;

    if ( to_zero ) begin
        cell_x_addr <= 1'b0;
        cell_y_addr <= 1'b0;
    end
    else if ( dim_sel ) begin
        cell_x_addr <= cell_x_addr;

        if ( count_en && count_dir && ( cell_y_addr < MAX_Y ) ) begin
            cell_y_addr <= cell_y_addr + 1'b1;
        end
        else if ( count_en && ~count_dir && ( cell_y_addr > 1'b0 ) ) begin
            cell_y_addr <= cell_y_addr - 1'b1;
        end
        else begin
            cell_y_addr <= cell_y_addr;
        end
    end
    else begin
        cell_y_addr <= cell_y_addr;

        if ( count_en && count_dir && ( cell_x_addr < MAX_X ) ) begin
            cell_x_addr <= cell_x_addr + 1'b1;
        end
        else if ( count_en && ~count_dir && ( cell_x_addr > 1'b0 ) ) begin
            cell_x_addr <= cell_x_addr - 1'b1;
        end
        else begin
            cell_x_addr <= cell_x_addr;
        end

    end
end

endmodule
