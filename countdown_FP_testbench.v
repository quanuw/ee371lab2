`include "countdown_FP.v"
`include "countdown_FP_tester.v"

module countdown_FP_testbench();

	wire Clock, Reset, countdown;
	wire pressurized;
	
	// Calls the 1 bit counter tester module 
	// Notice that the output Clock, Reset, Increase of the tester module are wires Clock, Reset, Increase in this module
	countdown_FP_tester t(.Clock(Clock), .Reset(Reset), .countdown(countdown));
	
	// Calls the 1 bit counter module as the device under test (dut)
	// Notice that the Clock, Reset, and Increase are wired to the input of the 1 bit counter module  
	countdown_FP dut(.Clock(Clock), .Reset(Reset), .countdown(countdown), .pressurized(pressurized));
	
	// Dumps the results of the simulation into a .vcd file for view in GTKWave
	initial begin 
		$dumpfile("countdown_FP.vcd");
		$dumpvars(0, countdown_FP_testbench);
		#150;
		$finish;
	end 
	
endmodule 