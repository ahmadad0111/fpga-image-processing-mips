module F_UNIT(reg_weM,reg_weW,Rs_E,Rt_E,Reg_DesM,Reg_DesW,Signal_A,Signal_B);
input [4:0]Rs_E,Rt_E,Reg_DesM,Reg_DesW;
input reg_weM,reg_weW;
output reg [1:0]Signal_A,Signal_B;

always@(reg_weM or Reg_DesM or reg_weW or Reg_DesW or Rs_E)  
   begin   
       if((reg_weM)&&(Reg_DesM != 0)&&(Reg_DesM == Rs_E))      
           Signal_A <= 2'b10;       
       else if((reg_weW)&&(Reg_DesW != 0)&&(Reg_DesW == Rs_E) )   
           Signal_A <= 2'b01;      
        else         
           Signal_A <= 2'b00;  
        end  
always@(reg_weM or Reg_DesM  or reg_weW or Reg_DesW or Rt_E)  
   begin 
       if((reg_weM)&&(Reg_DesM != 0)&&(Reg_DesM == Rt_E))      
           Signal_B <= 2'b10;       
       else if((reg_weW)&&(Reg_DesW != 0)&&(Reg_DesW == Rt_E) )   
           Signal_B <= 2'b01;      
        else         
           Signal_B <= 2'b00;  
        end   
endmodule