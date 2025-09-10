module imem (
    input [31:0] PC,
    output logic [31:0] instruction
);

    reg [31:0] mem [0:63];

    initial begin
       $readmemh("imem.mem", mem);
    end

    always @(*) begin
        instruction = mem[PC[31:2]];
    end

endmodule