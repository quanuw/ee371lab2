// Counts up to 1023 seconds
// Use clock with frequency 1 Hz
// counterSeconds == 300 for 5 minutes
// counterSeconds == 420 for 7 minutes
// counterSeconds == 480 for 8 minutes
// Counter counts down the number of seconds given
// then returns 1 forever after that
/*
<<<<<<< HEAD
module counter (clk, reset, beginCount, counterSeconds, signal);
	input clk, reset, beginCount;
	input [9:0] counterSeconds;
	output wire [9:0] signal;
	reg [9:0] count;
	
	always @(posedge clk) begin
		if (!reset) begin
			count <= counterSeconds;
		end else if (beginCount) begin
			if(count != 10'b0) begin
				while(count != 10'b0) begin
					count <= count - 10'b1;
				end
			end
		end else if (count == 10'b0) begin
			count <= counterSeconds;
		end
	end
	assign signal = count;
=======
*/
module counter (clk, reset, counterSeconds, start, signal, count);
	input clk, reset, start;
	input [9:0] counterSeconds;
	output wire signal;
	output wire [9:0] count;
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
// >>>>>>> 65c9eb1007036024b958e6fe0086b78dfac62c23
endmodule
				