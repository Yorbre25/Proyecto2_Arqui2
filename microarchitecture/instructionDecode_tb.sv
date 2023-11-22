module instructionDecode_tb();
	logic clk,rst,en,WE, rstTotal, WE1, WE2;
	logic [31:0] inst,inst1;
	logic [23:0] WD1;
	logic [143:0] WD2;
	logic [23:0] pc;
	logic [580:0] bufferOut;
	logic [3:0] Rd;
	
	instructionDecode myInstructionDecode(
		.clk(clk),.rst(rst), .rstTotal(rstTotal), .en(en),
		.inst(inst1),.WE1(WE1), .WE2(WE2), .Rd(Rd),.WD1(WD1), .WD2(WD2), .pc(pc),
		.bufferOut(bufferOut)); //output
	
	buffer #(.Buffer_size(32)) myEntryBuffer(.rst(rst),.clk(clk),.en(en),.bufferInput(inst),.bufferOut(inst1));
	
	always begin
		#10;
		clk=!clk;
	end
	initial begin
		clk=1;
		rst=1;
		rstTotal = 1;
		en=1;
		pc = 0;
		WE1=0;
		WE2=0;
		Rd=0;   
		
		#10; //negedge
		rst = 0;
		rstTotal = 0;
		#10; //posedge
		
		//Inst 1
		inst=32'b00100000010010101000000000000000; // not r1,r10 ## rb=r2
		
		#10; //negedge
		#10; //posedge
		
		//Inst 2
		inst=32'b01010110100110000000000000001111; // div r10,r6,#15
		
		#10; //negedge

		
		#10; //posedge
		$display("Test inst 1: not r1, r10");
		assert(bufferOut[122:121]==0) $display("Optype 00");
		else $error("OpType incorrecto");
		assert(bufferOut[120:117]==4'b1000) $display("Opcode verificado correctamente");
		else $error("Verificacion opCode fallado");
		assert(bufferOut[107:104]==4'b0010) $display("Ra verificado correctamente");
		else $error("Ra fallado");
		assert(bufferOut[79:76]==4'b1010) $display("Rb verificado correctamente");
		else $error("Rb fallado");
		assert(bufferOut[51:48]==4'b0001) $display("Rc verificado correctamente");
		else $error("Rd fallado");
		assert(bufferOut[111:108] == 8) $display("aluControl es igual a 8");
		else $error("aluControl no es 8");
		assert(bufferOut[112]== 1) $display("regWrite es 1"); // Que se escriba un reg
		else $error("regWrite no es 1");
		assert(bufferOut[113]== 0) $display("memToReg es 0"); //Que sea un load
		else $error("memToReg es 1");
		assert(bufferOut[114]== 0) $display("memWrite es 0"); //Que sea un str
		else $error("memWrite es 1");
		assert(bufferOut[115]== 0) $display("branchFlag es 0");  //Que sea inst de control
		else $error("branchFlag es 1");
		assert(bufferOut[116]== 0) $display("immSrc es 0"); //Que use imm
		else $error("immSrc es 1");
		assert(bufferOut[146:123]== 0) $display("pc es 0"); 
		else $error("pc es 1");
		assert(bufferOut[579]== 0) $display("regWriteV es 0"); 
		else $error("rdv1 es 1");
		assert(bufferOut[580]== 0) $display("modeSel es 0"); 
		else $error("rdv1 es 1");
		
		
		#10; //negedge
		//Inst 3
		inst=32'b10000011110000010000000000000000; // ld r15,[r0+r4]
		
		#10; //posedge
		$display("\nTest inst 2: div r10, r6, #15");
		assert(bufferOut[122:121]== 1) $display("Optype es 2");
		else $error("OpType incorrecto");
		assert(bufferOut[120:117]== 5) $display("Opcode verificado correctamente");
		else $error("Verificacion opCode fallado");
		assert(bufferOut[107:104]== 4'b0110) $display("Ra verificado correctamente");
		else $error("Ra fallado");
		assert(bufferOut[79:76]==4'b0000) $display("Rb verificado correctamente");
		else $error("Rb fallado");
		assert(bufferOut[51:48]== 4'b1010) $display("Rc verificado correctamente");
		else $error("Rc fallado");
		assert(bufferOut[23:0]== 15) $display("ImmExtend es 15");
		else $error("ImmExtend no es 15");
		assert(bufferOut[111:108] == 5) $display("aluControl es igual a 5");
		else $error("aluControl no es 5");
		assert(bufferOut[112]== 1) $display("regWrite es 1"); // Que se escriba un reg
		else $error("regWrite no es 1");
		assert(bufferOut[113]== 0) $display("memToReg es 0"); //Que sea un load
		else $error("memToReg es 1");
		assert(bufferOut[114]== 0) $display("memWrite es 0"); //Que sea un str
		else $error("memWrite es 1");
		assert(bufferOut[115]== 0) $display("branchFlag es 0");  //Que sea inst de control
		else $error("branchFlag es 1");
		assert(bufferOut[116]== 1) $display("immSrc es 1"); //Que use imm
		else $error("immSrc es 1");
		assert(bufferOut[146:123]== 0) $display("pc es 0"); 
		else $error("pc es 1");
		assert(bufferOut[579]== 0) $display("regWriteV es 0"); 
		else $error("rdv1 es 1");
		assert(bufferOut[580]== 0) $display("modeSel es 0"); 
		else $error("rdv1 es 1");
		


		#10; //negedge
		//Inst 4
		inst=32'b11000000000000000000010111011100; //B label (15)

		
		#10; //posedge
		$display("\nTest inst 3: ld r15, [r0+r4]");
		assert(bufferOut[122:121]==2) $display("Optype es 1");
		else $error("OpType incorrecto");
		assert(bufferOut[120:117]== 4'b0000) $display("Opcode verificado correctamente");
		else $error("Verificacion opCode fallado");
		assert(bufferOut[107:104]== 0) $display("Ra verificado correctamente");
		else $error("Ra fallado");
		assert(bufferOut[79:76]== 4) $display("Rb verificado correctamente");
		else $error("Rb fallado");
		assert(bufferOut[51:48]== 15) $display("Rc verificado correctamente");
		else $error("Rd fallado");
		assert(bufferOut[111:108] == 1) $display("aluControl es igual a 1");
		else $error("aluControl no es 5");
		assert(bufferOut[112]== 1) $display("regWrite es 1"); // Que se escriba un reg
		else $error("regWrite no es 1");
		assert(bufferOut[113]== 1) $display("memToReg es 0"); //Que sea un load
		else $error("memToReg es 1");
		assert(bufferOut[114]== 0) $display("memWrite es 0"); //Que sea un str
		else $error("memWrite es 1");
		assert(bufferOut[115]== 0) $display("branchFlag es 0");  //Que sea inst de control
		else $error("branchFlag es 1");
		assert(bufferOut[116]== 0) $display("immSrc es 1"); //Que use imm
		else $error("immSrc es 1");
		assert(bufferOut[146:123]== 0) $display("pc es 0"); 
		else $error("pc es 1");
		assert(bufferOut[579]== 0) $display("regWriteV es 0"); 
		else $error("rdv1 es 1");
		assert(bufferOut[580]== 0) $display("modeSel es 0"); 
		else $error("rdv1 es 1");
		
	
		#10; //negedge
//		//Inst 5
		inst=32'b00110100100011010100000000000000; //Addv r2, r3, r5

		
		#10; //posedge
		$display("\nTest inst 4: B label");
		assert(bufferOut[122:121]== 2'b11) $display("Optype es 3");
		else $error("OpType incorrecto");
		assert(bufferOut[120:117]== 4'b0000) $display("Opcode verificado correctamente");
		else $error("Verificacion opCode fallado");
		assert(bufferOut[107:104]== 0) $display("Ra verificado correctamente");
		else $error("Ra fallado");
		assert(bufferOut[79:76]== 0) $display("Rb verificado correctamente");
		else $error("Rb fallado");
		assert(bufferOut[51:48]== 0) $display("Rc verificado correctamente");
		else $error("Rd fallado");
		assert(bufferOut[111:108] == 1) $display("aluControl es igual a 1");
		else $error("aluControl no es 1");
		assert(bufferOut[112]== 0) $display("regWrite es 1"); // Que se escriba un reg
		else $error("regWrite no es 1");
		assert(bufferOut[113]== 0) $display("memToReg es 0"); //Que sea un load
		else $error("memToReg es 1");
		assert(bufferOut[114]== 0) $display("memWrite es 0"); //Que sea un str
		else $error("memWrite es 1");
		assert(bufferOut[115]== 1) $display("branchFlag es 0");  //Que sea inst de control
		else $error("branchFlag es 1");
		assert(bufferOut[116]== 1) $display("immSrc es 1"); //Que use imm
		else $error("immSrc es 1");
		assert(bufferOut[146:123]== 0) $display("pc es 0"); 
		else $error("pc es 1");
		assert(bufferOut[579]== 0) $display("regWriteV es 0"); 
		else $error("rdv1 es 1");
		assert(bufferOut[580]== 0) $display("modeSel es 0"); 
		else $error("rdv1 es 1");
			
		#10; //negedge
//		//Inst 6
		WE1 = 1; 	// Write scalar reg
		WD1 = 15;	// Data to write
		Rd = 1; 		// reg to write

		
		#10; //posedge
		$display("\nTest inst 5: Addv r2, r3, r5");
		assert(bufferOut[122:121]== 2'b00) $display("Optype es 0");
		else $error("OpType incorrecto");
		assert(bufferOut[120:117]== 4'b1101) $display("Opcode verificado correctamente");
		else $error("Verificacion opCode fallado");
		assert(bufferOut[107:104]== 3) $display("Ra verificado correctamente");
		else $error("Ra fallado");
		assert(bufferOut[79:76]== 5) $display("Rb verificado correctamente");
		else $error("Rb fallado");
		assert(bufferOut[51:48]== 2) $display("Rc verificado correctamente");
		else $error("Rd fallado");
		assert(bufferOut[47:24]== 0) $display("Rd3 (valor de Rc) es 0");
		else $error("Rd3 no es 0");
		assert(bufferOut[75:52]== 0) $display("Rd2 (valor de Rb) es 0");
		else $error("Rd2 no es 0");
		assert(bufferOut[103:80]== 0) $display("Rd1 (valor de Ra) es 0");
		else $error("Rd1 no es 0");
		assert(bufferOut[111:108] == 4'b1101) $display("aluControl es igual a 0");
		else $error("aluControl no es 0");
		assert(bufferOut[112]== 0) $display("regWrite es 1"); // Que se escriba un reg
		else $error("regWrite no es 0");
		assert(bufferOut[113]== 0) $display("memToReg es 0"); //Que sea un load
		else $error("memToReg es 1");
		assert(bufferOut[114]== 0) $display("memWrite es 0"); //Que sea un str
		else $error("memWrite es 1");
		assert(bufferOut[115]== 0) $display("branchFlag es 0");  //Que sea inst de control
		else $error("branchFlag es 1");
		assert(bufferOut[116]== 0) $display("immSrc es 1"); //Que use imm
		else $error("immSrc es 1");
		assert(bufferOut[146:123]== 0) $display("pc es 0"); 
		else $error("pc es 1");
		assert(bufferOut[579]== 1) $display("regWriteV es 1"); 
		else $error("rdv1 es 0");
		assert(bufferOut[580]== 1) $display("modeSel es 1"); 
		else $error("rdv1 es 0");
		
		#10 //negedge
		WE1 = 1; 	// Write scalar reg
		WD1 = 10;	// Data to write
		Rd = 2; 		// reg to write
		#10; //posedge
		//test
		
		#10; //negedge
		//Inst 6
		inst=32'b00000000110001001000000000000000; // add r3,r1,r2
		
		#10; //posedge
		//test
		#10; //negedge
		
		WE1 = 0; 	
		WD1 = 0;
		WE2 = 1; // Write vectorial reg
		WD2 = 981275;	// Data to write
		Rd = 1; // reg to write
		
		
		#10; //posedge
		$display("\nTest inst 6; add r3,r1,r2");
		assert(bufferOut[122:121]== 2'b00) $display("Optype es 0");
		else $error("OpType incorrecto");
		assert(bufferOut[120:117]== 4'b0000) $display("Opcode verificado correctamente");
		else $error("Verificacion opCode fallado");
		assert(bufferOut[107:104]== 1) $display("Ra verificado correctamente");
		else $error("Ra fallado");
		assert(bufferOut[79:76]== 2) $display("Rb verificado correctamente");
		else $error("Rb fallado");
		assert(bufferOut[51:48]== 3) $display("Rc verificado correctamente");
		else $error("Rd fallado");
		assert(bufferOut[47:24]== 0) $display("Rd3 (valor de Rc) es 0");
		else $error("Rd3 no es 0");
		assert(bufferOut[75:52]== 10) $display("Rd2 (valor de Rb) es 10");
		else $error("Rd2 no es 0");
		assert(bufferOut[103:80]== 15) $display("Rd1 (valor de Ra) es 15");
		else $error("Rd1 no es 0");
		assert(bufferOut[111:108] == 0) $display("aluControl es igual a 0");
		else $error("aluControl no es 0");
		assert(bufferOut[112]== 1) $display("regWrite es 1"); // Que se escriba un reg
		else $error("regWrite es 0");
		assert(bufferOut[113]== 0) $display("memToReg es 0"); //Que sea un load
		else $error("memToReg es 1");
		assert(bufferOut[114]== 0) $display("memWrite es 0"); //Que sea un str
		else $error("memWrite es 1");
		assert(bufferOut[115]== 0) $display("branchFlag es 0");  //Que sea inst de control
		else $error("branchFlag es 1");
		assert(bufferOut[116]== 0) $display("immSrc es 1"); //Que use imm
		else $error("immSrc es 1");
		assert(bufferOut[146:123]== 0) $display("pc es 0"); 
		else $error("pc es 1");
		assert(bufferOut[579]== 0) $display("regWriteV es 0"); 
		else $error("rdv1 es 0");
		assert(bufferOut[580]== 0) $display("modeSel es 0"); 
		else $error("rdv1 es 0");
		
		#10; //negedge
		WE2 = 1; // Write vectorial reg
		WD2 = 123152;	// Data to write
		Rd = 2; // reg to write
		
		#10; //posedge
		//test
		
		#10; //negedge
		// Inst 7
		inst=32'b00111000110001001000000000000000; //Mulv r3, r1, r2
		
		#10; //posedge
		// test
		#10; //negedge
		//inst
		#10; //posedge
		$display("\nTest inst 7: Mulv r3, r1, r2");
		assert(bufferOut[122:121]== 2'b00) $display("Optype es 0");
		else $error("OpType incorrecto");
		assert(bufferOut[120:117]== 4'b1110) $display("Opcode verificado correctamente");
		else $error("Verificacion opCode fallado");
		assert(bufferOut[111:108] == 4'b1110) $display("aluControl es igual a 0");
		else $error("aluControl no es 0");
		assert(bufferOut[112]== 0) $display("regWrite es 1"); // Que se escriba un reg
		else $error("regWrite es 0");
		assert(bufferOut[113]== 0) $display("memToReg es 0"); //Que sea un load
		else $error("memToReg es 1");
		assert(bufferOut[114]== 0) $display("memWrite es 0"); //Que sea un str
		else $error("memWrite es 1");
		assert(bufferOut[115]== 0) $display("branchFlag es 0");  //Que sea inst de control
		else $error("branchFlag es 1");
		assert(bufferOut[116]== 0) $display("immSrc es 1"); //Que use imm
		else $error("immSrc es 1");
		assert(bufferOut[146:123]== 0) $display("pc es 0"); 
		else $error("pc es 1");
		assert(bufferOut[290:147]== 0) $display("rdv3 es 0"); 
		else $error("rdv3 no es 1");
		assert(bufferOut[434:291]== 123152) $display("rdv2 es 123152"); 
		else $error("rdv2 no es 123152");
		assert(bufferOut[578:435]== 981275) $display("rdv1 es 981275"); 
		else $error("rdv1 no es 981275");
		assert(bufferOut[579]== 1) $display("regWriteV es 1"); 
		else $error("rdv1 es 0");
		assert(bufferOut[580]== 1) $display("modeSel es 1"); 
		else $error("rdv1 es 0");
		
		

		
		
		

		
		
		
	
		
	end
endmodule 