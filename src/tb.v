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
    //reg  clk;
    //reg  rst_n;
    //reg  ena;
    reg  [7:0] A;
    reg  [7:0] B;
    reg  Cin;
    
    wire [7:0] Sum;
    wire Cout;

    tt_um_parallel_adder dut (
    // include power ports for the Gate Level test
    `ifdef GL_TEST
        .VPWR( 1'b1),
        .VGND( 1'b0),
    `endif
        .A      (A),    
        .B     (B),   
        .Cin     (Cin),  
        .Sum    (Sum),  
        .Cout     (Cout)
        );

endmodule
