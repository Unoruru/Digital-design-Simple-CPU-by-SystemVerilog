module control_unit (input logic [3:0] opcode,
                     output logic [1:0] ALUControl,
                     output logic Branch, ALUSrc, RegWrite);

    always_comb begin

        case (opcode)
            4'b0000: begin RegWrite = 1 ;ALUSrc = 0 ;ALUControl = 2'b00 ;Branch = 0 ; end //and
            4'b0001: begin RegWrite = 1 ;ALUSrc = 0 ;ALUControl = 2'b01 ;Branch = 0 ; end//or
            4'b0010: begin RegWrite = 1 ;ALUSrc = 0 ;ALUControl = 2'b10 ;Branch = 0 ; end//add
            4'b0011: begin RegWrite = 1 ;ALUSrc = 0 ;ALUControl = 2'b11 ;Branch = 0 ; end//sub
            4'b0100: begin RegWrite = 1 ;ALUSrc = 1 ;ALUControl = 2'b00 ;Branch = 0 ; end//andi
            4'b0101: begin RegWrite = 1 ;ALUSrc = 1 ;ALUControl = 2'b01 ;Branch = 0 ; end//ori
            4'b0110: begin RegWrite = 1 ;ALUSrc = 1 ;ALUControl = 2'b10 ;Branch = 0 ; end//addi
            4'b0111: begin RegWrite = 0 ;ALUSrc = 0 ;ALUControl = 2'b11 ;Branch = 1 ; end//beq
            default: begin RegWrite = 1'bx ;ALUSrc = 1'bx ;ALUControl = 2'bxx ;Branch = 1'bx ;end
        endcase
        
    end

endmodule