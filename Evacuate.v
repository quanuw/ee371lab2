module Evacuate(Clock, Reset, begin_Evacuation, InnerClosed, OuterClosed, Pressurized, Evacuated, Evacuation);
	input Clock, Reset, begin_Evacuation, InnerClosed, OuterClosed, Pressurized, Evacuated;
	output Evacuation;
	
	parameter A = 0, B = 1;
	
	reg psDepressurize;
	reg nsDepressurize;
	
	reg psEvacuation;
	reg nsEvacuation;
	
	always@(*)
		
		case (Evacuated)
		
			A: begin 
			
				if (Pressurized && begin_Evacuation && OuterClosed && InnerClosed) begin 
				nsEvacuation = B;
				// nsDepressurize = B;
				end 
				else begin
				nsEvacuation = A;
				// nsDepressurize = A;
				end
			
			end 
			
			
			B: begin 
			
				nsEvacuation = A;
				// nsDepressurize = A;
				
			end 
		/*
		case (InnerClosed)
		
			A: begin 
			
				ns = A;
			
			end 
			
			
			B: begin 
			
				if (!Evacuated && Pressurized && begin_Evacuation && OuterClosed) ns = B;
				else ns = A;
				
			end 
		*/
		
		endcase
		
	assign Evacuation = (psEvacuation); 
	// assign Depressurize = (psDepressurize);
	
	always@(posedge Clock)
		if(!Reset) begin
		
			psEvacuation <= A;
			// psDepressurize <= A;
			
		end 
				
		else begin
		
			psEvacuation <= nsEvacuation;
			// psDepressurize <= nsDepressurize;
			
		end 
	
endmodule 

