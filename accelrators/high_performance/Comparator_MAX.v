module Comparator_MAX(Data1,Data2,Greator);
input [7:0]Data1,Data2;
output Greator;
assign Greator=(Data1>Data2)?1:0;
endmodule 