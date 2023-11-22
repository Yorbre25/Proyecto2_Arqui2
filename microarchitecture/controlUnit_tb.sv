module controlUnit_tb();
	logic [1:0] opType;
	logic [3:0] opCode,Rd;
	logic immSrc,branchFlag, memWrite, memToReg, regWrite, regWriteV, modeSel;
	logic [3:0] aluControl;

	controlUnit myControlUnit(.opType(opType),.opCode(opCode),.Rd(Rd),.immSrc(immSrc),.branchFlag(branchFlag),.memWrite(memWrite),.memToReg(memToReg),.regWrite(regWrite),.regWriteV(regWriteV),.modeSel(modeSel),.aluControl(aluControl));

	initial begin
		opType=2'b00; // operacion aritmetica
		opCode=4'b0000; //resta
		Rd= 3; //Registro a escribir 3
		#10;
		
		$display("Resta aritmetica escalar");
		
		
		assert(immSrc==0) $display("Bandera immSrc en bajo");
		else $error("Bandera immSrc en alto");
		
		assert(branchFlag==0) $display("Bandera branchFlag en bajo");
		else $error("Bandera branchFlag en alto");
		
		assert(memWrite==0) $display("Bandera memWrite en bajo");
		else $error("Bandera memWrite en alto");
		
		assert(memToReg==0) $display("Bandera memToReg en bajo");
		else $error("Bandera memToReg en alto");
		
		assert(regWrite==1) $display("Bandera regWrite en alto");
		else $error("Bandera regWrite en bajo");
		
		assert(regWriteV==0) $display("Bandera regWriteV en bajo");
		else $error("Bandera regWriteV en alto");
		
		assert(modeSel==0) $display("Bandera modeSel en bajo");
		else $error("Bandera modeSel en alto");
		
		
		opType=2'b00; // operacion aritmetica
		opCode=4'b0101; //division
		Rd= 4'b0000; //Registro a escribir 0, este registro no se debe escribir, por lo tanto regWrite deberia ser 0
		
		#10;
		$display("Division aritmetica escalar");
		
		assert(immSrc==0) $display("Bandera immSrc en bajo");
		else $error("Bandera immSrc en alto");
		
		assert(branchFlag==0) $display("Bandera branchFlag en bajo");
		else $error("Bandera branchFlag en alto");
		
		assert(memWrite==0) $display("Bandera memWrite en bajo");
		else $error("Bandera memWrite en alto");
		
		assert(memToReg==0) $display("Bandera memToReg en bajo");
		else $error("Bandera memToReg en alto");
		
		assert(regWrite==0) $display("Bandera regWrite en bajo");
		else $error("Bandera regWrite en alto");
		
		assert(regWriteV==0) $display("Bandera regWriteV en bajo");
		else $error("Bandera regWriteV en alto");
		
		assert(modeSel==0) $display("Bandera modeSel en bajo");
		else $error("Bandera modeSel en alto");
		
		
		opType=2'b01; // operacion aritmetica inmediato
		opCode=4'b0010; //multiplicacion
		Rd= 5; //Registro a escribir 5
		
		
		#10;
		
		$display("Multiplicacion aritmetica escalar con inmediato");
		
		
		assert(immSrc==1) $display("Bandera immSrc en alto");
		else $error("Bandera immSrc en bajo");
		
		assert(branchFlag==0) $display("Bandera branchFlag en bajo");
		else $error("Bandera branchFlag en alto");
		
		assert(memWrite==0) $display("Bandera memWrite en bajo");
		else $error("Bandera memWrite en alto");
		
		assert(memToReg==0) $display("Bandera memToReg en bajo");
		else $error("Bandera memToReg en alto");
		
		assert(regWrite==1) $display("Bandera regWrite en alto");
		else $error("Bandera regWrite en bajo");
		
		assert(regWriteV==0) $display("Bandera regWriteV en bajo");
		else $error("Bandera regWriteV en alto");
		
		assert(modeSel==0) $display("Bandera modeSel en bajo");
		else $error("Bandera modeSel en alto");
		
		
		
		
		opType=2'b10; // operacion de memoria
		opCode=4'b0000; //load escalar
		Rd= 5; //Registro a escribir 5
		
		#10;
		
		$display("Operacion de memoria escalar, load");
		
		
		assert(immSrc==0) $display("Bandera immSrc en bajo");
		else $error("Bandera immSrc en alto");
		
		assert(branchFlag==0) $display("Bandera branchFlag en bajo");
		else $error("Bandera branchFlag en alto");
		
		assert(memWrite==0) $display("Bandera memWrite en bajo"); // en bajo para el load
		else $error("Bandera memWrite en alto");
		
		assert(memToReg==1) $display("Bandera memToReg en alto"); // en alto para load
		else $error("Bandera memToReg en bajo");
		
		assert(regWrite==1) $display("Bandera regWrite en alto"); // load escribe en registro
		else $error("Bandera regWrite en bajo");
		
		assert(regWriteV==0) $display("Bandera regWriteV en bajo"); //no se escribe en registro vectorial
		else $error("Bandera regWriteV en alto");
		
		assert(modeSel==0) $display("Bandera modeSel en bajo"); //operacion escalar
		else $error("Bandera modeSel en alto");
		
		
		
		
		
		opType=2'b10; // operacion de memoria
		opCode=4'b0001; //store escalar
		Rd= 5; //Registro a escribir 5
		
		#10;
		
		$display("Operacion de memoria escalar, store");
		
		
		assert(immSrc==0) $display("Bandera immSrc en bajo");
		else $error("Bandera immSrc en alto");
		
		assert(branchFlag==0) $display("Bandera branchFlag en bajo");
		else $error("Bandera branchFlag en alto");
		
		assert(memWrite==1) $display("Bandera memWrite en alto"); // en alto para store
		else $error("Bandera memWrite en bajo");
		
		assert(memToReg==0) $display("Bandera memToReg en bajo"); // en bajo para store
		else $error("Bandera memToReg en alto");
		
		assert(regWrite==0) $display("Bandera regWrite en bajo"); // store no escribe a registros
		else $error("Bandera regWrite en alto");
		
		assert(regWriteV==0) $display("Bandera regWriteV en bajo"); //no se escribe en registro vectorial
		else $error("Bandera regWriteV en alto");
		
		assert(modeSel==0) $display("Bandera modeSel en bajo"); //operacion escalar
		else $error("Bandera modeSel en alto");
		
		
		
		
		opType=2'b11; // operacion de salto
		opCode=4'b0001; //beq
		Rd= 5; //Registro a escribir 5, en este caso no importa
		
		#10;
		
		
		$display("Operacion de salto, beq");
		
		
		assert(immSrc==1) $display("Bandera immSrc en alto"); //branch utiliza direccion de salto inmediato con respecto al pc
		else $error("Bandera immSrc en bajo");
		
		assert(branchFlag==1) $display("Bandera branchFlag en alto"); //salto
		else $error("Bandera branchFlag en bajo");
		
		assert(memWrite==0) $display("Bandera memWrite en bajo"); 
		else $error("Bandera memWrite en alto");
		
		assert(memToReg==0) $display("Bandera memToReg en bajo"); 
		else $error("Bandera memToReg en alto");
		
		assert(regWrite==0) $display("Bandera regWrite en bajo"); 
		else $error("Bandera regWrite en alto");
		
		assert(regWriteV==0) $display("Bandera regWriteV en bajo"); 
		else $error("Bandera regWriteV en alto");
		
		assert(modeSel==0) $display("Bandera modeSel en bajo"); //operacion escalar
		else $error("Bandera modeSel en alto");
		

		
		
		opType=2'b10; // operacion de memoria
		opCode=4'b0010; //load vectorial
		Rd= 5; //Registro a escribir 5
		
		#10;
		
		$display("Operacion de memoria vectorial, load");
		
		
		assert(immSrc==0) $display("Bandera immSrc en bajo");
		else $error("Bandera immSrc en alto");
		
		assert(branchFlag==0) $display("Bandera branchFlag en bajo");
		else $error("Bandera branchFlag en alto");
		
		assert(memWrite==0) $display("Bandera memWrite en bajo"); // en bajo para el load
		else $error("Bandera memWrite en alto");
		
		assert(memToReg==1) $display("Bandera memToReg en alto"); // en alto para load
		else $error("Bandera memToReg en bajo");
		
		assert(regWrite==0) $display("Bandera regWrite en bajo"); // no se escribe a registro escalar
		else $error("Bandera regWrite en bajo");
		
		assert(regWriteV==1) $display("Bandera regWriteV en alto"); //loadv escribe en registro vectorial
		else $error("Bandera regWriteV en alto");
		
		assert(modeSel==1) $display("Bandera modeSel en alto"); //operacion vectorial
		else $error("Bandera modeSel en alto");
		
		
		

		
		opType=2'b10; // operacion de memoria
		opCode=4'b0011; //store vectorial
		Rd= 5; //Registro a escribir 5
		
		#10;
		
		$display("Operacion de memoria vectorial, store");
		
		
		assert(immSrc==0) $display("Bandera immSrc en bajo");
		else $error("Bandera immSrc en alto");
		
		assert(branchFlag==0) $display("Bandera branchFlag en bajo");
		else $error("Bandera branchFlag en alto");
		
		assert(memWrite==1) $display("Bandera memWrite en alto"); // en alto para store
		else $error("Bandera memWrite en bajo");
		
		assert(memToReg==0) $display("Bandera memToReg en bajo"); // en bajo para store
		else $error("Bandera memToReg en alto");
		
		assert(regWrite==0) $display("Bandera regWrite en bajo"); // store no escribe a registros
		else $error("Bandera regWrite en alto");
		
		assert(regWriteV==0) $display("Bandera regWriteV en bajo"); //no se escribe en registro vectorial
		else $error("Bandera regWriteV en alto");
		
		assert(modeSel==1) $display("Bandera modeSel en alto"); //operacion vectorial
		else $error("Bandera modeSel en bajo");
		
		
		
		opType=2'b00; // operacion aritmetica
		opCode=4'b1101; //suma vectorial
		Rd= 3; //Registro a escribir 3
		#10;
		
		$display("suma aritmetica vectorial");
		
		
		assert(immSrc==0) $display("Bandera immSrc en bajo");
		else $error("Bandera immSrc en alto");
		
		assert(branchFlag==0) $display("Bandera branchFlag en bajo");
		else $error("Bandera branchFlag en alto");
		
		assert(memWrite==0) $display("Bandera memWrite en bajo");
		else $error("Bandera memWrite en alto");
		
		assert(memToReg==0) $display("Bandera memToReg en bajo");
		else $error("Bandera memToReg en alto");
		
		assert(regWrite==0) $display("Bandera regWrite en bajo");
		else $error("Bandera regWrite en alto");
		
		assert(regWriteV==1) $display("Bandera regWriteV en alto");
		else $error("Bandera regWriteV en bajo");
		
		assert(modeSel==1) $display("Bandera modeSel en alto");
		else $error("Bandera modeSel en bajo");
		
		
		#10;
		
		
		
		
	
	
	end

endmodule 