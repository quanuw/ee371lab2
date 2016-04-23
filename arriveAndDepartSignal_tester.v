module arriveAndDepartSignal_tester(clk, rst, arriveSwitch, departSwitch);
	output reg clk, rst, arriveSwitch, departSwitch;
	
	// Set up the clock.
	parameter CLOCK_PERIOD=2;
	initial clk=1;
	always begin
		#(CLOCK_PERIOD/2);
		clk = ~clk;
	end
	
	// Set up the inputs to the design. Each line is a clock cycle.
	initial begin
		departSwitch <= 0; arriveSwitch <= 0;
		@(posedge clk);
		rst <= 1;	
		@(posedge clk);			
		rst <= 0;					
		@(posedge clk);
		rst <= 1;						
		@(posedge clk);
		arriveSwitch <= 1;			
		@(posedge clk);
		departSwitch <= 1;	
		@(posedge clk);
		arriveSwitch <= 0;
		@(posedge clk);
		departSwitch <= 0;
		@(posedge clk);
	end
endmodule