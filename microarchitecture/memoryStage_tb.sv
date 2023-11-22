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
	
	logic [366:0] bufferInput,bufferOut1;
	

	memoryStage myMemoryStage(
		.clk(clk),.rst(rst),.en(en),.opType(bufferOut1[366:365]),.opCode(bufferOut1[364:361]),.address1(bufferOut1[360:217]),
		.address2(bufferOut1[216:193]),.memWrite(bufferOut1[192]),.memToReg(bufferOut1[191]),.regWrite(bufferOut1[190]), .regWriteV(bufferOut1[189]), .modeSel(bufferOut1[188]),
		.Rc(bufferOut1[187:184]),.writeData(bufferOut1[183:40]),.switches(bufferOut1[39:36]),.gpio1(bufferOut1[35:0]),.gpio2(gpio2),.q(q),.bufferOut(bufferOut));
		
	buffer #(.Buffer_size(367)) mybuffer(.rst(rst),.clk(clk),.en(en),.bufferInput(bufferInput),.bufferOut(bufferOut1));
		
	
	
	assign bufferInput={ opType,opCode, address1,  address2, memWrite, memToReg,regWrite,regWriteV,modeSel,  Rc,   writeData, switches,gpio1};
		//					 |366:365|364:361|360:217 |	216:193 |192		|		191|	190	 |189	    |188    |187:184 |	183:40 |	39:36   |35:0|
	
	
	always begin
	
		#10;
		clk=!clk;
	end
	
	initial begin
	
		clk=1;
		rst=1;
		en=1;
		opType=2'b00;
		opCode=4'b0010;
		address1=144'd500;
		address2=24'd400;
		memWrite=0;
		memToReg=1;
		regWrite=0;
		regWriteV=1;
		modeSel=0;
		Rc=4'b1010;
		writeData=144'd375;
		switches=4'b0011;
		gpio1=36'd96;
		
		#10; //negede (aqui se la el reset)
		
		#10; //posedge se setean datos para inst 1
		opType=2'b00;
		opCode=4'b0010;
		address1=144'd500;
		address2=24'd400;
		memWrite=0;
		memToReg=1;
		regWrite=0;
		regWriteV=1;
		modeSel=0;
		Rc=4'b1010;
		writeData=144'd375;
		switches=4'b0011;
		gpio1=36'd96;
		
		
		rst=0;
		
		#10; //negedge (se escribe buffer de entrada inst 1)
		
		#10; //posedge (se escribe datos para la inst 2)
		
		//escritura vectorial
		opType=2'b00;
		opCode=4'b0010;
		address1=144'd500;
		address2=24'd400;
		memWrite=1;
		memToReg=1;
		regWrite=0;
		regWriteV=1;
		modeSel=1;
		Rc=4'b1010;
		writeData=144'd432;
		switches=4'b0011;
		gpio1=36'd96;
		
		#10; //negedge (se escribe buffer de salida inst 1 y buffer entrada inst2)
		
		#10; //posedge (realizacion test para inst1 e ingresar datos para inst3)
		
		$display("Test 1: pass through signals");
		assert(bufferOut[143:0] == 144'd500) $display("Address1 signal pass through");
		else $error("Address1 value is not 144'd500");
		assert(bufferOut[291:288] == 4'b1010) $display("Rc signal pass through");
		else $error("Rc value is not 12");
		assert(bufferOut[292] == 0) $display("regWrite signal pass through");
		else $error("regWrite value is not 1");
		assert(bufferOut[293] == 1) $display("memToReg signal pass through");
		else $error("memToReg incorrect value");
		assert(bufferOut[297:294] == 4'b0010) $display("opCode signal pass through");
		else $error("opCode incorrect value");
		assert(bufferOut[299:298] == 2'b00) $display("opType signal pass through");
		else $error("opTpye incorrect value");
		assert(bufferOut[300] == 0) $display("modeSel signal pass through");
		else $error("modeSel incorrect value");
		assert(bufferOut[301] == 1) $display("regWriteV signal pass through");
		else $error("regWriteV incorrect value");
		
		
		//lectura vectorial
		opType=2'b00;
		opCode=4'b0010;
		address1=144'd500;
		address2=24'd400;
		memWrite=0;
		memToReg=1;
		regWrite=0;
		regWriteV=1;
		modeSel=1;
		Rc=4'b1010;
		writeData=144'd375;
		switches=4'b0011;
		gpio1=36'd96;
		
	
		
		
		#10; //negedge (se escribe buffer entrada inst 3 y se escribe en buffer salida inst 2)
		
		#10; //posedge 
		
		#10; //negedge (se escribe buffer salida inst 3)
		$display("\n Write/Read test");
		assert(bufferOut[287:144] == 144'd432) $display("Right read after vectorial write");
		else $error("Wrong read after vectorial write");
		
		#20;
		
	end

	endmodule 