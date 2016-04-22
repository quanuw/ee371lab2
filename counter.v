// Counts up to 1023 seconds
// Use clock with frequency 1 Hz
// counterSeconds == 300 for 5 minutes
// counterSeconds == 420 for 7 minutes
// counterSeconds == 480 for 8 minutes
// Counter counts down the number of seconds given
// then returns 1 forever after that
module counter (clk, reset, counterSeconds, start, signal);
	input clk, reset, start;
	input [9:0] counterSeconds;
	output wire signal;
	reg [9:0] count;
	reg go;
	always @(posedge clk) begin
		if (!reset || start) begin
			count <= counterSeconds;
		end else if (count != 10'b0 && go) begin
			count <= count - 10'b1;
		end
	end
	always @(posedge clk) begin
		if (!reset) begin
			go <= 1'b0;
		end else if (start) begin
			go <= 1'b1;
		end
	end
	assign signal = count == 10'b0;
endmodule
				