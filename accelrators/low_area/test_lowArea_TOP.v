module test_lowArea_TOP;

	// Inputs
	reg clk;
	reg reset;

	// Outputs
	wire [7:0] dout_min;
	wire [7:0] dout_med;
	wire [7:0] dout_max;
	wire [13:0] addr_out;

	// Instantiate the Unit Under Test (UUT)
	lowArea_TOP uut (
		.clk(clk), 
		.reset(reset), 
		.dout_min(dout_min), 
		.dout_med(dout_med), 
		.dout_max(dout_max), 
		.addr_out(addr_out)
	);

	initial begin
		// Initialize Inputs
		clk = 1;
		reset = 0;
		forever #50 clk=~clk;

	end
	initial begin #100;reset=1;end
      
endmodule

