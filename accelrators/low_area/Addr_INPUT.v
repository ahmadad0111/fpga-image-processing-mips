module Addr_INPUT(clk,reset,addr_enable,address);
input clk,reset,addr_enable;
output [3:0]address;
reg [3:0]address=0;

always@(posedge clk)begin
if(~reset || ~addr_enable)
address<=0;
else
address<=address+1;
end
endmodule
