module IN_TOP(clk,clkb,reset,addr_max,max_out,addr_min,min_out);
input clk,clkb,reset;
input [13:0]addr_min,addr_max;
wire addr_enable,reg_we,sort_enable,out_enable;
wire [13:0]addr1,addr2,addr3;
reg [13:0]addr_out=14'd100;
reg temp=0;
wire [7:0]OUTPUT_MIN,OUTPUT_MAX;
output [7:0]min_out,max_out;

always@(negedge clk)begin
	if(~reset) begin
		addr_out<=14'd100;
		end
	else begin
		if((out_enable) &&(addr_out<14'd9898))
			addr_out<=addr_out+1;
		else 
			addr_out<=addr_out;
	end
end
reg we=0;
reg [7:0]di=0;
wire [7:0]do1,do2,do3;
wire [3:0]IN_addr1,IN_addr2,IN_addr3;
IN_RAM_CU IN_RAM_CU1(clk,reset,addr_enable,reg_we,sort_enable,out_enable);
IN_RAM_addr IN_RAM_addr1(clk,reset,addr_enable,addr1,addr2,addr3);
IN_RAMv IN_RAMv1(clk, we, addr1,addr2,addr3,di, do1,do2,do3);
IN_REGF_addr IN_REGF_addr1(clk,reset,addr_enable,IN_addr1,IN_addr2,IN_addr3);
MAIN_MAX MAIN_MAX00(.clk(clk),.reset(reset),.OUTPUT_MAX(OUTPUT_MAX),.IN_addr1(IN_addr1),.IN_addr2(IN_addr2),.IN_addr3(IN_addr3),.IN_data1(do1),.IN_data2(do2),.IN_data3(do3),.sort_enable(sort_enable),.reg_we(reg_we));
MAIN_MIN MAIN_MIN00(.clk(clk),.reset(reset),.OUTPUT_MIN(OUTPUT_MIN),.IN_addr1(IN_addr1),.IN_addr2(IN_addr2),.IN_addr3(IN_addr3),.IN_data1(do1),.IN_data2(do2),.IN_data3(do3),.sort_enable(sort_enable),.reg_we(reg_we));
OUTPUT_RAM_MAX OUTPUT_RAM_MAX01 (
  .clka(clk), // input clka
  .wea(out_enable), // input [0 : 0] wea
  .addra(addr_out), // input [13 : 0] addra
  .dina(OUTPUT_MAX), // input [7 : 0] dina
  .clkb(clkb), // input clkb
  .addrb(addr_max), // input [13 : 0] addrb
  .doutb(max_out) // output [7 : 0] doutb
);
OUTPUT_RAM_MIN OUTPUT_RAM_MIN01 (
  .clka(clk), // input clka
  .wea(out_enable), // input [0 : 0] wea
  .addra(addr_out), // input [13 : 0] addra
  .dina(OUTPUT_MIN), // input [7 : 0] dina
  .clkb(clkb), // input clkb
  .addrb(addr_min), // input [13 : 0] addrb
  .doutb(min_out) // output [7 : 0] doutb
);
endmodule

