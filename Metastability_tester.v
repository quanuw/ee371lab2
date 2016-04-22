// This module will drive the inputs reset and clock to the 4 bit ripple down 
// counter module for simulation in GTKWave
module Metastability_tester(rst, clk, in);

	output reg rst, clk, in;
	
	// Establishes clock for simulation of  4 bit ripple down counter 
	parameter clk_PERIOD=2;
	initial clk=1;
	always begin
		#(clk_PERIOD/2);
		clk = ~clk;
	end 

	// Establishes reset for simulation of the making the user input high for once clock cycle
	initial begin
		rst <= 1;								@(posedge clk);
		rst <= 0;								@(posedge clk);
												@(posedge clk);
												@(posedge clk);
		rst <= 1; in <= 1;						@(posedge clk);
												@(posedge clk);
												@(posedge clk);
												@(posedge clk);
		in <= 0;								@(posedge clk);
												@(posedge clk);
												@(posedge clk);
		in <= 1;								@(posedge clk);
												@(posedge clk);
												@(posedge clk);
		rst <= 1;								@(posedge clk);
		rst <= 0;								@(posedge clk);
												@(posedge clk);
												@(posedge clk);
		in <= 0;								@(posedge clk);
		in <= 1;								@(posedge clk);
		in <= 0;								@(posedge clk);
												@(posedge clk);
	end
	
endmodule