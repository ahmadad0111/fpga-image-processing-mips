module Comparator_MIN(Data1,Data2,Smaller);
input [7:0]Data1,Data2;
output Smaller;
assign Smaller=(Data1<Data2)?1:0;
endmodule 