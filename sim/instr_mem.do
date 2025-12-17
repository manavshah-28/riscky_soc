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
vlog -sv -work work ../src/instr_mem.sv
vlog -sv -work work ../tests/instr_mem_tb.sv

# ----------------------------------
# Simulate
# ----------------------------------
vsim work.instr_mem_tb

run -all
quit
