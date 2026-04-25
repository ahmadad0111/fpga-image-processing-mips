module IM_WB(clk,reset,reg_weM,AoMM,ALU_OUTM,DATA_OUTMem,Reg_DesM,ALU_OUTW,DATA_OUTMemW,Reg_DesW,reg_weW,AoMW,halt);
input clk,reset,reg_weM,AoMM,halt;
input [31:0]ALU_OUTM,DATA_OUTMem;
input [4:0]Reg_DesM;
output reg [31:0]ALU_OUTW,DATA_OUTMemW;
output reg [4:0]Reg_DesW;
output reg reg_weW,AoMW;

always@(posedge clk or negedge reset)
begin
if(!reset) begin
ALU_OUTW<=0;
DATA_OUTMemW<=0;
reg_weW<=0;
AoMW<=0;
Reg_DesW<=0;
end
else if(halt)begin
AoMW<=AoMW;
ALU_OUTW<=ALU_OUTW;
DATA_OUTMemW<=DATA_OUTMemW;
reg_weW<=reg_weW;
Reg_DesW<=Reg_DesW;
end
else begin
AoMW<=AoMM;
ALU_OUTW<=ALU_OUTM;
DATA_OUTMemW<=DATA_OUTMem;
reg_weW<=reg_weM;
Reg_DesW<=Reg_DesM;
end
end
endmodule

