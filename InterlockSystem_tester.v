module InterlockSystem_tester(Clock, SW0, SW1, SW2, SW3, Key0, Key1, Key2);
	output reg Clock, Reset;
	output reg SW0, SW1, SW2, SW3;
	output reg Key0, Key1, Key2;
	
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
		Reset <= 0; 					@(posedge Clock);
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
endmodule