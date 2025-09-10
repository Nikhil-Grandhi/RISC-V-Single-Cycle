module dmem (
    input clk,
    input [31:0] A,
    input [31:0] WD,
    input WE,
    output logic [31:0] RD,
    output logic [31:0] single_mem
);

reg [31:0] mem [0:511];

always @(posedge clk) begin
    if (WE) begin
        mem[A[31:2]] <= WD;
    end
end

assign RD = mem[A[31:2]];
assign single_mem = mem[0];

endmodule