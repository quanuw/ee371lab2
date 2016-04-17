`include "FillandPressurize.v"
`include "FillandPressurize_tester.v"

module FillandPressurize_testbench();

	wire Clock, Reset, InnerClosed, begin_FandP, OuterClosed, Pressurized;
	wire FandP;
	
	// Calls the 1 bit counter tester module 
	// Notice that the output Clock, Reset, Increase of the tester module are wires Clock, Reset, Increase in this module
	FillandPressurize_tester t(.Clock(Clock), .Reset(Reset), .begin_FandP(begin_FandP), .InnerClosed(InnerClosed), .OuterClosed(OuterClosed), .Pressurized(Pressurized));
	
	// Calls the 1 bit counter module as the device under test (dut)
	// Notice that the Clock, Reset, and Increase are wired to the input of the 1 bit counter module  
	FillandPressurize dut(.Clock(Clock), .Reset(Reset), .begin_FandP(begin_FandP), .InnerClosed(InnerClosed), .OuterClosed(OuterClosed), .Pressurized(Pressurized), .FandP(FandP));
	
	// Dumps the results of the simulation into a .vcd file for view in GTKWave
	initial begin 
		$dumpfile("FillandPressurize.vcd");
		$dumpvars(0, FillandPressurize_testbench);
		#150;
		$finish;
	end 
	
endmodule 