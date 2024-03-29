# Clock 
set_property PACKAGE_PIN W5 [get_ports {CLK}] 
set_property IOSTANDARD LVCMOS33 [get_ports {CLK}] 
# active low reset 
set_property PACKAGE_PIN V17 [get_ports {rst_n}] 
set_property IOSTANDARD LVCMOS33 [get_ports {rst_n}]
#output
set_property PACKAGE_PIN V19 [get_ports {b[3]}] 
set_property IOSTANDARD LVCMOS33 [get_ports {b[3]}]
set_property PACKAGE_PIN U19 [get_ports {b[2]}] 
set_property IOSTANDARD LVCMOS33 [get_ports {b[2]}]
set_property PACKAGE_PIN E19 [get_ports {b[1]}] 
set_property IOSTANDARD LVCMOS33 [get_ports {b[1]}]
set_property PACKAGE_PIN U16 [get_ports {b[0]}] 
set_property IOSTANDARD LVCMOS33 [get_ports {b[0]}]
