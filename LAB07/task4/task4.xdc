# Clock
set_property PACKAGE_PIN W5 [get_ports {clk}]
set_property IOSTANDARD LVCMOS33 [get_ports {clk}]

# active low reset
set_property PACKAGE_PIN V17 [get_ports {rst_n}]
set_property IOSTANDARD LVCMOS33 [get_ports {rst_n}]
# Pmod I2S 
set_property PACKAGE_PIN A14 [get_ports {audio_mclk}]
set_property IOSTANDARD LVCMOS33 [get_ports {audio_mclk}]
set_property PACKAGE_PIN A16 [get_ports {audio_lrck}]
set_property IOSTANDARD LVCMOS33 [get_ports {audio_lrck}]
set_property PACKAGE_PIN B15 [get_ports {audio_sck}]
set_property IOSTANDARD LVCMOS33 [get_ports {audio_sck}]
set_property PACKAGE_PIN B16 [get_ports {audio_sdin}]
set_property IOSTANDARD LVCMOS33 [get_ports {audio_sdin}]

set_property PACKAGE_PIN W19 [get_ports {C}]
set_property IOSTANDARD LVCMOS33 [get_ports {C}]
set_property PACKAGE_PIN U18 [get_ports {D}]
set_property IOSTANDARD LVCMOS33 [get_ports {D}]
set_property PACKAGE_PIN T17 [get_ports {E}]
set_property IOSTANDARD LVCMOS33 [get_ports {E}]
set_property PACKAGE_PIN U17 [get_ports {F}]
set_property IOSTANDARD LVCMOS33 [get_ports {F}]
set_property PACKAGE_PIN T18 [get_ports {G}]
set_property IOSTANDARD LVCMOS33 [get_ports {G}]

set_property PACKAGE_PIN R2 [get_ports {switch}]
set_property IOSTANDARD LVCMOS33 [get_ports {switch}]