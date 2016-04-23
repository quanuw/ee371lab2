// `include "MetastabilityDFlipFlop.v"

module Metastability ( clk, press, metaFree);
	input clk, press;
	output metaFree;
	
	wire d1_Out;
	
	// Fixes Metastability by putting signal through two D flip-flops 
	MetastabilityDFlipFlop d1(.q(d1_Out), .qBar(), .D(press), .clk(clk));
	MetastabilityDFlipFlop d2(.q(metaFree), .qBar(), .D(d1_Out), .clk(clk));
	
endmodule 
