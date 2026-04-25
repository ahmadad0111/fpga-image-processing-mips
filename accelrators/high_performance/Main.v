module Main(clk,reset,we,d0,d1,d2,d3,d4,d5,d6,d7,d8,o0,o1,o2,o3,o4,o5,o6,o7);
input clk,reset,we;
output [7:0]d0,d1,d2,d3,d4,d5,d6,d7,d8;
output o0,o1,o2,o3,o4,o5,o6,o7;

Reg_File Reg_File0(clk,reset,we,d0,d1,d2,d3,d4,d5,d6,d7,d8,o0,o1,o2,o3,o4,o5,o6,o7);
endmodule
