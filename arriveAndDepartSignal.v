// module for arrival, departure, inner port, and outer port
module arriveAndDepartSignal(arriveSignal, departSignal, arriveSwitch,
                             departSwitch, clk, rst);
    output arriveSignal;
    output departSignal;
    input arriveSwitch;
    input departSwitch;
    input clk, rst;

    reg departPS;
    reg departNS;
    reg arrivePS;
    reg arriveNS;

    assign arriveSignal = arrivePS; // assign the signals to present states
    assign departSignal = departPS;

    always @(*)
        begin
            if (arriveSwitch && !departSwitch) begin // if switch is enabled and pressureUp counter is greater than 0 && pressureDown counter is 0
                arriveNS = 1;
					 departNS = 0;
            end
            else if (!arriveSwitch && departSwitch) begin // if present state is on and pressureUp counter is greater than 0 next
                arriveNS = 0;
					 departNS = 1;
            end 
				else begin // else turn off both signals
                arriveNS = 0;
                departNS = 0;
            end
        end

    always@(posedge clk)
    	if(!rst) begin
    		arrivePS <= 0;
         departPS <= 0;
    	end
    	else begin
            arrivePS <= arriveNS;
            departPS <= departNS;
    	end
endmodule

