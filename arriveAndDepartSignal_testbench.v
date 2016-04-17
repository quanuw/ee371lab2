`include "arriveAndDepartSignal.v"
`include "arriveAndDepartSignal_tester.v"

module arriveAndDepartSignal_testbench();

	wire Clock, Reset, Increase;
	wire Count;
	
	// Calls the 1 bit counter tester module 
	// Notice that the output Clock, Reset, Increase of the tester module are wires Clock, Reset, Increase in this module
	Counter_1bit_tester t(.Clock(Clock), .Reset(Reset), .Increase(Increase));
	
	// Calls the 1 bit counter module as the device under test (dut)
	// Notice that the Clock, Reset, and Increase are wired to the input of the 1 bit counter module  
	Counter_1bit dut(.Clock(Clock), .Reset(Reset), .Increase(Increase), .Count(Count));
	
	// Dumps the results of the simulation into a .vcd file for view in GTKWave
	initial begin 
		$dumpfile("Counter_1bit.vcd");
		$dumpvars(0, Counter_1bit_testbench);
		#150;
		$finish;
	end 
	
endmodule 