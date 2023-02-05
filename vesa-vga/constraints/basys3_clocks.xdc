# Identify the external 100MHz clock provided by the DSC1033CC1-100.0000T
# oscillator
create_clock \
  -add \
  -name clk_ext \
  -period 10.00 \
  -waveform {0 5} \
  [get_ports clk_ext_pad]

