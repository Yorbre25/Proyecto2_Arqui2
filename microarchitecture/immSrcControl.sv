module immSrcControl(input [1:0] opType,input [3:0] opCode,output logic immSrc);

	always_comb begin
		if(opType[0] && (opCode<=4'b1010)) immSrc=1; //en ambos casos, 01 V 11, correspondiente a aritmetica con imm y operacion de control
		else immSrc=0;
	end

endmodule 