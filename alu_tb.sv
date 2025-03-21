`timescale 1ps/1ps
`include "alu.sv"

module alu_tb;
logic [7:0] SrcA,SrcB,ALUResult;
logic [1:0] ALUControl;
logic Zero;

alu dut (SrcA,SrcB,ALUControl,ALUResult,Zero);

initial begin
    $dumpfile("alu_tb.vcd");
    $dumpvars(0,alu_tb);

    SrcA = 5;SrcB = 3;
    #10;
    ALUControl = 2'b00;
    #10; 
    ALUControl = 2'b01;
    #10;
    ALUControl = 2'b10;
    #10;
    ALUControl = 2'b11;
    #10;
    $finish;
end

initial begin
    $monitor("time = %3d, A = %d, B = %d, Zero = %b, ALUResult = %b",$time,SrcA,SrcB,Zero,ALUResult);
end

endmodule