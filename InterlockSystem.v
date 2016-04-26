`include "MetastabilityDFlipFlop.v"
`include "Metastability.v"
`include "clock_divider.v"
`include "UserInput_High2Low.v"
`include "UserInput_Low2High.v"
`include "Counter_1bit_Start1.v"
`include "Counter_1bit_Start0.v"
`include "FillandPressurize.v"
`include "Evacuate.v"
`include "countdown_FP.v"
`include "countdown_Evacuate.v"
`include "counter.v"
`include "displayTime.v"
`include "arriveAndDepartSignal.v"

module InterlockSystem(CLOCK_50, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, LEDR,
SW);
	
	input CLOCK_50; // 50MHz clock.
	output [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	output [9:0] LEDR;
	input [3:0] KEY; // True when not pressed, False when pressed
	input [9:0] SW;
	
	assign [6:0] HEX1 = 7'b1111111;
	assign [6:0] HEX3 = 7'b1111111;
	assign [6:0] HEX5 = 7'b1111111;
	
	wire [31:0] divided_clocks;
	clock_divider dividclock(.clock(CLOCK_50), .divided_clocks(divided_clocks));
	wire clock;
	assign clock = divided_clocks[18];
	
	wire sw0, sw1, sw2, sw3, key0, key1, key2;
	Metastability sw0m(.clk(clock), .press(SW[0]), .metaFree(sw0));
	Metastability sw1m(.clk(clock), .press(SW[1]), .metaFree(sw1));
	Metastability sw2m(.clk(clock), .press(SW[2]), .metaFree(sw2));
	Metastability sw3m(.clk(clock), .press(SW[3]), .metaFree(sw3));
	Metastability key0m(.clk(clock), .press(KEY[0]), .metaFree(key0));
	Metastability key1m(.clk(clock), .press(KEY[1]), .metaFree(key1));
	Metastability key2m(.clk(clock), .press(KEY[2]), .metaFree(key2));
	
	wire aSignal, dSignal, AorDSignal;
	wire [9:0] countdownAorD;
	wire arriveSignal, departSignal;
	// Determines state of arrive and depart signal leds 
	arriveAndDepartSignal arriveAndDepart(.arriveSignal(arriveSignal), .departSignal(departSignal), .arriveSwitch(sw0), .departSwitch(sw1), .clk(clock), .rst(resetInputSignal));
	UserInput_Low2High a(.Clock(clock), .Reset(resetInputSignal), .in(arriveSignal), .out(aSignal));
	UserInput_Low2High d(.Clock(clock), .Reset(resetInputSignal), .in(departSignal), .out(dSignal));
	or checkBathFlip(AorDSignal, aSignal, dSignal);
	counter makeAorD(.clk(clock), .reset(resetInputSignal), .counterSeconds(10'b0000000101), .start(aorDSignal), .signal(), .countInProcess(), .count(countdownAorD));
	assign LEDR[0] = arriveSignal;
	assign LEDR[1] = departSignal;
	
	
	// State of outer port (open or closed)
	wire OPOpenClose, OPState, OPFlipSignal1, OPFlipSignal2;
	UserInput_High2Low incrementOP1(.Clock(clock), .Reset(resetInputSignal), .in(sw2), .out(OPFlipSignal1));
	UserInput_Low2High incrementOP2(.Clock(clock), .Reset(resetInputSignal), .in(sw2), .out(OPFlipSignal2));
	or checkOPFlip(OPFlip, OPFlipSignal1, OPFlipSignal2);
	and incrementOPState(OPOpenClose, OPFlip, !EVState, !inProcessEV, !inProcessFP);

	Counter_1bit_Start1 OuterPort(.Clock(clock), .Reset(resetInputSignal), .Increase(OPOpenClose), .Count(OPState));
	assign LEDR[2] = OPState;
	
	// State of inner port (open or closed)
	wire IPOpenClose, IPState, IPIncrement, IPFlipSignal1, IPFlipSignal2, IPFlip;
	UserInput_High2Low incrementIP1(.Clock(clock), .Reset(resetInputSignal), .in(sw3), .out(IPFlipSignal1));
	UserInput_Low2High incrementIP2(.Clock(clock), .Reset(resetInputSignal), .in(sw3), .out(IPFlipSignal2));
	
	or checkIPFlip(IPFlip, IPFlipSignal1, IPFlipSignal2);
	and incrementIPState(IPOpenClose, IPFlip, !FPState, !inProcessEV, !inProcessFP);
		
	Counter_1bit_Start1 InnerPort(.Clock(clock), .Reset(resetInputSignal), .Increase(IPOpenClose), .Count(IPState));
	assign LEDR[3] = IPState;
	
	// Creates a fillandPressurize signal when key 1 is pressed
	wire FPKey, countdownSignalFP, beginFPSignal, fillandPressurizeSignal, FPSignalOneClock/*, FPState*/, devacuate, DevacuateOneClock, FPIncrement/*, inProcessFP*/;
	wire [9:0] countdownFP;
	or incrementFPState(FPIncrement, FPSignalOneClock, EVSignalOneClock);
	
	UserInput_High2Low keyFP(.Clock(clock), .Reset(resetInputSignal), .in(key1), .out(FPKey));
	FillandPressurize fP(.Clock(clock), .Reset(resetInputSignal), .begin_FandP(FPKey), .InnerClosed(IPState), .OuterClosed(OPState), .Evacuated(EVState), .Pressurized(FPState), .FandP(countdownSignalFP));
	counter makeFP(.clk(clock), .reset(resetInputSignal), .counterSeconds(10'b0000000111), .start(countdownSignalFP), .signal(fillandPressurizeSignal), .countInProcess(inProcessFP), .count(countdownFP));
	UserInput_Low2High makeFPIncrement(.Clock(clock), .Reset(resetInputSignal), .in(fillandPressurizeSignal), .out(FPSignalOneClock));
	Counter_1bit_Start0 Pressurized(.Clock(clock), .Reset(resetInputSignal), .Increase(FPIncrement), .Count(FPState));
	assign LEDR[5] = FPState;
	
	wire EVKey, countdownSignalEv, beginEVSignal, evacuateSignal, /*EVSignalOneClock,*//* EVState, Depressurize,*/ DepressurizeOneClock, EVIncrement/*, inProcessEV*/;
	wire [9:0] countdownEV;
	
	// Creates an evacuate signal when key 2 is pressed
	or incrementEVState(EVIncrement, EVSignalOneClock, FPSignalOneClock);
		
	UserInput_High2Low keyEV(.Clock(clock), .Reset(resetInputSignal), .in(key2), .out(EVKey));
	Evacuate e(.Clock(clock), .Reset(resetInputSignal), .begin_Evacuation(EVKey), .InnerClosed(IPState), .OuterClosed(OPState), .Pressurized(FPState), .Evacuated(EVState),.Evacuation(countdownSignalEV));
	counter makeEV(.clk(clock), .reset(resetInputSignal), .counterSeconds(10'b0000001000), .start(countdownSignalEV), .signal(evacuateSignal), .countInProcess(inProcessEV), .count(countdownEV));
	UserInput_Low2High makeEVIncrement(.Clock(clock), .Reset(resetInputSignal), .in(evacuateSignal), .out(EVSignalOneClock));
	Counter_1bit_Start1 Evacuated(.Clock(clock), .Reset(resetInputSignal), .Increase(EVIncrement), .Count(EVState));
	assign LEDR[6] = EVState;
	
	displayTime countdownTimes(.Clock(CLOCK_50), .Reset(resetInputSignal), .countArrive(countdownAorD), .countFandP(countdownFP), .countEvacuate(countdownEV),  .HEXArrive(HEX0), .HEXFandP(HEX2), .HEXEvacuate(HEX4));
	
endmodule
