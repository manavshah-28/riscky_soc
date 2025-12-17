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
vlog -sv -work work ../tests/mux_tb.sv

# ----------------------------------
# Simulate
# ----------------------------------
vsim work.mux_tb

run -all
quit
