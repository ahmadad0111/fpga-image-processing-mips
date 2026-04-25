module MAIN_MAX(clk,reset,OUTPUT_MAX,IN_addr1,IN_addr2,IN_addr3,IN_data1,IN_data2,IN_data3,sort_enable,reg_we);
input clk,reset,reg_we,sort_enable;
inout [3:0]IN_addr1,IN_addr2,IN_addr3;
inout [7:0]IN_data1,IN_data2,IN_data3;
wire [3:0]addr1_1,addr2_1;
wire [7:0]Dout1_1,Dout2_1;
wire we1,G1;
wire [3:0]clk_Counter;
output [7:0]OUTPUT_MAX;
Reg_FILE_MAX RF1(.clk(clk),.we1(we1),.addr1_1(addr1_1),.addr2_1(addr2_1),.Din1_1(Dout1_1),.Din2_1(Dout2_1),.Dout1_1(Dout1_1),.Dout2_1(Dout2_1),.OUTPUT_MAX(OUTPUT_MAX),.IN_addr1(IN_addr1),.IN_addr2(IN_addr2),.IN_addr3(IN_addr3),.IN_data1(IN_data1),.IN_data2(IN_data2),.IN_data3(IN_data3),.reg_we(reg_we));


Bubble_Sort_MAX BS1(clk,reset,addr1_1,addr2_1,clk_Counter,sort_enable);
Comparator_MAX C1(.Data1(Dout1_1),.Data2(Dout2_1),.Greator(G1));
CU_MAX CU01(.G1(G1),.we1(we1));
endmodule