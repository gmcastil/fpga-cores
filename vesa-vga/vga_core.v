module vga_core #(
  // Set to 1 to enable an ILA for the VGA core
  parameter   integer   ILA_VGA_CORE = 0
)
(
  // It is the user responsibility to provide VESA compliant clock and
  // timing values
  input   wire            pxl_clk,
  input   wire            pxl_rst,
  input   wire            enable,

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

  output  wire  [2:0]     rgb_video,
  output  wire            hsync,
  output  wire            vsync
);

  // Generate the HSYNC and VSYNC pulses
  always @(posedge pxl_clk) begin
    if ( pxl_rst == 1'b1 ) begin
    end else begin
    end
  end

  generate
    if (ILA_VGA_CORE == 1) begin
      ila_vga_core //#(
      //)
      ila_vga_core_i0 (
        .clk        (pxl_clk),
        .probe0     (rst),
        .probe1     (hsync)
      );
    end
  endgenerate

  endmodule

