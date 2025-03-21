`timescale 1ps/1ps
`include "cpu.sv"

module cpu_tb;
logic CLK, reset;
logic [7:0] ALUResult, cpu_out;

cpu dut (CLK,reset,ALUResult,cpu_out);

initial begin
    CLK = 0;
    forever begin
        #10 CLK = ~CLK;
    end
end

initial begin
    $dumpfile("cpu_tb.vcd");
    $dumpvars(0,cpu_tb);    

    reset = 1;
    #10
    #10 reset = 0;
    #510


    $finish;
end

initial begin
    $monitor("time = %3d, ALUResult = %d, cpu_out = %d", $time, ALUResult, cpu_out);
end


endmodule