module execVect #(parameter N= 24)(
	input [6*N-1:0] rd1, rd2, Forward1, Forward2,Forward3,	// Posible Alu entries
	input [N-1:0] imm,
	input [6*N-1:0] rd3,
	input [3:0] aluControl,
	input immSrc,
	input Fa, Fb,Fc,
	output  [6*N-1:0] aluCurrentResult,RD3Out

);
	
	//selectors
	logic controlOp1,controlOp3;
	logic [1:0] controlOp2;
	
	//operators output from the mux
	logic [N-1:0] op1,op2;
	
		
	mux2_1 #(.N(N)) controlOp1Mux(.a(rd1),.b(Forward1),.c(op1), .sel(controlOp1));
	
	mux41 #(.N(N)) controlOp2Mux(.a(rd2),.b(imm),.c(Forward2),.d(0),.e(op2),.sel(controlOp2));
	
	mux2_1 #(.N(N)) controlOp3Mux(.a(rd3),.b(Forward3),.c(RD3Out),.sel(controlOp3));
	
	
	ALU #(.N(N)) alu(.a(op1), .b(op2), .select(aluControl), .result(aluCurrentResult));
	
	
	
	
	assign controlOp1 =Fa;
	assign controlOp2={Fb,immSrc};
	assign controlOp3=Fc;
	

	
	
	
	

	
endmodule