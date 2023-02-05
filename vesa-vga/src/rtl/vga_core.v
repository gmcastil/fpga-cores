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
  input   wire  [31:0]    horz_res,
  input   wire  [31:0]    horz_front,
  input   wire  [31:0]    horz_back,
  input   wire  [31:0]    horz_sync_len,

  // Vertical front and back porch duration and vertical sync length should be
  // defined in integer numbers of horizontal lines
  input   wire  [31:0]    vert_res,
  input   wire  [31:0]    vert_front,
  input   wire  [31:0]    vert_back,
  input   wire  [31:0]    vert_sync_len,

  // These two signals are used to indicate the polarities of the hsync and vsync
  // outputs when they are pulsed (i.e., set to 1 for positive and 0 for
  // negative)
  input   wire            hsync_pol,
  input   wire            vsync_pol,

  // 12-bit color input data - a single clock of latency is added by the video
  // processor.  Data presented on these inputs will be presented one clock
  // later at the output.  Presumably, the user knows the resolution and timing
  // parameters it has supplied the core with and is capable of aligning the
  // input data with the pixel clock.
  input   wire  [3:0]     rgb_red,
  input   wire  [3:0]     rgb_green,
  input   wire  [3:0]     rgb_blue,

  // Indicate whether the output interface is in an active or blanking region.
  // Note that these are fully synchronous outputs (e.g., `frame_active` is not
  // simply `horz_active` AND `vert_active`.
  output  reg             horz_active,
  output  reg             vert_active,
  output  reg             frame_active,

  // Horizontal and vertical sync pulses
  output  reg             vga_hsync,
  output  reg             vga_vsync,

  // 12-bit VGA data
  output  reg   [3:0]     vga_red,
  output  reg   [3:0]     vga_green,
  output  reg   [3:0]     vga_blue
);

  // Define some constants to make blanking and such easier
  localparam    BLANK       = 4'h00;

  // FSM states
  localparam    RESET       = 8'h00;
  localparam    FRAME_SYNC  = 8'h05;
  localparam    HSYNC       = 8'h01;
  localparam    HBP         = 8'h02;
  localparam    HACTIVE     = 8'h03;
  localparam    HFP         = 8'h04;

  reg   [31:0]    horz_cnt;
  reg   [31:0]    vert_cnt;

  /* Prevent Vivado from trying to help by altering the FSM encoding */
  (* fsm_encoding = "user_encoding" *) reg   [7:0]     state;

  // synthesis translate_off
  reg [((8*10)-1):0]     state_ascii;
  always @(*) begin
    case (state)
      RESET:		  begin state_ascii = "  RESET   ";	end
      FRAME_SYNC: begin state_ascii = "FRAME_SYNC"; end
      HSYNC:	    begin state_ascii = "  HSYNC   ";	end
      HBP:		    begin state_ascii = "   HBP    ";	end
      HACTIVE:	  begin state_ascii = " HACTIVE  "; end
      HFP:		    begin state_ascii = "   HFP    ";	end
      default:    begin end
    endcase
  end
  // synthesis translate_on

  always @(posedge pxl_clk) begin

    if ( pxl_rst == 1'b1 ) begin
      state                 <= RESET;
      vga_hsync             <= ~hsync_pol;
      vga_vsync             <= ~vsync_pol;
      horz_cnt              <= 32'd0;
      vert_cnt              <= 32'd0;
      horz_active           <= 1'b0;
      vert_active           <= 1'b0;
      frame_active          <= 1'b0;

      // Blank out the VGA output channels until the active region
      vga_red               <= BLANK;
      vga_green             <= BLANK;
      vga_blue              <= BLANK;
    end else begin

      case (state)

        RESET: begin
          vga_hsync         <= ~hsync_pol;
          vga_vsync         <= ~vsync_pol;
          state             <= FRAME_SYNC;
          horz_cnt          <= 32'd0;
          vert_cnt          <= 32'd0;
          horz_active       <= 1'b0;
          vert_active       <= 1'b0;
          frame_active      <= 1'b0;
        end

        FRAME_SYNC: begin
          vga_hsync         <= hsync_pol;
          vga_vsync         <= vsync_pol;
          state             <= HSYNC;
          horz_cnt          <= 32'd0;
          vert_cnt          <= 32'd0;
          horz_active       <= 1'b0;
          vert_active       <= 1'b0;
          frame_active      <= 1'b0;
        end

        HSYNC: begin
          if ( horz_cnt == ( horz_sync_len - 32'd1 ) ) begin
            horz_cnt        <= 32'd0;
            state           <= HBP;
            vga_hsync       <= ~vsync_pol;
          end else begin
            horz_cnt        <= horz_cnt + 32'd1;
            state           <= HSYNC;
            vga_hsync       <= vga_hsync;
          end
        end

        HBP: begin
          if ( horz_cnt == ( horz_back - 32'd1 ) ) begin
            horz_cnt        <= 32'd0;
            state           <= HACTIVE;
            horz_active     <= 1'b1;
            if ( vert_active == 1'b1 ) begin
              vga_red       <= rgb_red;
              vga_green     <= rgb_green;
              vga_blue      <= rgb_blue;
              frame_active  <= 1'b1;
            end else begin
              vga_red       <= BLANK;
              vga_green     <= BLANK;
              vga_blue      <= BLANK;
              frame_active  <= 1'b0;
            end
          end else begin
            horz_cnt        <= horz_cnt + 32'd1;
            state           <= HBP;
            horz_active     <= 1'b0;
            frame_active    <= 1'b0;
          end
        end

        HACTIVE: begin
          if ( horz_cnt == ( horz_res - 32'd1 ) ) begin
            horz_cnt        <= 32'd0;
            state           <= HFP;
            horz_active     <= 1'b0;
            // Note no dependence on vertical active here
            frame_active    <= 1'b0;
            vga_red         <= BLANK;
            vga_green       <= BLANK;
            vga_blue        <= BLANK;
          end else begin
            horz_cnt        <= horz_cnt + 32'd1;
            state           <= HACTIVE;
            horz_active     <= 1'b1;
            vga_red         <= rgb_red;
            vga_green       <= rgb_green;
            vga_blue        <= rgb_blue;
            frame_active    <= frame_active;
          end
        end

        HFP: begin
          if ( horz_cnt == ( horz_front - 32'd1 ) ) begin
            horz_cnt        <= 32'd0;
            state           <= HSYNC;
            // HSYNC gets asserted every time we reach the end of a line
            vga_hsync       <= hsync_pol;
            // Three things are determined on the last clock out of the horizontal
            // front porch: the status of VSYNC, value of vert_cnt, and status of
            // vert_active
            if ( vert_cnt == ( vert_sync_len + vert_back + vert_res + vert_front - 32'd1 ) ) begin
              vga_vsync     <= vsync_pol;
            end else if ( vert_cnt == ( vert_sync_len - 32'd1 ) ) begin
              vga_vsync     <= ~vsync_pol;
            end else begin
              vga_vsync     <= vga_vsync;
            end
            // TODO: Interesting to see if there is another way that doesn't
            // require inferring an adder here
            if ( vert_cnt == ( vert_sync_len + vert_back + vert_res + vert_front - 32'd1 ) ) begin
              vert_cnt      <= 32'd0;
            end else begin
              vert_cnt      <= vert_cnt + 32'd1;
            end

            case (vert_cnt)
              32'd0: begin
                vert_active <= 1'b0;
              end
              (vert_sync_len + vert_back - 32'd1): begin
                vert_active <= 1'b1;
              end
              (vert_sync_len + vert_back + vert_res - 32'd1 ): begin
                vert_active <= 1'b0;
              end
              default: begin
                vert_active <= vert_active;
              end
            endcase

          end else begin
            horz_cnt        <= horz_cnt + 32'd1;
            state           <= HFP;
            vert_cnt        <= vert_cnt;
            vga_vsync       <= vga_vsync;
          end
          horz_active       <= 1'b0;
          frame_active      <= 1'b0;
        end

        default: begin end

      endcase
    end
  end

  generate
    if ( ILA_VGA_CORE == 1 ) begin
      ila_vga_core //#(
      //)
      ila_vga_core_i0 (
        .clk          (pxl_clk),
        .probe0			  (pxl_rst),          // input   wire
        .probe1			  (horz_res),         // input   wire  [31:0]
        .probe2			  (horz_front),       // input   wire  [31:0]
        .probe3			  (horz_back),        // input   wire  [31:0]
        .probe4			  (horz_sync_len),    // input   wire  [31:0]
        .probe5			  (vert_res),         // input   wire  [31:0]
        .probe6			  (vert_front),       // input   wire  [31:0]
        .probe7			  (vert_back),        // input   wire  [31:0]
        .probe8			  (vert_sync_len),    // input   wire  [31:0]
        .probe9			  (hsync_pol),        // input   wire
        .probe10			(vsync_pol),        // input   wire
        .probe11			(rgb_red),          // input   wire   [3:0]
        .probe12			(rgb_green),        // input   wire   [3:0]
        .probe13			(rgb_blue),         // input   wire   [3:0]
        .probe14			(horz_active),      // output  reg
        .probe15			(vert_active),      // output  reg
        .probe16			(frame_active),     // output  reg
        .probe17			(vga_hsync),        // output  reg
        .probe18			(vga_vsync),        // output  reg
        .probe19			(vga_red),          // output  reg    [3:0]
        .probe20			(vga_green),        // output  reg    [3:0]
        .probe21			(vga_blue),         // output  reg    [3:0]
        .probe22			(horz_cnt),         //               [31:0]
        .probe23			(vert_cnt),         //               [31:0]
        .probe24			(state)             //                [7:0]
      ) /* synthesis syn_keep=1 syn_preserve=1 syn_noprune=1 */;
    end
  endgenerate

endmodule

