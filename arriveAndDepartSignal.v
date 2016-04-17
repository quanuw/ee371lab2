// module for arrival, departure, inner port, and outer port

`include "Metastability.v"
`include "counter.v"

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
    parameter A = 0, B = 1;
    Metastability arrive(.clk(), .rst(), .press(arriveSwitch), .metaFree(arriveSignal));
    Metastability depart(.clk(), .rst(), .press(departSwitch), .metaFree(departSignal));
    counter pressureUpCount(.clk(), .reset(), .counterSeconds(10'b111), .signal(pressureUp));
    counter pressureDownCount(.clk(), .reset(), .counterSeconds(10'b111), .signal(pressureDown));


    assign arriveSignal = arrivePS;
    assign departSignal = departPS;

    always @(*)
        /*if (rst) begin
            departNS = 0;
            arriveNS = 0;
        end*/
        begin
            if (arriveSwitch && pressureUp > 0 && pressureDown == 0) begin
                arriveNS = 1;
            end
            else if (arrivePS && pressureUp > 0) begin
                arriveNS = 1;
            end
            if (departSwitch && pressureDown > 0 && pressureUp == 0) begin
                departNS = 1;
            end
            else if (departPS && pressureDown > 0) begin
                departNS = 1;
            end
            else begin
                arriveNS = 0;
                departNS = 0;
            end
        end

    always@(posedge clk)
    	if(rst) begin
    		arrivePS <= 0;
            departPS <= 0;
    	end
    	else begin
            arrivePS <= arriveNS;
            departPS <= departNS;
    	end
endmodule
