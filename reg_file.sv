module reg_file (input logic [3:0] RA1,RA2,WA,
                 input logic [7:0] ALUResult,
                 input logic write_enable,CLK,
                 output logic [7:0] RD1,RD2,cpu_out);
    
    logic [7:0] rf [0:15];
    assign RD1 = rf[RA1];
    assign RD2 = rf[RA2];

    always_comb begin
        rf[0] = 8'b0;
    end
    
    always_ff @( posedge CLK ) begin
        if (write_enable && WA > 0) begin
            rf[WA] <= ALUResult;
        end

        cpu_out <= rf[15];
    end

endmodule