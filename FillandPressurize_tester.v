module FillandPressurize_tester(Clock, Reset, begin_FandP, InnerClosed, OuterClosed, Evacuated, Pressurized);
	output reg Clock, Reset, begin_FandP, InnerClosed, OuterClosed, Pressurized, Evacuated;
	
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
		Reset <= 1; OuterClosed <= 0;	@(posedge Clock);
		InnerClosed <= 0;				@(posedge Clock);
		Pressurized <= 0;				@(posedge Clock);
										@(posedge Clock);
		begin_FandP	<= 1;				@(posedge Clock);
										@(posedge Clock);
										@(posedge Clock);
										@(posedge Clock);
		Pressurized <= 1;				@(posedge Clock);
										@(posedge Clock);
										@(posedge Clock);
										@(posedge Clock);
		begin_FandP	<= 1;				@(posedge Clock);
										@(posedge Clock);
		InnerClosed <= 1;				@(posedge Clock);
										@(posedge Clock);
										@(posedge Clock);
		OuterClosed <= 1;				@(posedge Clock);
		Pressurized <= 0;				@(posedge Clock);
										@(posedge Clock);
										@(posedge Clock);
		begin_FandP	<= 1;				@(posedge Clock);
										@(posedge Clock);
										@(posedge Clock);
										@(posedge Clock);
		OuterClosed <= 1;				@(posedge Clock);
		Evacuated <= 1;					@(posedge Clock);
										@(posedge Clock);
										@(posedge Clock);
										@(posedge Clock);
										@(posedge Clock);
										@(posedge Clock);
										@(posedge Clock);

	end
endmodule