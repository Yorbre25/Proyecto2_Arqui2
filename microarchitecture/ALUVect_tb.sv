`timescale 1ns/1ps  
module ALUVect_tb();

	logic clk;
	logic [143:0] a,b,result,addRes,multRes,divRes;
	logic [3:0] select;
	
	


	ALUVect #(.N(24),.M(6)) myALUVect(
		.clk(clk),
		.a(a),
		.b(b),
		.select(select),
		.result(result)
	);
	
	always begin
		#10;
		clk=!clk;
	
	end
	
	initial begin 
	
		clk=1;
		select=4'b0;
		
		
		a[23:0]=12;
		a[47:24]=45;
		a[71:48]=33;
		a[95:72]=98;
		a[119:96]=86;
		a[143:120]=52;
		
		b[23:0]=65;
		b[47:24]=12;
		b[71:48]=36;
		b[95:72]=41;
		b[119:96]=9;
		b[143:120]=40;
		
		
		//addRes=
		
		//multRes={a[143:120]*b[143:120],a[119:96]*b[119:96],a[95:72] * b[95:72],a[71:48]*b[71:48],a[47:24]*b[47:24],a[23:0]*b[23:0]};
		
		//divRes={a[143:120]/b[143:120],a[119:96]/b[119:96],a[95:72] / b[95:72],a[71:48]/b[71:48],a[47:24]/b[47:24],a[23:0]/b[23:0]};
		
		#10; //negedge
		select=4'b1010; //mov operation
		
		#10; //posedge
		
		
		#10; //negedge
		assert(result==b) $display("En mov la salida es el resultado del operando b");
		else $error("En mov la salida no es el resultado del operando b");
		
		select=4'b1011; //sin operation
		
		
		#10; //posedge
		
		
		#10; //negedge
		assert(result==100) $display("El resultado del sin corresponde a la tabla");  //Yordi este valor no lo tenia, hay que cambiarlo por la posicion del sin.mif cuando wage lo haga
		else $error("El resultado del sin no corresponde a la tabla");
		
		select=4'b1100; //cos operation
		
		#10; //posedge
		
		
		#10; //negedge
		assert(result==200) $display("El resultado del sin corresponde a la tabla");  //Yordi este valor no lo tenia, hay que cambiarlo por la posicion del cos.mif cuando wage lo haga
		else $error("El resultado del sin no corresponde a la tabla");
		
		select=4'b1101; //add operation
		
		
		
		#10; //posedge
		
		
		
		#10; //negedge
		
		
		assert(result[143:120]==a[143:120]+b[143:120]) $display("El resultado de la suma escalar 5 es correcto"); 
		else $error("El resultado de la suma escalar 5 no es correcto");
		
		assert(result[119:96]==a[119:96]+b[119:96]) $display("El resultado de la suma escalar 4 es correcto"); 
		else $error("El resultado de la suma escalar 4 no es correcto");
		
		assert(result[95:72]==a[95:72] + b[95:72]) $display("El resultado de la suma escalar 3 es correcto"); 
		else $error("El resultado de la suma escalar 3 no es correcto");
		
		assert(result[71:48]==a[71:48]+b[71:48]) $display("El resultado de la suma escalar 2 es correcto"); 
		else $error("El resultado de la suma escalar 2 no es correcto");
		
		assert(result[47:24]==a[47:24]+b[47:24]) $display("El resultado de la suma escalar 1 es correcto"); 
		else $error("El resultado de la suma escalar 1 no es correcto");
		
		assert(result[23:0]==a[23:0]+b[23:0]) $display("El resultado de la suma escalar 0 es correcto"); 
		else $error("El resultado de la suma escalar 0 no es correcto");
		
		
		select=4'b1110; //mult operation
		
		
		#10; //posedge
		
		
		#10; //negedge
		
		assert(result[143:120]==a[143:120]*b[143:120]) $display("El resultado de la multiplicacion escalar 5 es correcto"); 
		else $error("El resultado de la multiplicacion escalar 5 no es correcto");
		
		assert(result[119:96]==a[119:96]*b[119:96]) $display("El resultado de la multiplicacion escalar 4 es correcto"); 
		else $error("El resultado de la multiplicacion escalar 4 no es correcto");
		
		assert(result[95:72]==a[95:72] * b[95:72]) $display("El resultado de la multiplicacion escalar 3 es correcto"); 
		else $error("El resultado de la multiplicacion escalar 3 no es correcto");
		
		assert(result[71:48]==a[71:48]*b[71:48]) $display("El resultado de la multiplicacion escalar 2 es correcto"); 
		else $error("El resultado de la multiplicacion escalar 2 no es correcto");
		
		assert(result[47:24]==a[47:24]*b[47:24]) $display("El resultado de la multiplicacion escalar 1 es correcto"); 
		else $error("El resultado de la multiplicacion escalar 1 no es correcto");
		
		assert(result[23:0]==a[23:0]*b[23:0]) $display("El resultado de la multiplicacion escalar 0 es correcto"); 
		else $error("El resultado de la multiplicacion escalar 0 no es correcto");
		
		select=4'b1111; //div operation
		
		
		#10; //posedge
		
		
		#10; //negedge
		assert(result[143:120]==a[143:120]/b[143:120]) $display("El resultado de la division escalar 5 es correcto"); 
		else $error("El resultado de la division escalar 5 no es correcto");
		
		assert(result[119:96]==a[119:96]/b[119:96]) $display("El resultado de la division escalar 4 es correcto"); 
		else $error("El resultado de la division escalar 4 no es correcto");
		
		assert(result[95:72]==a[95:72] / b[95:72]) $display("El resultado de la division escalar 3 es correcto"); 
		else $error("El resultado de la division escalar 3 no es correcto");
		
		assert(result[71:48]==a[71:48]/b[71:48]) $display("El resultado de la division escalar 2 es correcto"); 
		else $error("El resultado de la division escalar 2 no es correcto");
		
		assert(result[47:24]==a[47:24]/b[47:24]) $display("El resultado de la division escalar 1 es correcto"); 
		else $error("El resultado de la division escalar 1 no es correcto");
		
		assert(result[23:0]==a[23:0]/b[23:0]) $display("El resultado de la division escalar 0 es correcto"); 
		else $error("El resultado de la division escalar 0 no es correcto");
		
		#10;//posedge
		
		
		
		

	end


endmodule 