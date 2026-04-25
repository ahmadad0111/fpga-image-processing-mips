module IN_RAM_CU(clk,reset,addr_enable,reg_we,sort_enable,out_enable);
input clk,reset;
output reg addr_enable=0,reg_we=0,sort_enable=0,out_enable=0;
reg [4:0]counter=0;
always@(posedge clk) begin
if(~reset) begin
counter<=0;
addr_enable<=0;
reg_we<=0;
sort_enable<=0;
out_enable<=0;
end
else if(counter==5'd16) begin
counter<=1;
addr_enable<=1;
reg_we<=0;
sort_enable<=0;
out_enable<=1;
end
else if(counter<5'd2)begin
counter<=counter+1;
addr_enable<=1;
reg_we<=0;
sort_enable<=0;
out_enable<=0;
end
else if(counter==5'd2)begin
counter<=counter+1;
addr_enable<=0;
reg_we<=1;
sort_enable<=0;
out_enable<=0;
end

else if((counter>5'd2)&&(counter<=5'd4))begin
counter<=counter+1;
addr_enable<=0;
reg_we<=1;
sort_enable<=1;
out_enable<=0;
end
else if((counter>5'd4)&&(counter<5'd16))begin
counter<=counter+1;
addr_enable<=0;
reg_we<=0;
sort_enable<=1;
out_enable<=0;
end
else begin
counter<=counter+1;
addr_enable<=0;
reg_we<=0;
sort_enable<=0;
out_enable<=0;
end
end
endmodule
