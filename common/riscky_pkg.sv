package riscky_pkg;

// RV64I
parameter int ILEN = 32; // instruction length
parameter int XLEN = 64; // register length

// Instruction
parameter int IMEM_WORDS = 4096;               // number of instructions
parameter int IMEM_AW    = $clog2(IMEM_WORDS); // address width

endpackage