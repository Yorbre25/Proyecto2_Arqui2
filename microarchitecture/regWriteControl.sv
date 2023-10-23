module regWriteControl(input [1:0] opType,input [3:0] opCode,Rd,output logic regWrite,regWriteV);
	always_comb begin
		if(Rd==4'b0000)begin //Vamos a usar registro 0 de manera constante en cero por desicion de diseno
			regWrite=0;
			regWriteV=0;
		end
		else if(!opType[1] && (opCode>=4'b0000 && opCode<=4'b1011))begin //operaciones de arit/log con y sin inmediato para el caso de las operaciones escalares
		
			regWrite=1; 
			regWriteV=0;
		
		end
		else if(!opType[1] &&  opCode>4'b1011)begin //operaciones de arit/log con y sin inmediato para el caso de las operaciones vectoriales
		
			regWrite=0; 
			regWriteV=1;
		
		end
		else if(opType==2'b10 && opCode==4'b0000)begin //operacion load para registros escalares
			regWrite=1;
			regWriteV=0;
		
		end
		else if(opType==2'b10 && opCode==4'b1111)begin //operacion load para registros escalares
			regWrite=0;
			regWriteV=1;
		
		end
		else begin //ninguno de los casos anteriores
			regWrite=0;
			regWriteV=0;
		end
	end
endmodule 