<<<<<<< HEAD
<<<<<<< HEAD
module counter_tester(Clock, Reset, beginCount, counterSeconds);
	output reg Clock, Reset, Increase, beginCount;
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
		beginCount <= 1;				@(posedge Clock);
		beginCount <= 0;				@(posedge Clock);
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
=======
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
		Reset <= 1;					@(posedge Clock);			
		Reset <= 0;					@(posedge Clock);
		Reset <= 1;					@(posedge Clock);	
		Start <= 0;					@(posedge Clock);
		Start <= 1;					@(posedge Clock);
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
>>>>>>> 65c9eb1007036024b958e6fe0086b78dfac62c23
=======
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
		Reset <= 1;					@(posedge Clock);			
		Reset <= 0;					@(posedge Clock);
		Reset <= 1;					@(posedge Clock);	
		Start <= 0;					@(posedge Clock);
		Start <= 1;					@(posedge Clock);
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
		Start <= 0;					@(posedge Clock);
		Start <= 1;					@(posedge Clock);
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

	end
>>>>>>> f0f5a8d88cdd457b58cf8f796f57b14ad7e54329
endmodule