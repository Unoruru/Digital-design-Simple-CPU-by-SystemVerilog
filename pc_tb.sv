`timescale 1ps/1ps
`include "pc.sv"

module pc_tb;
logic [7:0] immediate;
logic PCSrc, CLK, reset;
logic [7:0] PC;

pc dut (immediate, PCSrc ,CLK ,reset ,PC);

initial begin
    CLK = 0;
    forever begin
        #10 CLK = ~CLK;
    end
end

initial begin
    $dumpfile("pc_tb.vcd");
    $dumpvars(0,pc_tb);

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
    #10 PCSrc = 1;immediate = 8'h05;
    #10 PCSrc = 0;
    #10
    #10
    #10
    #10
    #10
    $finish;

end

initial begin
    $monitor("time = %3d, PCSrc = %b, immediate = %d, PC = %h", $time, PCSrc, immediate, PC);
end

endmodule