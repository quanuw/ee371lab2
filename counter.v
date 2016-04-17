// Counts up to 1023 seconds
// Use clock with frequency 1 Hz
// counterSeconds == 300 for 5 minutes
// counterSeconds == 420 for 7 minutes
// counterSeconds == 480 for 8 minutes
module counter (clk, reset, counterSeconds, signal);
	input clk, reset;
	input [9:0] counterSeconds;
	output wire signal;
	reg count;
	always @(posedge clk) begin
		if (reset) begin
			count <= 1'b0;
		end else if (count == counterSeconds) begin
			count <= 10'b0;
		end else begin
			count <= count + 10'b1;
		end
	end
	assign signal = count == (counterSeconds - 1);
endmodule
				