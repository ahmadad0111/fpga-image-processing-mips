module IM (reset, address, instruction);
input		reset;
input	[8:0]	address;
output	[31:0]	instruction;
reg	[31:0]	IMEM[0:511];
initial
	$readmemb ("factorial.bin", IMEM);
	assign instruction=reset?IMEM[address]:32'd0;
endmodule 
  