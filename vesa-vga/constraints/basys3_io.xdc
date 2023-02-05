# External 100MHz crystal oscillator
set_property IOSTANDARD LVCMOS33 [get_ports clk_ext_pad]

# Onboard LED  (LD0 - LD15)
set_property IOSTANDARD LVCMOS33 [get_ports user_led_pad[0] ]
set_property IOSTANDARD LVCMOS33 [get_ports user_led_pad[1] ]
set_property IOSTANDARD LVCMOS33 [get_ports user_led_pad[2] ]
set_property IOSTANDARD LVCMOS33 [get_ports user_led_pad[3] ]
set_property IOSTANDARD LVCMOS33 [get_ports user_led_pad[4] ]
set_property IOSTANDARD LVCMOS33 [get_ports user_led_pad[5] ]
set_property IOSTANDARD LVCMOS33 [get_ports user_led_pad[6] ]
set_property IOSTANDARD LVCMOS33 [get_ports user_led_pad[7] ]
set_property IOSTANDARD LVCMOS33 [get_ports user_led_pad[8] ]
set_property IOSTANDARD LVCMOS33 [get_ports user_led_pad[9] ]
set_property IOSTANDARD LVCMOS33 [get_ports user_led_pad[10]]
set_property IOSTANDARD LVCMOS33 [get_ports user_led_pad[11]]
set_property IOSTANDARD LVCMOS33 [get_ports user_led_pad[12]]
set_property IOSTANDARD LVCMOS33 [get_ports user_led_pad[13]]
set_property IOSTANDARD LVCMOS33 [get_ports user_led_pad[14]]
set_property IOSTANDARD LVCMOS33 [get_ports user_led_pad[15]]

# Onboard VGA display signals (J1)
set_property IOSTANDARD LVCMOS33 [get_ports vga_red_pad[0]]
set_property IOSTANDARD LVCMOS33 [get_ports vga_red_pad[1]]
set_property IOSTANDARD LVCMOS33 [get_ports vga_red_pad[2]]
set_property IOSTANDARD LVCMOS33 [get_ports vga_red_pad[3]]

set_property IOSTANDARD LVCMOS33 [get_ports vga_green_pad[0]]
set_property IOSTANDARD LVCMOS33 [get_ports vga_green_pad[1]]
set_property IOSTANDARD LVCMOS33 [get_ports vga_green_pad[2]]
set_property IOSTANDARD LVCMOS33 [get_ports vga_green_pad[3]]

set_property IOSTANDARD LVCMOS33 [get_ports vga_blue_pad[0]]
set_property IOSTANDARD LVCMOS33 [get_ports vga_blue_pad[1]]
set_property IOSTANDARD LVCMOS33 [get_ports vga_blue_pad[2]]
set_property IOSTANDARD LVCMOS33 [get_ports vga_blue_pad[3]]

set_property IOSTANDARD LVCMOS33 [get_ports vga_hsync_pad]
set_property IOSTANDARD LVCMOS33 [get_ports vga_vsync_pad]

