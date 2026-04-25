module CONTROL_UNIT(opcode,reg_we,reg_Des,ALU_OP,ALU_SB,AoM,FF,BEQ,BNE,WE_DM,RE_DM,J,reset,END_PC);
input reset;
input [5:0]opcode,FF;
output [1:0]ALU_OP;
output J,reg_we,reg_Des,ALU_SB,AoM,BEQ,BNE,WE_DM,RE_DM,END_PC;
reg [1:0]ALU_OP;
reg J,reg_we,reg_Des,ALU_SB,AoM,BEQ,BNE,WE_DM,RE_DM,END_PC;
always@(opcode or reset or FF)
begin
if(!reset)
begin
	reg_we=0;
     reg_Des=0;
     ALU_OP=2'd0;
     ALU_SB=0;
     AoM=0;
     BEQ=0;
     BNE=0;
     WE_DM=0;
     RE_DM=0;
     J=0;
	   END_PC=0;
	  
end
else if(opcode==6'd1)  //Add Imidiate
begin
     reg_we=1;
     reg_Des=1;
     ALU_OP=2'd0;
     ALU_SB=1;
     AoM=0;
     BEQ=0;
     BNE=0;
     WE_DM=0;
     RE_DM=0;
     J=0;
	   END_PC=0;
	  
end
else if(opcode==6'd2)  //R-Formate
begin
     reg_we=1;
     reg_Des=0;
     ALU_SB=0;
     AoM=0;
     BEQ=0;
     BNE=0;
     WE_DM=0;
     J=0;
     RE_DM=0;
	  END_PC=0;
	  
case(FF)
     6'd0:ALU_OP=2'd0; //add
     6'd1:ALU_OP=2'd1; //sub
     6'd2:ALU_OP=2'd2; //MUL
     6'd3:ALU_OP=2'd3; //DIV
	  default:ALU_OP=2'd0;
endcase
end
else if(opcode==6'd3) begin //branch if equal
reg_we=0;
reg_Des=0;
AoM=0;
ALU_SB=0;
ALU_OP=2'd1;
WE_DM=0;
RE_DM=0;
J=0;
BEQ=1;
BNE=0;
 END_PC=0;
end
else if(opcode==6'd4) begin //load word
reg_we=1;
ALU_SB=1;
ALU_OP=2'd0;
reg_Des=1;
AoM=1;
BEQ=0;
WE_DM=0;
RE_DM=1;
J=0;
BNE=0;
 END_PC=0;
end
else if(opcode==6'd5) begin //store word
reg_we=0;
ALU_SB=1;
reg_Des=1;
AoM=0;
ALU_OP=2'd0;
BEQ=0;
WE_DM=1;
RE_DM=0;
J=0;
BNE=0;
 END_PC=0;
end
else if(opcode==6'd6) begin //jump
reg_we=0;
ALU_SB=0;
reg_Des=0;
AoM=0;
ALU_OP=2'd0;
BEQ=0;
WE_DM=0;
RE_DM=0;
J=1;
BNE=0;
 END_PC=0;
end
else if(opcode==6'd7) begin //branch if not equal
reg_we=0;
reg_Des=0;
AoM=0;
ALU_SB=0;
ALU_OP=2'd1;
WE_DM=0;
RE_DM=0;
J=0;
BEQ=0;
BNE=1;
 END_PC=0;
end
else if((opcode==6'd0) ||(opcode==6'd63)) begin //NOP
     reg_we=0;
     reg_Des=0;
     ALU_OP=2'd0;
     ALU_SB=0;
     AoM=0;
     BEQ=0;
     WE_DM=0;
     RE_DM=0;
     J=0;
     BNE=0;
	   END_PC=0;
end
else if(opcode==6'd60)begin //END 
 reg_we=0;
     reg_Des=0;
     ALU_OP=2'd0;
     ALU_SB=0;
     AoM=0;
     BEQ=0;
     WE_DM=0;
     RE_DM=0;
     J=0;
     BNE=0;
	   END_PC=1;
end
else
begin
     reg_we=0;
     reg_Des=0;
     ALU_OP=2'd0;
     ALU_SB=0;
     AoM=0; 
     BEQ=0;
     WE_DM=0;
     RE_DM=0;
     J=0;
     BNE=0; 
	  END_PC=1;
end
end
endmodule
