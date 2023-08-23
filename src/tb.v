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
    reg  [7:0] ui_in1;
    reg  [7:0] ui_in2;
    reg  ui_in3;
    
    wire [7:0] uo_out1;
    wire uo_out2;

    tt_um_parallel_adder tt_um_parallel_adder (
    // include power ports for the Gate Level test
    `ifdef GL_TEST
        .VPWR( 1'b1),
        .VGND( 1'b0),
    `endif
        .ui_in1      (ui_in1),    
        .ui_in2     (ui_in2),   
        .ui_in3     (ui_in3),  
        .uo_out1    (uo_out1),  
        .uo_out2     (uo_out2)
        );

endmodule
