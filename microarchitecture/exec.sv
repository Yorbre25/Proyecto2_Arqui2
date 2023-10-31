parameter setValuesBuffer = 16;
module exec #(parameter N= 24,parameter M=6, parameter BW=setValuesBuffer + 2*N)(
	input clk, rst, en, //clock, flush, stall,
	input [N-1:0] rd1, rd2, pc, imm, // Alu entries
	input [M*N-1:0] rdv1,rdv2, Forward1, Forward2,Forward3, 
	input [N-1:0] rd3,
	input [M*N-1:0] rdv3,
	input [3:0] aluControl,
	input [3:0] Rc, // Register number
	input immSrc, branchFlag, memWrite, memToReg, regWrite,modeSel,// modeSel(if its scalar or vectorial)
	input Fa, Fb,Fc,
	input [1:0] opType,
	input [3:0] opCode,
	output [BW-1:0] bufferOut
);
	
	//sub modules output
	logic [1:0] flags;
	logic [M*N-1:0] aluCurrentResult,RD3Out,aluCurrentResultVectorial,RD3OutVectorial;
	logic [BW-1:0] bufferInput;
	logic [1:0]currentFlag;
	logic zeroFlag, negFlag;
	
	execScalar #(.N(N)) myExecScalar(
	.rd1(rd1), 
	.rd2(rd2), 
	.pc(pc), 
	.imm(imm),
	.Forward1(Forward1[N-1:0]),
	.Forward2(Forward2[N-1:0]), 
	.Forward3(Forward3[N-1:0]),
	.rd3(rd3), .aluControl(aluControl), 
	.immSrc(immSrc), .branchFlag(branchFlag), 
	.Fa(Fa), 
	.Fb(Fb), 
	.Fc(Fc), 
	.aluCurrentResult(aluCurrentResult[N-1:0]),
	.RD3Out(RD3Out[N-1:0]),
	.flags(flags));
	
	/*
	
	execVect #(.N24)(
	input [M*N-1:0] rd1, rd2, imm, Forward1, Forward2,Forward3, // Posible Alu entries
	input [6*N-1:0] rd3,
	input [3:0] aluControl,
	input immSrc,
	input Fa, Fb,Fc,
	output  [6*N-1:0] aluCurrentResult,RD3Out,

	);
	*/
	
	flagRegister myFlagRegister(
		.opType(opType), 
		.opCode(opCode),
		.newFlags(flags),
		.currentFlag(currentFlag),
		.rst(rst)
	);	

	
	//buffer setup
	buffer #(.Buffer_size(BW)) EX_MEM (.rst(rst), .clk(clk), .en(en), .bufferInput(bufferInput), .bufferOut(bufferOut));
	
	
	assign zeroFlag = currentFlag[0];
	assign negFlag = currentFlag[1];
	
	//setting void spaces for vectorial input
	assign aluCurrentResult[M*N-1:N] = {(M-1)*N{1'b0}};
	assign RD3Out[M*N-1:N] = {(M-1)*N{1'b0}};
	
	
	
	
//divide instruction:
//	   | opType | opCode | aluCurrentResult | zeroFlag | negFlag | branchFlag | memWrite | memToReg | regWrite | Rc | rd3  |
//Size:
//	   |   [2] 	|   [4]  |       [N]	       |  [1]     |   [1]   |    [1]     |   [1]    |    [1]   |   [1]    |[4] | [N]  | 
//	----------------------------------------------------------------------------------------------------------------
//    |63		|61		|57				    |33		   |32	    |31			  |30			 |29			|28		  | 27 |23   0|

  	assign bufferInput={opType,opCode,aluCurrentResult,zeroFlag,negFlag,branchFlag,memWrite,memToReg,regWrite, Rc, RD3Out};
	
endmodule