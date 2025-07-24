module scan_alu (
  input clk,
  input reset,              // NEW: added reset for proper initialization
  input scan_in,
  input scan_enable,
  input [3:0] A, B,
  input [2:0] opcode,
  output [3:0] result,
  output zero_flag,
  output scan_out
);
  reg [7:0] scan_chain;

  // Scan chain shift register with reset
  always @(posedge clk or posedge reset) begin
    if (reset)
      scan_chain <= 8'b0;
    else if (scan_enable)
      scan_chain <= {scan_chain[6:0], scan_in};
  end

  // Extract A and B from scan chain during scan mode
  wire [3:0] scan_A = scan_chain[7:4];
  wire [3:0] scan_B = scan_chain[3:0];

  // ALU instance
  alu u1 (
    .A(scan_enable ? scan_A : A),
    .B(scan_enable ? scan_B : B),
    .opcode(opcode),
    .result(result),
    .zero_flag(zero_flag)
  );

  assign scan_out = scan_chain[7];  // MSB of scan chain

endmodule
