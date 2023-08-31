import cocotb
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge, FallingEdge, Timer, ClockCycles

input_A = [0,1,2,3,4,5,6,7,5,6]
input_B = [7,6,5,4,3,2,1,0,5,7]
input_Cin = 0

@cocotb.test()
async def test_rca(dut):
    dut._log.info("start")
    clock = Clock(dut.clk, 10, units="us")
    cocotb.start_soon(clock.start())

    dut._log.info("reset")
    dut.rst.value = 1
    await ClockCycles(dut.clk, 10)
    dut.rst.value = 0

    dut._log.info("check 10 inputs")
    for i in range(10):
        dut._log.info("check input {}".format(i))
        await ClockCycles(dut.clk, 1000)
        assert int(dut.A.value) == input_A[i]
        assert int(dut.B.value) == input_B[i]
        assert int(dut.Cin.value) == input_Cin
