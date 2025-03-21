`include "alu.sv"
`include "reg_file.sv"

module reg_file_alu (input logic [3:0] RA1,RA2,WA,
                     input logic [7:0] immediate,
                     input logic [1:0] ALUControl,
                     input logic write_enable, ALUSrc, CLK,
                     output logic [7:0] ALUResult,cpu_out,
                     output logic Zero);

    logic [7:0] SrcA,SrcB,RD1,RD2;

    alu alu_in (SrcA,SrcB,ALUControl,ALUResult,Zero);

    reg_file reg_file_in (RA1,RA2,WA,ALUResult,write_enable,CLK,RD1,RD2,cpu_out);

    always_comb begin

        SrcA = RD1;

        if (ALUSrc) begin
            SrcB = immediate;
        end
        else begin
            SrcB = RD2; 
        end
    end

endmodule