module reg_file (
    input [4:0] rd_1,
    input [4:0] rd_2,
    input [4:0] wr,
    input [31:0] wr_data,
    input clk,
    input we,
    input reset,
    output logic [31:0] rd_data_1,
    output logic [31:0] rd_data_2
);

    reg [31:0] registers [0:31];
    integer i;

    always @(posedge clk or posedge reset) 
    begin
        if (reset) 
        begin
            for (i = 0; i < 32; i = i + 1) 
            begin
                registers[i] <= 32'd0;
            end
        end 
        else if (we && (wr != 5'd0)) 
        begin
            registers[wr] <= wr_data;
        end
    end

    assign rd_data_1 = (rd_1 == 5'b0) ? 32'b0 : registers[rd_1];
    assign rd_data_2 = (rd_2 == 5'b0) ? 32'b0 : registers[rd_2];

endmodule