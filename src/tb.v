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
    reg  [7:0] ui_in;
    reg  [7:0] uio_in;
    reg  uio_oe;
    
    wire [7:0] uo_out;
    wire uio_out;

    tt_um_parallel_adder tt_um_parallel_adder (
    // include power ports for the Gate Level test
    `ifdef GL_TEST
        .VPWR( 1'b1),
        .VGND( 1'b0),
    `endif
        .ui_in      (ui_in),    
        .uio_in     (uio_in),   
        .uio_oe     (uio_oe),  
        .uo_out    (uo_out),  
        .uio_out     (uio_out)
        );

endmodule
