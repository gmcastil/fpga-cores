`timescale 1ns / 1ps

module vga_core_tb ();

  // Some sort of ifdef thing here to let me pick the resolution during
  // simulation would be a good idea, but for now, we're sticking to 640x480
  // @ 59.94Hz refresh per CEA-861

  // 25.175MHz
  parameter N = 39.7219464;

  logic         pxl_clk;
  logic         pxl_rst;

  logic [31:0]  horiz_res;
  logic [31:0]  horiz_front;
  logic [31:0]  horiz_back;
  logic [31:0]  horiz_sync_len;

  logic [31:0]  vert_res;
  logic [31:0]  vert_front;
  logic [31:0]  vert_back;
  logic [31:0]  vert_sync_len;

  logic         hsync_pol;
  logic         vsync_pol;

  logic [63:0]  pxl_clk_cnt;

  logic [7:0]   rgb_red;
  logic [7:0]   rgb_green;
  logic [7:0]   rgb_blue;

  initial begin
    pxl_clk_cnt = 64'd0;
    pxl_clk = 1'b0;
    #(N/2);
    forever begin
      if ( pxl_clk == 1'b1 ) begin
        pxl_clk_cnt++;
      end
      pxl_clk = ~pxl_clk;
      #(N/2);
    end
  end

  initial begin
    pxl_rst = 1'b0;
    wait(pxl_clk_cnt == 10);
    pxl_rst = 1'b1;
    wait(pxl_clk_cnt == 20);
    pxl_rst = 1'b0;
    wait(pxl_clk_cnt == 256 * 1024);
    $display("Simulation ended\n");
    $stop;
  end

  // 640x480 @ 60Hz with 23.75 Mhz
  assign horiz_res        = 32'd640;
  assign horiz_front      = 32'd16;
  assign horiz_back       = 32'd48;
  assign horiz_sync_len   = 32'd96;

  assign vert_res         = 32'd480;
  assign vert_front       = 32'd10;
  assign vert_back        = 32'd33;
  assign vert_sync_len    = 32'd2;

  assign hsync_pol        = 1'b1;
  assign vsync_pol        = 1'b1;

  vga_core #(
    .ILA_VGA_CORE   (0)
  )
  vga_core_i0 (
    .pxl_clk          (pxl_clk),        // input   wire
    .pxl_rst          (pxl_rst),        // input   wire
    .horiz_res        (horiz_res),      // input   wire [31:0]
    .horiz_front      (horiz_front),    // input   wire [31:0]
    .horiz_back       (horiz_back),     // input   wire [31:0]
    .horiz_sync_len   (horiz_sync_len), // input   wire [31:0]
    .vert_res         (vert_res),       // input   wire [31:0]
    .vert_front       (vert_front),     // input   wire [31:0]
    .vert_back        (vert_back),      // input   wire [31:0]
    .vert_sync_len    (vert_sync_len),  // input   wire [31:0]
    .hsync_pol        (hsync_pol),      // input   wire
    .vsync_pol        (vsync_pol),      // input   wire
    .rgb_red          (rgb_red),        // output  reg  [7:0]
    .rgb_green        (rgb_green),      // output  reg  [7:0]
    .rgb_blue         (rgb_blue),       // output  reg  [7:0]
    .hsync            (hsync),          // output  reg
    .vsync            (vsync)           // output  reg
  );

endmodule

