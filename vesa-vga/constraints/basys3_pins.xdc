# External 100MHz crystal oscillator
set_property PACKAGE_PIN W5  [get_ports clk_ext_pad]

# User LED
set_property PACKAGE_PIN U16 [get_ports user_led_pad[0] ]
set_property PACKAGE_PIN E19 [get_ports user_led_pad[1] ]
set_property PACKAGE_PIN U19 [get_ports user_led_pad[2] ]
set_property PACKAGE_PIN V19 [get_ports user_led_pad[3] ]
set_property PACKAGE_PIN W18 [get_ports user_led_pad[4] ]
set_property PACKAGE_PIN U15 [get_ports user_led_pad[5] ]
set_property PACKAGE_PIN U14 [get_ports user_led_pad[6] ]
set_property PACKAGE_PIN V14 [get_ports user_led_pad[7] ]
set_property PACKAGE_PIN V13 [get_ports user_led_pad[8] ]
set_property PACKAGE_PIN V3  [get_ports user_led_pad[9] ]
set_property PACKAGE_PIN W3  [get_ports user_led_pad[10]]
set_property PACKAGE_PIN U3  [get_ports user_led_pad[11]]
set_property PACKAGE_PIN P3  [get_ports user_led_pad[12]]
set_property PACKAGE_PIN N3  [get_ports user_led_pad[13]]
set_property PACKAGE_PIN P1  [get_ports user_led_pad[14]]
set_property PACKAGE_PIN L1  [get_ports user_led_pad[15]]

# Onboard VGA display connector (J1)
set_property PACKAGE_PIN G19 [get_ports vga_red_pad[0]]
set_property PACKAGE_PIN H19 [get_ports vga_red_pad[1]]
set_property PACKAGE_PIN J19 [get_ports vga_red_pad[2]]
set_property PACKAGE_PIN N19 [get_ports vga_red_pad[3]]

set_property PACKAGE_PIN J17 [get_ports vga_green_pad[0]]
set_property PACKAGE_PIN H17 [get_ports vga_green_pad[1]]
set_property PACKAGE_PIN G17 [get_ports vga_green_pad[2]]
set_property PACKAGE_PIN D17 [get_ports vga_green_pad[3]]

set_property PACKAGE_PIN N18 [get_ports vga_blue_pad[0]]
set_property PACKAGE_PIN L18 [get_ports vga_blue_pad[1]]
set_property PACKAGE_PIN K18 [get_ports vga_blue_pad[2]]
set_property PACKAGE_PIN J18 [get_ports vga_blue_pad[3]]

set_property PACKAGE_PIN P19 [get_ports vga_hsync_pad]
set_property PACKAGE_PIN R19 [get_ports vga_vsync_pad]
