module IN_REGF_addr(clk,reset,addr_enable,IN_addr1,IN_addr2,IN_addr3);
input clk,reset,addr_enable;
output reg [3:0]IN_addr1,IN_addr2,IN_addr3;

always@(posedge clk)begin
	if(addr_enable || ~reset)begin
		IN_addr1<=0;
		IN_addr2<=4'd1;
		IN_addr3<=4'd2;
	end
	else begin
		IN_addr1<=IN_addr1+3;
		IN_addr2<=IN_addr2+3;
		IN_addr3<=IN_addr3+3;
	end	
end
endmodule
