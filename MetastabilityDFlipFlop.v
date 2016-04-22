module MetastabilityDFlipFlop(q, qBar, D, clk, rst);
	input D, clk, rst;
	output q, qBar;
	reg q;
	not n1 (qBar, q);
		always@ (posedge clk)
		begin
			q <= D;
		end
endmodule