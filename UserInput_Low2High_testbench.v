`include "UserInput_Low2High.v"
`include "UserInput_Low2High_tester.v"

// This module is the testbench that will save the results of the simulation for viewing in GTKWave 
module UserInput_Low2High_testbench();
	wire clk, rst, in;
	wire out;
	
	// Calls the 4 bit ripple down counter tester module 
	// Notice that the output clock and reset of the tester module are wires clk and rst in this module
	UserInput_Low2High_tester t(.clk(clk), .rst(rst), .in(in));
	
	// Calls the RippleDownCounter_4bit module as the device under test (dut)
	// Notice that the clock and reset wire are wired to the input clk and rst of the 4 bit ripple down counter module  
	UserInput_Low2High dut(.Clock(clk), .Reset(rst), .in(in), .out(out));
	
	// Dumps the results of the simulation into a .vcd file for view in GTKWave
	initial begin 
		$dumpfile("UserInput_Low2High.vcd");
		$dumpvars(0, UserInput_Low2High_testbench);
		#150;
		$finish;
	end 

endmodule
