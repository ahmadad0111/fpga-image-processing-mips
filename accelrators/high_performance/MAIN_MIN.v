module MAIN_MIN(clk,reset,OUTPUT_MIN,IN_addr1,IN_addr2,IN_addr3,IN_data1,IN_data2,IN_data3,sort_enable,reg_we);
input clk,reset,reg_we,sort_enable;
inout [3:0]IN_addr1,IN_addr2,IN_addr3;
inout [7:0]IN_data1,IN_data2,IN_data3;
wire [3:0]addr1_1,addr2_1;
wire [7:0]Dout1_1,Dout2_1;
wire we1,S1;
wire [3:0]clk_Counter;
output [7:0]OUTPUT_MIN;
Reg_FILE_MIN RF1(.clk(clk),.we1(we1),.addr1_1(addr1_1),.addr2_1(addr2_1),.Din1_1(Dout1_1),.Din2_1(Dout2_1),.Dout1_1(Dout1_1),.Dout2_1(Dout2_1),.OUTPUT_MIN(OUTPUT_MIN),.IN_addr1(IN_addr1),.IN_addr2(IN_addr2),.IN_addr3(IN_addr3),.IN_data1(IN_data1),.IN_data2(IN_data2),.IN_data3(IN_data3),.reg_we(reg_we));


Bubble_Sort_MIN BS1(clk,reset,addr1_1,addr2_1,clk_Counter,sort_enable);
Comparator_MIN C1(.Data1(Dout1_1),.Data2(Dout2_1),.Smaller(S1));
CU_MIN CU01(.S1(S1),.we1(we1));
endmodule