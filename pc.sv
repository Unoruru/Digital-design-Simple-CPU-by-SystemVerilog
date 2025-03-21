module pc (input logic [7:0] immediate,
           input logic PCSrc, CLK, reset,
           output logic [7:0] PC);

    logic [7:0] PC_temp;
    
    always_comb begin

        if (PCSrc) begin
            PC_temp = immediate;
        end

        else begin
            PC_temp = PC + 8'b01;
        end            
        
    end


    always_ff @( posedge CLK ) begin

        if (reset) begin    
            PC <= 0;
        end 
        else begin
            PC <= PC_temp;
        end
            
    end

    
endmodule