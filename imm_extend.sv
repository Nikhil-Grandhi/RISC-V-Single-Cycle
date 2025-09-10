module extend (
    input [31:7] op,
    input [1:0] imm_src,
    output logic [31:0] imm_extend
);

always @(*) begin
    case(imm_src)
        2'b00: imm_extend = {{20{op[31]}}, op[31:20]};
        2'b01: imm_extend = {{20{op[31]}}, op[31:25], op[11:7]};
        2'b10: imm_extend = {{20{op[31]}}, op[7], op[30:25], op[11:8], 1'b0};
        2'b11: imm_extend = {{12{op[31]}}, op[19:12], op[20], op[30:21], 1'b0};
    endcase
end

endmodule