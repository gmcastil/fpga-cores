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

  // synthesis translate_off
  reg [((8*10)-1):0]       hstate_ascii;
  always @(*) begin
    case (hstate)
      RESET:      begin hstate_ascii = "   RESET  "; end
      HFP_WAIT:   begin hstate_ascii = " HFP_WAIT "; end
      HSYNC:      begin hstate_ascii = "   HSYNC  "; end
      HBP_WAIT:   begin hstate_ascii = " HBP_WAIT "; end
      HACTIVE:    begin hstate_ascii = "  HACTIVE "; end
      FRAME_SYNC: begin hstate_ascii = "FRAME_SYNC"; end
      default:  begin end
    endcase
  end
  // synthesis translate_on

  localparam    [7:0]   RESET         = 8'h00;
	localparam		[7:0]		HFP_WAIT			= 8'h01;
	localparam		[7:0]		HSYNC					= 8'h02;
	localparam		[7:0]		HBP_WAIT			= 8'h03;
	localparam		[7:0]		HACTIVE				= 8'h04;
  localparam    [7:0]   FRAME_SYNC    = 8'h05;

  // Create counters to use for both dimensions - note that generally, the
  // horizontal counter will be used to count pixels, while the vertical counter
  // is used to count horizontal lines.
  reg   [31:0]    horiz_cnt;
  reg   [31:0]    hsync_cnt;
  reg             frame_start;
  reg   [7:0]     hstate;

  reg             hactive;
  reg             vactive;

  always @(posedge pxl_clk) begin
    if ( pxl_rst == 1'b1 ) begin
      hsync           <= ~hsync_pol;
      vsync           <= ~vsync_pol;
			horiz_cnt		    <= 32'd0;
      hstate          <= RESET;
      frame_start     <= 1'b0;
      hactive         <= 1'b1;
    end else begin

      case (hstate)

        RESET: begin
          hsync       <= ~hsync_pol;
          vsync       <= ~vsync_pol;
					horiz_cnt		<= 32'd0;
          hstate      <= FRAME_SYNC;
          hactive     <= 1'b0;
        end

				// Note that assertion and deassertion of VSYNC are always coincident with
				// the assertion of an HSYNC. A possibly more useful way to think of
        // this is that VSYNC assertion and deassertion only occur at the end of
        // a horizontal front porch.
        //
        // A point of clarity - for the first frame post a reset condition, no
        // vertical or horizontal front porches occur; HYSNC and VSYNC are
        // simply asserted together
				FRAME_SYNC: begin
					hsync				<= hsync_pol;
					horiz_cnt		<= 32'd0;
					hstate			<= HSYNC;
          hactive     <= 1'b0;
				end

        // Horizontal front porch
        HFP_WAIT: begin
          // HSYNC assertion occurs at the end of every horizontal front porch
          if ( horiz_cnt == ( horiz_front - 32'd1 ) ) begin
            hstate    <= HSYNC;
            hsync     <= hsync_pol;
            horiz_cnt <= 32'd0;
            vert_cnt  <= vert_cnt + 32'd1;
          end else begin
            hstate    <= HFP_WAIT;
            hsync     <= ~hsync_pol;
            horiz_cnt <= horiz_cnt + 32'd1;
            vert_cnt  <= vert_cnt;
          end
          hactive      <= 1'b0;
        end

        // Horizontal sync pulse
        HSYNC: begin
          if ( horiz_cnt == ( horiz_sync_len - 32'd1 ) ) begin
            hstate    <= HBP_WAIT;
            hsync     <= ~hsync_pol;
            horiz_cnt <= 32'd0;
            hsync_cnt <= hsync_cnt + 32'd1;
          end else begin
            hstate    <= HSYNC;
            hsync     <= hsync_pol;
            horiz_cnt <= horiz_cnt + 32'd1;
            hsync_cnt <= hsync_cnt;
          end
          hactive     <= hactive;
        end

        // Horizontal back porch
        HBP_WAIT: begin
          hsync       <= ~hsync_pol;
          if ( horiz_cnt == ( horiz_back - 32'd1 ) ) begin
            hstate    <= HACTIVE;
            horiz_cnt <= 32'd0;
            hactive   <= 1'b1;
          end else begin
            hstate    <= HBP_WAIT;
            horiz_cnt <= horiz_cnt + 32'd1;
            hactive   <= hactive;
          end
        end

        // Horizontal active region
        HACTIVE: begin
          hsync       <= ~hsync_pol;
          if ( horiz_cnt == ( horiz_res - 32'd1 ) ) begin
            hstate    <= HFP_WAIT;
            horiz_cnt <= 32'd0;
            hactive   <= 1'b0;
          end else begin
            hstate    <= HACTIVE;
            horiz_cnt <= horiz_cnt + 32'd1;
            hactive   <= hactive;
          end
        end

        default: begin end
      endcase

      case (vstate)

        FRAME_SYNC: begin
					vsync				<= vsync_pol;
          vstate      <= VSYNC;
          vert_cnt    <= 32'd0;
        end

        VSYNC: begin
          if ( vert_cnt == ( vert_sync_len - 32'd1 ) 


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

