module counter_tester(Clock, Reset, start, counterSeconds);
	output reg Clock, Reset, Increase, start;
	output reg [9:0] counterSeconds;
	
	// Set up the clock.
	parameter CLOCK_PERIOD=2;
	initial Clock=1;
	always begin
		#(CLOCK_PERIOD/2);
		Clock = ~Clock;
	end
	
	// Set up the inputs to the design. Each line is a clock cycle.
	initial begin
		counterSeconds <= 10'b0000000111; @(posedge Clock);
		Reset <= 0;						@(posedge Clock);			
										@(posedge Clock);
		Reset <= 1; 					@(posedge Clock);
										@(posedge Clock);
										@(posedge Clock);
										@(posedge Clock);
		start <= 1;				@(posedge Clock);
		start <= 0;				@(posedge Clock);
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