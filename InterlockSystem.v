module InterlockSystem(CLOCK_50, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, LEDR,
SW);
	
	input CLOCK_50; // 50MHz clock.
	output reg [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	output [9:0] LEDR;
	input [3:0] KEY; // True when not pressed, False when pressed
	input [9:0] SW;
	
	wire [31:0] divided_clocks;
	wire [3:0] CounterLights;
	
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
	
	// Creates a reset signal when key 1 is pressed
	wire resetInputSignal;
	UserInput_OneClock makeReset(clock,,key0, resetInputSignal);
	
	wire [1:0] ports; // 0 is open, 1 is closed
	assign ports[0] = sw2; // if switch on, outerport is closed
	assign ports[1] = sw3; // if switch on, innerport is closed
	assign LEDR[2] = ports[0]; // outer
	assign LEDR[3] = ports[1]; // innerPort // NEED LOGIC
	
	reg pressureUp, pressureDown;								// what are these?
	arriveAndDepartSignal(LEDR[0], LEDR[1], sw0, sw1, pressureUp, pressureDown, clock, resetInputSignal);
	
	// Creates a fillandPressurize signal when key 2 is pressed
	wire fillandPressurizeSignal;
	UserInput_OneClock makeFP(clock, resetInputSignal, key1, fillandPressurizeSignal);
	FillandPressurize fP(clock, resetInputSignal, fillandPressurizeSignal, ports[1], ports[0]);
	
	// Creates an evacuation signal when key 3 is pressed
	wire evacuateChamberSignal;
	reg ChamberIn;
	UserInput_OneClock makeEC(clock, resetInputSignal, key2, evacuateChamberSignal);     // need code using last two
	Evacuate e(clock, resetInputSignal, evacuateChamberSignal, ports[1], ports[0], ChamberIn,,);
	
endmodule
