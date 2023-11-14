`timescale 1ns/1ps  
module exec_tb();

	localparam vec_num_elem=6;
	localparam reg_size=24;
	localparam setValuesBuffer = 17;
	localparam BW = setValuesBuffer + 2*vec_num_elem*reg_size;

	logic clk, rst, en; //clock, flush, stall,
	logic [reg_size-1:0] rd1, rd2, pc, imm; // Alu entries
	logic [vec_num_elem*reg_size-1:0] rdv1,rdv2, Forward1, Forward2,Forward3; 
	logic [reg_size-1:0] rd3;
	logic [vec_num_elem*reg_size-1:0] rdv3;
	logic [3:0] aluControl;
	logic [3:0] Rc; // Register number
	logic immSrc, branchFlag, memWrite, memToReg, regWrite,modeSel;// modeSel(if its scalar or vectorial)
	logic Fa, Fb,Fc;
	logic [1:0] opType;
	logic [3:0] opCode;
	logic [BW-1:0] bufferOut; // output

	

exec #(.N(reg_size),.M(vec_num_elem),.BW(BW)) myExec(
	.clk(clk), .rst(rst), .en(en), //clock, flush, stall,
	.rd1(rd1), .rd2(rd2), .pc(pc), .imm(imm), // Alu entries
	.rdv1(rdv1), .rdv2(rdv2), .Forward1(Forward1), .Forward2(Forward2),.Forward3(Forward3), 
	.rd3(rd3),
	.rdv3(rdv3),
	.aluControl(aluControl),
	.Rc(Rc), 
	.immSrc(immSrc), .branchFlag(branchFlag), .memWrite(memWrite), .memToReg(memToReg), .regWrite(regWrite), .modeSel(modeSel),
	.Fa(Fa), .Fb(Fb), .Fc(Fc),
	.opType(opType),
	.opCode(opCode),
	.bufferOut(bufferOut)
);

		
	always begin
		#10;
		clk=!clk;
	end

	initial begin 
		clk = 1;
		rst = 1; 
		en = 1;
		aluControl = 0;
		immSrc = 0;
		branchFlag = 0;
		memWrite = 0;
		memToReg = 0;
		regWrite = 0;
		modeSel = 0;
		pc = 0;
		Fa = 0;
		Fb = 0;
		Fc = 0;
		opType = 0;
		opCode = 0;
		bufferOut = 0;
//		---

		rd1=1;
		rd2=5;
		rd3=12;
		imm = 0;
		Rc = 0;
		
		rdv1[23:0]=1;
		rdv1[47:24]=2;
		rdv1[71:48]=3;
		rdv1[95:72]=4;
		rdv1[119:96]=5;
		rdv1[143:120]=6;
		
		rdv2[23:0]=7;
		rdv2[47:24]=8;
		rdv2[71:48]=9;
		rdv2[95:72]=10;
		rdv2[119:96]=11;
		rdv2[143:120]=12;
		
		rdv3[23:0]=13;
		rdv3[47:24]=14;
		rdv3[71:48]=15;
		rdv3[95:72]=16;
		rdv3[119:96]=17;
		rdv3[143:120]=18;
		
		Forward1[23:0]=13;
		Forward1[47:24]=14;
		Forward1[71:48]=15;
		Forward1[95:72]=16;
		Forward1[119:96]=17;
		Forward1[143:120]=18;
		
		Forward1[23:0]=19;
		Forward1[47:24]=20;
		Forward1[71:48]=21;
		Forward1[95:72]=22;
		Forward1[119:96]=23;
		Forward1[143:120]=24;
		
		Forward2[23:0]=25;
		Forward2[47:24]=26;
		Forward2[71:48]=27;
		Forward2[95:72]=28;
		Forward2[119:96]=29;
		Forward2[143:120]=30;
		
		Forward3[23:0]=31;
		Forward3[47:24]=32;
		Forward3[71:48]=33;
		Forward3[95:72]=34;
		Forward3[119:96]=35;
		Forward3[143:120]=36;
		
		#10; //negedge (aqui se hace rst)
		
		
		
		
		#10; //posedge
		rst=0;
		
		
		#10; //negedge (aqui se coordina se manda a ejecutar por primera vez)
		
		$display("TEST: Pass through signals");
		Rc = 15;
		regWrite = 1;
		memToReg = 1;
		memWrite = 1;
		opCode = 7;
		opType = 2;
		modeSel = 1;

		#10; //posedge
		
		#10; //negedge
		
		//Scalar Operations
		$display("TEST: scalar Add rd1+rd2");
		// modeSel = 0, Fa = 0, Fb = 0 (scalar :rd1 + rd2)
		Rc = 0;
		regWrite = 0;
		memToReg = 0;
		memWrite = 0;
		opCode = 0;
		opType = 0;
		
		modeSel = 0;
		aluControl = 4'b0001;
		Fa = 0;
		Fb = 0;
		
		rd3 = 3;

		#10; //posedge
		assert(bufferOut[147:144]== Rc) $display("RC value is 15");
		else $error("RC value is not 15");
		assert(bufferOut[148]== regWrite) $display("regWrite value is 1");
		else $error("regWrite value is not 1");
		assert(bufferOut[149]== memToReg) $display("memToReg value is 1");
		else $error("memToReg is not 1");
		assert(bufferOut[150]== memWrite) $display("memWrite value is 1");
		else $error("memWrite is not 1");
		assert(bufferOut[301:298]== opCode) $display("opCode value is 7");
		else $error("opCode value is not 7");
		assert(bufferOut[303:302]== opType) $display("opType value is 2");
		else $error("opType value is not 4");
		assert(bufferOut[304]== modeSel) $display("modeSel value is 1");
		else $error("ModeSel value is not 1");
		
		#10; //negedge
		//aqui iria la siguiente instruccion
		
		#10;//posedge
		
		$display("%b", bufferOut);
		assert(bufferOut[297:154]== {120'b0,rd1+rd2}) $display("aluCurrentResultFinal equals rd1+rd2");
		else $error("aluCurrentResultFinal value is not rd1+rd2");
		assert(bufferOut[151]== 0) $display("branchFlag is 0");
		else $error("branchFlag is high");
		assert(bufferOut[152]== 0) $display("negFlag is 0");
		else $error("negFlag is high");
		assert(bufferOut[153]== 0) $display("zeroFlag is 0");
		else $error("zeroFlag is high");
		assert(bufferOut[304]== 0) $display("modeSel is 0");
		else $error("modeSel not set to scalar");

//	FLAG NEG Y ZERO SIN VALOR

		
		
		
		
		
//divide instruction:
//	 | modeSel | opType | opCode | aluCurrentResultFinal | zeroFlag | negFlag | branchFlag | memWrite | memToReg | regWrite | Rc | RD3OutFinal  |
//Size:
//	 | [1]     |   [2]  |   [4]  |       [M*N]	        |  [1]     |   [1]   |    [1]     |   [1]    |    [1]   |   [1]    |[4] | [M*N]        | 
//	----------------------------------------------------------------------------------------------------------------
//  |304      |303	  |301	  |297				        |153		  |152	   |151			 |150		   |149		  |148	   |147 |143          0|
	 
	end
endmodule