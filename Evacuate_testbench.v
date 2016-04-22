`include "Evacuate.v"
`include "Evacuate_tester.v"

module Evacuate_testbench();

	wire Clock, Reset, InnerClosed, begin_Evacuation, OuterClosed, Pressurized, Evacuated;
	wire Evacuation, Depressurize;
	
	// Calls the 1 bit counter tester module 
	// Notice that the output Clock, Reset, Increase of the tester module are wires Clock, Reset, Increase in this module
	Evacuate_tester t(.Clock(Clock), .Reset(Reset), .begin_Evacuation(begin_Evacuation), .InnerClosed(InnerClosed), .OuterClosed(OuterClosed), .Pressurized(Pressurized), .Evacuated(Evacuated));
	
	// Calls the 1 bit counter module as the device under test (dut)
	// Notice that the Clock, Reset, and Increase are wired to the input of the 1 bit counter module  
	Evacuate dut(.Clock(Clock), .Reset(Reset), .begin_Evacuation(begin_Evacuation), .InnerClosed(InnerClosed), .OuterClosed(OuterClosed), .Pressurized(Pressurized), .Evacuated(Evacuated), .Depressurize(Depressurize), .Evacuation(Evacuation));
	
	// Dumps the results of the simulation into a .vcd file for view in GTKWave
	initial begin 
		$dumpfile("Evacuate.vcd");
		$dumpvars(0, Evacuate_testbench);
		#150;
		$finish;
	end 
	
endmodule 