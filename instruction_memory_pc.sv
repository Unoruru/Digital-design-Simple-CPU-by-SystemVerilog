`include "instruction_memory.sv"
`include "pc.sv"

module instruction_memory_pc (input logic [7:0] immediate,
                              input logic PCSrc, CLK, reset, 
                              output logic [23:0] Instr);

    logic [7:0] PC;

    pc pc_in (immediate,PCSrc, CLK, reset,PC);

    instruction_memory instruction_memory_in (PC,Instr);

    
endmodule