module vga_core #(
  // Set to 1 to enable an ILA for the VGA core
  parameter   integer   ILA_VGA_CORE = 0
)
(
  // It is the user responsibility to provide VESA compliant clock and
  // timing values
  input   wire            pxl_clk,
  input   wire            pxl_rst,

  // Horizontal front and back porch durations and horizontal sync length
  // should be defined in integer numbers of pixel clocks
  input   wire  [31:0]    horiz_res,
  input   wire  [31:0]    horiz_front,
  input   wire  [31:0]    horiz_back,
  input   wire  [31:0]    horiz_sync_len,

  // Vertical front and back porch duration and vertical sync length should be
  // defined in integer numbers of horizontal line
  input   wire  [31:0]    vert_res,
  input   wire  [31:0]    vert_front,
  input   wire  [31:0]    vert_back,
  input   wire  [31:0]    vert_sync_len,

  // These two signals are used to indicate the polarities of the hsync and vsync
  // outputs when they are pulsed (i.e., set to 1 for positive and 0 for
  // negative)
  input   wire            hsync_pol,
  input   wire            vsync_pol,

  output  reg   [7:0]     rgb_red,
  output  reg   [7:0]     rgb_blue,
  output  reg   [7:0]     rgb_green,

  output  reg             hsync,
  output  reg             vsync
);

  localparam    [7:0]   HSTATE_RESET  = 8'hFF;
  localparam    [7:0]   HSTATE_FRONT  = 8'h00;
  localparam    [7:0]   HSTATE_HSYNC  = 8'h01;
  localparam    [7:0]   HSTATE_BACK   = 8'h02;
  localparam    [7:0]   HSTATE_LINE   = 8'h03;

  localparam    [7:0]   VSTATE_RESET  = 8'hFF;
  localparam    [7:0]   VSTATE_FRONT  = 8'h00;
  localparam    [7:0]   VSTATE_HSYNC  = 8'h01;
  localparam    [7:0]   VSTATE_BACK   = 8'h02;
  localparam    [7:0]   VSTATE_LINE   = 8'h03;

  // Create counters to use for both dimensions - note that generally, the
  // horizontal counter will be used to count pixels, while the vertical counter
  // is used to count horizontal lines.
  reg   [31:0]    horiz_cnt;
  reg   [31:0]    vert_cnt;

  reg   [31:0]    line_cnt;

  reg   [7:0]     hstate;
  reg   [7:0]     vstate;

  // Define a state machine to create HSYNC pulse based on the provided
  // timing values
  always @(posedge pxl_clk) begin
    if ( pxl_rst == 1'b1 ) begin
      hstate            <= HSTATE_RESET;
      hsync             <= ~hsync_pol;
    end else begin

      case (hstate)

        HSTATE_RESET: begin
          hstate          <= HSTATE_FRONT;
          hsync           <= ~hsync_pol;
          horiz_cnt       <= 32'd0;
          line_cnt        <= 32'd0;
        end

        HSTATE_FRONT: begin
          line_cnt        <= line_cnt;
          if ( horiz_cnt == horiz_front ) begin
            hstate        <= HSTATE_HSYNC;
            hsync         <= hsync_pol;
            horiz_cnt     <= 32'd0;
          end else begin  
            hstate        <= HSTATE_FRONT;
            hsync         <= hsync;
            horiz_cnt     <= horiz_cnt + 32'd1;
          end
        end

        HSTATE_HSYNC: begin
          line_cnt        <= line_cnt;
          if ( horiz_cnt == ( horiz_sync_len - 32'd1 ) ) begin
            hstate        <= HSTATE_BACK;
            hsync         <= ~hsync_pol;
            horiz_cnt     <= 32'd0;
          end else begin  
            hstate        <= HSTATE_HSYNC;
            hsync         <= hsync;
            horiz_cnt     <= horiz_cnt + 32'd1;
          end
        end

        HSTATE_BACK: begin
          hsync           <= ~hsync_pol;
          line_cnt        <= line_cnt;
          if ( horiz_cnt == ( horiz_back - 32'd1 ) ) begin
            hstate        <= HSTATE_LINE;
            horiz_cnt     <= 32'd0;
          end else begin  
            hstate        <= HSTATE_BACK;
            horiz_cnt     <= horiz_cnt + 32'd1;
          end
        end

        HSTATE_LINE: begin
          hsync           <= ~hsync_pol;
          if ( horiz_cnt == ( horiz_res - 32'd1 ) ) begin
            hstate        <= HSTATE_FRONT;
            horiz_cnt     <= 32'd0;
            line_cnt      <= line_cnt + 32'd1;
          end else begin
            hstate        <= HSTATE_LINE;
            horiz_cnt     <= horiz_cnt + 32'd1;
            line_cnt      <= line_cnt;
          end
        end

        default: begin end

      endcase

    end
  end

  always @(posedge pxl_clk) begin
    if ( pxl_rst == 1'b1 ) begin
      vstate            <= VSTATE_RESET;
      vsync             <= ~vsync_pol;

    end else begin

      case (vstate)

        VSTATE_RESET: begin
          vstate          <= VSTATE_FRONT;
          vsync           <= ~vsync_pol;
          vert_cnt        <= 32'd0;
        end

        VSTATE_BACK: begin
          
          vstate          <= VSTATE_
    end
  end






  // This is probably all garbage too since I dont know what the output or
  // input data interface looks liek yet
  //
  generate
    if (ILA_VGA_CORE == 1) begin
      ila_vga_core //#(
      //)
      ila_vga_core_i0 (
        .clk        (pxl_clk),
        .probe0     (pxl_rst),
        .probe1     (hsync),
        .probe2     (vsync),
        .probe3     (rgb_red),      // [7:0]
        .probe4     (rgb_green),    // [7:0]
        .probe6     (rgb_blue)      // [7:0]
      );
    end
  endgenerate
endmodule

