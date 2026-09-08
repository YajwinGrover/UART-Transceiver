# URBANA BOARD CONSTRAINTS V2I1 1/3/2023 
# clk input is from the 100 MHz oscillator on Urbana board
create_clock -period 10.000 -name gclk [get_ports clk]
set_property -dict {PACKAGE_PIN N15 IOSTANDARD LVCMOS33} [get_ports {clk}]

# Set Bank 0 voltage
set_property CFGBVS VCCO [current_design]
set_property CONFIG_VOLTAGE 3.3 [current_design]
set_property BITSTREAM.Config.SPI_buswidth 4 [current_design]

# UART signals
set_property -dict {PACKAGE_PIN B16 IOSTANDARD LVCMOS33} [get_ports {rx_pin}]
set_property -dict {PACKAGE_PIN A16 IOSTANDARD LVCMOS33} [get_ports {tx_pin}]

#LED 
set_property -dict {PACKAGE_PIN C13 IOSTANDARD LVCMOS33} [get_ports {rx_done}]

#Pushbutton 0
set_property -dict {PACKAGE_PIN J2 IOSTANDARD LVCMOS25} [get_ports {rst}]
#Pushbutton 1
set_property -dict {PACKAGE_PIN J1 IOSTANDARD LVCMOS25} [get_ports {send_data}]

#Slide switch 
set_property -dict {PACKAGE_PIN G1 IOSTANDARD LVCMOS25} [get_ports {data_out[0]}]
set_property -dict {PACKAGE_PIN F2 IOSTANDARD LVCMOS25} [get_ports {data_out[1]}]
set_property -dict {PACKAGE_PIN F1 IOSTANDARD LVCMOS25} [get_ports {data_out[2]}]
set_property -dict {PACKAGE_PIN E2 IOSTANDARD LVCMOS25} [get_ports {data_out[3]}]
set_property -dict {PACKAGE_PIN E1 IOSTANDARD LVCMOS25} [get_ports {data_out[4]}]
set_property -dict {PACKAGE_PIN D2 IOSTANDARD LVCMOS25} [get_ports {data_out[5]}]
set_property -dict {PACKAGE_PIN D1 IOSTANDARD LVCMOS25} [get_ports {data_out[6]}]
set_property -dict {PACKAGE_PIN C2 IOSTANDARD LVCMOS25} [get_ports {data_out[7]}]

#Data out display
set_property -dict {PACKAGE_PIN G6 IOSTANDARD LVCMOS25} [get_ports {d0_anode[0]}];  # Active LOW
set_property -dict {PACKAGE_PIN H6 IOSTANDARD LVCMOS25} [get_ports {d0_anode[1]}];  # Active LOW
set_property -dict {PACKAGE_PIN C3 IOSTANDARD LVCMOS25} [get_ports {d0_anode[2]}];  # Active LOW
set_property -dict {PACKAGE_PIN B3 IOSTANDARD LVCMOS25} [get_ports {d0_anode[3]}];  # Active LOW
set_property -dict {PACKAGE_PIN E6 IOSTANDARD LVCMOS25} [get_ports {data_out_display[0]}];  # CA Active LOW
set_property -dict {PACKAGE_PIN B4 IOSTANDARD LVCMOS25} [get_ports {data_out_display[1]}];  # CB Active LOW
set_property -dict {PACKAGE_PIN D5 IOSTANDARD LVCMOS25} [get_ports {data_out_display[2]}];  # CC Active LOW
set_property -dict {PACKAGE_PIN C5 IOSTANDARD LVCMOS25} [get_ports {data_out_display[3]}];  # CD Active LOW
set_property -dict {PACKAGE_PIN D7 IOSTANDARD LVCMOS25} [get_ports {data_out_display[4]}];  # CE Active LOW
set_property -dict {PACKAGE_PIN D6 IOSTANDARD LVCMOS25} [get_ports {data_out_display[5]}];  # CF Active LOW
set_property -dict {PACKAGE_PIN C4 IOSTANDARD LVCMOS25} [get_ports {data_out_display[6]}];  # CG Active LOW
set_property -dict {PACKAGE_PIN B5 IOSTANDARD LVCMOS25} [get_ports {data_out_display[7]}];  # CDP Active LOW


set_property BITSTREAM.CONFIG.UNUSEDPIN PULLUP [current_design]
set_property BITSTREAM.GENERAL.COMPRESS TRUE [current_design]


