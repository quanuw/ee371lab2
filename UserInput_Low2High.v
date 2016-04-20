module UserInput_Low2High (Clock, Reset, in, out);
	input Clock, Reset, in;
	output out;

	reg ps; // Present State
	reg ns; // Next State

	// State encoding.
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
		if (!Reset)
			ps <= A;
		else
			ps <= ns;
endmodule

