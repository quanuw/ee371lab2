`include "counter.v"
`include "counter_tester.v"

module counter_testbench();

	wire Clock, Reset, Start;
	wire Signal;
	
	// Calls the 1 bit counter tester module 
	// Notice that the output Clock, Reset, Increase of the tester module are wires Clock, Reset, Increase in this module
	counter_tester t(.Clock(Clock), .Reset(Reset), .Start(Start));
	
	// Calls the 1 bit counter module as the device under test (dut)
	// Notice that the Clock, Reset, and Increase are wired to the input of the 1 bit counter module  
	counter dut(.clk(Clock), .reset(Reset), .counterSeconds(10'b0000001010), .start(Start), .signal(Signal));
	
	// Dumps the results of the simulation into a .vcd file for view in GTKWave
	initial begin 
		$dumpfile("counter.vcd");
		$dumpvars(0, counter_testbench);
		#150;
		$finish;
	end 
	
endmodule 