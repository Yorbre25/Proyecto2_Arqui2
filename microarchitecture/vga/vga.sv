module vga(input logic clk, input logic [3:0] data, output logic vgaclk, output logic hsync, vsync, output logic sync_b, blank_b, output logic [7:0] r, g, b, output logic [23:0] address);
		
		logic [9:0] x, y;
		logic [3:0] dataAux;
		
		clockDivider clkDiv(clk, vgaclk);
		
		// Generate monitor timing signals
		vgaController vgaCont(vgaclk, hsync, vsync, sync_b, blank_b, x, y);
		
		// User-defined module to determine pixel color
		//videoGen videoGen(x, y,clk, data,  r, g, b, address);
		videoGen videoGen(x, y,vgaclk, data,  r, g, b, address);
		
		// module videoGen(input logic [9:0] x, y, input logic clk, input logic [3:0] data, output logic [7:0] r, g, b, output logic [18:0] address);


endmodule