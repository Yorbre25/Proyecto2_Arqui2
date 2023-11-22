module rectgen(input logic [9:0] x, y, left, top, right, bot, output logic inrect, borders); 
	
	assign inrect = (x >= left & x < right & y >= top & y < bot);
	assign borders = (x >= left & x < 630 & y >= top & y < 470);

endmodule