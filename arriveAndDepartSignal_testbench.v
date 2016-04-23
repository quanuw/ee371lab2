`include "arriveAndDepartSignal.v"
`include "arriveAndDepartSignal_tester.v"

module arriveAndDepartSignal_testbench();

	wire clk, rst, arriveSwitch, departSwitch, arriveSignal, departSignal;
	
	// Calls the arriveAndDepartSignal tester module 
	arriveAndDepartSignal_tester t(.clk(clk), .rst(rst), .arriveSwitch(arriveSwitch),
                             .departSwitch(departSwitch));
	
	// Calls the arriveAndDepartSignal module as the device under test (dut 
	arriveAndDepartSignal dut(.arriveSignal(arriveSignal), .departSignal(departSignal), .arriveSwitch(arriveSwitch),
                             .departSwitch(departSwitch), .clk(clk), .rst(rst));
	
	// Dumps the results of the simulation into a .vcd file for view in GTKWave
	initial begin 
		$dumpfile("arriveAndDepartSignal.vcd");
		$dumpvars(0, arriveAndDepartSignal_testbench);
		#150;
		$finish;
	end 
	
endmodule
	
