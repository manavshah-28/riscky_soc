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
vlog -sv -work work ../src/register_file.sv
vlog -sv -work work ../src/extender.sv
vlog -sv -work work ../src/control.sv
vlog -sv -work work ../src/decode.sv
vlog -sv -work work ../tests/decode_tb.sv



# ----------------------------------
# Simulate
# ----------------------------------
vsim work.decode_tb
vcd file waves.vcd
vcd add -r /*

run -all
quit
