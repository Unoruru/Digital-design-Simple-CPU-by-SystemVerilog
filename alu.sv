module alu (input logic [7:0] SrcA,SrcB,
            input logic [1:0] ALUControl,
            output logic [7:0] ALUResult,
            output logic Zero);
    always_comb begin

        case(ALUControl)
        2'b00: ALUResult = SrcA & SrcB;
        2'b01: ALUResult = SrcA | SrcB;
        2'b10: ALUResult = SrcA + SrcB;
        2'b11: ALUResult = SrcA - SrcB;
        default: ALUResult = 8'bx;
        endcase

        if(ALUResult == 0) begin
            Zero = 1;
        end
        else begin
            Zero = 0;
        end
    end

  
endmodule