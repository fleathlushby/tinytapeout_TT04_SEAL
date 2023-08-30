import cocotb
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge, FallingEdge, Timer, ClockCycles


@cocotb.test()
async def rca_adder(dut):
    dut._log.info("start")
    clock = Clock(dut.clk, 10, units="us")
    cocotb.start_soon(clock.start())

    # reset
    dut._log.info("reset")
    dut.rst.value = 1
    # set the compare value
    dut.A.value = 7
    dut.B.value = 5
    dut.Cin.value = 0
    await ClockCycles(dut.clk, 10)
    dut.rst.value = 0

    # the compare value is shifted 10 bits inside the design to allow slower counting
    # max_count = dut.ui_in.value << 10
    # dut._log.info(f"check all segments with MAX_COUNT set to {max_count}")
    # check all segments and roll over
    # for i in range(15):
    #     dut._log.info("check segment {}".format(i))
    #     await ClockCycles(dut.clk, max_count)
    #     assert int(dut.segments.value) == segments[i % 10]

        # all bidirectionals are set to output
        # assert dut.uio_oe == 0xFF

    # reset
    dut.rst.value = 1
    # set a different compare value
    dut.A.value = 3
    dut.B.value = 6
    dut.Cin.value = 1
    await ClockCycles(dut.clk, 10)
    dut.rst.value = 0

    # max_count = dut.ui_in.value << 10
    # dut._log.info(f"check all segments with MAX_COUNT set to {max_count}")
    # check all segments and roll over
    # for i in range(15):
    #     dut._log.info("check segment {}".format(i))
    #     await ClockCycles(dut.clk, max_count)
    #     assert int(dut.segments.value) == segments[i % 10]

