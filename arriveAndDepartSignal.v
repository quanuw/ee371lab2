module arriveAndDepartSignal(arriveSignal, leaveSignal, arriveSwitch,
    leaveSwitch, bathIn, clk, rst);
    output arriveSignal;
    output leaveSignal;
    input arriveSwitch;
    input leaveSwitch;
    input bathIn;
    input clk, rst;

assign arriveSignal = arriveSwitch && bathIn;
endmodule
