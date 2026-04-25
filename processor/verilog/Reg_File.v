module  Register_Fil(reset,clk,w_e,Rs,Rd,Rt,Din,Dout1,Dout2,OUTPUT);
input reset,clk,w_e;
input [4:0]Rs,Rt,Rd;
input [31:0]Din;
output [31:0]Dout1,Dout2,OUTPUT;
reg [31:0]rf[31:0];
integer i;
always@(negedge clk or negedge reset)
begin
if(!reset)begin
for(i=0;i<32;i=i+1)
rf[i]<=32'd0;
end
else if(w_e)
rf[Rd]<=Din;
end
assign Dout1=rf[Rs];
assign Dout2=rf[Rt];
assign OUTPUT=rf[20];
endmodule
