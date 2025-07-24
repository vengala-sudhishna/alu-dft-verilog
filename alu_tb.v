`timescale 1ns/1ps
module alu_tb;
    reg [3:0] A, B;
    reg [2:0] opcode;
    reg SE, SI;
    wire [3:0] result;
    wire zero_flag;
    wire SO;

    scan_alu uut (
        .A(A), .B(B), .opcode(opcode),
        .SE(SE), .SI(SI),
        .result(result), .zero_flag(zero_flag),
        .SO(SO)
    );

    initial begin
        $dumpfile("wave.vcd");
        $dumpvars(0, alu_tb);

        A = 4'b0101; B = 4'b0011; opcode = 3'b000; SE = 0; SI = 0;
        #10;
        opcode = 3'b001; #10;
        opcode = 3'b010; #10;
        opcode = 3'b011; #10;
        opcode = 3'b100; #10;
        opcode = 3'b101; #10;

        SE = 1; SI = 1; #10;
        SI = 0; #10;
        SI = 1; #10;
        SI = 1; #10;

        SE = 0; opcode = 3'b000; #10;

        $finish;
    end
endmodule
