module Addr_INPUTRAM(clk,reset,address_input,addr1_en,addr2_en,addr3_en,addr_back);
input clk,reset,addr1_en,addr2_en,addr3_en,addr_back;
output [13:0]address_input;
reg [13:0]addr1=0,addr2=100,addr3=200;
always@(posedge clk)begin
if(~reset)begin
//address_input<=0;
addr1<=0;
addr2<=14'd100;
addr3<=14'd200;
end
else begin
if(addr1_en)begin
//address_input<=addr1;
addr1<=addr1+1;
addr2<=addr2;
addr3<=addr3;
end
else if(addr2_en)begin
//address_input<=addr2;
addr1<=addr1;
addr2<=addr2+1;
addr3<=addr3;
end
else if(addr3_en)begin
//address_input<=addr3;
addr1<=addr1;
addr2<=addr2;
addr3<=addr3+1;
end
else if(addr_back)begin
addr1<=addr1-2;
addr2<=addr2-2;
addr3<=addr3-3;
end
end
end
assign address_input=reset?(addr1_en?addr1:(addr2_en?addr2:(addr3_en?addr3:address_input))):0;
endmodule
