`timescale 1ns/1ns
module hazardUnit_tb();
	logic [3:0] Ra,Rb,Rc,Rd_EXMEM,Rd_MEMWB;
	logic [1:0] opTypeMem,opTypeWB;
	logic [3:0] opCodeMem,opCodeWB;
	logic [143:0] aluResult,Result,Forward1,Forward2,Forward3;
	logic branchTakenFlag,Fa,Fb,Fc,stall,flush1,flush2,flush3,flush4,flush5;
	logic regWriteMem,regWriteWB,regWriteVMem,regWriteVWB,modeSel,modeSelMem,modeSelWB;
	
	
	
	hazardUnit myhazardUnit(.Ra(Ra),.Rb(Rb),.Rc(Rc),.Rd_EXMEM(Rd_EXMEM),.Rd_MEMWB(Rd_MEMWB),
	.opTypeMem(opTypeMem),.opTypeWB(opTypeWB),.opCodeMem(opCodeMem),.opCodeWB(opCodeWB),
	.regWriteMem(regWriteMem),.regWriteWB(regWriteWB),.regWriteVMem(regWriteVMem),.regWriteVWB(regWriteVWB),
	.modeSel(modeSel),.modeSelMem(modeSelMem),.modeSelWB(modeSelWB),
	.aluResult(aluResult),.Result(Result), 
	.branchTakenFlag(branchTakenFlag),
	.Fa(Fa),.Fb(Fb),.Fc(Fc),.stall(stall),
	.flush1(flush1),.flush2(flush2),.flush3(flush3),.flush4(flush4),.flush5(flush5), 
	.Forward1(Forward1),.Forward2(Forward2),.Forward3(Forward3));
	
	
	initial begin
	
		#10;
		Ra=4'b0001;
		Rb=4'b0010;
		Rc=4'b0011;
		Rd_EXMEM=4'b1010;
		Rd_MEMWB=4'b1111;
		opTypeMem=2'b00;
		opCodeMem=4'b0010;
		opTypeWB=2'b11;
		opCodeWB=4'b0010;
		aluResult=10;
		Result=2;
		branchTakenFlag=0;
		regWriteMem=0;
		regWriteWB=0;
		regWriteVMem=0;
		regWriteVWB=0;
		modeSel=0;
		modeSelMem=0;
		modeSelWB=0;
		
		//prueba ningun adelanto (numero de registros no coinciden para adelantar)
		
		#10;
		$display("\n Prueba ningun adelanto (numero de registros no coinciden para adelantar)");
		assert(stall==0) $display("stall no realizado cuando no han conflico");
		else $error("stall realizado sin conflicto");
		
		assert(flush1==0) $display("Flush 1 no realizado correctamente");
		else $error("Flush 1 realizado incorrectamente");
		
		assert(flush2==0) $display("Flush 2 no realizado correctamente");
		else $error("Flush 2 realizado incorrectamente");
		
		assert(flush3==0) $display("Flush 3 no realizado correctamente");
		else $error("Flush 3 realizado incorrectamente");
		
		assert(flush4==0) $display("Flush 4 no realizado correctamente");
		else $error("Flush 4 realizado incorrectamente");
		
		assert(flush5==0) $display("Flush 5 no realizado correctamente");
		else $error("Flush 5 realizado incorrectamente");
		
		assert(Fa==0) $display("Fa en bajo de forma correcta");
		else $error("Fa en alto incorrectamente");
		
		assert(Fb==0) $display("Fb en bajo de forma correcta");
		else $error("Fb en alto incorrectamente");
		
		assert(Fc==0) $display("Fb en bajo de forma correcta");
		else $error("Fb en alto incorrectamente");
		
		//prueba adelanto de Fa desde memoria etapa de memoria registro escalar
		#10;
		Ra=4'b0001;
		Rb=4'b0010;
		Rd_EXMEM=4'b0001;
		Rd_MEMWB=4'b1111;
		opTypeMem=2'b00;
		opCodeMem=4'b0010;
		regWriteMem=1;
		
		#10;
		$display("\n Prueba adelanto de Fa desde memoria etapa de memoria registro escalar");
		assert(stall==0) $display("stall no realizado conflicto con unidad de adelantamiento");
		else $error("stall realizado conflicto con unidad de adelantamiento");
		
		assert(flush1==0) $display("Flush 1 no realizado correctamente");
		else $error("Flush 1 realizado incorrectamente");
		
		assert(flush2==0) $display("Flush 2 no realizado correctamente");
		else $error("Flush 2 realizado incorrectamente");
		
		assert(flush3==0) $display("Flush 3 no realizado correctamente");
		else $error("Flush 3 realizado incorrectamente");
		
		assert(flush4==0) $display("Flush 4 no realizado correctamente");
		else $error("Flush 4 realizado incorrectamente");
		
		assert(flush5==0) $display("Flush 5 no realizado correctamente");
		else $error("Flush 5 realizado incorrectamente");
		
		assert(Fa==1) $display("Fa en alto de forma correcta");
		else $error("Fa en bajo incorrectamente");
		
		assert(Fb==0) $display("Fb en bajo de forma correcta");
		else $error("Fb en alto incorrectamente");
		
		assert(Forward1==aluResult) $display("Operador 1 adelantado correctamente");
		else $error("Operador 1 adelantado incorrectamente");
		
		
		//prueba adelanto de Fa desde memoria etapa de memoria registro vectorial
		#10;
		Ra=4'b0001;
		Rb=4'b0010;
		Rd_EXMEM=4'b0001;
		Rd_MEMWB=4'b1111;
		opTypeMem=2'b00;
		opCodeMem=4'b0010;
		regWriteMem=0;
		regWriteVMem=1;
		modeSel=1;
		modeSelMem=1;
		
		#10;
		$display("\n Prueba adelanto de Fa desde memoria etapa de memoria registro vectorial");
		assert(stall==0) $display("stall no realizado conflicto con unidad de adelantamiento");
		else $error("stall realizado conflicto con unidad de adelantamiento");
		
		assert(flush1==0) $display("Flush 1 no realizado correctamente");
		else $error("Flush 1 realizado incorrectamente");
		
		assert(flush2==0) $display("Flush 2 no realizado correctamente");
		else $error("Flush 2 realizado incorrectamente");
		
		assert(flush3==0) $display("Flush 3 no realizado correctamente");
		else $error("Flush 3 realizado incorrectamente");
		
		assert(flush4==0) $display("Flush 4 no realizado correctamente");
		else $error("Flush 4 realizado incorrectamente");
		
		assert(flush5==0) $display("Flush 5 no realizado correctamente");
		else $error("Flush 5 realizado incorrectamente");
		
		assert(Fa==1) $display("Fa en alto de forma correcta");
		else $error("Fa en bajo incorrectamente");
		
		assert(Fb==0) $display("Fb en bajo de forma correcta");
		else $error("Fb en alto incorrectamente");
		
		assert(Forward1==aluResult) $display("Operador 1 adelantado correctamente");
		else $error("Operador 1 adelantado incorrectamente");
		
		
		//Prueba de adelanto del Rb desde la etapa de writeback, escalar
		#10;
		
		regWriteMem=0;
		regWriteVMem=1;
		
		
		Ra=4'b0001;
		Rb=4'b0010;
		Rd_EXMEM=4'b1010;
		Rd_MEMWB=4'b0010;
		opTypeWB=2'b00;
		opCodeWB=4'b0010;
		modeSel=0;
		modeSelWB=0;
		regWriteWB=1;
		
		#10;
		$display("\n Prueba de adelanto del Rb desde la etapa de writeback, escalar");
		assert(stall==0) $display("stall no realizado conflicto con unidad de adelantamiento");
		else $error("stall realizado conflicto con unidad de adelantamiento");
		
		assert(flush1==0) $display("Flush 1 no realizado correctamente");
		else $error("Flush 1 realizado incorrectamente");
		
		assert(flush2==0) $display("Flush 2 no realizado correctamente");
		else $error("Flush 2 realizado incorrectamente");
		
		assert(flush3==0) $display("Flush 3 no realizado correctamente");
		else $error("Flush 3 realizado incorrectamente");
		
		assert(flush4==0) $display("Flush 4 no realizado correctamente");
		else $error("Flush 4 realizado incorrectamente");
		
		assert(flush5==0) $display("Flush 5 no realizado correctamente");
		else $error("Flush 5 realizado incorrectamente");
		
		assert(Fa==0) $display("Fa en bajo de forma correcta");
		else $error("Fa en alto incorrectamente");
		
		assert(Fb==1) $display("Fb en alto de forma correcta");
		else $error("Fb en bajo incorrectamente");
		
		assert(Forward2==Result) $display("Operador 2 adelantado correctamente");
		else $error("Operador 2 adelantado incorrectamente");
		
		
		
		//Prueba de adelanto del Rb desde la etapa de writeback, vectorial
		
		#10;
		
		
		Ra=4'b0001;
		Rb=4'b0010;
		Rd_EXMEM=4'b1010;
		Rd_MEMWB=4'b0010;
		opTypeWB=2'b00;
		opCodeWB=4'b0010;
		modeSel=1;
		modeSelWB=1;
		regWriteWB=0;
		regWriteVWB=1;
		
		#10;
		$display("\n Prueba de adelanto del Rb desde la etapa de writeback, vectorial");
		assert(stall==0) $display("stall no realizado conflicto con unidad de adelantamiento");
		else $error("stall realizado conflicto con unidad de adelantamiento");
		
		assert(flush1==0) $display("Flush 1 no realizado correctamente");
		else $error("Flush 1 realizado incorrectamente");
		
		assert(flush2==0) $display("Flush 2 no realizado correctamente");
		else $error("Flush 2 realizado incorrectamente");
		
		assert(flush3==0) $display("Flush 3 no realizado correctamente");
		else $error("Flush 3 realizado incorrectamente");
		
		assert(flush4==0) $display("Flush 4 no realizado correctamente");
		else $error("Flush 4 realizado incorrectamente");
		
		assert(flush5==0) $display("Flush 5 no realizado correctamente");
		else $error("Flush 5 realizado incorrectamente");
		
		assert(Fa==0) $display("Fa en bajo de forma correcta");
		else $error("Fa en alto incorrectamente");
		
		assert(Fb==1) $display("Fb en alto de forma correcta");
		else $error("Fb en bajo incorrectamente");
		
		assert(Forward2==Result) $display("Operador 2 adelantado correctamente");
		else $error("Operador 2 adelantado incorrectamente");
		
		
		
		#10;
		
		//Prueba de stall debido a tratar de adelantar de memoria pero se este procesando un load. (escalar)
		regWriteWB=0;
		regWriteVWB=0;
		
		
		Ra=4'b0001;
		Rb=4'b0010;
		Rd_EXMEM=4'b0010;
		Rd_MEMWB=4'b1010;
		opTypeMem=2'b10;
		opCodeMem=4'b0000;
		regWriteMem=1;
		modeSel=0;
		modeSelMem=0;
		
		#10;
		$display("Prueba de stall debido a tratar de adelantar de memoria pero se este procesando un load. (escalar)");
		assert(stall==1) $display("stall realizado correctamente debido a ld imposible de unidad de adelantamiento");
		else $error("stall no realizado incorrectamente");
		
		assert(flush1==0) $display("Flush 1 no realizado correctamente");
		else $error("Flush 1 realizado incorrectamente");
		
		assert(flush2==0) $display("Flush 2 no realizado correctamente");
		else $error("Flush 2 realizado incorrectamente");
		
		assert(flush3==0) $display("Flush 3 no realizado correctamente");
		else $error("Flush 3 realizado incorrectamente");
		
		assert(flush4==0) $display("Flush 4 no realizado correctamente");
		else $error("Flush 4 realizado incorrectamente");
		
		assert(flush5==0) $display("Flush 5 no realizado correctamente");
		else $error("Flush 5 realizado incorrectamente");
		
		
		
		#10;
		
		Ra=4'b0001;
		Rb=4'b0010;
		Rd_EXMEM=4'b0010;
		Rd_MEMWB=4'b1010;
		opTypeMem=2'b10;
		opCodeMem=4'b0000;
		regWriteMem=0;
		regWriteVMem=1;
		modeSel=1;
		modeSelMem=1;
		
		#10;
		$display("Prueba de stall debido a tratar de adelantar de memoria pero se este procesando un load. (vectorial)");
		assert(stall==1) $display("stall realizado correctamente debido a ld imposible de unidad de adelantamiento");
		else $error("stall no realizado incorrectamente");
		
		assert(flush1==0) $display("Flush 1 no realizado correctamente");
		else $error("Flush 1 realizado incorrectamente");
		
		assert(flush2==0) $display("Flush 2 no realizado correctamente");
		else $error("Flush 2 realizado incorrectamente");
		
		assert(flush3==0) $display("Flush 3 no realizado correctamente");
		else $error("Flush 3 realizado incorrectamente");
		
		assert(flush4==0) $display("Flush 4 no realizado correctamente");
		else $error("Flush 4 realizado incorrectamente");
		
		assert(flush5==0) $display("Flush 5 no realizado correctamente");
		else $error("Flush 5 realizado incorrectamente");
		
		
		
		
		
		
		#10;
		
		//Prueba de stall. No debe hacer stall debido a diferentes modeSel en el execute y memoryStage
		Ra=4'b0001;
		Rb=4'b0010;
		Rd_EXMEM=4'b0010;
		Rd_MEMWB=4'b1010;
		opTypeMem=2'b10;
		opCodeMem=4'b0000;
		regWriteMem=1;
		modeSel=0;
		modeSelMem=1;
		
		#10;
		$display("\n Prueba de stall. No debe hacer stall debido a diferentes modeSel en el execute y memoryStage");
		assert(stall==0) $display("stall no realizado correctamente debido a diferentes modeSel");
		else $error("stall realizado incorrectamente aun con diferentes modeSel");
		
		assert(flush1==0) $display("Flush 1 no realizado correctamente");
		else $error("Flush 1 realizado incorrectamente");
		
		assert(flush2==0) $display("Flush 2 no realizado correctamente");
		else $error("Flush 2 realizado incorrectamente");
		
		assert(flush3==0) $display("Flush 3 no realizado correctamente");
		else $error("Flush 3 realizado incorrectamente");
		
		assert(flush4==0) $display("Flush 4 no realizado correctamente");
		else $error("Flush 4 realizado incorrectamente");
		
		assert(flush5==0) $display("Flush 5 no realizado correctamente");
		else $error("Flush 5 realizado incorrectamente");
		
		
		
		
		// test de branch no realizado (branch cuyas condiciones no se cumplieron)
		#10;
		Ra=4'b0001;
		Rb=4'b0010;
		Rd_EXMEM=4'b0010;
		Rd_MEMWB=4'b1010;
		opTypeMem=2'b11;
		opCodeMem=4'b1011;
		branchTakenFlag=0;
		
		#10;
		$display("\n test de branch no realizado (branch cuyas condiciones no se cumplieron)");
		assert(stall==0) $display("stall no realizado correctamente");
		else $error("stall realizado incorrectamente");
		
		assert(flush1==0) $display("Flush 1 no realizado correctamente");
		else $error("Flush 1 realizado incorrectamente");
		
		assert(flush2==0) $display("Flush 2 no realizado correctamente");
		else $error("Flush 2 realizado incorrectamente");
		
		assert(flush3==0) $display("Flush 3 no realizado correctamente");
		else $error("Flush 3 realizado incorrectamente");
		
		assert(flush4==0) $display("Flush 4 no realizado correctamente");
		else $error("Flush 4 realizado incorrectamente");
		
		assert(flush5==0) $display("Flush 5 no realizado correctamente");
		else $error("Flush 5 realizado incorrectamente");
		
		
		#10;
		
		// test de branch realizado (branch cuyas condiciones se cumplieron)
		Ra=4'b0001;
		Rb=4'b0010;
		Rd_EXMEM=4'b0010;
		Rd_MEMWB=4'b1010;
		opTypeMem=2'b11;
		opCodeMem=4'b1011;
		branchTakenFlag=1;
		
		#10;
		$display("\n test de branch realizado (branch cuyas condiciones se cumplieron)");
		assert(stall==0) $display("stall no realizado correctamente");
		else $error("stall realizado incorrectamente");
		
		assert(flush1==0) $display("Flush 1 no realizado correctamente");
		else $error("Flush 1 realizado incorrectamente");
		
		assert(flush2==1) $display("Flush 2  realizado correctamente");
		else $error("Flush 2 no realizado incorrectamente");
		
		assert(flush3==1) $display("Flush 3  realizado correctamente");
		else $error("Flush 3 no realizado incorrectamente");
		
		assert(flush4==1) $display("Flush 4 realizado correctamente");
		else $error("Flush 4 no realizado incorrectamente");
		
		assert(flush5==0) $display("Flush 5 no realizado correctamente");
		else $error("Flush 5 realizado incorrectamente");
		
		
		#10;
		// test adelantamiento de Ra desde WB
		regWriteVWB=0;
		regWriteWB=1;
		
		Ra=4'b1001;
		Rb=4'b0111;
		Rd_EXMEM=4'b0111;
		Rd_MEMWB=4'b1001;
		opTypeMem=2'b11;
		opCodeMem=4'b1011;
		opTypeWB=2'b10;
		opCodeWB=4'b0000;
		branchTakenFlag=0;
		modeSel=0;
		modeSelWB=0;
		
		#10;
		$display("\n test adelantamiento de Ra desde WB");
		assert(stall==0) $display("stall no realizado correctamente");
		else $error("stall realizado incorrectamente");
		
		assert(flush1==0) $display("Flush 1 no realizado correctamente");
		else $error("Flush 1 realizado incorrectamente");
		
		assert(flush2==0) $display("Flush 2  no realizado correctamente");
		else $error("Flush 2 no realizado incorrectamente");
		
		assert(flush3==0) $display("Flush 3  no realizado correctamente");
		else $error("Flush 3 no realizado incorrectamente");
		
		assert(flush4==0) $display("Flush 4 no realizado correctamente");
		else $error("Flush 4 no realizado incorrectamente");
		
		assert(flush5==0) $display("Flush 5 no realizado correctamente");
		else $error("Flush 5 realizado incorrectamente");
		
		assert(Fa==1) $display("Fa en alto de forma correcta proveniente desde WB ");
		else $error("Fa en bajo incorrectamente");
		
		assert(Fb==0) $display("Fb en bajo de forma correcta ya que la operacion en memoria corresponde a un branch que no escribe a registro");
		else $error("Fb en alto incorrectamente");
		
		#10;
		
		regWriteWB=0;
		regWriteVWB=0;
		
		
		Ra=4'b1001;
		Rb=4'b0111;
		Rd_EXMEM=4'b0111;
		Rd_MEMWB=4'b1001;
		opTypeMem=2'b01;
		opCodeMem=4'b1011;
		opTypeWB=2'b10;
		opCodeWB=4'b0001;
		branchTakenFlag=0;
		regWriteMem=0;
		regWriteVMem=1;
		modeSel=1;
		modeSelMem=1;
		
		#10;
		
		$display("\n Test adelanto de Fb desde Mem");
		assert(stall==0) $display("stall no realizado correctamente");
		else $error("stall realizado incorrectamente");
		
		assert(flush1==0) $display("Flush 1 no realizado correctamente");
		else $error("Flush 1 realizado incorrectamente");
		
		assert(flush2==0) $display("Flush 2  no realizado correctamente");
		else $error("Flush 2 no realizado incorrectamente");
		
		assert(flush3==0) $display("Flush 3  no realizado correctamente");
		else $error("Flush 3 no realizado incorrectamente");
		
		assert(flush4==0) $display("Flush 4 no realizado correctamente");
		else $error("Flush 4 no realizado incorrectamente");
		
		assert(flush5==0) $display("Flush 5 no realizado correctamente");
		else $error("Flush 5 realizado incorrectamente");
		
		assert(Fa==0) $display("Fa en bajo de forma correcta debido a lectura de str que no altera los registros ");
		else $error("Fa en alto incorrectamente");
		
		assert(Fb===1) $display("Fb en alto de forma correcta ya que la operacion en WB corresponde aritmetico con inmediato que escribe a registro");
		else $error("Fb en bajo incorrectamente");
		
		#10;
		
		
		Rc=4'b0111;
		Rd_EXMEM=4'b0111;
		Rd_MEMWB=4'b1001;
		opTypeMem=2'b01;
		opCodeMem=4'b1011;
		opTypeWB=2'b10;
		opCodeWB=4'b0001;
		branchTakenFlag=0;
		regWriteMem=0;
		regWriteVMem=1;
		modeSel=1;
		modeSelMem=1;
		
		#10;
		$display("\n test adelantamiento para Rc");
		assert(Fc===1) $display("Fc en alto de forma correcta ya que la operacion en WB corresponde aritmetico con inmediato que escribe a registro");
		else $error("Fc en bajo incorrectamente");
		
		#10;
		
		Ra=4'b0001;
		Rb=4'b0010;
		Rc=4'b0011;
		Rd_EXMEM=4'b0001;
		Rd_MEMWB=4'b0011;
		regWriteMem=1;
		regWriteVMem=0;
		regWriteWB=1;
		regWriteVWB=0;
		modeSel=1;
		modeSelWB=0;
		modeSelMem=0;
		
		#10;
		$display("\n test no adelantamiento en condiciones donde el tipo de operacion en execute (vectorial o escalar) no es la misma que en memory y writeback");
		assert(Fa==0) $display("Ra no adelantada debido a diferente tipo de operacion en las etapas para adeltantar (escalar vs vectorial) ");
		else $error("Ra adelantada debido a diferente tipo de operacion en las etapas para adeltantar (escalar vs vectorial) ");
		
		assert(Fb===0) $display("Rb no adelantada debido a diferente tipo de operacion en las etapas para adeltantar (escalar vs vectorial) ");
		else $error("Rb adelantada debido a diferente tipo de operacion en las etapas para adeltantar (escalar vs vectorial) ");
		
		assert(Fc===0) $display("Rc no adelantada debido a diferente tipo de operacion en las etapas para adeltantar (escalar vs vectorial) ");
		else $error("Rc adelantada debido a diferente tipo de operacion en las etapas para adeltantar (escalar vs vectorial) ");
		
		
		#10;
		
		
		
		
		
		
	end
endmodule 