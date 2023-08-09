# Clock 
set_property PACKAGE_PIN W5 [get_ports {CLK}] 
set_property IOSTANDARD LVCMOS33 [get_ports {CLK}] 
# active low reset 
set_property PACKAGE_PIN V17 [get_ports {rst_n}] 
set_property IOSTANDARD LVCMOS33 [get_ports {rst_n}]
# Clock out
set_property PACKAGE_PIN U16 [get_ports {CLK_out}]
set_property IOSTANDARD LVCMOS33 [get_ports {CLK_out}]