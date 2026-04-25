 module MAIN(clk,reset,OUTPUTE,bdata,addr);  
input clk,reset;
input  [15:0]addr;
output [31:0]bdata;
wire	  flush,halt,END_PC;
wire PC_wr,IFID_wr,Cu_Signal;
wire [8:0]PC_IN; 
wire  ZF; 
wire [8:0]PC_OUT,PC_Plus4Reg;
wire [31:0]instruction,InstReg;  
wire [5:0]opcode,FF;  
wire [4:0]Rs,Rt,Rd,Reg_DesM,Reg_DesW; 
wire [4:0]Rd_Rt_E,Rs_E,Rt_E,Rd_E; 
wire [31:0]Wr_Data,MEM_DATA_OUT,Din,Dout1,Dout2;  
wire [31:0]Dout11,Dout22,ALU_OUT,ALU_OUTM,ALU_OUTW,DATA_OUTMemW;
wire [31:0]OFF_SET,ALU_DataB,Rs_A,Rt_B,FU_ALU_SA,FU_ALU_SB;
wire [15:0]OffSet,SL_OFFSET;
wire [8:0]Branch_Offset;
wire [7:0]CU_SIGNALS;
wire reg_we,reg_Des,ALU_SB,AoM,BEQ,BNE,WE_DM,RE_DM,J,reg_weM,AoMM,WE_DMM,RE_DMM,AoMW,reg_weW;
wire [1:0]ALU_OP,Signal_A,Signal_B;
wire [31:0]OUTPUT;
output [7:0]OUTPUTE; 
parameter a=16'b1111111111111111;
parameter b=16'b0000000000000000;   
assign opcode=InstReg[31:26];     
assign FF=InstReg[5:0];   
assign Rs=reset?InstReg[25:21]:5'd0; 
assign Rt=reset?InstReg[20:16]:5'd0;
assign Rd=reset?(reg_Des?InstReg[20:16]:InstReg[15:11]):(5'd0);
///////////////////////////////////////////////////////////////
assign OffSet[15:0]=reset?InstReg[15:0]:16'd0;
assign OFF_SET[15:0]=reset?SL_OFFSET[15:0]:16'd0;
assign OFF_SET[31:16]=reset?(SL_OFFSET[15]?b:b):16'd0;

///////////////////////////////////////////////////////////////////////////  
assign Branch_Offset=halt?Branch_Offset:(reset?InstReg[8:0]:9'd0);
wire [1:0]s1,s2;

assign Dout11=(s1==2'b00)?Dout1:(s1==2'b10)?ALU_OUTM:(s1==2'b01)?Din:Dout1;
assign Dout22=(s2==2'b00)?Dout2:(s2==2'b10)?ALU_OUTM:(s2==2'b01)?Din:Dout2;

assign ZF=(Dout11-Dout22==32'd0)?1:0;
//////////////////////////////////////////////////////////////////////////////////////////////////////
wire bb;
assign PC_IN=halt?PC_IN:(reset?(((ZF&&BEQ==1)||(J==1)||(~ZF&&BNE==1))?PC_Plus4Reg+Branch_Offset:PC_OUT+1):9'd0);
assign flush=((ZF&&(BEQ&&bb) ==1)||(J==1)||(~ZF&&(BNE&&bb)==1))?1:0;
//////////////////////////////////////////////////////////////////////////////////////////////////////

PC PC1(PC_IN,PC_OUT,clk,reset,PC_wr,END_PC);
IM IM1(.reset(reset), .address(PC_OUT), .instruction(instruction));
IFID IFID1(flush,clk,PC_OUT,instruction,InstReg,PC_Plus4Reg,IFID_wr,halt);
//Hd_Unit Hd_Unit1(.Rs(Rs),.Rt(Rt),.Rt_E(Rt_E),.Ex_MemRead(CU_SIGNALS[5]),.PC_wr(PC_wr),.IFID_wr(IFID_wr),.Cu_Signal(Cu_Signal));
Hd_Unit Hd_UNIT1(.bb(bb),.Rs(Rs),.Rt(Rt),.Rt_E(Rt_E),.Ex_MemRead(CU_SIGNALS[5]),.PC_wr(PC_wr),.IFID_wr(IFID_wr),.Cu_Signal(Cu_Signal),.Rd_E(Rd_E),.opcode(opcode),.RegDes_M(Reg_DesM),.RE_DMM(RE_DMM));
F_UNIT F_UNIT2(.reg_weM(reg_weM),.reg_weW(reg_weW),.Rs_E(Rs),.Rt_E(Rt),.Reg_DesM(Reg_DesM),.Reg_DesW(Reg_DesW),.Signal_A(s1),.Signal_B(s2));
CONTROL_UNIT CU(opcode,reg_we,reg_Des,ALU_OP,ALU_SB,AoM,FF,BEQ,BNE,WE_DM,RE_DM,J,reset,END_PC);
Register_Fil Reg_File(.reset(reset),.clk(clk),.w_e(reg_weW),.Rs(Rs),.Rd(Reg_DesW),.Rt(Rt),.Din(Din),.Dout1(Dout1),.Dout2(Dout2),.OUTPUT(OUTPUT));


assign OUTPUTE=OUTPUT[7:0];


ID_IE ID_IE1(reg_we,reg_Des,ALU_SB,AoM,WE_DM,RE_DM,ALU_OP,Dout1,Dout2,OffSet,Rs,Rt,Rd,CU_SIGNALS,Rs_A,Rt_B,SL_OFFSET,Rs_E,Rt_E,Rd_E,clk,reset,Cu_Signal,halt);
//////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////     F.U      /////////////////////////////////////////////////////////
///////////////////////////////////              /////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////
F_UNIT F_UNIT1(reg_weM,reg_weW,Rs_E,Rt_E,Reg_DesM,Reg_DesW,Signal_A,Signal_B);
assign FU_ALU_SA=(Signal_A==2'b00)?Rs_A:(Signal_A==2'b10)?ALU_OUTM:(Signal_A==2'b01)?Din:Rs_A;
assign FU_ALU_SB=(Signal_B==2'b00)?Rt_B:(Signal_B==2'b10)?ALU_OUTM:(Signal_B==2'b01)?Din:Rt_B;
assign ALU_DataB=CU_SIGNALS[2]?OFF_SET:FU_ALU_SB;
///////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////
ALU ALU1(.reset(reset),.IN1(FU_ALU_SA),.IN2(ALU_DataB),.ALU_OUT(ALU_OUT),.ALU_OP(CU_SIGNALS[7:6]));


assign Rd_Rt_E=CU_SIGNALS[1]?Rt_E:Rd_E;

IEMEM IEMEM1(.clk(clk),.reset(reset),.reg_we(CU_SIGNALS[0]),.AoM(CU_SIGNALS[3]),.WE_DM(CU_SIGNALS[4]),.RE_DM(CU_SIGNALS[5]),.ALU_OUT(ALU_OUT),.Rt_B(FU_ALU_SB),.Reg_Des(Rd_Rt_E),.reg_weM(reg_weM),.AoMM(AoMM),.WE_DMM(WE_DMM),.RE_DMM(RE_DMM),.ALU_OUTM(ALU_OUTM),.Wr_Data(Wr_Data),. Reg_DesM(Reg_DesM),.halt(halt));


DATA_MEMORY DATA_MEMORY1(.clk(clk),.reset(reset),.halt(halt),.ADDRESS_ALU(ALU_OUTM),.DATA_OUT(MEM_DATA_OUT),.WE_DM(WE_DMM),.RE_DM(RE_DMM),.DATA_IN_O(Wr_Data),.bdata(bdata),.addr(addr));
//DATA_MEM DATA_MEM1(.clk(clk),.reset(reset),.ADDRESS(ALU_OUTM[7:0]),.DATA_IN(Wr_Data),.DATA_OUT(MEM_DATA_OUT),.WE_DM(WE_DMM),.RE_DM(RE_DMM));
IM_WB IM_WB1(.clk(clk),.reset(reset),.reg_weM(reg_weM),.AoMM(AoMM),.ALU_OUTM(ALU_OUTM),.DATA_OUTMem(MEM_DATA_OUT),.Reg_DesM(Reg_DesM),.ALU_OUTW(ALU_OUTW),.DATA_OUTMemW(DATA_OUTMemW),.Reg_DesW(Reg_DesW),.reg_weW(reg_weW),.AoMW(AoMW),.halt(halt));
assign Din=AoMW?MEM_DATA_OUT:ALU_OUTW;

//assign OUTPUT=reset?(((opcode==6'd0) ||(opcode==6'd63))?OUTPUT[7:0]:Din[7:0]):8'd0;
endmodule
