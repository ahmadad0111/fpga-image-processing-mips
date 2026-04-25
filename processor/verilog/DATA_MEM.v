module DATA_MEM(clk,reset,ADDRESS,DATA_IN,DATA_OUT,WE_DM,RE_DM);
input clk,WE_DM,RE_DM,reset;
input [7:0]ADDRESS;
input [31:0]DATA_IN;
output [31:0]DATA_OUT;
reg [31:0]DATA_OUT;
reg [31:0]D_reg[255:0];
always@(negedge clk or negedge reset ) begin
if(!reset)
DATA_OUT<=32'd0;
else begin 
if(WE_DM)
D_reg[ADDRESS]=DATA_IN;
else if(RE_DM==1)
DATA_OUT<=D_reg[ADDRESS];
else
DATA_OUT<=32'd0;
end
end
endmodule