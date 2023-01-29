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
  input   wire  [31:0]    hoz_res,
  input   wire  [31:0]    hoz_front,
  input   wire  [31:0]    hoz_back,
  input   wire  [31:0]    hoz_sync_len,

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

  // This is probably not a good way to think about the output because a) I have
  // no input data yet and b) I've got a 12-bit RGB output to drive, so this
  // interface is going to change
  output  wire  [2:0]     rgb_video,
  output  reg             hsync,
  output  reg             vsync
);

  localparam  integer   RED   = 0;
  localparam  integer   GREEN = 1;
  localparam  integer   BLUE  = 2;

  localparam    [7:0]   HSTATE_FRONT   = 8'd0;
  localparam    [7:0]   HSTATE_HSYNC   = 8'd1;
  localparam    [7:0]   HSTATE_BACK    = 8'd2;
  localparam    [7:0]   HSTATE_LINE    = 8'd3;

  reg   rgb_red;
  reg   rgb_blue;
  reg   rgb_green;

  // Create counters to use for both dimensions
  reg   [31:0]    hoz_cnt;
  reg   [31:0]    vert_cnt;

  reg   [31:0]    hstate;

  assign rgb_video[RED]   = rgb_red;
  assign rgb_video[GREEN] = rgb_green;
  assign rgb_video[BLUE]  = rgb_blue;

  always @(posedge pxl_clk) begin
    if ( pxl_rst == 1'b1 ) begin
      hstate      <= HSTATE_FRONT;
      hsync       <= ~hsync_pol;
    end else begin

      case (hstate)

    end
  end

  generate
    if (ILA_VGA_CORE == 1) begin
      ila_vga_core //#(
      //)
      ila_vga_core_i0 (
        .clk        (pxl_clk),
        .probe0     (rst),
        .probe1     (hsync),
        .probe2     (vsync),
        .probe3     (rgb_red),
        .probe4     (rgb_green),
        .probe6     (rgb_blue)
      );
    end
  endgenerate
endmodule

