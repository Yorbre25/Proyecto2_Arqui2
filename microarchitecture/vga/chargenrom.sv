module chargenrom( input logic [9:0] x, y,input logic inrect,borders, clk, input logic [3:0] data, output logic [7:0] r,g,b, output logic [23:0] address);
		// 		chargenrom chargenromb( x,y, inrect, clk, data, rx,gx,bx, address);


		//logic [4:0] charrom[307199:0]; // character generator ROM
		logic [25:0] mapped;

		// Initialize ROM with characters from text file
		//initial begin
		//$readmemb("../common/memory/data_memory/RAM.txt", charrom);
		//$readmemb("salida.txt", charrom);
		
		//end
		
		//always_ff @(posedge clk) begin
		//$readmemb("../common/memory/data_memory/RAM.txt", charrom);
		//end
	
	
		
		
		always_comb begin
		case(data)
			4'b0000: mapped = 24'hFFFFFF;
			4'b0001: mapped = 24'h7F118C;
			4'b0010: mapped = 24'h28107E;
			4'b0011: mapped = 24'h0022FF;
			4'b0100: mapped = 24'h049180;
			4'b0101: mapped = 24'h08FF00;
			4'b0110: mapped = 24'hEBE533;
			4'b0111: mapped = 24'hFD0019;
			4'b1000: mapped = 24'h000000;
			4'b1001: mapped = 24'hFF2DDC;
			4'b1010: mapped = 24'h34FFD3;
			4'b1011: mapped = 24'h146D00;
			4'b1100: mapped = 24'h830837;
			4'b1101: mapped = 24'hFF70A2;
			4'b1110: mapped = 24'h2A9CF4;
			4'b1111: mapped = 24'h9560F8;
		endcase
		
		//if(!borders)
		//	mapped= 24'h08FF00;
		
		end

		// is entry 0
		// Reverse order of bits
		//assign pixel = inrect ? charrom[100*x + y] : 7'h00;
		
		always @(negedge clk) begin
			r = inrect ? mapped[23:16]: 7'h00;
			g = inrect ? mapped[15:8]: 7'h00 ;
			b = inrect ? mapped[7:0]: 7'h00;
			address = inrect ? (x + y*640): 0; // 79 de offset por los gpios
		
		end
		
		
endmodule