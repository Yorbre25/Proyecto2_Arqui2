module videoGen(input logic [9:0] x, y, input logic clk, input logic [3:0] data, output logic [7:0] r, g, b, output logic [23:0] address);
		
		logic [7:0] rx,gx,bx; 
		logic inrect, borders;
		
		chargenrom chargenromb( x,y, inrect, borders,  clk, data, rx,gx,bx, address);
		rectgen rectgen(x, y, 10'd0, 10'd0, 10'd640, 10'd480, inrect, borders);

		
		// assign {r, g} = pixel;
		assign r = rx;
		assign g = gx;
		assign b = bx;

endmodule