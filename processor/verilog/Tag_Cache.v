module tag(clk,cw_en,address,tag_in,tag_out);
input clk,cw_en;
input [9:0]address;
input [5:0]tag_in;
output [5:0]tag_out;
reg [5:0]tag_out_reg[1023:0];
//reg [1:0]tag_out;
integer i;
initial 
for(i=0;i<1024;i=i+1)
tag_out_reg[i]=6'd0;
always@(negedge clk)
if(cw_en)
tag_out_reg[address]=tag_in;
//always@(posedge clk)
assign tag_out=tag_out_reg[address];
endmodule