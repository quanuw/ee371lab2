`include "arriveAndDepartSignal.v"
module arriveAndDepartSignal_tb();
	wire arriveSignal;
	wire departSignal;
	wire arriveSwitch;
	wire departSwitch;
	wire clk;
	wire rst;

	arriveAndDepartSignal signal(.arriveSignal,
								 .departSignal,
								 .arriveSwitch,
								 .departSwitch,
								 .clk,
								 .rst);

	arriveAndDepartSignal_tester tester(.arriveSignal,
										.departSignal,
										.arriveSwitch,
										.departSwitch,
										.clk,
										.rst);

	initial begin
		$dumpfile("arriveAndDepartSignal_tb.vcd");
		$dumpvars;
	end
endmodule

module arriveAndDepartSignal_tester(input arriveSignal,
									input departSignal,
									output reg arriveSwitch,
									output reg departSwitch,
									output reg clk,
						 			output reg rst);

	parameter CLOCK_PERIOD = 2; //gtkwave simulates in seconds
	initial begin
		clk=0;
		forever #(CLOCK_PERIOD / 2) clk = ~clk;
	end
	initial begin
		#10;
		$display("\t\t rst \t clk \t\t arriveSignal \t departSignal \t    time");
		$monitor("\t\t %b \t %b \t\t %b \t\t %b", rst, clk, arriveSignal,
				departSignal, $time);
	end

	initial begin
		// Active low rst:
		// rst with rst = 0 and keep it
		// one for the rest of the time.
		#2 rst <= 1'b1 ; 		@(posedge clk);
		#2 rst <= 1'b0 ; 		@(posedge clk);
		#2 rst <= 1'b1 ; 		@(posedge clk);
		#2 arriveSwitch <= 1;   @(posedge clk);
		#2 arriveSwitch <= 0;	@(posedge clk);
								@(posedge clk);
								@(posedge clk);
								@(posedge clk);
								@(posedge clk);

		 // ascend once then descend once
		$finish;
	end
endmodule
