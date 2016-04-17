module Counter_2bit (Clock, Reset, gameStart, keyPress, hexSelector);
	input Clock, Reset, keyPress, gameStart;

	// Output scoreKeeper is 3 bit number that should send to displayVictor module
	output [1:0] hexSelector;
	
	// Your code goes here!!
	reg [1:0] ps; // Present State
	reg [1:0] ns; // Next State
	
	// State encoding.
	parameter A = 1, B = 0, C = 2'b00;
	
	initial ps = C;
	
	// Next State logic
	always @(*) begin
	
		case (Reset)
			
			B: begin
				
				if (gameStart) begin
			
					if (keyPress) ns = ps + 1; // case for when counter should go up by 1	
					else ns = ps;
				end 
				
				else begin
					ns = C;
				end 
						
			end

		endcase
		
	end

	// Output logic - could also be another always, or part of above block.
	assign hexSelector = (ps);
	
	// DFFs
	always @(posedge Clock)
		if (Reset) begin
			ps <= C;
		end 	
		else begin
			ps <= ns;
		end
endmodule

module Counter_2bit_testbench();
	reg Clock, Reset, gameStart, keyPress;
	wire [1:0] hexSelector;
	
	Counter_2bit dut (Clock, Reset, keyPress, hexSelector);
	
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
		Reset <=	1;										@(posedge Clock);			
															@(posedge Clock);
		Reset <= 0; keyPress <= 1;					@(posedge Clock);
		keyPress <= 0;									@(posedge Clock);
															@(posedge Clock);
		keyPress <= 1;									@(posedge Clock);
		keyPress <= 0;									@(posedge Clock);
															@(posedge Clock);
		keyPress <= 1;									@(posedge Clock);
		keyPress <= 0;									@(posedge Clock);
															@(posedge Clock);
		keyPress <= 1;									@(posedge Clock);
		keyPress <= 0;									@(posedge Clock);
															@(posedge Clock);
		keyPress <= 1;									@(posedge Clock);
		keyPress <= 0;									@(posedge Clock);
															@(posedge Clock);	
																
		$stop; // End the simulation.
	end
endmodule