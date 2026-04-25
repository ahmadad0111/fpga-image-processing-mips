module IFID(flush,clk,PC_OUT,instruction,InstReg,PC_Plus4Reg,IFID_wr,halt);
input [31:0]  instruction;   
input [8:0]   PC_OUT;
input clk,flush,IFID_wr,halt;   
output [31:0] InstReg;
reg [31:0] InstReg; 
output [8:0] PC_Plus4Reg; 
reg [8:0]PC_Plus4Reg;
initial begin
InstReg=0;
PC_Plus4Reg=0;
end
always@(posedge clk )    
begin      
if(flush)       
begin         
InstReg <= 32'd0;            PC_Plus4Reg <=9'd0;       
end      
else if(IFID_wr && ~halt)     begin           
InstReg <= instruction;            PC_Plus4Reg <= PC_OUT;   
end  
else begin
InstReg <=InstReg ;            PC_Plus4Reg <=PC_Plus4Reg ;   
end  
end  
endmodule