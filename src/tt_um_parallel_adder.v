module parallel_adder (
    input [7:0] A,
    input [7:0] B,
    input Cin,
    output reg [7:0] Sum,
    output reg Cout
);

wire [7:0] sum_bits;
wire [7:0] carry;
wire c_out;

fulladder fa0 (.A(A[0]), .B(B[0]), .Cin(Cin), .Sum(sum_bits[0]), .Cout(carry[0]));
fulladder fa1 (.A(A[1]), .B(B[1]), .Cin(carry[0]), .Sum(sum_bits[1]), .Cout(carry[1]));
fulladder fa2 (.A(A[2]), .B(B[2]), .Cin(carry[1]), .Sum(sum_bits[2]), .Cout(carry[2]));
fulladder fa3 (.A(A[3]), .B(B[3]), .Cin(carry[2]), .Sum(sum_bits[3]), .Cout(carry[3]));
fulladder fa4 (.A(A[4]), .B(B[4]), .Cin(carry[3]), .Sum(sum_bits[4]), .Cout(carry[4]));
fulladder fa5 (.A(A[5]), .B(B[5]), .Cin(carry[4]), .Sum(sum_bits[5]), .Cout(carry[5]));
fulladder fa6 (.A(A[6]), .B(B[6]), .Cin(carry[5]), .Sum(sum_bits[6]), .Cout(carry[6]));
fulladder fa7 (.A(A[7]), .B(B[7]), .Cin(carry[6]), .Sum(sum_bits[7]), .Cout(c_out));

always @ (*) begin
    Sum <= sum_bits;
    Cout <= c_out;
end

endmodule