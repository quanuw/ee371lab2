module Counter_1bit_tester(Clock, Reset, Increase);
	output reg Clock, Reset, Increase;
	
	// Set up the clock.
	parameter CLOCK_PERIOD=2;
	initial Clock=1;
	always begin
		#(CLOCK_PERIOD/2);
		Clock = ~Clock;
	end
	
	// Set up the inputs to the design. Each line is a clock cycle.
	initial begin
										@(posedge Clock);
		Reset <= 1;						@(posedge Clock);			
										@(posedge Clock);
		Reset <= 0; Increase <= 1;		@(posedge Clock);
		Increase <= 0;					@(posedge Clock);
										@(posedge Clock);
		Increase <= 1;					@(posedge Clock);
		Increase <= 0;					@(posedge Clock);
										@(posedge Clock);
		Increase <= 1;					@(posedge Clock);
		Increase <= 0;					@(posedge Clock);
										@(posedge Clock);
		Increase <= 1;					@(posedge Clock);
		Increase <= 0;					@(posedge Clock);
										@(posedge Clock);
		Increase <= 1;					@(posedge Clock);
		Increase <= 0;					@(posedge Clock);
										@(posedge Clock);	

	end
endmodule