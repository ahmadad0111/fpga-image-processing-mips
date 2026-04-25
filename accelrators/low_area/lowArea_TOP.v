module lowArea_TOP(clk,clkb,reset,addr_in,addr_min,addr_med,addr_max,dout_in,dout_min,dout_med,dout_max);
input clk,clkb,reset;
input [13:0]addr_in,addr_min,addr_med,addr_max;
wire sort_enable,addr_enable,out_enable,addr1_en,addr2_en,addr3_en,addr_back;
wire [13:0]address_input;
wire [7:0]data_out;
wire [7:0]data_outa;
wire [7:0]OUTPUT_MAX,OUTPUT_MIN,OUTPUT_MED;
wire [3:0]address;
reg [13:0]addr_out=14'd101;
reg temp=0;
output [7:0]dout_in,dout_min,dout_med,dout_max;

always@(negedge clk)begin
	if(~reset) begin
		addr_out<=14'd101;
		temp<=0;
		end
	else begin
		if((out_enable)&&(temp==0)&&(addr_out<14'd9998))begin
			addr_out<=addr_out+1;
			temp<=1;
			end
	else if(~out_enable)
			temp<=0;
		else if(addr_out==14'd9998)
			addr_out<=addr_out;
		else
			;
	end
end

CU_IN CU_IN0(clk,reset,addr_enable,sort_enable,out_enable,addr1_en,addr2_en,addr3_en,addr_back);
Addr_INPUTRAM Addr_INPUTRAM0(clk,reset,address_input,addr1_en,addr2_en,addr3_en,addr_back);
INPUT_IMAGE  INPUT_IMAGE0(
  .clka(clk), // input clka
  .addra(address_input), // input [13 : 0] addra
  .douta(data_out), // output [7 : 0] douta
  .clkb(clkb), // input clkb
  .addrb(addr_in), // input [13 : 0] addrb
  .doutb(dout_in) // output [7 : 0] doutb
);
MAIN MAIN0(.clk(clk),.reset(reset),.OUTPUT_MAX(OUTPUT_MAX),.OUTPUT_MIN(OUTPUT_MIN),.OUTPUT_MED(OUTPUT_MED),.IN_addr1(address),.IN_data1(data_out),.sort_enable(sort_enable),.reg_we(addr_enable));
Addr_INPUT Addr_INPUT0(.clk(clk),.reset(reset),.addr_enable(addr_enable),.address(address));
OUTPUT_MIN OUTPUT_MIN0(
  .clka(clk), // input clka
  .wea(out_enable), // input [0 : 0] wea
  .addra(addr_out), // input [13 : 0] addra
  .dina(OUTPUT_MIN), // input [7 : 0] dina
  .clkb(clkb), // input clkb
  .addrb(addr_min), // input [13 : 0] addrb
  .doutb(dout_min) // output [7 : 0] doutb
);
OUTPUT_MED OUTPUT_MED0 (
  .clka(clk), // input clka
  .wea(out_enable), // input [0 : 0] wea
  .addra(addr_out), // input [13 : 0] addra
  .dina(OUTPUT_MED), // input [7 : 0] dina
  .clkb(clkb), // input clkb
  .addrb(addr_med), // input [13 : 0] addrb
  .doutb(dout_med) // output [7 : 0] doutb
);
OUTPUT_MAX OUTPUT_MAX0(
  .clka(clk), // input clka
  .wea(out_enable), // input [0 : 0] wea
  .addra(addr_out), // input [13 : 0] addra
  .dina(OUTPUT_MAX), // input [7 : 0] dina
  .clkb(clkb), // input clkb
  .addrb(addr_max), // input [13 : 0] addrb
  .doutb(dout_max) // output [7 : 0] doutb
);
endmodule
