`include "constants.vh"

module basys3_io //#(
//)
(
  output  wire          clk_ext,
  input   wire          clk_ext_pad,

  input   wire  [3:0]   vga_red,
  input   wire  [3:0]   vga_green,
  input   wire  [3:0]   vga_blue,
  input   wire          vga_hsync,
  input   wire          vga_vsync,

  output  wire  [3:0]   vga_red_pad,
  output  wire  [3:0]   vga_green_pad,
  output  wire  [3:0]   vga_blue_pad,
  output  wire          vga_hsync_pad,
  output  wire          vga_vsync_pad,

  input   wire  [15:0]  user_led,
  output  wire  [15:0]  user_led_pad

);

  // Global clock instances
  IBUFG //#(
  //)
  IBUFG_i0 (
    .I        (clk_ext_pad),
    .O        (clk_ext)
  );

  // Onboard VGA interface signals
  genvar i;
  generate
    for (i = 0; i < 4; i = i + 1) begin
      OBUF //#(
      //)
      OBUF_vga_red (
        .I        (vga_red[i]),
        .O        (vga_red_pad[i])
      );
  
      OBUF //#(
      //)
      OBUF_vga_green (
        .I        (vga_green[i]),
        .O        (vga_green_pad[i])
      );
  
      OBUF //#(
      //)
      OBUF_vga_blue (
        .I        (vga_blue[i]),
        .O        (vga_blue_pad[i])
      );
    end
  endgenerate

  OBUF //#(
  //)
  OBUF_hsync (
    .I          (vga_hsync),
    .O          (vga_hsync_pad)
  );

  OBUF //#(
  //)
  OBUF_vsync (
    .I          (vga_vsync),
    .O          (vga_vsync_pad)
  );

  // Onboard user LED signals
  generate
    for (i = 0; i < 16; i = i + 1) begin
      OBUF //#(
      //)
      (
        .I      (user_led[i]),
        .O      (user_led_pad[i])
      );
    end
  endgenerate

endmodule

