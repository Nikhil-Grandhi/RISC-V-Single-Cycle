module alu_dec (
    input [1:0] ALU_op,
    input [2:0] funct3,
    input funct7,
    input op5,
    output logic [2:0] alu_control
);

always @(*) begin
    case (ALU_op)
        2'b00: alu_control = 3'b000;
        2'b01: alu_control = 3'b001;
        2'b10: begin
            casez ({funct3, op5, funct7})
                5'b00000: alu_control = 3'b000;
                5'b00001: alu_control = 3'b000;
                5'b00010: alu_control = 3'b000;
                5'b00011: alu_control = 3'b001;
                5'b010zz: alu_control = 3'b101;
                5'b110zz: alu_control = 3'b011;
                5'b111zz: alu_control = 3'b010;
                default: alu_control = 3'b111;
            endcase
        end
        default: alu_control = 3'b000;
    endcase
end

endmodule