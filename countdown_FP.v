module countdown_FP(Clock, Reset, countdown, pressurized);
	input Clock, Reset, countdown;
	output reg pressurized;
	
	parameter A = 3'b111, B = 3'b110, C = 3'b101, D = 3'b100, E = 3'b011, F = 3'b010, G = 3'b001, H = 3'b000;
	
	reg [2:0] ps;
	reg [2:0] ns; 
	
	always@(*)
	
		case (ps)
		
			A: begin 
			
				if(countdown) begin
				ns = B;
				pressurized = 0;
				end 
				
				else begin
				ns = A;
				pressurized = 0;
				end
		
			end 
			
			B: begin 
			ns = C;	
			pressurized = 0;
			end 
			
			C: begin 
			ns = D;
			pressurized = 0;
			end 
			
			D: begin 
			ns = E;
			pressurized = 0;
			end 
			
			E: begin 
			ns = F;
			pressurized = 0;
			end 
			
			F: begin 
			ns = G;
			pressurized = 0;
			end 
			
			F: begin 
			ns = G;
			pressurized = 0;
			end 
			
			G: begin 
			ns = H;
			pressurized = 0;
			end 
			
			H: begin 
			ns = A;
			pressurized = 1; 
			end 
		
		endcase
		
	always@(posedge Clock)
		if(!Reset) begin

			ps <= A;
			
		end 
				
		else begin
		
			ps <= ns;
			
		end 
	
endmodule 

