module vga_test_gen #(
  parameter   ILA_VGA_PATTERN     = 0
)
(
  input   wire          pxl_clk,
  input   wire          pxl_rst,

  // This pattern generator currently only supports 640x480 resolutions. It will
  // certainly put pixels on the screen with other resolutions, but none of the
  // results are what would be expected
  input   wire  [31:0]  horz_res,
  input   wire  [31:0]  vert_res,

  input   wire          horz_active,
  input   wire          vert_active,
  input   wire          frame_active,

  output  wire   [3:0]  rgb_red,
  output  wire   [3:0]  rgb_green,
  output  wire   [3:0]  rgb_blue
);

  localparam    COLOR_HORZ_LEN = 32'd80;
  localparam    COLOR_VERT_LEN = 32'd8;

  reg   [31:0]        horz_cnt;
  reg   [31:0]        vert_cnt;

  reg   [11:0]        rgb_color;
  reg   [11:0]        rgb_color_next;   

  localparam    COLOR0 = 12'h000;
  localparam    COLOR1 = 12'hF00;
  localparam    COLOR2 = 12'h800;
  localparam    COLOR3 = 12'h0F0;
  localparam    COLOR4 = 12'h080;
  localparam    COLOR5 = 12'h00F;
  localparam    COLOR6 = 12'h008;
  localparam    COLOR7 = 12'h000;

  assign rgb_red    = rgb_color[11:8];
  assign rgb_green  = rgb_color[7:4];
  assign rgb_blue   = rgb_color[3:0];

  always @(*) begin
    case (rgb_color)
      COLOR0: begin rgb_color_next = COLOR1; end
      COLOR1: begin rgb_color_next = COLOR2; end
      COLOR2: begin rgb_color_next = COLOR3; end
      COLOR3: begin rgb_color_next = COLOR4; end
      COLOR4: begin rgb_color_next = COLOR5; end
      COLOR5: begin rgb_color_next = COLOR6; end
      COLOR6: begin rgb_color_next = COLOR7; end
      COLOR7: begin rgb_color_next = COLOR0; end
      default: begin end
    endcase
  end

  always @(posedge pxl_clk) begin
    if ( pxl_rst == 1'b1 ) begin
    end else begin
      if ( 
    end
  end
  
  generate
    if ( ILA_VGA_PATTERN == 1 ) begin
      ila_vga_test_gen //#(
      //)
      ila_vga_test_gen_i0 (
        .clk            (pxl_clk),
        .probe0         (pxl_rst),				// input  reg
        .probe1         (horz_cnt),				// [31:0]
        .probe2         (vert_cnt),				// [31:0]
        .probe3         (horz_active),		// input  wire
        .probe4         (vert_active),		// input  wire
        .probe5         (frame_active),		// input  wire
        .probe6         (rgb_red),				// output reg [31:0]
        .probe7         (rgb_green),			// output reg [31:0]
        .probe8         (rgb_blue)				// output reg [31:0]
      );
    end
  endgenerate

endmodule

