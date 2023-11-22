module ALUVect #(parameter N = 24,parameter M=6)(
	input clk,
	input [M*N-1:0] a,
	input [M*N-1:0] b,
	input [3:0] select,
	output [M*N-1:0] result
);
	
	logic [65:0] cosOut,sinOut;
	
	
	
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
	.sinRead({{13{sinOut[10]}},sinOut[10:0]}),
	.cosRead({{13{cosOut[10]}},cosOut[10:0]}),
	.out(result[N-1:0])
	);
	
	ALUElement #(.N(N)) b1(
	.a(a[2*N-1:N]),
	.b(b[2*N-1:N]),
	.select(select),
	.sinRead({{13{sinOut[21]}},sinOut[21:11]}),
	.cosRead({{13{cosOut[21]}},cosOut[21:11]}),
	.out(result[2*N-1:N])
	);
	
	ALUElement #(.N(N)) b2(
	.a(a[3*N-1:2*N]),
	.b(b[3*N-1:2*N]),
	.select(select),
	.sinRead({{13{sinOut[32]}},sinOut[32:22]}),
	.cosRead({{13{cosOut[32]}},cosOut[32:22]}),
	.out(result[3*N-1:2*N])
	);
	
	
	ALUElement #(.N(N)) b3(
	.a(a[4*N-1:3*N]),
	.b(b[4*N-1:3*N]),
	.select(select),
	.sinRead({{13{sinOut[43]}},sinOut[43:33]}),
	.cosRead({{13{cosOut[43]}},cosOut[43:33]}),
	.out(result[4*N-1:3*N])
	);
	
	ALUElement #(.N(N)) b4(
	.a(a[5*N-1:4*N]),
	.b(b[5*N-1:4*N]),
	.select(select),
	.sinRead({{13{sinOut[54]}},sinOut[54:44]}),
	.cosRead({{13{cosOut[54]}},cosOut[54:44]}),
	.out(result[5*N-1:4*N])
	);
	
	ALUElement #(.N(N)) b5(
	.a(a[6*N-1:5*N]),
	.b(b[6*N-1:5*N]),
	.select(select),
	.sinRead({{13{sinOut[65]}},sinOut[65:55]}),
	.cosRead({{13{cosOut[65]}},cosOut[65:55]}),
	.out(result[6*N-1:5*N])
	);

	

endmodule
