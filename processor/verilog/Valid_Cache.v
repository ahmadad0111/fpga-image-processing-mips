module Valid_Cache(clk,reset,cw_en,address,valid_in,valid_out);
input clk,reset,valid_in,cw_en;
input [9:0]address;
output  valid_out;
reg valid_out_reg[1023:0];
//reg valid_out;
integer j;
initial 
for(j=0;j<1024;j=j+1)
valid_out_reg[j]=0;
integer i;
always@(negedge clk) begin
if(reset && cw_en)
valid_out_reg[address]=valid_in;
else if(!reset)
for(i=0;i<1023;i=i+1)
valid_out_reg[i]=1'd0;
end

//always@(posedge clk)
assign valid_out=valid_out_reg[address];

endmodule