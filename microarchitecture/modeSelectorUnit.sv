module modeSelectorUnit(input [1:0] opType,input [3:0] opCode,output logic  modeSel);

	always_comb begin
		if(!opType[1])begin // opType 00=aritmetica reg 01=aritmetrica immediato
			if(opCode<4'b1010) modeSel=1'b0; //aritmetica escalar
			else modeSel=1'b1; //aritmetica vectorial
		end
		else if(opType==2'b10)begin //operacion de memoria
			if(opCode<=4'b0001) modeSel=1'b0; //memoria escalar
			else modeSel=1'b1; //memoria vectorial
		end
		else modeSel=1'b0;
	
	
	end

endmodule 