`include "reg_file_alu.sv"
`include "instruction_memory_pc.sv"
`include "control_unit.sv"

module cpu (input logic CLK, reset, 
            output logic [7:0] ALUResult, cpu_out);

    logic [3:0] RA1, RA2, WA, opcode;
    logic [7:0] immediate;
    logic [1:0] ALUControl;
    logic write_enable, ALUSrc, Zero, PCSrc, Branch, RegWrite;
    logic [23:0] Instr;

    assign immediate = Instr[7:0];
    assign RA2 = Instr[11:8];
    assign RA1 = Instr[15:12];
    assign WA = Instr[19:16];
    assign opcode = Instr[23:20];

    assign write_enable = RegWrite;

    assign PCSrc = Branch & Zero;

    reg_file_alu reg_file_alu_in (RA1,RA2,WA,immediate,ALUControl,write_enable, ALUSrc, CLK,ALUResult,cpu_out,Zero);
    instruction_memory_pc instruction_memory_pc_in (immediate,PCSrc, CLK, reset,Instr);
    control_unit control_unit_in (opcode,ALUControl,Branch, ALUSrc, RegWrite);


    
endmodule