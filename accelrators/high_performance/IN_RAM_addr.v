module IN_RAM_addr(clk,reset,addr_enable,addr1,addr2,addr3);
input clk,reset,addr_enable;
output [13:0] addr1,addr2,addr3;
reg [13:0] addr1=0;
reg [13:0] addr2=16'd100;
reg [13:0] addr3=16'd200;
reg temp=1;

always@(posedge clk )begin
	if(~reset)begin
		addr1<=0;
		addr2<=14'd100;
		addr3<=14'd200;
	end
	else if(addr_enable) begin
		addr1<=addr1+1;
		addr2<=addr2+1;
		addr3<=addr3+1;
		temp<=0;
	end
	else begin
		if(~temp)begin
		addr1<=addr1-1;
		addr2<=addr2-1;
		addr3<=addr3-1;
		temp<=1;
		end
	end
end
endmodule