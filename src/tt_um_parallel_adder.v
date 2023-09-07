`default_nettype none

module tt_um_parallel_adder #(parameter MAX_COUNT=1000) (
    input wire [7:0] ui_in,
    output wire [7:0] uo_out,
    input  wire [7:0] uio_in,
    output wire [7:0] uio_out,
    output wire [7:0] uio_oe,
    input wire clk,
    input wire rst_n,
    input wire ena
);

wire reset = ! rst_n;
wire [2:0] sum_bits;
reg [2:0] Sum;
reg Cout;
wire [1:0] carry;
wire c_out;
assign uo_out[2:0] = Sum;
assign uo_out[7:3] = 5'b00000;
assign uio_oe = 8'b11111111;   // use bidirectionals as outputs
assign uio_out[0] = Cout;
assign uio_out[7:1] = 7'b0000000;
reg [9:0] count;

always @ (posedge clk) begin
    if (reset) begin
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

// instantiate adder
fulladder fa0 (.A(ui_in[4]), .B(ui_in[1]), .Cin(ui_in[0]), .Sum(sum_bits[0]), .Cout(carry[0]));
fulladder fa1 (.A(ui_in[5]), .B(ui_in[2]), .Cin(carry[0]), .Sum(sum_bits[1]), .Cout(carry[1]));
fulladder fa2 (.A(ui_in[6]), .B(ui_in[3]), .Cin(carry[1]), .Sum(sum_bits[2]), .Cout(c_out));
    
endmodule
