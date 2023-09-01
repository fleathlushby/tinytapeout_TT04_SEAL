`default_nettype none

module tt_um_parallel_adder #(parameter MAX_COUNT=1000) (
    input wire [2:0] A,
    input wire [2:0] B,
    input wire Cin,
    input wire clk, rst,
    output reg [2:0] Sum,
    output reg Cout
);

wire [2:0] sum_bits;
wire [1:0] carry;
wire c_out;
reg [9:0] count;

fulladder fa0 (.A(A[0]), .B(B[0]), .Cin(Cin), .Sum(sum_bits[0]), .Cout(carry[0]));
fulladder fa1 (.A(A[1]), .B(B[1]), .Cin(carry[0]), .Sum(sum_bits[1]), .Cout(carry[1]));
fulladder fa2 (.A(A[2]), .B(B[2]), .Cin(carry[1]), .Sum(sum_bits[2]), .Cout(c_out));

always @ (posedge clk) begin
  if (!rst) begin
    Sum <= 3'd0;
    Cout <= 1'd0;
    count <= 10'd0;
  end else begin
      if (count <= MAX_COUNT) begin
        count <= count + 1;
        Sum <= sum_bits;
        Cout <= c_out;
      end else if (count == MAX_COUNT) begin
        count <= 10'd0;
        Sum <= 3'd0;
        Cout <= 1'd0;
      end
  end
end

endmodule
