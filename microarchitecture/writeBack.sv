module writeBack #(parameter N=144)(input [N-1:0] readDataW, aluOutW, input memToReg, output logic [N-1:0] resultW);
	
	mux2_1 #(.N(N)) mux1(
	.a(aluOutW), 
	.b(readDataW), 
	.c(resultW), 
	.sel(memToReg));

	
endmodule 