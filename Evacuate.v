module Evacuate(Clock, Reset, begin_Evacuation, InnerClosed, OuterClosed, Pressurized, Evacuated, Evacuation);
	input Clock, Reset, begin_Evacuation, InnerClosed, OuterClosed, Pressurized, Evacuated;
	output Evacuation;
	
	parameter A = 0, B = 1;
	
	reg ps;
	reg ns;
	
	always@(*)
	
		case (InnerClosed)
		
			A: begin 
			
				ns = A;
			
			end 
			
			
			B: begin 
			
				if (!Evacuated && Pressurized && begin_Evacuation && OuterClosed) ns = B;
				else ns = A;
				
			end 
		
		endcase
		
	assign Evacuation = (ps); 
		
	always@(posedge Clock)
		if(!Reset) begin
		
			ps <= A;
			
		end 
				
		else begin
		
			ps <= ns;
			
		end 
	
endmodule 

