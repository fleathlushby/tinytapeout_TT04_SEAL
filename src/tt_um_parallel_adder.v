module tt_um_parallel_adder (
    input wire [2:0] A,
    input wire [2:0] B,
    input wire Cin,
    input wire clk, rst,
    output wire [2:0] Sum,
    output wire Cout
);

wire [2:0] sum_bits;
wire [1:0] carry;
wire c_out;

fulladder fa0 (.A(A[0]), .B(B[0]), .Cin(Cin), .Sum(sum_bits[0]), .Cout(carry[0]));
fulladder fa1 (.A(A[1]), .B(B[1]), .Cin(carry[0]), .Sum(sum_bits[1]), .Cout(carry[1]));
fulladder fa2 (.A(A[2]), .B(B[2]), .Cin(carry[1]), .Sum(sum_bits[2]), .Cout(c_out));

always @ (posedge clk) begin
  if (!rst) begin
    Sum <= 3'd0;
    Cout <= 1'd0;
  end else begin
    Sum <= sum_bits;
    Cout <= c_out;
  end
end

endmodule
