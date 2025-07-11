# MIPS Processor Constraint File
# Adjust pin assignments according to your target FPGA board

## Clock signal (100MHz)
set_property PACKAGE_PIN W5 [get_ports clk]
set_property IOSTANDARD LVCMOS33 [get_ports clk]
create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports clk]

## Reset signal
set_property PACKAGE_PIN U18 [get_ports reset]
set_property IOSTANDARD LVCMOS33 [get_ports reset]

## LEDs for output display
set_property PACKAGE_PIN U16 [get_ports {result[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {result[0]}]
set_property PACKAGE_PIN E19 [get_ports {result[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {result[1]}]
set_property PACKAGE_PIN U19 [get_ports {result[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {result[2]}]
set_property PACKAGE_PIN V19 [get_ports {result[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {result[3]}]

## Switches for input
set_property PACKAGE_PIN V17 [get_ports {input[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {input[0]}]
set_property PACKAGE_PIN V16 [get_ports {input[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {input[1]}]
set_property PACKAGE_PIN W16 [get_ports {input[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {input[2]}]
set_property PACKAGE_PIN W17 [get_ports {input[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {input[3]}]

## Timing constraints
set_input_delay -clock [get_clocks sys_clk_pin] -min -add_delay 2.000 [get_ports {input[*]}]
set_input_delay -clock [get_clocks sys_clk_pin] -max -add_delay 4.000 [get_ports {input[*]}]
set_output_delay -clock [get_clocks sys_clk_pin] -min -add_delay 2.000 [get_ports {result[*]}]
set_output_delay -clock [get_clocks sys_clk_pin] -max -add_delay 4.000 [get_ports {result[*]}]
