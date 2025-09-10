module main_dec (
    input [6:0] opcode,
    input zero,
    output logic [1:0] alu_op,
    output logic reg_write,
    output logic mem_write,
    output logic [1:0] Imm_src,
    output logic [1:0] Result_src,
    output logic alu_src,
    output logic branch,
    output logic jump
);

always @(*) begin
    case (opcode)
    7'b0000011: begin
        alu_op = 2'b00;
        reg_write = 1'b1;
        mem_write = 1'b0;
        Imm_src = 2'b00;
        branch = 1'b0;
        Result_src = 2'b01;
        alu_src = 1'b1;
        jump = 1'b0;
    end
    7'b0100011: begin
        alu_op = 2'b00;
        reg_write = 1'b0;
        mem_write = 1'b1;
        Imm_src = 2'b01;
        branch = 1'b0;
        Result_src = 2'b00;
        alu_src = 1'b1;
        jump = 1'b0;
    end
    7'b0110011: begin
        alu_op = 2'b10;
        reg_write = 1'b1;
        mem_write = 1'b0;
        Imm_src = 2'b00;
        branch = 1'b0;
        Result_src = 2'b00;
        alu_src = 1'b0;
        jump = 1'b0;
    end
    7'b1100011: begin
        alu_op = 2'b01;
        reg_write = 1'b0;
        mem_write = 1'b0;
        Imm_src = 2'b10;
        branch = 1'b1;
        Result_src = 2'b00;
        alu_src = 1'b0;
        jump = 1'b0;
    end
    7'b0010011: begin
        alu_op = 2'b10;
        reg_write = 1'b1;
        mem_write = 1'b0;
        Imm_src = 2'b00;
        branch = 1'b0;
        Result_src = 2'b00;
        alu_src = 1'b1;
        jump = 1'b0;
    end
    7'b1101111: begin
        alu_op = 2'b00;
        reg_write = 1'b1;
        mem_write = 1'b0;
        Imm_src = 2'b11;
        branch = 1'b0;
        Result_src = 2'b10;
        alu_src = 1'b0;
        jump = 1'b1;
    end
    default: begin
        alu_op = 2'b00;
        reg_write = 1'b0;
        mem_write = 1'b0;
        Imm_src = 2'b00;
        branch = 1'b0;
        Result_src = 2'b00;
        alu_src = 1'b0;
        jump = 1'b0;
    end
    endcase
end

endmodule