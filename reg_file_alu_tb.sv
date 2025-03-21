`timescale 1ps/1ps
`include "reg_file_alu.sv"

module reg_file_alu_tb;
logic [3:0] RA1,RA2,WA;
logic [7:0] immediate;
logic [1:0] ALUControl;
logic write_enable, ALUSrc, CLK;
logic [7:0] ALUResult,cpu_out;
logic Zero;

reg_file_alu dut (RA1,RA2,WA,immediate,ALUControl,write_enable, ALUSrc, CLK,ALUResult,cpu_out,Zero);

initial begin
    CLK = 0;
    forever begin
        #10 CLK = ~CLK;
    end
end

initial begin
    $dumpfile("reg_file_alu_tb.vcd");
    $dumpvars(0,reg_file_alu_tb);
    
    #10 WA = 0;write_enable = 1;immediate = 2;
    #10 ALUControl = 2'b10;

    for (int i = 0; i <= 15; i = i + 1) begin
        #10 ALUSrc = 1;
        #10 RA1 = i;RA2 = i;
        #10 WA = WA + 1;
    end

    RA1 = 7; RA2 = 8;
    #30;
    ALUControl = 2'b00;
    #30; 
    ALUControl = 2'b01;
    #30;
    ALUControl = 2'b10;
    #30;
    ALUControl = 2'b11;

    $finish;
end

initial begin
    $monitor("Time = %3d, ALUResult = %d, Zero = %b, cpu_out = %d",$time,ALUResult,Zero,cpu_out);
end


endmodule