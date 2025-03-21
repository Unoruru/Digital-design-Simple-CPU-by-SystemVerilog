`timescale 1ps/1ps
`include "reg_file.sv"

module reg_file_tb;
logic [3:0] RA1,RA2,WA;
logic [7:0] ALUResult,RD1,RD2,cpu_out;
logic write_enable,CLK;  

reg_file dut (RA1,RA2,WA,ALUResult,write_enable,CLK,RD1,RD2,cpu_out);

initial begin
    CLK = 0;
    forever begin
        #10 CLK = ~CLK;
    end
end

initial begin
    $dumpfile("reg_file_tb.vcd");
    $dumpvars(0,reg_file_tb);
    
    ALUResult = 5;WA = 0;write_enable = 1;
    for (int i = 0;i <= 15;i = i + 1 ) begin
        #10 WA = WA + 1;
        #10 ALUResult = ALUResult + 2;
        RA1 =WA-1;RA2 = WA;
    end
    
    RA1 = 1; RA2 = 2; WA = 0; ALUResult = 5; write_enable = 0; 
    #15 write_enable = 1;
    #20 WA = 1; ALUResult = 7;
    #20 WA = 5; ALUResult = 13;
    #20 WA = 15; ALUResult = 30;
    #20 write_enable = 0;
    #20 WA = 5; ALUResult = 11;
    #20 RA2 = 5;RA1 = 8;
    #30 write_enable = 1;
    #15 WA = 15; ALUResult = 23;
    #20 WA = 4; ALUResult=24;
    #20 RA1 = 4; RA2 = 15;

    $finish;
end

initial begin
    $monitor("time=%3d, write_enable = %b, RD1 = %d, RD2 = %d,cpu_out = %d",$time,write_enable,RD1,RD2,cpu_out);
end
    
endmodule