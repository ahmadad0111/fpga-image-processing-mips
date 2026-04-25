module RAM_88(clk,we,addr_IN1,addr_IN2, di,do1,do2);

input clk;
input we;
input [15:0] addr_IN1,addr_IN2;
input [7:0] di;
output reg [7:0] do1=0,do2=0; 

reg [7:0] ram [0:39999];
reg [7:0] do11=0,do22=0;

initial $readmemh("image.txt",ram);
always @(posedge clk) begin  
if (we)    ram[addr_IN1] <= di;  

do11 <= ram[addr_IN1];
do22 <= ram[addr_IN2];

do1 <= do11;
do2 <= do22;
end
endmodule  