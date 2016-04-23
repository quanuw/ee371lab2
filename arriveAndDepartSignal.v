/*`include"Metastability.v"
`include"counter.v"
*/
/*
// module for arrival, departure, inner port, and outer port
module arriveAndDepartSignal(arriveSignal, departSignal, arriveSwitch,
                             departSwitch, clk, rst);
    output arriveSignal;
    output departSignal;
    input arriveSwitch;
    input departSwitch;
    input pressureUp;
    input pressureDown;
    input clk, rst;

    reg departPS;
    reg departNS;
    reg arrivePS;
    reg arriveNS;

    Metastability arrive(.clk(), .rst(), .press(arriveSwitch), .metaFree(arriveSignal)); // prevent metastability from the signals
    Metastability depart(.clk(), .rst(), .press(departSwitch), .metaFree(departSignal));

    //counter pressureUpCount(.clk(clk), .reset(rst), .counterSeconds(10'b111), .signal(pressureUp)); // interface with counters
    //counter pressureDownCount(.clk(clk), .reset(rst), .counterSeconds(10'b111), .signal(pressureDown));
    //FillandPressurize isPressurized(.Clock, .Reset, .begin_FandP, .InnerClosed, .OuterClosed, .Evacuated, .Pressurized, .FandP(pressureUp));

    assign arriveSignal = arrivePS; // assign the signals to present states
    assign departSignal = departPS;

    always @(*)
        begin
            if (arriveSwitch && FPState == 0) begin // if switch is enabled and pressureUp counter is greater than 0 && pressureDown counter is 0
                arriveNS = 1;
            end
            else if (arrivePS && FPState == 0) begin // if present state is on and pressureUp counter is greater than 0 next
                arriveNS = 1;
            end
            if (departSwitch &&  EvState == 0) begin // if switch is enabled and pressureDown counter is greater than 0 && pressureUp counter is 0
                departNS = 1;
            end
            else if (departPS && EVState == 0) begin // if present state is on and pressureDown counter is greater than o
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
*/
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
