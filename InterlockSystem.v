`include "Counter_1bit.v"
`include "OCPort.v"
`include "UserInput_High2Low.v"
`include "Metastability.v"
`include "clock_divider.v"

module InterlockSystem(CLOCK_50, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, LEDR,
SW);
	
	input CLOCK_50; // 50MHz clock.
	output reg [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	output [9:0] LEDR;
	input [3:0] KEY; // True when not pressed, False when pressed
	input [9:0] SW;
	
	wire [31:0] divided_clocks;
	// wire [3:0] CounterLights;
	
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
	
<<<<<<< HEAD
// <<<<<<< HEAD
	// Creates a reset signal when key 0 is pressed
	wire resetInputSignal;  // **************metastability
	assign resetInputSignal = !KEY[0];
	// UserInput_High2Low makeReset(.Clock(CLOCK_50), .Reset(resetInputSignal), .in(key0), .out(resetInputSignal));
=======
	// Creates a reset signal when key 0 is pressed
	wire resetInputSignal;
	UserInput_OneClock makeReset(.Clock(CLOCK_50), .Reset(resetInputSignal), .in(key0), .out(resetInputSignal));
>>>>>>> 9eef407b640cd65a7e82fec6d59528ad4c6c137c
	
	/*
	wire innerPort, outerPort; // 0 is open, 1 is closed
	assign outerPort = sw2; // if switch on, outerport is closed
	assign innerPort = sw3; // if switch on, innerport is closed
	assign LEDR[2] = outerPort;
	assign LEDR[3] = innerPort; // ADD MODULE
	*/
	/*

	// Creates a reset signal when key 1 is pressed
	wire resetInputSignal;
	UserInput_High2Low makeReset(clock,,key0, resetInputSignal);
	
	wire [1:0] ports; // 0 is open, 1 is closed
	assign ports[0] = sw2; // if switch on, outerport is closed
	assign ports[1] = sw3; // if switch on, innerport is closed
	assign LEDR[2] = ports[0]; // outer
	assign LEDR[3] = ports[1]; // innerPort // NEED LOGIC
	

	reg pressureUp, pressureDown;								// what are these?
	arriveAndDepartSignal(LEDR[0], LEDR[1], sw0, sw1, pressureUp, pressureDown, clock, resetInputSignal);
	*/
	
	// State of outer port (open or closed)
	wire OPOpenClose, OPState;
	OCPort OP(.Clock(CLOCK_50), .Reset(resetInputSignal), .SwitchFlip(sw2), .OpenClose(OPOpenClose));
	Counter_1bit OuterPort(.Clock(CLOCK_50), .Reset(resetInputSignal), .Increase(OPOpenClose), .Count(OPState));
	assign LEDR[2] = OPState;
	
	// State of inner port (open or closed)
	wire IPOpenClose, IPState;
	OCPort IP(.Clock(CLOCK_50), .Reset(resetInputSignal), .SwitchFlip(sw3), .OpenClose(IPOpenClose));
	Counter_1bit InnerPort(.Clock(CLOCK_50), .Reset(resetInputSignal), .Increase(IPOpenClose), .Count(IPState));
	assign LEDR[3] = IPState;
	
<<<<<<< HEAD
// <<<<<<< HEAD
=======
>>>>>>> 9eef407b640cd65a7e82fec6d59528ad4c6c137c
	/*
	// Creates a fillandPressurize signal when key 1 is pressed
	wire fillandPressurizeSignal, fiFPState;
	UserInput_High2Low makeFP(.Clock, .resetInputSignal, .key1, .fillandPressurizeSignal);
	Counter_1bit Pressurized(.Clock(CLOCK_50), .Reset(resetInputSignal), .Increase(fillandPressurizeSignal), .Count(FPState));
	FillandPressurize fP(.Clock(CLOCK_50), .Reset(resetInputSignal), .begin_FandP(key1), .InnerClosed(IPState), .OuterClosed(OPState), .Pressurized(FPState), .FandP(fillandPressurizeSignal));

	// Creates a fillandPressurize signal when key 2 is pressed
	wire fillandPressurizeSignal;
	UserInput_High2Low makeFP(clock, resetInputSignal, key1, fillandPressurizeSignal);
	FillandPressurize fP(clock, resetInputSignal, fillandPressurizeSignal, ports[1], ports[0]);

	
	// Creates an evacuation signal when key 2 is pressed
	wire evacuateChamberSignal;
<<<<<<< HEAD
<<<<<<< HEAD
	UserInput_High2Low makeEC(clock, resetInputSignal, key2, EvacuateChamber);     // need code using last two
	Evacuate e(Clock, Reset, begin_Evacuation, InnerClosed, OuterClosed, Evacuated, Evacuation);
	
=======
	reg ChamberIn;
	UserInput_OneClock makeEC(clock, resetInputSignal, key2, evacuateChamberSignal);     // need code using last two
	Evacuate e(clock, resetInputSignal, evacuateChamberSignal, ports[1], ports[0], ChamberIn,,);
>>>>>>> b8a4c2462c6aa2fab4042ae47a30f4305f49edf6
	*/
=======

	UserInput_OneClock makeEC(clock, resetInputSignal, key2, EvacuateChamber);     // need code using last two
	Evacuate e(Clock, Reset, begin_Evacuation, InnerClosed, OuterClosed, Evacuated, Evacuation);
	*/

	reg ChamberIn;
	UserInput_OneClock makeEC(clock, resetInputSignal, key2, evacuateChamberSignal);     // need code using last two
	Evacuate e(clock, resetInputSignal, evacuateChamberSignal, ports[1], ports[0], ChamberIn,,);
	
>>>>>>> 9eef407b640cd65a7e82fec6d59528ad4c6c137c
endmodule
