module IEMEM(clk,reset,reg_we,AoM,WE_DM,RE_DM,ALU_OUT,Rt_B,Reg_Des,reg_weM,AoMM,WE_DMM,RE_DMM,ALU_OUTM,Wr_Data,Reg_DesM,halt);
input reg_we,AoM,WE_DM,RE_DM,clk,reset,halt;
input [31:0]ALU_OUT,Rt_B;
input [4:0]Reg_Des;
output reg [31:0]ALU_OUTM,Wr_Data;
output reg reg_weM,AoMM,WE_DMM,RE_DMM;
output reg [4:0]Reg_DesM;

always@(posedge clk or negedge reset)
begin
if(!reset) begin
ALU_OUTM<=0;
Wr_Data<=0;
reg_weM<=0;
AoMM<=0;
WE_DMM<=0;
RE_DMM<=0;
Reg_DesM<=0;
end
else if(halt)begin
ALU_OUTM<=ALU_OUTM;
Wr_Data<=Wr_Data;
reg_weM<=reg_weM;
AoMM<=AoMM;
WE_DMM<=WE_DMM;
RE_DMM<=RE_DMM;
Reg_DesM<=Reg_DesM;
end
else begin
ALU_OUTM<=ALU_OUT;
Wr_Data<=Rt_B;
reg_weM<=reg_we;
AoMM<=AoM;
WE_DMM<=WE_DM;
RE_DMM<=RE_DM;
Reg_DesM<=Reg_Des;
end
end
endmodule
