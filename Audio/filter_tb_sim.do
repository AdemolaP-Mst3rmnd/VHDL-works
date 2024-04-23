onbreak resume
onerror resume
vsim -voptargs=+acc work.filter_tb
add wave sim:/filter_tb/u_filterDesigner/clk
add wave sim:/filter_tb/u_filterDesigner/clk_enable
add wave sim:/filter_tb/u_filterDesigner/reset
add wave sim:/filter_tb/u_filterDesigner/filter_in
add wave sim:/filter_tb/u_filterDesigner/filter_out
add wave sim:/filter_tb/filter_out_ref
run -all
