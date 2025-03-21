`timescale 1ps/1ps
`include "instruction_memory_pc.sv"

module instruction_memory_pc_tb;

logic [7:0] immediate;
logic PCSrc, CLK, reset; 
logic [23:0] Instr;

instruction_memory_pc dut (immediate, PCSrc, CLK, reset, Instr);

initial begin
    CLK = 0;
    forever begin
        #10 CLK = ~CLK;
    end
end

initial begin
    $dumpfile("instruction_memory_pc_tb.vcd");
    $dumpvars(0,instruction_memory_pc_tb);

    reset = 0;immediate = 8'h00;
    PCSrc = 1;
    #10 
    #10 PCSrc = 0;
    #10
    #10
    #10 
    #10 
    #10 
    #10
    #10 
    #10 
    #10
    #10
    #10
    #10
    #10 PCSrc = 1;immediate = 8'h03;
    #10
    #10 PCSrc = 0;
    #10
    #10
    #10
    #10
    #10
    #10
    #10


    $finish;
end

initial begin
    $monitor("time = %3d, PCSrc = %d , immediate = %h, Instr = %h",$time, PCSrc, immediate, Instr);
end

endmodule