module vga_test_gen //#(
//)
(
  input   wire          pxl_clk,
  input   wire          pxl_rst,

  input   wire          horz_active,
  input   wire          vert_active,
  input   wire          frame_active,

  output  wire  [3:0]   rgb_red,
  output  wire  [3:0]   rgb_green,
  output  wire  [3:0]   rgb_blue
);

  assign  rgb_red   = 4'hF;
  assign  rgb_green = 4'h0;
  assign  rgb_blue  = 4'h0;

endmodule

