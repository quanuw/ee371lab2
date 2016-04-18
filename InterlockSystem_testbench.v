`include "InterlockSystem.v"
`include "InterlockSystem_tester.v"

module InterlockSystem_testbench();

	wire Clock;
	wire [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	wire [9:0] LEDR;
	wire [3:0] KEY; // True when not pressed, False when pressed
	wire [9:0] SW;
	
	// Calls the 1 bit counter tester module 
	// Notice that the output Clock, Reset, Increase of the tester module are wires Clock, Reset, Increase in this module
	InterlockSystem_tester t(.Clock(Clock), .SW0(SW[0]), .SW1(SW[1]), .SW2(SW[2]), .SW3(SW[3]), .Key0(KEY[0]), .Key1(KEY[1]), .Key2(KEY[2]));
	
	// Calls the 1 bit counter module as the device under test (dut)
	// Notice that the Clock, Reset, and Increase are wired to the input of the 1 bit counter module  
	InterlockSystem dut(.CLOCK_50(Clock), .HEX0(HEX0), .HEX1(HEX1), .HEX2(HEX2), .HEX3(HEX3), .HEX4(HEX4), .HEX5(HEX5), .KEY(KEY), .LEDR(LEDR), .SW(SW));
	
	// Dumps the results of the simulation into a .vcd file for view in GTKWave
	initial begin 
		$dumpfile("InterlockSystem.vcd");
		$dumpvars(0, InterlockSystem_testbench);
		#150;
		$finish;
	end 
	
endmodule 