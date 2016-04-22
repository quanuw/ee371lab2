`include "MetastabilityDFlipFlop.v"

module Metastability ( clk, rst, press, metaFree);
	input clk, rst, press;
	output metaFree;
	
	wire d1_Out;
	
	// Fixes Metastability by putting signal through two D flip-flops 
	MetastabilityDFlipFlop d1(.q(d1_Out), .qBar(), .D(press), .rst(rst), .clk(clk));
	MetastabilityDFlipFlop d2(.q(metaFree), .qBar(), .D(d1_Out), .rst(rst), .clk(clk));
	
endmodule 
