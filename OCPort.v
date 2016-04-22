module OCPort(Clock, Reset, SwitchFlip, OpenClose);
	input Clock, Reset, SwitchFlip;
	output reg OpenClose;
	/*
	parameter A = 0, B = 1;
	
	reg ps;
	reg ns;
	
	
	always@(posedge SwitchFlip or negedge SwitchFlip)
	
		case (ps)
		
			A: begin 
			
				ns = B;
				
			end 
			
			
			B: begin 
				

			
			end 
		
		endcase
		*/

	parameter A = 2'b00, B = 2'b01, C = 2'b10, D = 2'b11;
	
	reg [1:0] ps;
	reg [1:0] ns; 
	
	always@(*)
	
		case (ps)
		
			A: begin 
			
				if(SwitchFlip) begin
				
				ns = B;
				OpenClose = 1;
				
				end
				
				else if(!SwitchFlip) begin
				ns = A;
				OpenClose = 0;
				
				end 
				
			
			end 
			
			
			B: begin 
			
				if(SwitchFlip) begin
				
				ns = C;
				OpenClose = 0;
				
				end
				
				else begin
				
				ns = D;
				OpenClose = 1;
				
				end
				
			end 
			
			C: begin 
			
				if(!SwitchFlip) begin
				
				ns = D;
				OpenClose = 1;
				
				end 
				
				else begin
				
				ns = C;
				OpenClose = 0;
				
				end
			
			end 
			
			D: begin 
			
				if(SwitchFlip) begin
				
				ns = B;
				OpenClose = 1;
				
				end
				
				else begin
				
				ns = A;
				OpenClose = 0;
				
				end 
			
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

