// Counts up to 1023 seconds
// Use clock with frequency 1 Hz
// counterSeconds == 300 for 5 minutes
// counterSeconds == 420 for 7 minutes
// counterSeconds == 480 for 8 minutes
// Counter counts down the number of seconds given
// then returns 1 forever after that
module counter (clk, reset, counterSeconds, signal);
	input clk, reset;
	input [9:0] counterSeconds;
	output wire signal;
	reg count;
	always @(posedge clk) begin
		if (reset) begin
			count <= counterSeconds;
		end else if (count != 10'b0) begin
			count <= count - 10'b1;
		end
	end
	assign signal = count == 10'b0;
endmodule
				