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
vlog -sv -work work ../src/register_file.sv
vlog -sv -work work ../tests/reg_file_tb.sv

# ----------------------------------
# Simulate
# ----------------------------------
vsim work.reg_file_tb

run -all
quit
