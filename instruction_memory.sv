module instruction_memory (input logic [7:0] PC, 
                           output logic [23:0] Instr); 

logic [24:0] data_ROM [0:255]; 

initial begin
    $readmemh("program.txt", data_ROM);
end

assign Instr = data_ROM[PC]; 

endmodule