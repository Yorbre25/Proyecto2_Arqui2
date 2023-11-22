module dataMemory(input clk,rst,memWrite,modeSel,input [19:0] address1,address2,input [143:0] data1, input [4:0] switches,input [35:0] gpio1,output [35:0] gpio2, output [143:0] qa, output [15:0] qb);
	
	logic en1,en2;
	logic memSel;
	logic [143:0] mem1Out,mem2Out;
	logic [19:0] mainMemoryAddress;
	logic [71:0] mainMemoryData,mainMemoryOut;
	IOMemory myIOMemory(.clk(clk),.rst(rst),.en(en1),.address(address1[7:0]),.dataIn(data1[23:0]),.switches(switches),.gpio1(gpio1),.gpio2(gpio2),.dataOut(mem1Out[23:0]));
	
	
	
	
	mainMemory myMainMemory(.clk(clk),.modeSel(modeSel),.address_a(mainMemoryAddress[18:0]),.address_b(address2[18:0]),.data_a(mainMemoryData),.wren(en2), .q_a(mainMemoryOut),.q_b(qb[11:0]));

	

	
	chipSet myChipSet(.address(address1),.memWrite(memWrite),.en1(en1),.en2(en2),.memSel(memSel));
	
	mux2_1 #(.N(144)) myMemReadSelector(.a(mem1Out),.b(mem2Out),.c(qa), .sel(memSel));
	


	assign mainMemoryAddress=address1-76;
	assign mem1Out[143:24]={120{mem1Out[23]}};
	assign mem2Out={{12{mainMemoryOut[71]}},mainMemoryOut[71:60],{12{mainMemoryOut[59]}},mainMemoryOut[59:48],{12{mainMemoryOut[47]}},mainMemoryOut[47:36],{12{mainMemoryOut[35]}},mainMemoryOut[35:24],{12{mainMemoryOut[23]}},mainMemoryOut[23:12],{12{mainMemoryOut[11]}},mainMemoryOut[11:0]};
	assign mainMemoryData = {data1[131:120],data1[107:96],data1[83:72],data1[59:48],data1[35:24],data1[11:0]};
	assign qb[15:12]={4{qb[11]}};
	
	
endmodule 