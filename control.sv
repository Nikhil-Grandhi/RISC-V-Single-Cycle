module control (
    input [6:0] opcode,
    input [2:0] funct3,
    input funct7,
    input zero,
    output logic reg_write,
    output logic [1:0] imm_src,
    output logic alu_src,
    output logic [2:0] alu_control,
    output logic [1:0] result_src,
    output logic pc_src,
    output logic mem_write
);

wire [1:0] alu_op;
wire branch, jump;

// Main Decoder
main_dec md (
    .opcode(opcode),
    .zero(zero),
    .alu_op(alu_op),
    .reg_write(reg_write),
    .mem_write(mem_write),
    .Imm_src(imm_src),
    .Result_src(result_src),
    .alu_src(alu_src),
    .branch(branch),
    .jump(jump)
);

assign pc_src = (branch & zero) | jump;

// ALU Decoder

alu_dec ad (
    .ALU_op(alu_op),
    .funct3(funct3),
    .funct7(funct7),
    .op5(opcode[5]),
    .alu_control(alu_control)
);

endmodule