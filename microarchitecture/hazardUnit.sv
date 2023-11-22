module hazardUnit(input [3:0] Ra,Rb,Rc,Rd_EXMEM,Rd_MEMWB,input  [1:0] opTypeMem,opTypeWB,input  [3:0] opCodeMem,opCodeWB,input regWriteMem,regWriteWB,regWriteVMem,regWriteVWB,modeSel,modeSelMem,modeSelWB,input [143:0] aluResult,Result,input  branchTakenFlag,output Fa,Fb,Fc,stall,flush1,flush2,flush3,flush4,flush5,output logic [143:0] Forward1,Forward2,Forward3);



	// Ra,Rb,Rc registros utilizados actualmente en la etapa de execute
	//Rd_EXMEM: registro destino(posible escritura) leido desde el buffer EXMEM
	//RE_MEMWB: registro destino (posible escritura) leido desde el buffer MEMWB
	//opTypeMem: opType de la actual operation en la etapa de memoria, se lee desde el buffer EXMEM
	//opCodeMem: opCode de la actual operation en la etapa de memoria, se lee desde el buffer EXMEM
	//opTypeWB: opType de la actual operation en la etapa de writeback, se lee desde el buffer MEMWB
	//opCodeWB: opCode de la actual operation en la etapa de writeback, se lee desde el buffer MEMWB
	//regWriteMem: bandera regWrite escalar en la etapa de memoria se lee del buffer EXMEM
	//regWriteWB: bandera regWrite escalar en la etapa de writeback se lee del buffer MEMWB
	//regWriteVMem: bandera regWrite vectorial en la etapa de memoria se lee del buffer EXMEM
	//regWriteVWB: bandera regWrite vectorial en la etapa de writeback se lee del buffer MEMWB
	//modeSel: bandera de modeSel(indica si es escalar o vectorial) leida en buffer IDEX
	//modeSelMem: bandera de modeSel(indica si es escalar o vectorial) leida en buffer EXMEM
	//modeSelWB: bandera de modeSel(indica si es escalar o vectorial) leida en buffer MEMWB
	//aluResult: salida del ALU, es decir, valor calculado en la etapa de execute se lee en el registro EXMEM
	//result: resultado de la etapa del right back, se lee como salida del modulo de writeback
	//branchTakenFlag: bandera que indica si se ha echo un salto y por lo tanto tendria que realizarse un flush, se obtiene del buffer EXMEM
	//Fa bandera de salida que indica si la lectura del registro Ra en execute necesita un adelantamiento
	//Fb bandera de salida que indica si la lectura del registro Rb en execute necesita un adelantamiento
	//Fb bandera de salida que indica si la lectura del registro Rc en execute necesita un adelantamiento
	//Stall: bandera para realizar el stall del las etapas de IF,ID,EX. Es para esperar la lectura de memoria desde el load
	//flush1: bandera para indicar el flush del buffer del pc
	//flush2: bandera para indicar el flush del buffer del instructionFetch
	//flush3: bandera para indicar el flush del buffer del instructionDecode
	//flush4: bandera para indicar el flush del buffer del Execute
	//flush5: bandera para indicar el flush del buffer del MEM
	//Forward1: dato para hacer forward hacia execute en lectura de Ra, basicamente elige entre los datos ya sea de EXMEM o MEMWB
	//Forward2: dato para hacer forward hacia execute en lectura de Rb, basicamente elige entre los datos ya sea de EXMEM o MEMWB
	//Forward3: dato para hacer forward hacia execute en lectura de Rc, basicamente elige entre los datos ya sea de EXMEM o MEMWB
	logic flushCondition,ldFlag,writtenOnMem,writtenOnWB;
	
	logic Ra_Written_EXMEM,Rb_Written_EXMEM,Rc_Written_EXMEM;
	logic Ra_Written_MEMWB,Rb_Written_MEMWB,Rc_Written_MEMWB;
	
	assign Ra_Written_EXMEM= Ra==Rd_EXMEM; //indica si el registro leido Ra en el execute es el mismo que se tiene en la etapa de memoria
	assign Rb_Written_EXMEM= Rb==Rd_EXMEM;	//indica si el registro leido Rb en el execute es el mismo que se tiene en la etapa de memoria
	assign Rc_Written_EXMEM= Rc==Rd_EXMEM; //indica si el registro leido Rc en el execute es el mismo que se tiene en la etapa de memoria
	assign Ra_Written_MEMWB= Ra==Rd_MEMWB; //indica si el registro leido Ra en el execute es el mismo que se tiene en la etapa de writeback
	assign Rb_Written_MEMWB= Rb==Rd_MEMWB; //indica si el registro leido Rb en el execute es el mismo que se tiene en la etapa de writeback
	assign Rc_Written_MEMWB= Rc==Rd_MEMWB;	//indica si el registro leido Rc en el execute es el mismo que se tiene en la etapa de writeback
	
	assign ldFlag= (opTypeMem==2'b10) & (opCodeMem==4'b0000 | opCodeMem==4'b0010); // verifica si la operacion actual en la etapa de memoria es un load, ya que en este caso, se tendria que realizar un stall si se requiere adelantar el dato
	assign writtenOnMem=(regWriteMem | regWriteVMem) & (modeSel ~^ modeSelMem); //verifica si se escribe en memoria y ademas es el mismo tipo de operacion (escalar o vectorial)
	assign writtenOnWB=(regWriteWB | regWriteVWB) & (modeSel ~^ modeSelWB);//verifica si se escribe en writeback y ademas es el mismo tipo de operacion (escalar o vectorial)
	assign stall = (Ra_Written_EXMEM | Rb_Written_EXMEM | Rc_Written_EXMEM) & ldFlag & (modeSel ~^ modeSelMem); // stall si se necesita adelantar desde memoria y ademas en memoria se esta dando un load 
	assign flushCondition=branchTakenFlag; //si se toma un branch es necesario realizar flush
	assign flush1=0;
	assign flush2=flushCondition;
	assign flush3=flushCondition;
	assign flush4=flushCondition;
	assign flush5=0;
	assign Fa= (Ra_Written_EXMEM & writtenOnMem )| (Ra_Written_MEMWB & writtenOnWB); // Se adelanta a si es escrito en esa etapa y ademas esta destinado a escribirse
	assign Fb= (Rb_Written_EXMEM & writtenOnMem) | (Rb_Written_MEMWB & writtenOnWB); // Se adelanta a si es escrito en esa etapa y ademas esta destinado a escribirse
	assign Fc= (Rc_Written_EXMEM & writtenOnMem) | (Rc_Written_MEMWB & writtenOnWB); // Se adelanta a si es escrito en esa etapa y ademas esta destinado a escribirse
	
	
	always_comb begin
	
		if(Ra_Written_EXMEM)Forward1=aluResult;
		else Forward1=Result;
	end
	
	
	always_comb begin
		if(Rb_Written_EXMEM)Forward2=aluResult;
		else Forward2=Result;
	end
	
	always_comb begin
		if(Rc_Written_EXMEM)Forward3=aluResult;
		else Forward3=Result;
	end
	

endmodule 