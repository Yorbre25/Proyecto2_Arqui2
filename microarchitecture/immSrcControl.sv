module immSrcControl(input [1:0] opType,output logic immSrc);

	assign immSrc= opType[0]; //en ambos casos, 01 V 11, correspondiente a aritmetica con imm y operacion de control
endmodule 