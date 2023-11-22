module MainConnection(
	///////// FPGA /////////
      input              FPGA_CLK1_50,
      input              FPGA_CLK2_50,
      input              FPGA_CLK3_50,


      ///////// KEY /////////
		input [35:0] gpio1,
		input [4:0] switches,
		input rst,
		output [35:0] gpio2,
		output vgaclk, 
		output hsync, vsync, 
		output sync_b, blank_b, 
		output [7:0] r, g, b
);

//module processor(input rst,input clk, input [35:0] gpio1,input [23:0] parallelAddress,
//input [4:0] switches,output [35:0] gpio2,output [15:0] q);


wire [23:0] parallelAddress;
reg [17:0] offset;

wire [7:0] q;
//assign colors = q;

processor processor(.rst(rst),
	.clk(FPGA_CLK1_50), 
	.gpio1(gpio1),
	.parallelAddress(parallelAddress),
	.switches(switches),
	.gpio2(gpio2),
	.q(q));

// module vga(input logic clk, input logic [3:0] data, output logic vgaclk, 
//output logic hsync, vsync, output logic sync_b, blank_b, output logic [7:0] r, g, b, 
//output logic [18:0] address);


vga vga(
	.clk(FPGA_CLK1_50),
	.data(q[3:0]),
	.vgaclk(vgaclk), 
	.hsync(hsync),
	.vsync(vsync),
	.sync_b(sync_b),
	.blank_b(blank_b),
	.r(r),
	.g(g),
	.b(b),
	.address(parallelAddress)
);



endmodule
