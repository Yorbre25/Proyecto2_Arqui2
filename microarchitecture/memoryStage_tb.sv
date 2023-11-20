`timescale 1ns/1ns
module memoryStage_tb();
	logic clk,rst,en,memWrite,memToReg,regWrite,regWriteV,modeSel;
	logic [1:0] opType;
	logic [3:0] opCode;
	logic [143:0] address1;
	logic [23:0] address2;
	logic [3:0] Rc,switches;
	logic [143:0] writeData;
	logic [15:0] q;
	logic [35:0] gpio1,gpio2;
	logic [181:0] bufferOut;
	

	memoryStage myMemoryStage(.clk(clk),.rst(rst),.en(en),.opType(opType),.opCode(opCode),.address1(address1),
	.address2(address2),.memWrite(memWrite),.memToReg(memToReg),.regWrite(regWrite), .regWriteV(regWriteV), .modeSel(modeSel),
	.Rc(Rc),.writeData(writeData),.switches(switches),.gpio1(gpio1),.gpio2(gpio2),.q(q),.bufferOut(bufferOut));
	
	
	always begin
	
		#10;
		clk=!clk;
	end
	
	initial begin
	
		
		clk=1;
		rst=1;
		en=0;
		memWrite=1;
		memToReg=0;
		regWrite=0;
		opType=2;
		opCode=9;
		address1=144'd500;
		address2=0;
		Rc=12;
		switches=4'b1101;
		writeData=144'd35;
		gpio1=23;
		modeSel=0;
		regWriteV=0;
		
		#10; //negedge(reset de buffer)
		
		#5;
		rst=0;
		en=1;

		
		#5;//posedge (escribe a memoria)
		
		
		#10; //negedge (escribe buffer de salida)
		memWrite=0;
		memToReg=0;
		regWrite=0;
		opType=1;
		opCode=4;
		address1=144'd700;
		address2=0;
		Rc=12;
		switches=4'b1101;
		writeData=144'd90;
		gpio1=23;
		
		#10; //posedge (lectura prueba)
		
		
		
	
	end

	endmodule 