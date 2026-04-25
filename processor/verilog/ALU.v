module ALU(reset,IN1,IN2,ALU_OUT,ALU_OP);
input reset;
input [31:0]IN1,IN2;
output [31:0]ALU_OUT;
input [1:0]ALU_OP;
reg [31:0] multiply;
initial
multiply=32'd0;
always@(ALU_OP,IN1,IN2) begin
if(ALU_OP==2'b10)
multiply[31:0]<=IN1[15:0]*IN2[15:0];
else
multiply[31:0]<=32'd0;
end
assign ALU_OUT=reset?((ALU_OP==2'b00)?(IN1+IN2):(ALU_OP==2'b01)?(IN1-IN2):(ALU_OP==2'b10)?(multiply):(ALU_OP==2'b11)?(IN1>IN2):32'd0):32'd0;
endmodule 