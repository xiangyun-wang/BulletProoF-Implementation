
vlib work

;# Compile components if any
vcom SHA3_Absorb.vhd
vcom SHA3_Function.vhd
vcom SHA3_tb.vhd


;# Start simulation
vsim SHA3_tb

;# Generate a clock with 1ns period
force -deposit clk 0 0 ns, 1 0.5 ns -repeat 1 ns

proc AddWaves {} {
	;#Add waves we're interested in to the Wave window
    add wave -position end sim:/SHA3_tb/clk
		add wave -position end sim:/SHA3_tb/data_ready
		add wave -position end sim:/SHA3_tb/more_data
		add wave -position end sim:/SHA3_tb/rst
		add wave -position end sim:/SHA3_tb/configuration_in
		add wave -position end sim:/SHA3_tb/data_request
		add wave -position end sim:/SHA3_tb/hash_out
		add wave -position end sim:/SHA3_tb/message_out_checker
		add wave -position end sim:/SHA3_tb/round_constant_checker
		add wave -position end sim:/SHA3_tb/absorb_debug

}

;# Add the waves
AddWaves
;# Run for 100 ns
run 100ns
