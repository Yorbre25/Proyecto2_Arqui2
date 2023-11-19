module ALUVect #(parameter N = 24,parameter M=6)(
	input clk,
	input [M*N-1:0] a,
	input [M*N-1:0] b,
	input [3:0] select,
	output [M*N-1:0] result
);
	
	logic [59:0] cosOut,sinOut;
	
	
	
	cosROM myCos (
	.address(b[5:0]),
	.clock(clk),
	.q(cosOut));
	
	sinROM mySin (
	.address(b[5:0]),
	.clock(clk),
	.q(sinOut));
	
	
	
	
	ALUElement #(.N(N)) b0(
	.a(a[N-1:0]),
	.b(b[N-1:0]),
	.select(select),
	.sinRead({{14{sinOut[9]}},sinOut[9:0]}),
	.cosRead({{14{cosOut[9]}},cosOut[9:0]}),
	.out(result[N-1:0])
	);
	
	ALUElement #(.N(N)) b1(
	.a(a[2*N-1:N]),
	.b(b[2*N-1:N]),
	.select(select),
	.sinRead({{14{sinOut[19]}},sinOut[19:10]}),
	.cosRead({{14{cosOut[19]}},cosOut[19:10]}),
	.out(result[2*N-1:N])
	);
	
	ALUElement #(.N(N)) b2(
	.a(a[3*N-1:2*N]),
	.b(b[3*N-1:2*N]),
	.select(select),
	.sinRead({{14{sinOut[29]}},sinOut[29:20]}),
	.cosRead({{14{cosOut[29]}},cosOut[29:20]}),
	.out(result[3*N-1:2*N])
	);
	
	
	ALUElement #(.N(N)) b3(
	.a(a[4*N-1:3*N]),
	.b(b[4*N-1:3*N]),
	.select(select),
	.sinRead({{14{sinOut[39]}},sinOut[39:30]}),
	.cosRead({{14{cosOut[39]}},cosOut[39:30]}),
	.out(result[4*N-1:3*N])
	);
	
	ALUElement #(.N(N)) b4(
	.a(a[5*N-1:4*N]),
	.b(b[5*N-1:4*N]),
	.select(select),
	.sinRead({{14{sinOut[49]}},sinOut[49:40]}),
	.cosRead({{14{cosOut[49]}},cosOut[49:40]}),
	.out(result[5*N-1:4*N])
	);
	
	ALUElement #(.N(N)) b5(
	.a(a[6*N-1:5*N]),
	.b(b[6*N-1:5*N]),
	.select(select),
	.sinRead({{14{sinOut[59]}},sinOut[59:50]}),
	.cosRead({{14{cosOut[59]}},cosOut[59:50]}),
	.out(result[6*N-1:5*N])
	);

	

endmodule
