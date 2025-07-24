module scan_alu (
    input [3:0] A, B,
    input [2:0] opcode,
    input SE, SI,
    output [3:0] result,
    output zero_flag,
    output SO
);
    reg [3:0] scan_reg;

    always @ (posedge SE) begin
        scan_reg <= {scan_reg[2:0], SI};
    end

    assign SO = scan_reg[3];
    wire [3:0] A_int = SE ? scan_reg : A;
    wire [3:0] B_int = SE ? 4'b0000 : B;

    alu uut (
        .A(A_int),
        .B(B_int),
        .opcode(opcode),
        .result(result),
        .zero_flag(zero_flag)
    );
endmodule
