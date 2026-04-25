module Comparator(tag1,tag2,Out);
input [5:0]tag1,tag2;
output  Out;
wire Out=(tag1==tag2);
endmodule


