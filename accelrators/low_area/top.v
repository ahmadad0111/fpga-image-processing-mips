module vgamult(clk_100mhz, reset, rst, pixel_r, pixel_g, pixel_b, hsync, vsync, blank, clk, clk_n, D, dvi_rst, scl_tri, sda_tri,dout_in,dout_min,dout_med,dout_max);
    input clk_100mhz;
    input rst,reset;
	 
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
output  [7:0]dout_in,dout_min,dout_med,dout_max;
reg [13:0]addr_in=0,addr_min=0,addr_med,addr_max;	 


	 always@(posedge clk_25mhz)begin
if((pixel_x==10'd50)&&(pixel_y==10'd50))
addr_in<=14'd0;
else if((pixel_x>=10'd50)&&(pixel_x<10'd150)&&(pixel_y>=10'd50)&&(pixel_y<10'd150))
addr_in<=addr_in+1;
else if((pixel_x==10'd300)&&(pixel_y==10'd50))
addr_min<=14'd0;
else if((pixel_x>=10'd300)&&(pixel_x<10'd400)&&(pixel_y>=10'd50)&&(pixel_y<10'd150))
addr_min<=addr_min+1;
//////////////////////
if((pixel_x==10'd50)&&(pixel_y==10'd160))
addr_med<=14'd0;
else if((pixel_x>=10'd50)&&(pixel_x<10'd150)&&(pixel_y>=10'd160)&&(pixel_y<10'd260))
addr_med<=addr_med+1;
else if((pixel_x==10'd300)&&(pixel_y==10'd260))
addr_max<=14'd0;
else if((pixel_x>=10'd300)&&(pixel_x<10'd400)&&(pixel_y>=10'd160)&&(pixel_y<10'd260))
addr_max<=addr_max+1;
else;

end


/////////////////////////////////////////////////////////
	 assign pixel_b=((pixel_x>=10'd50)&&(pixel_x<10'd150)&&(pixel_y>=10'd50)&&(pixel_y<10'd150))?dout_in:((pixel_x>=10'd300)&&(pixel_x<10'd400)&&(pixel_y>=10'd50)&&(pixel_y<10'd150))?dout_min:((pixel_x>=10'd50)&&(pixel_x<10'd150)&&(pixel_y>=10'd160)&&(pixel_y<10'd260))?dout_med:((pixel_x>=10'd300)&&(pixel_x<10'd400)&&(pixel_y>=10'd160)&&(pixel_y<10'd260))?dout_max:8'd0;
	 assign pixel_g=((pixel_x>=10'd50)&&(pixel_x<10'd150)&&(pixel_y>=10'd50)&&(pixel_y<10'd150))?dout_in:((pixel_x>=10'd300)&&(pixel_x<10'd400)&&(pixel_y>=10'd50)&&(pixel_y<10'd150))?dout_min:((pixel_x>=10'd50)&&(pixel_x<10'd150)&&(pixel_y>=10'd160)&&(pixel_y<10'd260))?dout_med:((pixel_x>=10'd300)&&(pixel_x<10'd400)&&(pixel_y>=10'd160)&&(pixel_y<10'd260))?dout_max:8'd0;
	 assign pixel_r=((pixel_x>=10'd50)&&(pixel_x<10'd150)&&(pixel_y>=10'd50)&&(pixel_y<10'd150))?dout_in:((pixel_x>=10'd300)&&(pixel_x<10'd400)&&(pixel_y>=10'd50)&&(pixel_y<10'd150))?dout_min:((pixel_x>=10'd50)&&(pixel_x<10'd150)&&(pixel_y>=10'd160)&&(pixel_y<10'd260))?dout_med:((pixel_x>=10'd300)&&(pixel_x<10'd400)&&(pixel_y>=10'd160)&&(pixel_y<10'd260))?dout_max:8'd0;
 
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
		



lowArea_TOP lowArea_TOP11(.clk(clk_100mhz_buf),.clkb(clk_25mhz),.reset(reset),.addr_in(addr_in),.addr_min(addr_min),.addr_med(addr_med),.addr_max(addr_max),.dout_in(dout_in),.dout_min(dout_min),.dout_med(dout_med),.dout_max(dout_max));	 
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