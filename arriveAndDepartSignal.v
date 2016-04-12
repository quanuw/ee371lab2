// module for arrival, departure, inner port, and outer port
module arriveAndDepartSignal(arriveSignal, leaveSignal, arriveSwitch,
    leaveSwitch, timer, rst);
    output arriveSignal;
    output leaveSignal;
    input arriveSwitch;
    input leaveSwitch;
    input pressureUp;
    input pressureDown;
    input timer, rst;


    assign arriveSignal = arriveSwitch && pressureUp;
    assign leaveSignal = leaveSwitch && pressureDown;
    assign outPort = pressureUp;
    assign inPort = pressureDown;
endmodule
