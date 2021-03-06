<<<<<<< HEAD
module OCPort_tester(Clock, Reset, SwitchFlip);
	output reg Clock, Reset, SwitchFlip;
	
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
		Reset <= 0;						@(posedge Clock);			
										@(posedge Clock);
		Reset <= 1; 					@(posedge Clock);
										@(posedge Clock);
		SwitchFlip <= 0;				@(posedge Clock);
										@(posedge Clock);
		SwitchFlip	<= 1;				@(posedge Clock);
										@(posedge Clock);
										@(posedge Clock);
										@(posedge Clock);
		SwitchFlip <= 0;				@(posedge Clock);
										@(posedge Clock);
										@(posedge Clock);
										@(posedge Clock);
		SwitchFlip	<= 1;				@(posedge Clock);
										@(posedge Clock);
		SwitchFlip <= 0;				@(posedge Clock);
										@(posedge Clock);
										@(posedge Clock);
		SwitchFlip <= 1;				@(posedge Clock);
										@(posedge Clock);
										@(posedge Clock);
										@(posedge Clock);
										@(posedge Clock);
		Reset <= 0;						@(posedge Clock);
										@(posedge Clock);
										@(posedge Clock);
										@(posedge Clock);
		Reset <= 1;						@(posedge Clock);
										@(posedge Clock);
										@(posedge Clock);
										@(posedge Clock);
										@(posedge Clock);
										@(posedge Clock);
										@(posedge Clock);
		

	end
=======
module OCPort_tester(Clock, Reset, SwitchFlip, EVState);
	output reg Clock, Reset, SwitchFlip, EVState;
	
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
		EVState <= 0;					@(posedge Clock);
		Reset <= 0;						@(posedge Clock);			
										@(posedge Clock);
		Reset <= 1; 					@(posedge Clock);
										@(posedge Clock);
		SwitchFlip <= 0;				@(posedge Clock);
										@(posedge Clock);
		SwitchFlip	<= 1;				@(posedge Clock);
										@(posedge Clock);
										@(posedge Clock);
										@(posedge Clock);
		SwitchFlip <= 0;				@(posedge Clock);
										@(posedge Clock);
										@(posedge Clock);
										@(posedge Clock);
		SwitchFlip	<= 1;				@(posedge Clock);
										@(posedge Clock);
		SwitchFlip <= 0;				@(posedge Clock);
										@(posedge Clock);
										@(posedge Clock);
		SwitchFlip <= 1;				@(posedge Clock);
		SwitchFlip <= 0;				@(posedge Clock);
										@(posedge Clock);
										@(posedge Clock);
		EVState <= 1;					@(posedge Clock);
		Reset <= 0;						@(posedge Clock);			
										@(posedge Clock);
		Reset <= 1; 					@(posedge Clock);
										@(posedge Clock);
		SwitchFlip <= 0;				@(posedge Clock);
										@(posedge Clock);
		SwitchFlip	<= 1;				@(posedge Clock);
										@(posedge Clock);
										@(posedge Clock);
										@(posedge Clock);
		SwitchFlip <= 0;				@(posedge Clock);
										@(posedge Clock);
										@(posedge Clock);
										@(posedge Clock);
		SwitchFlip	<= 1;				@(posedge Clock);
										@(posedge Clock);
		SwitchFlip <= 0;				@(posedge Clock);
										@(posedge Clock);
										@(posedge Clock);
		SwitchFlip <= 1;				@(posedge Clock);
		SwitchFlip <= 0;				@(posedge Clock);
										@(posedge Clock);
										@(posedge Clock);
		

	end
>>>>>>> 2d3c6978af9f9573d9b0d176905916ab6a779f29
endmodule