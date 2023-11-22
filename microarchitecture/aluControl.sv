module aluControl(input [1:0] opType,input [3:0] opCode,output logic [3:0] aluControl );
	
	always_comb begin
		if(!opType[1])aluControl=opCode; // 00=aritmetica v 01=aritmetica con inmediato pasa el opCode
		else aluControl=4'b0001;//en todos los demas casos se asigna
	
	end

endmodule  