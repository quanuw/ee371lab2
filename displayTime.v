module displayTime (Clock, Reset, countArrive, countFandP, countEvacuate, HEXArrive, HEXFandP, HEXEvacuate);
	input Clock, Reset; 
	input [9:0] countArrive, countFandP;
	input [9:0] countEvacuate;
	output wire [6:0] HEXArrive, HEXFandP, HEXEvacuate;
	
	// State encoding.
	parameter [6:0] A = 7'b1000000, B = 7'b1111001, C = 7'b0100100, D = 7'b0110000, E = 7'b0011001, F = 7'b0010010, G = 7'b0000010, H = 7'b1111000, I = 7'b1111111;
	
	// Next State logic
	always @(*) begin 
		case(Reset)
			1: begin
				case (countArrive)
					3'b0000000000: HEXArrive = A;
					3'b0000000001: HEXArrive = B;
					3'b0000000010: HEXArrive = C;
					3'b0000000011: HEXArrive = D;
					3'b0000000100: HEXArrive = E;
				endcase
				
				case (countFandP)
					3'b0000000000: HEXFandP = A;
					3'b0000000001: HEXFandP = B;
					3'b0000000010: HEXFandP = C;
					3'b0000000011: HEXFandP = D;
					3'b0000000100: HEXFandP = E;
					3'b0000000101: HEXFandP = F;
					3'b0000000110: HEXFandP = G;
					3'b0000000111: HEXFandP = H;
				endcase
				
				case (countEvacuate)
					3'b0000000000: HEXEvacuate = A;
					3'b0000000001: HEXEvacuate = B;
					3'b0000000010: HEXEvacuate = C;
					3'b0000000011: HEXEvacuate = D;
					3'b0000000100: HEXEvacuate = E;
					3'b0000000101: HEXEvacuate = F;
					3'b0000000110: HEXEvacuate = G;
					3'b0000000111: HEXEvacuate = H;
					4'b0000001000: HEXEvacuate = I;
				endcase
			end
			0: begin
				HEXArrive = A;
				HEXFandP = A;
				HEXEvacuate = A;
			end 
		endcase
	end
	
endmodule