module alu (
  input [3:0] A, B,
  input [2:0] opcode,
  output reg [3:0] result,
  output reg zero_flag
);
  always @(*) begin
    case (opcode)
      3'b000: result = A + B;
      3'b001: result = A - B;
      3'b010: result = A & B;
      3'b011: result = A | B;
      3'b100: result = A ^ B;
      3'b101: result = ~A;
      3'b110: result = A << 1;
      3'b111: result = A >> 1;
      default: result = 4'b0000;
    endcase

    // Proper zero flag assignment
    zero_flag = (result == 4'b0000);
  end
endmodule
