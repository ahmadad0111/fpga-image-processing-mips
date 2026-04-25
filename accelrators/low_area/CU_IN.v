module CU_IN(clk,reset,addr_enable,sort_enable,out_enable,addr1_en,addr2_en,addr3_en,addr_back);
input clk,reset;
output addr_enable,sort_enable,out_enable,addr1_en,addr2_en,addr3_en,addr_back;
reg addr_enable=0,sort_enable=0,out_enable=0,addr1_en=0,addr2_en=0,addr3_en=0,addr_back=0;
reg [5:0] counter=0;
always@(posedge clk)begin
if(~reset)begin
addr_enable<=0;
sort_enable<=0;
out_enable<=0;
counter<=0;
addr1_en<=0;
addr2_en<=0;
addr3_en<=0;
addr_back<=0;
end
else begin
if(counter<=6'd9)begin
if(counter>=6'd1)
addr_enable<=1;
else
addr_enable<=0;
sort_enable<=0;
out_enable<=0;
counter<=counter+1;

if(counter<6'd3)begin
addr1_en<=1;
addr2_en<=0;
addr3_en<=0;
end
else if((counter>=6'd3)&&(counter<6'd6))begin
addr1_en<=0;
addr2_en<=1;
addr3_en<=0;
end
else if((counter>=6'd6)&&(counter<6'd9))begin
addr1_en<=0;
addr2_en<=0;
addr3_en<=1;
end
addr_back<=0;
end

else if((counter>6'd9)&&(counter<=6'd45))begin
addr_enable<=0;
sort_enable<=1;
out_enable<=0;
addr1_en<=0;
addr2_en<=0;
addr3_en<=0;
counter<=counter+1;
if(counter==6'd10)
addr_back<=1;
else
addr_back<=0;
end
else if(counter==6'd46)begin
addr_enable<=0;
sort_enable<=0;
out_enable<=1;
counter<=0;
addr1_en<=0;
addr2_en<=0;
addr3_en<=0;
addr_back<=0;
end
else begin
addr_enable<=0;
sort_enable<=0;
out_enable<=0;
counter<=counter+1;
addr1_en<=0;
addr2_en<=0;
addr3_en<=0;
addr_back<=0;
end
end
end
endmodule
