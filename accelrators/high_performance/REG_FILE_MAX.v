module Reg_FILE_MAX(clk,we1,addr1_1,addr2_1,Din1_1,Din2_1,Dout1_1,Dout2_1,OUTPUT_MAX,IN_addr1,IN_addr2,IN_addr3,IN_data1,IN_data2,IN_data3,reg_we);
input clk,we1,reg_we;
input [3:0]addr1_1,addr2_1,IN_addr1,IN_addr2,IN_addr3;
input [7:0]Din1_1,Din2_1,IN_data1,IN_data2,IN_data3;
output [7:0]Dout1_1,Dout2_1;
reg [7:0]REG_FILE[0:8];
output [7:0]OUTPUT_MAX;
//integer i;
//initial $readmemb("File.txt",REG_FILE);

always@(negedge clk)begin

if(reg_we)begin
REG_FILE[IN_addr1]<=IN_data1;
REG_FILE[IN_addr2]<=IN_data2;
REG_FILE[IN_addr3]<=IN_data3;
end
else if(we1)begin
		REG_FILE[addr1_1]<=Din2_1;
	        REG_FILE[addr2_1]<=Din1_1;
	        end
end
assign Dout1_1=REG_FILE[addr1_1];
assign Dout2_1=REG_FILE[addr2_1];
assign OUTPUT_MAX=REG_FILE[4'd8];
endmodule 