/*
`include "Metastability.v"
`include "clock_divider.v"
`include "UserInput_High2Low.v"
`include "UserInput_Low2High.v"
`include "Counter_1bit_Start1.v"
`include "Counter_1bit_Start0.v"
`include "OCPort.v"
`include "FillandPressurize.v"
`include "Evacuate.v"
`include "countdown_FP.v"
`include "countdown_Evacuate.v"
*/

module InterlockSystem(CLOCK_50, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, LEDR,
SW);
	
	input CLOCK_50; // 50MHz clock.
	output reg [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	output [9:0] LEDR;
	input [3:0] KEY; // True when not pressed, False when pressed
	input [9:0] SW;
	
	wire [31:0] divided_clocks;
	
	assign resetInputSignal = KEY[0];
	
	clock_divider dividclock(.clock(CLOCK_50), .divided_clocks(divided_clocks));
	wire clock;
	assign clock = divided_clocks[25];
	wire sw0, sw1, sw2, sw3, key0, key1, key2;
	Metastability sw0m(.clk(CLOCK_50), .rst(resetInputSignal), .press(SW[0]), .metaFree(sw0));
	Metastability sw1m(.clk(CLOCK_50), .rst(resetInputSignal), .press(SW[1]), .metaFree(sw1));
	Metastability sw2m(.clk(CLOCK_50), .rst(resetInputSignal), .press(SW[2]), .metaFree(sw2));
	Metastability sw3m(.clk(CLOCK_50), .rst(resetInputSignal), .press(SW[3]), .metaFree(sw3));
	// Metastability key0m(.clk(CLOCK_50), .rst(resetInputSignal), .press(KEY[0]), .metaFree(key0));
	Metastability key1m(.clk(CLOCK_50), .rst(resetInputSignal), .press(KEY[1]), .metaFree(key1));
	Metastability key2m(.clk(CLOCK_50), .rst(resetInputSignal), .press(KEY[2]), .metaFree(key2));
	
	// State of outer port (open or closed)
	wire OPOpenClose, OPState;
	OCPort OP(.Clock(CLOCK_50), .Reset(resetInputSignal), .SwitchFlip(sw2), .OpenClose(OPOpenClose));
	Counter_1bit_Start1 OuterPort(.Clock(CLOCK_50), .Reset(resetInputSignal), .Increase(OPOpenClose), .Count(OPState));
	assign LEDR[2] = OPState;
	
	// State of inner port (open or closed)
	wire IPOpenClose, IPState;
	OCPort IP(.Clock(CLOCK_50), .Reset(resetInputSignal), .SwitchFlip(sw3), .OpenClose(IPOpenClose));
	Counter_1bit_Start1 InnerPort(.Clock(CLOCK_50), .Reset(resetInputSignal), .Increase(IPOpenClose), .Count(IPState));
	assign LEDR[3] = IPState;
	
	// Creates a fillandPressurize signal when key 1 is pressed
	wire FPKey, countdownSignalFP, beginFPSignal, fillandPressurizeSignal, FPSignalOneClock, FPState, devacuate, DevacuateOneClock, FPIncrement;
	or incrementFPState(FPIncrement, fillandPressurizeSignal, Depressurize);
	
	UserInput_High2Low keyFP(.Clock(CLOCK_50), .Reset(resetInputSignal), .in(key1), .out(FPKey));
	FillandPressurize fP(.Clock(CLOCK_50), .Reset(resetInputSignal), .begin_FandP(FPKey), .InnerClosed(IPState), .OuterClosed(OPState), .Evacuated(EVState), .Pressurized(FPState), .FandP(countdownSignalFP));
	// UserInput_High2Low beginFP(.Clock(CLOCK_50), .Reset(resetInputSignal), .in(countdownSignalFP), .out(beginFPSignal));
	countdown_FP makeFP(.Clock(CLOCK_50), .Reset(resetInputSignal), .countdown(countdownSignalFP), .devacuated(Devacuate), .pressurized(fillandPressurizeSignal));
	// UserInput_Low2High makeFPIncrement(.Clock(CLOCK_50), .Reset(resetInputSignal), .in(Depressurize), .out(DepressurizeOneClock));
	Counter_1bit_Start0 Pressurized(.Clock(CLOCK_50), .Reset(resetInputSignal), .Increase(FPIncrement), .Count(FPState));
	assign LEDR[5] = FPState;
	

	// Creates an evacuate signal when key 2 is pressed
	wire EVKey, countdownSignalEv, beginEVSignal, evacuateSignal, EVSignalOneClock, EVState, Depressurize, DepressurizeOneClock, EVIncrement;
	or incrementEVState(EVIncrement, evacuateSignal, Devacuate);
	
	UserInput_High2Low keyEV(.Clock(CLOCK_50), .Reset(resetInputSignal), .in(key2), .out(EVKey));
	Evacuate e(.Clock(CLOCK_50), .Reset(resetInputSignal), .begin_Evacuation(EVKey), .InnerClosed(IPState), .OuterClosed(OPState), .Pressurized(FPState), .Evacuated(EVState),.Evacuation(countdownSignalEV));
	// UserInput_High2Low beginEV(.Clock(CLOCK_50), .Reset(resetInputSignal), .in(countdownSignalEV), .out(beginEVSignal));
	countdown_Evacuate makeEV(.Clock(CLOCK_50), .Reset(resetInputSignal), .countdown(countdownSignalEV), .depressurized(Depressurize), .evacuated(evacuateSignal));
	// UserInput_Low2High makeEVIncrement(.Clock(CLOCK_50), .Reset(resetInputSignal), .in(Devacuate), .out(DevacuateOneClock));
	Counter_1bit_Start1 Evacuated(.Clock(CLOCK_50), .Reset(resetInputSignal), .Increase(EVIncrement), .Count(EVState));
	assign LEDR[6] = EVState;
	
	
endmodule
