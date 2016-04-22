`include "EVState.v"
`include "EVState_tester.v"

module EVState_testbench();

	wire Clock, Reset, Increase;
	wire Count;
	
	// Calls the 1 bit counter tester module 
	// Notice that the output Clock, Reset, Increase of the tester module are wires Clock, Reset, Increase in this module
	EVState_tester t(.Clock(Clock), .Reset(Reset), .Increase(Increase));
	
	// Calls the 1 bit counter module as the device under test (dut)
	// Notice that the Clock, Reset, and Increase are wired to the input of the 1 bit counter module  
	EVState dut(.Clock(Clock), .Reset(Reset), .Increase(Increase), .Count(Count));
	
	// Dumps the results of the simulation into a .vcd file for view in GTKWave
	initial begin 
		$dumpfile("EVState.vcd");
		$dumpvars(0, EVState_testbench);
		#150;
		$finish;
	end 
	
endmodule 