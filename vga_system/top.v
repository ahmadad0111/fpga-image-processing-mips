module vgamult(clk_100mhz, reset,OUTPUTE, rst, pixel_r, pixel_g, pixel_b, hsync, vsync, blank, clk, clk_n, D, dvi_rst, scl_tri, sda_tri,bdata);
    input clk_100mhz;
    input rst,reset;
	 output [7:0]OUTPUTE;
	 
	 output hsync;
    output vsync;
	 output blank;
	 output dvi_rst;  
	  
	 output [7:0] pixel_r; 
    output [7:0] pixel_g;  
    output [7:0] pixel_b;  
	    
	 output [11:0] D; 
	 output clk; 
	 output clk_n;
	 
	  
	 inout scl_tri, sda_tri;
	 
	 wire [9:0] pixel_x; 
	 wire [9:0] pixel_y;
	 wire [23:0] pixel_gbrg;
	 
	 assign pixel_gbrg = {pixel_g[3:0], pixel_b, pixel_r, pixel_g[7:4]}; 
	 
	 wire clkin_ibufg_out;
	 wire clk_100mhz_buf;
	 wire locked_dcm;
	 wire clk_200mhz;
	 
	 wire clk_25mhz;
	 wire clkn_25mhz;
	 wire comp_sync;
    
	 //wire shutdown;
	 
	 assign clk = clk_25mhz;
	 assign clk_n = ~clk_25mhz;
		
	 wire sda_tri;
	 wire scl_tri;
	 wire sda;
	 wire scl;
	 
//output [7:0]rdata,gdata,bdata;
output  [31:0]bdata;
reg [15:0]addr=0;	 
////////////////////////////////////////////////////////////
	// 		reg wea=1'd0;
	//	reg [23:0]dina;

//image dimension
	 /////////////////////////////////////////////////////
	 always@(posedge clk_25mhz)begin
if((pixel_x==10'd50)&&(pixel_y==10'd50))
addr<=16'd0;
else if((pixel_x>=10'd50)&&(pixel_x<10'd150)&&(pixel_y>=10'd50)&&(pixel_y<10'd150))
addr<=addr+1;
else if((pixel_x>=10'd50)&&(pixel_x<10'd150)&&(pixel_y>=10'd160)&&(pixel_y<10'd260))
addr<=addr+1;
else if((pixel_x>=10'd50)&&(pixel_x<10'd150)&&(pixel_y>=10'd270)&&(pixel_y<10'd370))
addr<=addr+1;
else if((pixel_x>=10'd50)&&(pixel_x<10'd150)&&(pixel_y>=10'd380)&&(pixel_y<10'd480))
addr<=addr+1;


end
/////////////////////////////////////////////////////////
	 assign pixel_b=((pixel_y>=10'd50)&&(pixel_y<150)&&(pixel_x>=10'd50)&&(pixel_x<150))?bdata[7:0]:((pixel_y>=10'd160)&&(pixel_y<260)&&(pixel_x>=10'd50)&&(pixel_x<150))?bdata[7:0]:((pixel_y>=10'd270)&&(pixel_y<370)&&(pixel_x>=10'd50)&&(pixel_x<150))?bdata[7:0]:((pixel_y>=10'd380)&&(pixel_y<480)&&(pixel_x>=10'd50)&&(pixel_x<150))?bdata[7:0]:8'd0;
	 assign pixel_g=((pixel_y>=10'd50)&&(pixel_y<150)&&(pixel_x>=10'd50)&&(pixel_x<150))?bdata[7:0]:((pixel_y>=10'd160)&&(pixel_y<260)&&(pixel_x>=10'd50)&&(pixel_x<150))?bdata[7:0]:((pixel_y>=10'd270)&&(pixel_y<370)&&(pixel_x>=10'd50)&&(pixel_x<150))?bdata[7:0]:((pixel_y>=10'd380)&&(pixel_y<480)&&(pixel_x>=10'd50)&&(pixel_x<150))?bdata[7:0]:8'd0;
	 assign pixel_r=((pixel_y>=10'd50)&&(pixel_y<150)&&(pixel_x>=10'd50)&&(pixel_x<150))?bdata[7:0]:((pixel_y>=10'd160)&&(pixel_y<260)&&(pixel_x>=10'd50)&&(pixel_x<150))?bdata[7:0]:((pixel_y>=10'd270)&&(pixel_y<370)&&(pixel_x>=10'd50)&&(pixel_x<150))?bdata[7:0]:((pixel_y>=10'd380)&&(pixel_y<480)&&(pixel_x>=10'd50)&&(pixel_x<150))?bdata[7:0]:8'd0;
	 	 
	 
	 //DVI Interface
	 assign dvi_rst = ~(rst|~locked_dcm);
	 assign D = (clk)? pixel_gbrg[23:12] : pixel_gbrg[11:0];
	 assign sda_tri = (sda)? 1'bz: 1'b0;
	 assign scl_tri = (scl)? 1'bz: 1'b0;
	 
	 dvi_ifc dvi1(.Clk(clk_25mhz),                     // Clock input
						.Reset_n(dvi_rst),       // Reset input
						.SDA(sda),                          // I2C data
						.SCL(scl),                          // I2C clock
						.Done(done),                        // I2C configuration done
						.IIC_xfer_done(iic_tx_done),        // IIC configuration done
						.init_IIC_xfer(1'b0)                // IIC configuration request
						);
		

/*
RAM200X200 ram (
  .clka(clk_25mhz), // input clka
  .wea(wea), // input [0 : 0] wea
  .addra(addr), // input [15 : 0] addra
  .dina(dina), // input [23 : 0] dina
  .douta(bdata) // output [23 : 0] douta
);*/
 
	 MAIN MAIN1(clk_100mhz_buf,reset,OUTPUTE,bdata,addr); 
	 //vga_clk vga_clk_gen1(clk_100mhz, rst, clk_25mhz, clkin_ibufg_out, clk_100mhz_buf, locked_dcm);
 vga_clk vga_clk_gen1 (
    .CLKIN_IN(clk_100mhz), 
    .RST_IN(rst), 
    .CLKDV_OUT(clk_25mhz), 
    .CLKIN_IBUFG_OUT(clkin_ibufg_out), 
    .CLK0_OUT(clk_100mhz_buf), 
    .CLK2X_OUT(clk_200mhz), 
    .LOCKED_OUT(locked_dcm)
    );
   
	//vga_logic  vgal1(.clk(clk_25mhz),.rst( rst|~locked_dcm),.inDisplayArea( blank),.comp_sync(comp_sync), .VGA_HSYNC(hsync), .VGA_VSYNC(vsync),.CounterX(pixel_x),.CounterY (pixel_y));
    vga_logic  vgal1(clk_25mhz, rst|~locked_dcm, blank, comp_sync, hsync, vsync, pixel_x, pixel_y);
	
endmodule 