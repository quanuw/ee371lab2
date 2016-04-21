`include "OCPort.v"
`include "OCPort_tester.v"

module OCPort_testbench();

	wire Clock, Reset, SwitchFlip;
	wire OpenClose;
	
	// Calls the 1 bit counter tester module 
	// Notice that the output Clock, Reset, Increase of the tester module are wires Clock, Reset, Increase in this module
	OCPort_tester t(.Clock(Clock), .Reset(Reset), .SwitchFlip(SwitchFlip));
	
	// Calls the 1 bit counter module as the device under test (dut)
	// Notice that the Clock, Reset, and Increase are wired to the input of the 1 bit counter module  
	OCPort dut(.Clock(Clock), .Reset(Reset), .SwitchFlip(SwitchFlip), .OpenClose(OpenClose));
	
	// Dumps the results of the simulation into a .vcd file for view in GTKWave
	initial begin 
		$dumpfile("OCPort.vcd");
		$dumpvars(0, OCPort_testbench);
		#150;
		$finish;
	end 
	
endmodule 