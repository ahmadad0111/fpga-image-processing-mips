module IN_RAMv(clk, we, addr1,addr2,addr3,di, do1,do2,do3);

input clk;
input we;
input [13:0] addr1,addr2,addr3;
input [7:0] di;
output reg [7:0] do1=0,do2=0,do3=0; 

reg [7:0] ram [0:9999];
reg [7:0] do11=0,do22=0,do33=0;

initial $readmemh("abc.txt",ram);
always @(posedge clk) begin   
if (we)    ram[addr1] <= di;  

do11 <= ram[addr1];
do22 <= ram[addr2];
do33 <= ram[addr3];

do1 <= do11;
do2 <= do22;
do3 <= do33;
end
endmodule 