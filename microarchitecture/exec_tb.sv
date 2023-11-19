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
		opCode = 0;
		opType = 0;
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
		
		rd1=0;
		rd2=0;
		rd3=0;
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
		
		#10; //negedge
		rst = 0;
		#10; //posedge
		
//		INST 1: Todo en 0
//		Ya todo está en 0, entonces no se pone nada aquí

		#10; //negedge
		#10; //posedge
		
//		INST 2: scalar add rd1 + rd2 (rd1 + rd2)
		aluControl = 4'b0001;
		rd1 = 1;
		rd2 = 2;
		
		#10; //negedge
		assert(bufferOut == 0) $display("buffer is empty");
		else $error("buffer is not empty");
		
		#10; //posedge
		
		//INST 3: pass through signals
		aluControl = 0;
		rd1 = 0;
		rd2 = 0;
		Rc = 15;
		regWrite = 1;
		memToReg = 1;
		memWrite = 1;
		opCode = 7;
		opType = 2;
		modeSel = 1;;
		
		#10; //negedge
		$display("\nTest inst 2: Add rd1+rd2");
		assert(bufferOut[177:154] == 3) $display("aluCurrentResultFinal equals 3");
		else $error("aluCurrentResultFinal value is not 3");
		assert(bufferOut[151]== 0) $display("branchFlag is 0");
		else $error("branchFlag is high");
		assert(bufferOut[152]== 0) $display("negFlag is 0");
		else $error("negFlag is high");
		assert(bufferOut[153]== 0) $display("zeroFlag is 0");
		else $error("zeroFlag is high");
		assert(bufferOut[304]== 0) $display("modeSel is 0");
		else $error("modeSel not set to scalar");
		
		#10; //posedge
//		Inst 4: vectorial add rdv1 + rdv2
		aluControl = 4'b1101;
		modeSel = 1;
		
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
		
		#10; //negedge
		$display("\nTest inst 3: pass through signals");
		assert(bufferOut[147:144]== 15) $display("RC value is 15");
		else $error("RC value is not 15");
		assert(bufferOut[148]== 1) $display("regWrite value is 1");
		else $error("regWrite value is not 1");
		assert(bufferOut[149]== 1) $display("memToReg value is 1");
		else $error("memToReg is not 1");
		assert(bufferOut[150]== 1) $display("memWrite value is 1");
		else $error("memWrite is not 1");
		assert(bufferOut[301:298]== 7) $display("opCode value is 7");
		else $error("opCode value is not 7");
		assert(bufferOut[303:302]== 2) $display("opType value is 2");
		else $error("opType value is not 4");
		assert(bufferOut[304]== 1) $display("modeSel value is 1");
		else $error("ModeSel value is not 1");
		
		#10; //posedge
//		Inst 5: compare (rd1-rd2)
		rdv1[23:0]=0;
		rdv1[47:24]=0;
		rdv1[71:48]=0;
		rdv1[95:72]=0;
		rdv1[119:96]=0;
		rdv1[143:120]=0;
		
		rdv2[23:0]=0;
		rdv2[47:24]=0;
		rdv2[71:48]=0;
		rdv2[95:72]=0;
		rdv2[119:96]=0;
		rdv2[143:120]=0;
		
		rd1 = 1;
		rd2 = 4;
		aluControl = 4'b0100;
		opType = 0;
		opCode = 4'b0100;
		modeSel = 0;

		
		#10; //negedge
		$display("\nTest inst 4: add rdv1+rdv2");
		assert(bufferOut[177:154] == 8) $display("rdv1[0]+rdv2[0] equals 8");
		else $error("rdv1[0]+rdv1[0] doesn't equals 8");
		assert(bufferOut[201:178] == 10) $display("rdv1[1]+rdv2[1] equals 10");
		else $error("rdv1[1]+rdv1[1] doesn't equals 10");
		assert(bufferOut[225:202] == 12) $display("rdv1[2]+rdv2[2] equals 12");
		else $error("rdv1[2]+rdv1[2] doesn't equals 12");
		assert(bufferOut[249:226] == 14) $display("rdv1[3]+rdv2[3] equals 14");
		else $error("rdv1[3]+rdv1[3] doesn't equals 14");
		assert(bufferOut[273:250] == 16) $display("rdv1[4]+rdv2[4] equals 16");
		else $error("rdv1[4]+rdv1[4] doesn't equals 16");
		assert(bufferOut[297:274] == 18) $display("rdv1[5]+rdv2[5] equals 18");
		else $error("rdv1[5]+rdv1[5] doesn't equals 18");
		assert(bufferOut[151]== 0) $display("branchFlag is 0");
		else $error("branchFlag is high");
		assert(bufferOut[152]== 0) $display("negFlag is 0");
		else $error("negFlag is high");
		assert(bufferOut[153]== 0) $display("zeroFlag is 0");
		else $error("zeroFlag is high");
		
		#10; //posedge
//		Inst 6: compare (rd1-rd2)
		rd1 = 1;
		rd2 = 1;
		aluControl = 4'b0100;
		opType = 0;
		opCode = 4'b0100;
		modeSel = 0;
		
		#10; //negedge
		$display("\nTest inst 5: negFlag compare (rd1-rd2)");
		assert($signed(bufferOut[177:154]) == -3) $display("aluCurrentResultFinal equals -3");
		else $error("aluCurrentResultFinal value is not -3");
		assert(bufferOut[151]== 0) $display("branchFlag is 0");
		else $error("branchFlag is high");
		assert(bufferOut[152]== 1) $display("negFlag is 1");
		else $error("negFlag is 0");
		assert(bufferOut[153]== 0) $display("zeroFlag is 0");
		else $error("zeroFlag is 1");
		#10; //posedge
		
		#10; //negedge
		$display("\nTest inst 6: zeroFlag compare (rd1-rd2)");
		assert(bufferOut[177:154] == 0) $display("aluCurrentResultFinal equals 0");
		else $error("aluCurrentResultFinal value is not 0");
		assert(bufferOut[151]== 0) $display("branchFlag is 0");
		else $error("branchFlag is high");
		assert(bufferOut[152]== 0) $display("negFlag is 0");
		else $error("negFlag is 1");
		assert(bufferOut[153]== 1) $display("zeroFlag is 1");
		else $error("zeroFlag is 0");
		
	end
	
endmodule