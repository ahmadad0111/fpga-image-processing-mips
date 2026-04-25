module test_CU_IN;

	// Inputs
	reg clk;
	reg reset;

	// Outputs
	wire addr_enable;
	wire sort_enable;
	wire out_enable;
	wire addr1_en;
	wire addr2_en;
	wire addr3_en;

	// Instantiate the Unit Under Test (UUT)
	CU_IN uut (
		.clk(clk), 
		.reset(reset), 
		.addr_enable(addr_enable), 
		.sort_enable(sort_enable), 
		.out_enable(out_enable), 
		.addr1_en(addr1_en), 
		.addr2_en(addr2_en), 
		.addr3_en(addr3_en)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		reset = 0;
		forever #50 clk=~clk;

	end
	initial begin #100;reset=1;end
      
endmodule

