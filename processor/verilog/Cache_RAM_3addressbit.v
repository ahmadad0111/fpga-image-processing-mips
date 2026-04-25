module DATA_MEMORY(clk,reset,halt,ADDRESS_ALU,DATA_OUT,WE_DM,RE_DM,DATA_IN_O,bdata,addr);
input clk,reset;
input RE_DM;
input WE_DM;
input [15:0]addr;
output [31:0]bdata;
input [31:0]ADDRESS_ALU;
reg [15:0]ADDRESS;
reg [15:0]temp;
output reg halt=0;
output  reg[31:0]DATA_OUT=0;
input [31:0]DATA_IN_O;
reg [31:0]DATA_IN=0;
reg [5:0]tag_in=0; 
wire [5:0]tag_out;
reg valid_in=0;
wire valid_out;
reg [31:0]data_in=0; 
wire [31:0]data_out;
reg [9:0]address;
reg [15:0]RAM_address;
reg cw_en=0;
wire Out;
reg w_en=0;
reg [31:0]datain=0;
wire [31:0]DataOut;
assign DataOut[31:8]=0;
assign bdata[31:8]=0;


//////////////////////////////////////////////////
integer i;
reg [9:0]ii;
reg [2:0]state=0,state_next=0;
always@(posedge clk)begin
if(~halt)begin
DATA_IN=DATA_IN_O;
ADDRESS=ADDRESS_ALU[15:0];
temp=ADDRESS_ALU[31:16];
end
if(!reset)
state=0;
else begin
state=state_next;
case(state)
3'd0:begin//idle state
     if(RE_DM)begin
     address=ADDRESS[9:0];
     RAM_address=ADDRESS;
     halt=1;
     cw_en=0;
     w_en=0;
     state_next=3'd1;end
     else if(WE_DM)begin
     address=ADDRESS[9:0];
     RAM_address=ADDRESS;
     halt=1;
     cw_en=0;
     w_en=0;
     state_next=3'd4;end
     else begin
     address=ADDRESS[9:0];
     RAM_address=ADDRESS;
     cw_en=0;
	  halt=0;
     w_en=0;
     state_next=3'd5;end
     end
3'd1:begin                               //read enable
     if(Out && valid_out)begin
     address=ADDRESS[9:0];
     RAM_address=ADDRESS;
     halt=0;
     cw_en=0;
     DATA_OUT=data_out;
     state_next=3'd0;end
     else begin 
     i=0;
     ii=0;
     state_next=3'd2;end
     end     
3'd2:begin                               //write cache mem
     if(i>=1024)begin
     i=0;
     ii=0;
     address=ADDRESS[9:0];
     RAM_address=ADDRESS;
     DATA_OUT=data_out;
     cw_en=0;
     state_next=3'd1;
     end
     else begin
     address=i;
     RAM_address={ADDRESS[15:10],ii};
     cw_en=1;
     i=i+1;
     ii=ii+1;
     state_next=3'd3;end
     end
3'd3:begin
     //address=i;//
     //cw_en=1;//
     //data_in=DataOut;//
     //tag_in=ADDRESS[4:3];//
    // valid_in=1;//
     data_in=DataOut;
     tag_in=ADDRESS[15:10];
     valid_in=1;
     state_next=3'd2;
     end
3'd4:begin
     if(Out && valid_out)begin
     address=ADDRESS[9:0];
     RAM_address=ADDRESS;
     cw_en=1;
     w_en=1;
     halt=0;
     data_in=DATA_IN;
     datain=DATA_IN;
     state_next=3'd5;end
     else begin
     address=ADDRESS[9:0];
     RAM_address=ADDRESS;
     w_en=1;
     datain=DATA_IN;
     halt=0;
     state_next=3'd0;end
     end
3'd5:begin//idle state
     if(RE_DM)begin
     address=ADDRESS[9:0];
     RAM_address=ADDRESS;
     halt=1;
     cw_en=0;
     w_en=0;
     state_next=3'd1;end
     else if(WE_DM)begin
     address=ADDRESS[9:0];
     RAM_address=ADDRESS;
     halt=1;
     cw_en=0;
     w_en=0;
     state_next=3'd4;end
     else begin
     address=ADDRESS[9:0];
     RAM_address=ADDRESS;
     cw_en=0;
     w_en=0;
	  halt=0;
     state_next=3'd0;end
     end
endcase
end

end
//always@(state)begin
//end
//////////////////////////////////////////////////
tag tag1(clk,cw_en,address,tag_in,tag_out);
Valid_Cache valid_cache1(clk,reset,cw_en,address,valid_in,valid_out);
Comparator comp(.tag1(ADDRESS[15:10]),.tag2(tag_out),.Out(Out));
Data_Cache data_cache1(clk,cw_en,address,data_in,data_out);

/*RAM_mem your_instance_name (
  .clka(clk), // input clka
  .wea(w_en), // input [0 : 0] wea
  .addra(RAM_address), // input [15 : 0] addra
  .dina(datain), // input [31 : 0] dina
  .douta(DataOut) // output [31 : 0] douta
);*/

reg wea=0;
reg [31:0]dina=0; 
/*RAM_8bit RAM_8bit (
  .clka(clk), // input clka
  .wea(wea), // input [0 : 0] wea
  .addra(addr), // input [15 : 0] addra
  .dina(dina), // input [31 : 0] dina
  .douta(bdata), // output [31 : 0] douta
  .clkb(clk), // input clkb
  .web(w_en), // input [0 : 0] web
  .addrb(RAM_address), // input [15 : 0] addrb
  .dinb(datain), // input [31 : 0] dinb
  .doutb(DataOut) // output [31 : 0] doutb
);*/

RAM_88 RAM_88(.clk(clk),.we(w_en),.addr_IN1(RAM_address),.addr_IN2(addr), .di(datain[7:0]),.do1(DataOut[7:0]),.do2(bdata[7:0]));

//RAM_5bitaddress random_mem(.clk(clk),.w_en(w_en),.address(RAM_address),.datain(datain),.DataOut(DataOut));


endmodule
