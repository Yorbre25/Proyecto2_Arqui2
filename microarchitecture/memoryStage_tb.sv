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
	logic [301:0] bufferOut;
	

	memoryStage myMemoryStage(
		.clk(clk),.rst(rst),.en(en),.opType(opType),.opCode(opCode),.address1(address1),
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

		
		#10; //negedge
		rst=0;
		en=1;
		#10; //posedge
		//Inst 1: pass through  signals
		address1 = 144'd500;
		Rc = 12;
		regWrite = 1;
		memToReg = 1;
		opCode = 9;
		opType = 3;
		modeSel = 1;
		regWriteV = 1;
		
		#10; //negedge
		#10;//posedge 
		
		//Inst 2:
		Rc = 0;
		regWrite = 0;
		memToReg = 0;
		opCode = 0;
		opType = 0;
		modeSel = 0;
		regWriteV = 0;
		
		memWrite=1;
		address1=5000;
		writeData = 255;
		
		#10; //negedge 
		$display("Test 1: pass through signals");
		assert(bufferOut[143:0] == 144'd500) $display("Address1 signal pass through");
		else $error("Address1 value is not 144'd500");
		assert(bufferOut[291:288] == 12) $display("Rc signal pass through");
		else $error("Rc value is not 12");
		assert(bufferOut[292] == 1) $display("regWrite signal pass through");
		else $error("regWrite value is not 1");
		assert(bufferOut[293] == 1) $display("memToReg signal pass through");
		else $error("memToReg incorrect value");
		assert(bufferOut[297:294] == 9) $display("opCode signal pass through");
		else $error("opCode incorrect value");
		assert(bufferOut[299:298] == 3) $display("opType signal pass through");
		else $error("opTpye incorrect value");
		assert(bufferOut[300] == 1) $display("modeSel signal pass through");
		else $error("modeSel incorrect value");
		assert(bufferOut[301] == 1) $display("regWriteV signal pass through");
		else $error("regWriteV incorrect value");
		#10; //posedge
		#10; //negedge
		
		#10; //posedge
		//Inst 3: Read mem
		memWrite=0;
		modeSel = 0;
		address1=5000;

		//AQUÍ LE METI ESTOS TIEMPOS PORQUE SI NO LA LECTURA NO ME SALÍA CORRECTA
		#10; //negedge
		//Test
		#10; //posedge
		//Inst 4
		
		#10; //negedge
		assert(bufferOut[287:144] == 255) $display("Lectura de la posicion 50000 de memoria despues de la escritura fue correcta");
		else $error("Lectura de la posicion 50000 de memoria despues de la escritura fue correcta");
		#10; //posedge
		memWrite=1;
		address1=30;
		address2=5000-76; // a address 2 se le debe quitar el offset de 76 del caso de la primera
		writeData=1;
		
		#10; //negedge
		#10; //posedge
		//Inst 3: Read gpio ESTA LA COPIE DE DATAMEMORY, ENTIENDO QUE LEE LOS GPIO, PERO NI IDEA DE POR QUE EL VALOR DE 38
		address1=38;
		memWrite=0;
		
		#10; //negedge //MAS TIEMPOS PORQUE SI NO NO LO LEE BIEN
		//Test
		#10; //posedge
		//Inst 4
		
		#10; //negedge
		assert(bufferOut[287:144] == 1) $display("Lectura correcta de los GPIO escritos");
		else $error("Lectura incorrecta de los GPIO escritos");
		
		
		

		
		
		
	
	end

	endmodule 