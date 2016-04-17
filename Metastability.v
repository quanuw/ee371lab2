`include "DFlipFlop.v"

module Metastability ( clk, rst, press, metaFree);
	input clk, rst, press;
	output metaFree;
	
	wire d1_Out;
	
	// Fixes Metastability by putting signal through two D flip-flops 
	DFlipFlop d1(.q(d1_Out), .qBar(), .D(press), .clk(clk), .rst(rst));
	DFlipFlop d2(.q(metaFree), .qBar(), .D(d1_Out), .clk(clk), .rst(rst));
	
endmodule 
