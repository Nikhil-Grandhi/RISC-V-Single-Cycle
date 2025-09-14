module top (
    input logic clk,
    input logic reset
);

wire [31:0] pc_out, instr_out, dmem_read_data;
wire [31:0] dmem_write_data, dmem_write_addr, result;
wire reg_write, alu_src, pc_src, mem_write;

wire [1:0] imm_src, result_src;
wire [2:0] alu_control;
wire zero_flag;

// Control Unit
control control_unit (
    .opcode(instr_out[6:0]),
    .funct3(instr_out[14:12]),
    .funct7(instr_out[30]),
    .zero(zero_flag),
    .reg_write(reg_write),
    .imm_src(imm_src),
    .alu_src(alu_src),
    .alu_control(alu_control),
    .result_src(result_src),
    .pc_src(pc_src),
    .mem_write(mem_write)
);

// Datapath
datapath dp (
    .clk(clk),
    .reset(reset),
    .instr(instr_out),
    .Read_data(dmem_read_data),
    .reg_write(reg_write),
    .imm_src(imm_src),
    .alu_src(alu_src),
    .alu_control(alu_control),
    .Result_src(result_src),
    .pc_src(pc_src),
    .zero(zero_flag),
    .prog_counter(pc_out),
    .WriteData(dmem_write_data),
    .WriteAddr(dmem_write_addr),
    .result(result)
);

// Instruction Memory
imem instruction_memory (
    .PC(pc_out),
    .instruction(instr_out)
);

// Data Memory
dmem data_memory (
    .clk(clk),
    .A(dmem_write_addr),
    .WD(dmem_write_data),
    .WE(mem_write),
    .RD(dmem_read_data),
    .single_mem(out_temp)
);

endmodule
