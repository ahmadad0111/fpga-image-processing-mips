module test_MAIN;

	// Inputs
	reg clk;
	reg reset;
	reg sort_enable;
	reg reg_we;

	// Outputs
	wire [7:0] OUTPUT_MAX,OUTPUT_MIN,OUTPUT_MED;
	wire [5:0]clk_Counter;
	wire [3:0]addr1_1,addr2_1;
	
	// Bidirs
	wire [3:0] IN_addr1;

	wire [7:0] IN_data1;


	// Instantiate the Unit Under Test (UUT)
	MAIN uut (
		.clk(clk), 
		.reset(reset), 
		.OUTPUT_MAX(OUTPUT_MAX),.OUTPUT_MIN(OUTPUT_MIN),.OUTPUT_MED(OUTPUT_MED), 
		.IN_addr1(IN_addr1),  
		.IN_data1(IN_data1), 
		.sort_enable(sort_enable), 
		.reg_we(reg_we),.clk_Counter(clk_Counter),.addr1_1(addr1_1),.addr2_1(addr2_1)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		reset = 0;
		sort_enable = 1;
		reg_we = 0;
		forever #50 clk=~clk;

	end
	initial begin #100; reset=1;end
      
endmodule

