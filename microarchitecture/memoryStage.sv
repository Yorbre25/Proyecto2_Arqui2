module memoryStage(input clk,rst,en,input [1:0] opType,input [3:0] opCode,input [143:0] address1,input [23:0] address2,input memWrite,memToReg,regWrite,regWriteV,modeSel,input [3:0] Rc,input [143:0] writeData,input [3:0] switches,input [35:0] gpio1,output [35:0] gpio2,output [15:0] q,output [301:0] bufferOut);



	logic [143:0] qa;
	logic [301:0] bufferInput;
	dataMemory myDataMemory(.clk(clk),.rst(rst),.memWrite(memWrite),.modeSel(modeSel),.address1(address1[19:0]),.address2(address2[19:0]),.data1(writeData),.switches(switches),.gpio1(gpio1),.gpio2(gpio2),.qa(qa),.qb(q));
	
	
	buffer #(.Buffer_size(302)) myBuffer(.rst(rst),.clk(clk),.en(en),.bufferInput(bufferInput),.bufferOut(bufferOut));
	//                 |  1     |   1    |    2   |  4     |    1   |    1    |4      |144    | 144 |
	assign bufferInput={regWriteV, modeSel, opType, opCode, memToReg, regWrite,  Rc   , qa, address1};
	//                 |301     |300     |299:298 |297:294 |293     |292      |291:288|287:144|143:0|
endmodule 