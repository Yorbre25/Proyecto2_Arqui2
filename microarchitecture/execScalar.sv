module execScalar #(parameter N= 24)(
	input [N-1:0] rd1, rd2, pc, imm, Forward1, Forward2,Forward3, // Posible Alu entries
	input [N-1:0] rd3,
	input [3:0] aluControl,
	input immSrc, branchFlag,
	input Fa, Fb,Fc,
	output  [N-1:0] aluCurrentResult,RD3Out,
	output [1:0] flags

);
	
	
	
	//Alu entry selector
	ALUMux #(.N(N)) AluMux1(
		.rd1(rd1), 
		.rd2(rd2), 
		.rd3(rd3),
		.pc(pc), 
		.imm(imm), 
		.Forward1(Forward1), 
		.Forward2(Forward2), 
		.Forward3(Forward3),
		.aluControl(aluControl), 
		.immSrc(immSrc), 
		.branchFlag(branchFlag), 
		.Fa(Fa), 
		.Fb(Fb), 
		.Fc(Fc),
		.flags(flags), 
		.aluCurrentResult(aluCurrentResult),
		.RD3Out(RD3Out)
	);
	

	
	
	
	

	
endmodule