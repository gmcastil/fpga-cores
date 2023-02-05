`include "constants.vh"
`include "debug.vh"

module basys3_top // #(
// )
(
  /* 100MHz external clock */
  input   wire            clk_ext_pad,

  /* Slider switches */
  // input   wire  [15:0]    slider_sw,

  /* Pushbutton switches */
  // input   wire  [4:0]     pushb_sw,

  /* PMOD interfaces */
  // inout   wire  [7:0]     pmod_ja,
  // inout   wire  [7:0]     pmod_jb,
  // inout   wire  [7:0]     pmod_jc,
  // inout   wire  [7:0]     pmod_jxadc,

  /* Flash SPI interface */
  // output  wire            flash_mosi,
  // input   wire            flash_miso,
  // output  wire            flash_csn,
  // output  wire            flash_wpn,
  // output  wire            flash_hldn,

  /* VGA interface */
  output  wire  [3:0]     vga_red_pad,
  output  wire  [3:0]     vga_green_pad,
  output  wire  [3:0]     vga_blue_pad,
  output  wire            vga_hsync_pad,
  output  wire            vga_vsync_pad,

  /* User LED */
  output  wire  [15:0]    user_led_pad

  /* Seven-segment (SSEG) display */
  // output  wire  [6:0]     sseg_digit,
  // output  wire            sseg_dp,
  // output  wire  [3:0]     sseg_selectn,

  /* USB HID (PS/2) */
  // output  wire            host_ps2_clk,
  // input   wire            host_ps2_data,

  /* USB RS-232 interface */
  // output  wire            uart_txd,
  // input   wire            uart_rxd
);

  localparam BLANK = 4'h0;

  wire  [3:0]         vga_red;
  wire  [3:0]         vga_green;
  wire  [3:0]         vga_blue;
  wire                vga_hsync;
  wire                vga_vsync;

  wire  [15:0]        user_led;

  wire                pxl_clk;
  wire                pxl_rst;

  assign user_led   = {14'd0, vga_hsync, vga_vsync};

  wire  [3:0]         rgb_red;
  wire  [3:0]         rgb_green;
  wire  [3:0]         rgb_blue;

  wire  [31:0]        horz_res;
  wire  [31:0]        horz_front;
  wire  [31:0]        horz_back;
  wire  [31:0]        horz_sync_len;

  wire  [31:0]        vert_res;
  wire  [31:0]        vert_front;
  wire  [31:0]        vert_back;
  wire  [31:0]        vert_sync_len;

  wire                hsync_pol;
  wire                vsync_pol;

  // Hard code the desired 640x480 @59.94MHz signal we want to generate
  assign horz_res       = 32'd640;
  assign horz_front     = 32'd16;
  assign horz_back      = 32'd48;
  assign horz_sync_len  = 32'd96;

  assign vert_res       = 32'd480;
  assign vert_front     = 32'd10;
  assign vert_back      = 32'd33;
  assign vert_sync_len  = 32'd2;

  assign hsync_pol      = 1'b1;
  assign vsync_pol      = 1'b1;

  basys3_io //#(
  //)
  basys3_io_i0 (
    .clk_ext          (clk_ext),        // output wire
    .clk_ext_pad      (clk_ext_pad),    // input  wire
    .vga_red			    (vga_red),        // input  wire  [3:0]   
    .vga_green			  (vga_green),      // input  wire  [3:0]   
    .vga_blue			    (vga_blue),       // input  wire  [3:0]   
    .vga_hsync			  (vga_hsync),      // input  wire          
    .vga_vsync			  (vga_vsync),      // input  wire          
    .vga_red_pad 		  (vga_red_pad),    // output wire  [3:0]   
    .vga_green_pad		(vga_green_pad),  // output wire  [3:0]   
    .vga_blue_pad		  (vga_blue_pad),   // output wire  [3:0]   
    .vga_hsync_pad		(vga_hsync_pad),  // output wire          
    .vga_vsync_pad    (vga_vsync_pad),  // output wire          
    .user_led         (user_led),       // input  wire  [15:0]
    .user_led_pad     (user_led_pad)    // output wire  [15:0]
  );

  clk_rst //#(
  //)
  clk_rst_i0 (
    .clk_ext          (clk_ext),
    .rst_ext          (`GND),
    .clk_25m175       (pxl_clk),
    .clk_100m00       (),
    .rst_25m175       (pxl_rst),
    .rst_100m00       ()
  );

  vga_test_gen //#(
  //)
  vga_test_gen_i0 (
    .pxl_clk					(pxl_clk),        // input   wire    
    .pxl_rst					(pxl_rst),        // input   wire    
    .horz_active	  	(horz_active),    // input   wire    
    .vert_active			(vert_active),    // input   wire    
    .frame_active			(frame_active),   // input   wire    
    .rgb_red					(rgb_red),        // output  [3:0]   
    .rgb_green			  (rgb_green),      // output  [3:0]   
    .rgb_blue     	  (rgb_blue)        // output  [3:0]   
  );


  vga_core #(
    .ILA_VGA_CORE     (`ILA_VGA_CORE)
  )
  vga_core_i0 (
    .pxl_clk			    (pxl_clk),         // input  wire            
    .pxl_rst			    (pxl_rst),         // input  wire            
    .horz_res			    (horz_res),        // input  wire  [31:0]    
    .horz_front			  (horz_front),      // input  wire  [31:0]    
    .horz_back			  (horz_back),       // input  wire  [31:0]    
    .horz_sync_len		(horz_sync_len),   // input  wire  [31:0]    
    .vert_res			    (vert_res),        // input  wire  [31:0]    
    .vert_front			  (vert_front),      // input  wire  [31:0]    
    .vert_back			  (vert_back),       // input  wire  [31:0]    
    .vert_sync_len		(vert_sync_len),   // input  wire  [31:0]    
    .hsync_pol			  (hsync_pol),       // input  wire            
    .vsync_pol			  (vsync_pol),       // input  wire            
    .rgb_red			    (rgb_red),         // input  wire  [3:0]     
    .rgb_green			  (rgb_green),       // input  wire  [3:0]     
    .rgb_blue			    (rgb_blue),        // input  wire  [3:0]     
    .horz_active			(horz_active),     // output reg             
    .vert_active			(vert_active),     // output reg             
    .frame_active			(frame_active),    // output reg             
    .vga_hsync			  (vga_hsync),       // output reg             
    .vga_vsync			  (vga_vsync),       // output reg             
    .vga_red			    (vga_red),         // output reg   [3:0]     
    .vga_blue			    (vga_blue),        // output reg   [3:0]     
    .vga_green			  (vga_green)        // output reg   [3:0]     
  );

endmodule

