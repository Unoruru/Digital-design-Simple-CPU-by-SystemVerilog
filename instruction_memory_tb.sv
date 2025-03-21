`timescale 1ps/1ps
`include "instruction_memory.sv"

module instruction_memory_tb;
logic [7:0] PC;
logic [23:0] Instr;

instruction_memory dut (PC,Instr);

initial begin
    $dumpfile("instruction_memory_tb.vcd");
    $dumpvars(0,instruction_memory_tb);

    PC = 8'h00;
    #10 PC = 8'h01;
    #10 PC = 8'h02;
    #10 PC = 8'h03;
    #10 PC = 8'h04;
    #10 PC = 8'h05;
    #10 PC = 8'h06;
    #10 PC = 8'h07;

    $finish;
end

initial begin
    $monitor("time = %3d, PC = %d, Instr = %h",$time,PC,Instr);
end

    
endmodule