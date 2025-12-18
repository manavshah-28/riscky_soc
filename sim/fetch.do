# ----------------------------------
# Clean and create library
# ----------------------------------
if {[file exists work]} {
    vdel -lib work -all
}
vlib work

# ----------------------------------
# Compile
# ----------------------------------
vlog -sv -work work ../common/riscky_pkg.sv
vlog -sv -work work ../src/mux.sv
vlog -sv -work work ../src/instr_mem.sv
vlog -sv -work work ../src/pc.sv
vlog -sv -work work ../src/adder.sv
vlog -sv -work work ../src/fetch.sv
vlog -sv -work work ../tests/fetch_tb.sv


# ----------------------------------
# Simulate
# ----------------------------------
vsim work.fetch_tb

run -all
quit
