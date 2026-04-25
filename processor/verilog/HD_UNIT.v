module Hd_Unit (bb,Rs,Rt,Rt_E,Ex_MemRead,PC_wr,IFID_wr,Cu_Signal,Rd_E,opcode,RegDes_M,RE_DMM);
input [4:0]Rs,Rt,Rt_E,Rd_E,RegDes_M;
input [5:0]opcode;
input Ex_MemRead,RE_DMM;
output PC_wr,Cu_Signal,IFID_wr,bb;
reg PC_wr,IFID_wr,Cu_Signal,bb;
always@(Rs,Rt,Rt_E,Ex_MemRead,Rd_E,opcode,RegDes_M,RE_DMM)
begin
if(Ex_MemRead && ((Rt_E==Rs)||(Rt_E==Rt)))
begin
IFID_wr<=0;
PC_wr<=0;
Cu_Signal<=1;
end
else if((((opcode==6'd3)||(opcode==6'd7))&&(RE_DMM&&(RegDes_M==Rs ||RegDes_M==Rt)))||(((opcode==6'd3)||(opcode==6'd7))&&(Rd_E == Rs || Rd_E==Rt)))
begin
IFID_wr<=0;
PC_wr<=0;
Cu_Signal<=0;
bb<=0;
end
else
begin
PC_wr<=1;
IFID_wr<=1;
Cu_Signal<=0;
bb<=1;
end
end
endmodule
