module FillandPressurize(Clock, Reset, begin_FandP, InnerClosed, OuterClosed, Evacuated, Pressurized, FandP);
	input Clock, Reset, begin_FandP, InnerClosed, OuterClosed, Evacuated, Pressurized;
	output FandP;
	
	parameter A = 0, B = 1;
	
	reg psFandP;
	reg nsFandP;
	
	reg psEvacuate;
	reg nsEvacuate;
	
	always@(*)
		
		case (Pressurized)
	
		A: begin 
		
			if (Evacuated && begin_FandP && OuterClosed && InnerClosed) begin 
			nsFandP = B;
			// nsEvacuate = B;
			end 
			else begin
			nsFandP = A;
			// nsEvacuate = A;
			end
		
		end 
		
		
		B: begin 
		
			nsFandP = A;
			// nsEvacuate = A;
			
		end 
		
		/*
		case (OuterClosed)
		
			A: begin 
			
				ns = A;
			
			end 
			
			
			B: begin 
			
				if (!Pressurized && Evacuated && begin_FandP && InnerClosed) ns = B;
				else ns = A;
				
			end 
		*/
		
		endcase
		
	assign FandP = (psFandP); 
	// assign Evacuate = (psEvacuate);
		
	always@(posedge Clock)
		if(!Reset) begin
			psFandP <= A;
			// psEvacuate <= A;
			
		end 
				
		else begin
		
			psFandP <= nsFandP;
			// psEvacuate <= nsEvacuate;
			
		end 
	
endmodule 

