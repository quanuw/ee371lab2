module pulsetoToggle(clock, reset, in, out);
	input clock, reset, in;
	output out;
	
	reg ps, ns;
	parameter A = 1'b0, B = 1'b1;
	
	always@(*)
		case (in)
			A: if (ps == A) begin
					ns <= A;
				end else begin
					ns <= B;
				end
			B: if (ps == A) begin
					ns <= B;
				end else begin
					ns <= A;
				end
			default: ns <= 1'bx;
		endcase
		
	always @(posedge Clock)
		if (Reset)
			ps <= A;
		else
			ps <= ns;
	
	assign out = ps;
	
endmodule