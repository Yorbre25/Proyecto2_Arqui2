module dataMemory(input clk,rst,memWrite,input [19:0] address1,address2,input [23:0] data1, input [3:0] switches,input [35:0] gpio1,output [35:0] gpio2, output [23:0] qa, output [15:0] qb);
	
	logic en1,en2;
	logic memSel;
	logic [23:0] mem1Out,mem2Out;
	logic [19:0] mainMemoryAddress;
	IOMemory myIOMemory(.clk(clk),.rst(rst),.en(en1),.address(address1[7:0]),.dataIn(data1),.switches(switches),.gpio1(gpio1),.gpio2(gpio2),.dataOut(mem1Out));
	
	
	mainMemory mymainMemory(.address_a(mainMemoryAddress[18:0]),
	.address_b(address2[18:0]),
	.clock(clk),
	.data_a(data1[15:0]),
	.data_b(data2),
	.wren_a(en2),
	.wren_b(1'b0),
	.q_a(mem2Out[15:0]),
	.q_b(qb));
	
	

	

	
	chipSet myChipSet(.address(address1),.memWrite(memWrite),.en1(en1),.en2(en2),.memSel(memSel));
	
	mux2_1 #(.N(24)) myMemReadSelector(.a(mem1Out),.b(mem2Out),.c(qa), .sel(memSel));
	


	assign mainMemoryAddress=address1-76;
	assign mem2Out[23:16]={8{mem2Out[15]}};
	
	
	
endmodule 