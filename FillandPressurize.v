module FillandPressurize(Clock, Reset, begin_FandP, InnerClosed, OuterClosed, Pressurized, FandP);
	input Clock, Reset, begin_FandP, InnerClosed, OuterClosed, Pressurized;
	output FandP;
	
	parameter A = 0, B = 1;
	
	reg ps;
	reg ns;
	
	always@(*)
	
		case (OuterClosed)
		
			A: begin 
			
				ns = A;
			
			end 
			
			
			B: begin 
			
				if (!Pressurized && begin_FandP && InnerClosed) ns = B;
				else ns = A;
				
			end 
		
		endcase
		
	assign FandP = (ps); 
		
	always@(posedge Clock)
		if(Reset) begin
		
			ps <= A;
			
		end 
				
		else begin
		
			ps <= ns;
			
		end 
	
endmodule 

