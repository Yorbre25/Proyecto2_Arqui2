module testExec;
	parameter setValuesBuffer = 17;
	parameter N = 24;
	parameter M=6;
	parameter BW = setValuesBuffer + 2*N* M;

	//module inputs
	logic clk, rst, en;
	logic [1:0] opType;
	logic [3:0] opCode;
	logic immSrc, branchFlag, memWrite, memToReg, regWrite,modeSel;
	logic [3:0] aluControl, Ra, Rb, Rc;
	logic [N-1:0] rd1, rd2, rd3;
	logic [N-1:0] imm,pc;
	
	logic [N*M-1:0] rdv1,rdv2, Forward1, Forward2, Forward3;
	logic [N*M-1:0] rdv3;
	
	logic Fa,Fb,Fc;
	
	logic [BW-1:0] bufferOut;
	
	
	//module outputs

	logic modeSel_e;
	logic [1:0] opType_e;
	logic [3:0] opCode_e;
	logic [M*N-1:0] aluCurrentResult_e;
	logic zeroFlag_e,negFlag_e,branchFlag_e,memWrite_e,memToReg_e,regWrite_e;
	logic [3:0] RC_e;
	logic [M*N-1:0] RD3Out_e;

	
	

	
	exec #(.N(24),.M(6)) myExec(
	.clk(clk), .rst(rst), .en(en), 
	.rd1(rd1),.rd2(rd2), .pc(pc), .imm(imm), 
	.rdv1(rdv1),.rdv2(rdv2), .Forward1(Forward1), .Forward2(Forward2),.Forward3(Forward3), 
	.rd3(rd3),
	.rdv3(rdv3),
	.aluControl(aluControl),
	.Rc(Rc),
	.immSrc(immSrc), .branchFlag(branchFlag), .memWrite(memWrite), .memToReg(memToReg), .regWrite(regWrite),.modeSel(modeSel),
	.Fa(Fa), .Fb(Fb),.Fc(Fc),
	.opType(opType),
	.opCode(opCode),
	.bufferOut(bufferOut)
	);
		
	
	
	
	
	//Exec Inputs
	assign modeSel_e = bufferOut[304];
	assign opType_e = bufferOut[303:302];
	assign opCode_e = bufferOut[301:298];
	assign aluCurrentResult_e = bufferOut[297:154];
	assign zeroFlag_e = bufferOut[153];
	assign negFlag_e = bufferOut[152];
	assign branchFlag_e = bufferOut[151];
	assign memWrite_e = bufferOut[150];
	assign memToReg_e = bufferOut[149];
	assign regWrite_e = bufferOut[148];
	assign RC_e = bufferOut[147:144];
	assign RD3Out_e = bufferOut[143:0];
	
	

	
	// Clock generation
	always #10 clk = ~clk;

	
	// Initialize inputs
	initial begin
		clk=0;
		rst=0;
		en=0;
		rd1=24'b0;
		rd2=24'b0;
		pc=24'b0;
		imm=24'b0;
		rdv1= 144'd540;
		rdv2=144'd300;
		Forward1=144'd150;
		Forward2=144'd832;
		Forward3=144'd1022;
		rd3=24'd32;
		rdv3=144'd192;
		
		
	end

	
endmodule
