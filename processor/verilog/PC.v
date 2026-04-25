module PC(PC_IN,PC_OUT,clk,reset,PC_wr,END_PC);
input reset,clk,PC_wr,END_PC;
input [8:0]PC_IN;
output [8:0]PC_OUT;
reg [8:0]PC_OUT;
always@(posedge clk )
begin
if(!reset)
PC_OUT<=9'd0;
else if(PC_wr && ~END_PC) 
PC_OUT<=PC_IN;
end
endmodule