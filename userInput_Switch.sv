module userInput_Switch (Clock, Reset, in, out);
	input Clock, Reset, in;
	output out;

	reg ps; // Present State
	reg ns; // Next State

	// State encoding.
	parameter A = 1, B = 0;
	
	// Next State logic
	always @(*)
		
		case (in)
			A: if (ps == 0) ns = 1; // case for when KEY is unpressed and becomes pressed. 
				else if (ps == 1) ns = 1;
			B: if (ps == 0) ns = 0;
				else if (ps == 1) ns = 0;
			
			default: ns = 1'bx;
		endcase 
		
		/*
		case (in)
			A: if (ps == 0) ns <= 1; // case for when KEY is unpressed and becomes pressed. 
				else if (ps == 1) ns <= 1;
			B: if (ps == 0) ns <= 0;
				else if (ps == 1) ns <= 0;
			
			default: ns = 1'bx;
		endcase
		*/
		
	// Output logic - could also be another always, or part of above block.
	assign out = (~ps & ns);
	
	// DFFs
	always @(posedge Clock)
		if (Reset)
			ps <= A;
		else
			ps <= ns;
endmodule

module userInput_Switch_testbench();
	reg Clock, Reset, in;
	wire out, ps, ns;
	
	userInput_Switch dut (Clock, Reset, in, out);
	
	// Set up the clock.
	parameter CLOCK_PERIOD=100;
	initial Clock=1;
	always begin
		#(CLOCK_PERIOD/2);
		Clock = ~Clock;
	end
	
	// Set up the inputs to the design. Each line is a clock cycle.
	initial begin
												@(posedge Clock);
		Reset <= 1; in <= 1;				@(posedge Clock);
												@(posedge Clock);
		Reset <= 0; 			 			@(posedge Clock);
												@(posedge Clock);
		in <= 0;								@(posedge Clock);
												@(posedge Clock);
												@(posedge Clock);
		in <= 1;								@(posedge Clock);
												@(posedge Clock);
												@(posedge Clock);
		in <= 0;								@(posedge Clock);
		in <= 1;								@(posedge Clock);
		in <= 0;								@(posedge Clock);
												@(posedge Clock);
		$stop; // End the simulation.
	end
endmodule

