module counter_tester(Clock, Reset, Start);
	output reg Clock, Reset, Start;
	
	// Set up the clock.
	parameter CLOCK_PERIOD=2;
	initial Clock=1;
	always begin
		#(CLOCK_PERIOD/2);
		Clock = ~Clock;
	end
	
	// Set up the inputs to the design. Each line is a clock cycle.
	initial begin
		Reset <= 0;					@(posedge Clock);			
										@(posedge Clock);
		Reset <= 1;					@(posedge Clock);
										@(posedge Clock);
		Reset <= 0;					@(posedge Clock);	
		Start <= 0;					@(posedge Clock);
		Start <= 1;					@(posedge Clock);
										@(posedge Clock);
		Start <= 0;					@(posedge Clock);
										@(posedge Clock);
										@(posedge Clock);
										@(posedge Clock);
										@(posedge Clock);
										@(posedge Clock);
										@(posedge Clock);
										@(posedge Clock);
										@(posedge Clock);
										@(posedge Clock);
										@(posedge Clock);
										@(posedge Clock);
										@(posedge Clock);	
										@(posedge Clock);
										@(posedge Clock);
										@(posedge Clock);
										@(posedge Clock);
										@(posedge Clock);
										@(posedge Clock);
										@(posedge Clock);
										@(posedge Clock);
										@(posedge Clock);
										@(posedge Clock);
										@(posedge Clock);
										@(posedge Clock);	

	end
endmodule