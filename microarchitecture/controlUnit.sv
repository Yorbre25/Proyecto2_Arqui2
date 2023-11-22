module controlUnit(input [1:0] opType, input [3:0] opCode,Rd, output immSrc,branchFlag,memWrite,memToReg,regWrite,regWriteV,modeSel, output [3:0] aluControl);

 //immSrc : es inmediato en alu
 //brachFlag: es branch
 //aluControl: operacion en alu
 //memWrite: operacion escribe en memoria
 //memToReg: de memoria a registro
 //regWrite: se escribe a registro
 //regWriteV: se escribe a registro vectorial
 //modeSel: identifica si es una operacion escalar=0 o una vectorial=1
 //ldFlag: branch que indica que si la operacion futura es un load, es usada para la detecion posterior de riesgos
 
	immSrcControl myImmSrc(.opType(opType),.opCode(opCode),.immSrc(immSrc));
	branchFlagControl myBranchFlag (.opType(opType),.branchFlag(branchFlag));
	aluControl myAluControl(.opType(opType),.opCode(opCode),.aluControl(aluControl));
	memWriteControl myMemWriteControl(.opType(opType),.opCode(opCode),.memWrite(memWrite));
	memToRegControl myMemToRegControl(.opType(opType),.opCode(opCode),.memToReg(memToReg));
	regWriteControl myRegWriteControl(.opType(opType),.opCode(opCode),.regWrite(regWrite),.regWriteV(regWriteV),.Rd(Rd));
	modeSelectorUnit myModeSelectorUnit (.opType(opType),.opCode(opCode),.modeSel(modeSel));

endmodule 