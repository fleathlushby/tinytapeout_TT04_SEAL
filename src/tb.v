`default_nettype none
`timescale 1ns/1ps

/*
this testbench just instantiates the module and makes some convenient wires
that can be driven / tested by the cocotb test.py
*/

// testbench is controlled by test.py
module tb ();

    // this part dumps the trace to a vcd file that can be viewed with GTKWave
    initial begin
        $dumpfile ("tb.vcd");
        $dumpvars (0, tb);
        #1;
    end

    // wire up the inputs and outputs
    wire  clk;
    wire  rst;
    //reg  ena;
    wire  [2:0] A;
    wire  [2:0] B;
    wire  Cin;
    
    wire [2:0] Sum;
    wire Cout;

    `ifdef GL_TEST
    tt_um_parallel_adder tt_um_parallel_adder (
    // include power ports for the Gate Level test
        .VPWR( 1'b1),
        .VGND( 1'b0)
    )
    `else
    tt_um_parallel_adder #(.MAX_COUNT(1000)) tt_um_parallel_adder (
    `endif
        .A      (A),    
        .B     (B),   
        .Cin     (Cin),  
        .Sum    (Sum),  
        .Cout     (Cout),
        .clk     (clk),
        .rst    (rst)
        );

endmodule
