`timescale 1ns/1ps
module alu_tb;

  // DUT signals
  reg clk, reset;
  reg scan_enable, scan_in;
  reg [3:0] A, B;
  reg [2:0] opcode;
  wire [3:0] result;
  wire zero_flag;
  wire scan_out;

  // DUT instance
  scan_alu uut (
    .clk(clk),
    .reset(reset),
    .scan_in(scan_in),
    .scan_enable(scan_enable),
    .A(A),
    .B(B),
    .opcode(opcode),
    .result(result),
    .zero_flag(zero_flag),
    .scan_out(scan_out)
  );

  // Clock generation
  always #5 clk = ~clk;

  initial begin
    $dumpfile("wave.vcd");
    $dumpvars(0, alu_tb);

    // Initialization
    clk = 0;
    reset = 1;
    scan_enable = 0;
    scan_in = 0;
    A = 4'b0000;
    B = 4'b0000;
    opcode = 3'b000;

    // Release reset
    #10 reset = 0;

    // 1. Normal ALU mode test (A + B)
    A = 4'b0011;      // 3
    B = 4'b0001;      // 1
    opcode = 3'b000;  // ADD
    #20;

    // 2. Enter scan mode: shift in 8 bits = {A = 4'b1010, B = 4'b0101}
    scan_enable = 1;
    // Bits to shift: 1010_0101 (A = 1010, B = 0101)
    // MSB first: scan_in = 1,0,1,0,0,1,0,1
    scan_in = 1; #10;
    scan_in = 0; #10;
    scan_in = 1; #10;
    scan_in = 0; #10;
    scan_in = 0; #10;
    scan_in = 1; #10;
    scan_in = 0; #10;
    scan_in = 1; #10;
    scan_enable = 0;

    // 3. Use scan chain A/B, opcode = 001 (A - B)
    opcode = 3'b001;
    #20;

    // 4. Try another opcode, OR
    opcode = 3'b011;
    #20;

    // Finish simulation
    $finish;
  end

endmodule
