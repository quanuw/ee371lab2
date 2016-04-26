module counter (clk, reset, counterSeconds, start, signal, countInProcess, count);
	input clk, reset, start;
	input [9:0] counterSeconds;
	output wire signal;
	output reg [9:0] count;
	output reg countInProcess;

	reg go;
	reg [7:0] increment;
	always@(posedge clk) begin
		if(!reset || increment == 0 || start) begin
			increment <= 8'b10111111;

			// increment <= 8'b00000010;

		end else begin
			increment <= increment - 8'b1;
		end
	end

	always @(posedge clk) begin
		if (!reset || start) begin
			count <= counterSeconds;
		end else if (count != 10'b0 && go && increment == 0) begin
			count <= count - 10'b1;
		end
	end
	
	always @(posedge clk) begin
		if (count != 10'b0 && go) begin
			countInProcess = 1;
		end else begin
			countInProcess = 0;
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

