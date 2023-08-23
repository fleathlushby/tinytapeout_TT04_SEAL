module tt_um_parallel_adder #( parameter MAX_COUNT = 8 ) (
    input  wire [MAX_COUNT-1:0] ui_in1,    // Dedicated inputs A
    input  wire [MAX_COUNT-1:0] ui_in2,    // Dedicated inputs B
    input  wire ui_in3,    // Dedicated input Cin
    output wire [MAX_COUNT-1:0] uo_out1,   // Dedicated outputs Sum
    output wire uo_out2   // Dedicated output Cout
    // input  wire [MAX_COUNT-1:0] uio_in,   // IOs: Input path
    // output wire [MAX_COUNT-1:0] uio_out,  // IOs: Output path
    // output wire [MAX_COUNT-1:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    // input  wire       ena,      // will go high when the design is enabled
    // input  wire       clk,      // clock
    // input  wire       rst_n     // reset_n - low to reset
);

wire [7:0] sum_bits;
wire [6:0] carry;
wire c_out;

    fulladder fa0 (.A(ui_in1[0]), .B(ui_in2[0]), .Cin(ui_in3), .Sum(sum_bits[0]), .Cout(carry[0]));
genvar i;
generate
      for (i=1; i < 7; i=i+1)
      begin
            fulladder fa (.A(ui_in1[i]), .B(ui_in2[i]), .Cin(carry[i-1]), .Sum(sum_bits[i]), .Cout(carry[i]));
      end
   endgenerate
fulladder fa7 (.A(ui_in1[7]), .B(ui_in2[7]), .Cin(carry[6]), .Sum(sum_bits[7]), .Cout(c_out));

always @ (*) begin
    uo_out1 <= sum_bits;
    uo_out2 <= c_out;
end

endmodule
