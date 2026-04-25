module Bubble_Sort_MIN(clk,reset,addr1_1,addr2_1,clk_Counter,sort_enable);
input clk,reset,sort_enable;
output [3:0]addr1_1,addr2_1;
reg [3:0]addr1_1=0,addr2_1=1;
output [3:0]clk_Counter;
reg [3:0]clk_Counter=0;
always@(posedge clk)begin
if(!reset || ~sort_enable) begin
	addr1_1<=0;
	addr2_1<=1;
	clk_Counter<=0;
	end
else if(sort_enable) begin
if(clk_Counter==4'd12)
clk_Counter<=clk_Counter;
else
clk_Counter<=clk_Counter+1;

if(clk_Counter==0)begin
	addr1_1<=0;
	addr2_1<=1;
	end
else    begin
	addr1_1<=addr1_1+1;
	addr2_1<=addr2_1+1;
	end
end
else;
end
endmodule