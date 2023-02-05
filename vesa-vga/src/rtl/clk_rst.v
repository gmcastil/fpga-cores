`include "constants.vh"

module clk_rst //#(
//)
(
  input     clk_ext,
  input     rst_ext,

  output    clk_25m175,
  output    clk_100m00,

  output    rst_25m175,
  output    rst_100m00
);

  // The Xilinx MMCM wizard commonly inserts a BUFG between the MMCM output and
  // the feedback input clock.  Unless phase alignment or deskewing is required,
  // this BUFG is unnecessary
  wire    clk_mmcm_i0_fb;
  // We choose to use the locked indicator to drive an asynchronous reset to
  // all downstream clock domains, and then generate individual synchronous resets
  // on each of them individually
  wire    mmcm_i0_locked;
  wire    mmcm_i0_async_rst = ~mmcm_i0_locked;

  MMCME2_ADV #(
    .BANDWIDTH              ("OPTIMIZED"),
    .CLKOUT4_CASCADE        ("FALSE"),
    .COMPENSATION           ("ZHOLD"),
    .STARTUP_WAIT           ("FALSE"),
    .DIVCLK_DIVIDE          (1),
    .CLKFBOUT_MULT_F        (9.000),
    .CLKFBOUT_PHASE         (0.000),
    .CLKFBOUT_USE_FINE_PS   ("FALSE"),
    .CLKOUT0_DIVIDE_F       (35.750),
    .CLKOUT0_PHASE          (0.000),
    .CLKOUT0_DUTY_CYCLE     (0.500),
    .CLKOUT0_USE_FINE_PS    ("FALSE"),
    .CLKOUT1_DIVIDE         (9),
    .CLKOUT1_PHASE          (0.000),
    .CLKOUT1_DUTY_CYCLE     (0.500),
    .CLKOUT1_USE_FINE_PS    ("FALSE"),
    .CLKIN1_PERIOD          (10.000)
  )
  mmcm_i0 (
    .CLKFBOUT            (clk_mmcm_i0_fb),
    .CLKFBOUTB           (),
    .CLKOUT0             (clk_25m175_mmcm_i0),
    .CLKOUT0B            (),
    .CLKOUT1             (clk_100m00_mmcm_i0),
    .CLKOUT1B            (),
    .CLKOUT2             (),
    .CLKOUT2B            (),
    .CLKOUT3             (),
    .CLKOUT3B            (),
    .CLKOUT4             (),
    .CLKOUT5             (),
    .CLKOUT6             (),
    .CLKFBIN             (clk_mmcm_i0_fb),
    .CLKIN1              (clk_ext),
    .CLKIN2              (`GND),
    .CLKINSEL            (`VCC),
    .DADDR               (7'h0),
    .DCLK                (`GND),
    .DEN                 (`GND),
    .DI                  (16'h0),
    .DO                  (),
    .DRDY                (),
    .DWE                 (`GND),
    .PSCLK               (`GND),
    .PSEN                (`GND),
    .PSINCDEC            (`GND),
    .PSDONE              (),
    .LOCKED              (mmcm_i0_locked),
    .CLKINSTOPPED        (),
    .CLKFBSTOPPED        (),
    .PWRDWN              (`GND),
    .RST                 (rst_ext)
  );

  BUFG //#(
  //)
  BUFG_25m175 (
    .I      (clk_25m175_mmcm_i0),
    .O      (clk_25m175)
  );
    
  BUFG //#(
  //)
  BUFG_100m00 (
    .I      (clk_100m00_mmcm_i0),
    .O      (clk_100m00)
  );

  porfgen #(
    .PORF_LEN     (10),
    .PORF_VIO     (1),
    .DEVICE       ("7SERIES")
  )
  porfgen_25m175 (
    .clk          (clk_25m175),
    .async_rst    (mmcm_i0_async_rst),
    .sync_rst     (rst_25m175)
  );

  porfgen #(
    .PORF_LEN     (10),
    .PORF_VIO     (0),
    .DEVICE       ("7SERIES")
  )
  porfgen_100m00 (
    .clk          (clk_100m00),
    .async_rst    (mmcm_i0_async_rst),
    .sync_rst     (rst_100m00)
  );

endmodule


