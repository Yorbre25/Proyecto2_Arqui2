parameter M=6;
module execVect #(parameter N= 24)(
	input clk,
	input [M*N-1:0] rd1, rd2, Forward1, Forward2,Forward3,	// Posible Alu entries
	input [N-1:0] imm,
	input [M*N-1:0] rd3,
	input [3:0] aluControl,
	input immSrc,
	input Fa, Fb,Fc,
	output  [M*N-1:0] aluCurrentResult,RD3Out

);
	
	//selectors
	logic controlOp1,controlOp3;
	logic [1:0] controlOp2;
	
	//operators output from the mux
	logic [M*N-1:0] op1,op2;
	
		
	mux2_1 #(.N(M*N)) controlOp1Mux(.a(rd1),.b(Forward1),.c(op1), .sel(controlOp1));
	
	mux41 #(.N(M*N)) controlOp2Mux(.a(rd2),.b({imm,imm,imm,imm,imm,imm}),.c(Forward2),.d(0),.e(op2),.sel(controlOp2));
	
	mux2_1 #(.N(M*N)) controlOp3Mux(.a(rd3),.b(Forward3),.c(RD3Out),.sel(controlOp3));
	
	ALUVect #(.N(N),.M(M)) myALUVect(
	.clk(clk),
	.a(op1),
	.b(op2),
	.select(aluControl),
	.result(aluCurrentResult)
	);
	
	
	
	
	
	
	
	assign controlOp1 =Fa;
	assign controlOp2={Fb,immSrc};
	assign controlOp3=Fc;
	

	
	
	
	

	
endmodule