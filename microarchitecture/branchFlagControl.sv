module branchFlagControl(input [1:0] opType, output branchFlag);
	
	assign branchFlag= (opType==2'b11); //opType correspondiente a instruccion de control
endmodule 