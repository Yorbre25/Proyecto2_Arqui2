module memToRegControl(input [1:0] opType,input [3:0] opCode,output logic  memToReg);
	
	always_comb begin
		if(opType==2'b10  && opCode==4'b0000)memToReg=1'b1; //load escalar
		else if(opType==2'b10  && opCode==4'b0010)memToReg=1'b1; //load vectorial
		else memToReg=1'b0;
		
	end

endmodule 