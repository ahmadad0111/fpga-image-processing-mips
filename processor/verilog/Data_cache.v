module Data_Cache(clk,cw_en,address,data_in,data_out);
input clk,cw_en;
input [9:0]address;
input [31:0]data_in;
output [31:0]data_out;
reg [31:0]data_out_reg[1023:0];
//reg [4:0]data_out;
integer i;
initial 
for(i=0;i<1024;i=i+1)
data_out_reg[i]=0;

always@(negedge clk)
if(cw_en)
data_out_reg[address]=data_in;

//always@(posedge clk)
assign data_out=data_out_reg[address];
endmodule