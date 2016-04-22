module countdown_Evacuate(Clock, Reset, countdown, depressurized, evacuated);
	input Clock, Reset, countdown;
	output reg evacuated, depressurized;
	
	parameter A = 4'b1000,  B = 4'b0111, C = 4'b0110, D = 4'b0101, E = 4'b0100, F = 4'b0011, G = 4'b0010, H = 4'b0001, I = 4'b0000;
	
	reg [3:0] ps;
	reg [3:0] ns; 
	
	always@(*)
	
		case (ps)
		
			A: begin 
			
				if(countdown) begin
				ns = B;
				evacuated = 0;
				depressurized = 0;
				end
				
				else begin
				ns = A;
				evacuated = 0;
				depressurized = 0;
				end
				
		
		
			end 
			
			B: begin 
			ns = C;	
			evacuated = 0;
			depressurized = 0;
			end 
			
			C: begin 
			ns = D;
			evacuated = 0;
			depressurized = 0;
			end 
			
			D: begin 
			ns = E;
			evacuated = 0;
			depressurized = 0;
			end 
			
			E: begin 
			ns = F;
			evacuated = 0;
			depressurized = 0;
			end 
			
			F: begin 
			ns = G;
			evacuated = 0;
			depressurized = 0;
			end 
			
			G: begin 
			ns = H;
			evacuated = 0;
			depressurized = 0;
			end 
			
			H: begin 
			ns = I;
			evacuated = 0;
			depressurized = 0;
			end 
			
			I: begin 
			ns = A;
			evacuated = 1;
			depressurized = 1;
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

