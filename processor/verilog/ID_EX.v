module ID_IE(reg_we,reg_Des,ALU_SB,AoM,WE_DM,RE_DM,ALU_OP,Dout1,Dout2,OffSet,Rs,Rt,Rd,CU_SIGNALS,Rs_A,Rt_B,SL_OFFSET,Rs_E,Rt_E,Rd_E,clk,reset,Cu_Signal,halt);
input reg_we,reg_Des,ALU_SB,AoM,WE_DM,RE_DM,Cu_Signal,halt;
input [1:0]ALU_OP;
input [31:0]Dout1,Dout2;
input [15:0]OffSet;
input [4:0]Rs,Rt,Rd;
output reg [7:0]CU_SIGNALS;
output reg [31:0]Rs_A,Rt_B;
output reg [15:0]SL_OFFSET;
output reg [4:0]Rs_E,Rt_E,Rd_E;
input clk,reset;
always@(posedge clk or negedge reset)
begin
if(!reset) begin
CU_SIGNALS<=0;
Rs_A<=0;
Rt_B<=0;
SL_OFFSET<=0;
Rs_E<=0;
Rt_E<=0;
Rd_E<=0;
end
else begin
if(Cu_Signal)begin
CU_SIGNALS<=0;
Rs_A<=0;
Rt_B<=0;
SL_OFFSET<=0;
Rs_E<=0;
Rt_E<=0;
Rd_E<=0;
end
else if(halt) begin
Rs_E<=Rs_E;
Rt_E<=Rt_E;
Rd_E<=Rd_E;
CU_SIGNALS<=CU_SIGNALS;
Rs_A<=Rs_A;
Rt_B<=Rt_B;
SL_OFFSET<=SL_OFFSET;
end
else begin
Rs_E<=Rs;
Rt_E<=Rt;
Rd_E<=Rd;
CU_SIGNALS[0]<=reg_we;
CU_SIGNALS[1]<=reg_Des;
CU_SIGNALS[2]<=ALU_SB;
CU_SIGNALS[3]<=AoM;
CU_SIGNALS[4]<=WE_DM;
CU_SIGNALS[5]<=RE_DM;
CU_SIGNALS[7:6]<=ALU_OP;
Rs_A<=Dout1;
Rt_B<=Dout2;
SL_OFFSET<=OffSet;
end
end
end
endmodule

