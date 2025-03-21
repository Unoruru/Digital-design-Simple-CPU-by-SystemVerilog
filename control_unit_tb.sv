`timescale 1ps/1ps
`include "control_unit.sv"

module control_unit_tb;
logic [3:0] opcode;
logic [1:0] ALUControl;
logic Branch, ALUSrc, RegWrite;

control_unit dut (opcode,ALUControl,Branch,ALUSrc,RegWrite);

initial begin
    $dumpfile("control_unit_tb.vcd");
    $dumpvars(0,control_unit_tb);

    #10 opcode = 4'b0000; 
    #10 opcode = 4'b0001;
    #10 opcode = 4'b0010;
    #10 opcode = 4'b0011;
    #10 opcode = 4'b0100;
    #10 opcode = 4'b0101;
    #10 opcode = 4'b0110;
    #10 opcode = 4'b0111;

    $finish;

end

initial begin
    $monitor("time = %3d, opcode = %b,ALUControl =%b ,Branch = %b,ALUSrc = %b,RegWrite = %b",$time,opcode,ALUControl,Branch,ALUSrc,RegWrite);
end

endmodule