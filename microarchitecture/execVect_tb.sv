`timescale 1ns/1ps  
parameter vec_num_elem=2;
parameter reg_size=24;
module execVect_tb();

	logic clk;
	logic [vec_num_elem*reg_size - 1:0] rd1, rd2, rd3, forward1, forward2, forward3;
	logic [reg_size-1:0] imm;
	logic [3:0] aluControl;
	// Fa 		   selects rd1 or forward1
	// {Fb,immSrc} selects rd2, imm, forward2 or 0
	// Fc  	      selects rd3 or forward3 (No alu inputs)
	logic immSrc, Fa, Fb, Fc;
	logic [vec_num_elem*reg_size - 1:0] aluCurrentResult, RD3Out; //outputs
	
	execVect #(.N(reg_size)) myExecVect(
		.clk(clk),
		.rd1(rd1), .rd2(rd2), .Forward1(forward1), .Forward2(forward2), .Forward3(forward3),	// Posible Alu entries
		.imm(imm),
		.rd3(rd3),
		.aluControl(aluControl),
		.immSrc(immSrc),
		.Fa(Fa),.Fb(Fb),.Fc(Fc),
		.aluCurrentResult(aluCurrentResult),.RD3Out(RD3Out)
	);

		
	always begin
		#10;
		clk=!clk;
	end

	initial begin 

		clk=1;
		
		rd1[23:0]=1;
		rd1[47:24]=2;
		
		rd2[23:0]=3;
		rd2[47:24]=4;
		
		forward1[23:0]=5;
		forward1[47:24]=6;

		forward2[23:0]=7;
		forward2[47:24]=8;

		forward3[23:0]=9;
		forward3[47:24]=10;
		
		rd3[23:0]=11;
		rd3[47:24]=12;
		
		imm = 0;
		
		#10; //negedge
		// add with immSrc, Fa, Fb, Fc = 0 (use rd1 and rd2 value)
		aluControl = 4'b1101;
		immSrc = 0;
		Fa = 0;
		Fb = 0;
		Fc = 0;
		
		#10; //posedge
		
		#10; //negedge
		assert(aluCurrentResult== rd1+rd2) $display("En add la salida es el resultado de la operacion rd1+rd2");
		else $error("En mov la salida no es el resultado de la operacion rd1+rd2");
		
		// add with Fa=1 (use forward1 and rd2 value)
		aluControl = 4'b1101; 
		immSrc = 0;
		Fa = 1;
		Fb = 0;
		Fc = 0;
		
		#10; //posedge
		
		#10; //negedge
		assert(aluCurrentResult== forward1+rd2) $display("En add la salida es el resultado de la operacion forward1+rd2");
		else $error("En add la salida no es el resultado de la operacion forward1+rd2");
		
		// add with Fa=1, Fb=1, immSrc=0 (use forward1 and forward2 value)
		aluControl = 4'b1101; 
		immSrc = 0;
		Fa = 1;
		Fb = 1;
		Fc = 0;
		
		#10; //posedge
	
		#10; //negedge
		assert(aluCurrentResult== forward1+forward2) $display("En add la salida es el resultado de la operacion forward1+forward2");
		else $error("En add la salida no es el resultado de la operacion forward1+forward2");
		
				
		// add with Fa=0, Fb=0, immSrc=1  (use forward1 and imm value)
		aluControl = 4'b1101; 
		immSrc = 1;
		Fa = 0;
		Fb = 0;
		Fc = 0;
		
		#10; //posedge
	
		#10; //negedge
		assert(aluCurrentResult== rd1+{imm,imm}) $display("En add la salida es el resultado de la operacion rd1+imm"); //CUIDADO, RESULTADO DEPENDE DE N
		else $error("En add la salida no es el resultado de la operacion rd1+imm");
		
		// add with Fa=0, Fb=1, immSrc=1  (use forward1 and 0 value)
		aluControl = 4'b1101; 
		immSrc = 1;
		Fa = 0;
		Fb = 1;
		Fc = 0;
		
		#10; //posedge
	
		#10; //negedge
		assert(aluCurrentResult== rd1) $display("En add la salida es el resultado de la operacion rd1+0");
		else $error("En add la salida no es el resultado de la operacion rd1+0");
		
		// add with Fa=0, Fb=0, Fc=0  (output rd3Out as rd3)
		aluControl = 4'b1101; 
		immSrc = 0;
		Fa = 0;
		Fb = 0;
		Fc = 0;
		
		#10; //posedge
	
		#10; //negedge
		assert(RD3Out== rd3) $display("Salida RD3Out tiene el valor de RD3");
		else $error("Salida RD3Out NO tiene el valor de RD3");
		
		// add with Fa=0, Fb=0, Fc=1  (output rd3Out as forward3)
		aluControl = 4'b1101; 
		immSrc = 0;
		Fa = 0;
		Fb = 0;
		Fc = 1;
		
		#10; //posedge
	
		#10; //negedge
		assert(RD3Out== forward3) $display("Salida RD3Out tiene el valor de forward3");
		else $error("Salida RD3Out NO tiene el valor de forward3");
		
	end


endmodule 