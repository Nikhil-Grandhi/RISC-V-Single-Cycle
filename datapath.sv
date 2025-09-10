module datapath (
    input clk, reset,
    input [31:0] instr,
    input reg_write,
    input [1:0] imm_src,
    input alu_src,
    input [2:0] alu_control,
    input [1:0] Result_src,
    input pc_src,
    input [31:0] Read_data,
    output logic zero,
    output logic [31:0] prog_counter,
    output logic [31:0] WriteData, WriteAddr,
    output logic [31:0] result
);

wire [31:0] pc_next, pc_4, pc_target;
wire [31:0] ImmExt, SrcA, SrcB, read_2, ALU_result;

// PC Logic
reset_ff #(32) pc_reg (
    .clk(clk),
    .rst(reset),
    .d(pc_next),
    .q(prog_counter)
);

assign pc_4 = prog_counter + 4;
assign pc_target = prog_counter + ImmExt;

mux_2 #(32) pc_mux (
    .in0(pc_4),
    .in1(pc_target),
    .sel(pc_src),
    .out(pc_next)
);

// Register File
reg_file regfile (
    .rd_1(instr[19:15]),
    .rd_2(instr[24:20]),
    .wr(instr[11:7]),
    .wr_data(result),
    .clk(clk),
    .we(reg_write),
    .rd_data_1(SrcA),
    .rd_data_2(read_2),
    .reset(reset)
);

extend imm_extend (
    .op(instr[31:7]),
    .imm_src(imm_src),
    .imm_extend(ImmExt)
);

// ALU Logic
mux_2 #(32) alu_src_mux (
    .in0(read_2),
    .in1(ImmExt),
    .sel(alu_src),
    .out(SrcB)
);
alu alu (
    .a(SrcA),
    .b(SrcB),
    .alu_control(alu_control),
    .result(ALU_result),
    .zero(zero)
);

// Result Logic
mux_3 result_mux (
    .in0(ALU_result),
    .in1(Read_data),
    .in2(pc_4),
    .sel(Result_src),
    .out(result)
);

assign WriteData = read_2;

assign WriteAddr = ALU_result;

endmodule