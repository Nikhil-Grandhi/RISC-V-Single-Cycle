module alu (
    input [31:0] a,
    input [31:0] b,
    input [2:0] alu_control,
    output logic [31:0] result,
    output logic zero
);

always @(*) begin
    case (alu_control)
        3'b000: result = a + b;
        3'b001: result = a - b;
        3'b010: result = a & b;
        3'b011: result = a | b;
        3'b101: result = ($signed(a) < $signed(b)) ? 1 : 0;
        default: result = 32'b0;
    endcase
end

assign zero = (result == 32'b0);

endmodule