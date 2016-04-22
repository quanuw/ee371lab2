module Counter_1bit_Start1 (Clock, Reset, Increase, Count);
	input Clock, Reset, Increase;

	// Output scoreKeeper is 3 bit number that should send to displayVictor module
	output Count;
	
	// Your code goes here!!
	reg ps; // Present State
	reg ns; // Next State
	
	// State encoding.
	parameter A = 0, B = 1, C = 0;
	
	// Next State logic
	always @(*) begin
	
		case (Increase)
		
			1: begin
							
				ns = ps + 1; // case for when counter should go up by 1	

			end 
				
			0: begin
				
				ns = ps;
						
			end

		endcase
		
	end

	// Output logic - could also be another always, or part of above block.
	assign Count = (ps);
	
	// DFFs
	always @(posedge Clock)
		if (!Reset) begin
			ps <= 1;
		end 	
		else begin
			ps <= ns;
		end
endmodule
