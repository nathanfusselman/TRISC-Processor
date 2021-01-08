onerror {quit -f}
vlib work
vlog -work work TRISCPROCESSOR.vo
vlog -work work TRISCPROCESSOR.vt
vsim -novopt -c -t 1ps -L cycloneii_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate work.TRISCPROCESSOR_vlg_vec_tst
vcd file -direction TRISCPROCESSOR.msim.vcd
vcd add -internal TRISCPROCESSOR_vlg_vec_tst/*
vcd add -internal TRISCPROCESSOR_vlg_vec_tst/i1/*
add wave /*
run -all
