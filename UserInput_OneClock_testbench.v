`include "UserInput_OneClock_tester.v"
`include "UserInput_OneClock.v"

// This module is the testbench that will save the results of the simulation for viewing in GTKWave 
module UserInput_OneClock_testbench();
	wire clk, rst, in;
	wire out;
	
	// Calls the 4 bit ripple down counter tester module 
	// Notice that the output clock and reset of the tester module are wires clk and rst in this module
	UserInput_OneClock_tester t(.clk(clk), .rst(rst), .in(in));
	
	// Calls the RippleDownCounter_4bit module as the device under test (dut)
	// Notice that the clock and reset wire are wired to the input clk and rst of the 4 bit ripple down counter module  
	UserInput_OneClock dut(.Clock(clk), .Reset(rst), .in(in), .out(out));
	
	// Dumps the results of the simulation into a .vcd file for view in GTKWave
	initial begin 
		$dumpfile("UserInput_OneClock.vcd");
		$dumpvars(0, UserInput_OneClock_testbench);
		#150;
		$finish;
	end 

endmodule
