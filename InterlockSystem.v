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
	Metastability sw0m(clock,, SW[0], sw0);
	Metastability sw1m(clock,, SW[1], sw1);
	Metastability sw2m(clock,, SW[2], sw2);
	Metastability sw3m(clock,, SW[3], sw3);
	Metastability key0m(clock,, KEY[0], key0);
	Metastability key1m(clock,, KEY[1], key1);
	Metastability key2m(clock,, KEY[2], key2);
	
	// Creates a reset signal when key 0 is pressed
	wire resetInputSignal;  // **************metastability
	UserInput_OneClock makeReset(.Clock(CLOCK_50), .key0(key0), .resetInputSignal(resetInputSignal));
	
	wire innerPort, outerPort; // 0 is open, 1 is closed
	assign outerPort = sw2; // if switch on, outerport is closed
	assign innerPort = sw3; // if switch on, innerport is closed
	assign LEDR[2] = outerPort;
	assign LEDR[3] = innerPort; // ADD MODULE
	
	reg pressureUp, pressureDown;								// what are these?
	arriveAndDepartSignal(LEDR[0], LEDR[1], sw0, sw1, pressureUp, pressureDown, clock, resetInputSignal);
	
	// State of outer port (open or closed)
	wire OPOpenClose, OPState;
	OCPort IP(.Clock(CLOCK_50), .Reset(resetInputSignal), .SwitchFlip(sw2), .OpenClose(OPOpenClose));
	Counter_1bit OuterPort(.Clock(CLOCK_50), .Reset(resetInputSignal), .Increase(OPOpenClose), .Count(OPState));
	assign LEDR[2] = OPstate;
	
	// State of inner port (open or closed)
	wire IPOpenClose, IPState;
	OCPort IP(.Clock(CLOCK_50), .Reset(resetInputSignal), .SwitchFlip(sw3), .OpenClose(IPOpenClose));
	Counter_1bit InnerPort(.Clock(CLOCK_50), .Reset(resetInputSignal), .Increase(IPOpenClose), .Count(IPState));
	assign LEDR[3] = IPState;
	
	// Creates a fillandPressurize signal when key 1 is pressed
	wire fillandPressurizeSignal, FPState;
	UserInput_OneClock makeFP(.Clock, .resetInputSignal, .key1, .fillandPressurizeSignal);
	Counter_1bit Pressurized(.Clock(CLOCK_50), .Reset(resetInputSignal), .Increase(fillandPressurizeSignal), .Count(FPState));
	FillandPressurize fP(.Clock(CLOCK_50), .Reset(resetInputSignal), .begin_FandP(key1), .InnerClosed(IPState), .OuterClosed(OPState), .Pressurized(FPState), .FandP(fillandPressurizeSignal));
	
	// Creates an evacuation signal when key 2 is pressed
	wire evacuateChamberSignal;
	UserInput_OneClock makeEC(clock, resetInputSignal, key2, EvacuateChamber);     // need code using last two
	Evacuate e(Clock, Reset, begin_Evacuation, InnerClosed, OuterClosed, Evacuated, Evacuation);
	
endmodule
