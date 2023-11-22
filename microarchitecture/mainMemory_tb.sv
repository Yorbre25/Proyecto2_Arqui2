`timescale 1ns/1ns
module mainMemory_tb();

	logic clk,wren,modeSel;
	logic [18:0] address_a,address_b;
	logic [11:0] q_b;
	logic [71:0] data_a,q_a;
	mainMemory myMainMemory(.clk(clk),.modeSel(modeSel),.address_a(address_a),.address_b(address_b),.data_a(data_a),.wren(wren),.q_a(q_a),.q_b(q_b));
	
	
	always begin
		#10;
		clk=!clk;
	end
	
	initial begin
		modeSel=0;
		clk=0;
		address_a=500;
		address_b=500;
		data_a=72'd99;
		wren=0;
		
		#10; //posedge 
		
		
		#10; //negedge
		assert(q_a==72'b0) $display("Escritura no realizada con wren_b en bajo");
		else $error("Escritura realizada con wren en bajo");
		
		assert(q_b==0) $display("Escritura no realizada con wren_b en bajo");
		else $error("Escritura realizada con wren en bajo");
		
		wren=1;
		
		#10;// posedge (aqui escribe)
		
		#10; //negedge
		wren=0;
		
		#10; //posedge (aqui lee)
		
		#10;//negedge
		assert(q_a==72'd99) $display("Lectura correcta despues puerto a despues de un write");
		else $error("Lectura incorrecta despues puerto a despues de un write");
		
		assert(q_b==99) $display("Lectura correcta despues puerto b despues de un write");
		else $error("Lectura incorrecta despues puerto b despues de un write");
		
		wren=1;
		address_a=700;
		address_b=500;
		data_a=72'd27;
		
		
		#10; //posedge (aqui escribe)
		
		
		#10; //negedge
		wren=0;
		
		#10; //posedge(aqui lee)
		
		#10; //negedge
		modeSel=1;
		address_a=870; // direccion mod 6 ==0
		data_a={12'd32,12'd28,12'd46,12'd93,12'd10,12'd59};
		wren=1;
		assert(q_a==72'd27) $display("Lectura correcta despues puerto a despues de un write");
		else $error("Lectura incorrecta despues puerto a despues de un write");
		
		assert(q_b==99) $display("Lectura se mantuvo a pesar de escritura en puerto A");
		else $error("Lectura no se mantuvo a pesar de escritura en puerto ");
		
		#10; //posedge(aqui se escribe)
		
		#10; //negedge
		wren=0;
		
		#10;//posedge (aqui se lee)
		
		#10; //negedge
		address_a=871; //direccion mod 6 ==1
		wren=1;
		assert(q_a=={12'd32,12'd28,12'd46,12'd93,12'd10,12'd59}) $display("Lectura correcta escritura vectorial con direccion mod 6 igual a cero");
		else $error("Lectura incorrecta escritura vectorial con direccion mod 6 igual a cero");
		
		#10; //posedge(aqui se escribe)
		
		
		#10; //negedge
		wren=0;
		
		#10; //posedge (aqui se lee)
		
		
		#10; //negedge
		address_a=872; //direccion mod 6 ==2
		wren=1;
		assert(q_a=={12'd32,12'd28,12'd46,12'd93,12'd10,12'd59}) $display("Lectura correcta escritura vectorial con direccion mod 6 igual a uno");
		else $error("Lectura incorrecta escritura vectorial con direccion mod 6 igual a uno");
		
		#10; //posedge (aqui se escribe)
		
		
		#10; //negedge 
		wren=0;
		
		#10; //posedge(aqui se lee)
		
		#10; //negedge
		address_a=873; //direccion mod 6 ==3 
		wren=1;
		assert(q_a=={12'd32,12'd28,12'd46,12'd93,12'd10,12'd59}) $display("Lectura correcta escritura vectorial con direccion mod 6 igual a dos");
		else $error("Lectura incorrecta escritura vectorial con direccion mod 6 igual a dos");
		
		
		#10; //posedge (aqui se escribe)
		
		
		#10; //negedge 
		wren=0;
		
		#10; //posedge(aqui se lee)
		
		#10; //negedge
		address_a=874; //direccion mod 6 ==4
		wren=1;
		assert(q_a=={12'd32,12'd28,12'd46,12'd93,12'd10,12'd59}) $display("Lectura correcta escritura vectorial con direccion mod 6 igual a tres");
		else $error("Lectura incorrecta escritura vectorial con direccion mod 6 igual a tres");
		
		
		#10; //posedge (aqui se escribe)
		
		
		#10; //negedge 
		wren=0;
		
		#10; //posedge(aqui se lee)
		
		#10; //negedge
		address_a=875; //direccion mod 6 ==5
		wren=1;
		assert(q_a=={12'd32,12'd28,12'd46,12'd93,12'd10,12'd59}) $display("Lectura correcta escritura vectorial con direccion mod 6 igual a cuatro");
		else $error("Lectura incorrecta escritura vectorial con direccion mod 6 igual a cuatro");
		
		
		#10; //posedge (aqui se escribe)
		
		
		#10; //negedge 
		wren=0;
		
		#10; //posedge(aqui se lee)
		
		#10; //negedge
		modeSel=0; //se vuelve a lectura escalar
		assert(q_a=={12'd32,12'd28,12'd46,12'd93,12'd10,12'd59}) $display("Lectura correcta escritura vectorial con direccion mod 6 igual a cinco");
		else $error("Lectura incorrecta escritura vectorial con direccion mod 6 igual a cinco");
		
		#10; //posedge (aqui lee)
		
		#10; //negedge 
		address_a=876;
		assert(q_a=={60'b0,12'd59}) $display("Lectura correcta escritura vectorial lectura escalar primer componente ");
		else $error("Lectura incorrecta escritura vectorial lectura escalar componente primer");
		
		
		#10; //posedge (aqui lee)
		
		#10; //negedge 
		address_a=877;
		assert(q_a=={60'b0,12'd10}) $display("Lectura correcta escritura vectorial lectura escalar segundo componente");
		else $error("Lectura incorrecta escritura vectorial lectura escalar segundo componente ");
		
		
		#10; //posedge (aqui lee)
		
		#10; //negedge 
		address_a=878;
		assert(q_a=={60'b0,12'd93}) $display("Lectura correcta escritura vectorial lectura escalar tercer componente ");
		else $error("Lectura incorrecta escritura vectorial lectura escalar tercer componente ");
		
		
		#10; //posedge (aqui lee)
		
		#10; //negedge 
		address_a=879;
		assert(q_a=={60'b0,12'd46}) $display("Lectura correcta escritura vectorial lectura escalar cuatro componente ");
		else $error("Lectura incorrecta escritura vectorial lectura escalar cuarto componente ");
		
		
		#10; //posedge (aqui lee)
		
		#10; //negedge 
		address_a=880;
		assert(q_a=={60'b0,12'd28}) $display("Lectura correcta escritura vectorial lectura escalar quinto  componente");
		else $error("Lectura incorrecta escritura vectorial lectura escalar quinto  componente");
		
		
		
		#10; //posedge (aqui lee)
		
		#10; //negedge 
		address_a = 877;
		wren=1; //escritura escalar
		data_a={60'b0,12'd20};
		assert(q_a=={60'b0,12'd32}) $display("Lectura correcta escritura vectorial lectura escalar sexto  componente");
		else $error("Lectura incorrecta escritura vectorial lectura escalar sexto  componente");
		
		#10; //posedge (aqui escribe)
		
		#10;//negedge 
		wren=0;
		modeSel=1; //pasa a vectorial
		address_a = 875;
		
		
		
		#10;  //posedge (lectura vectorial)
		
		#10; //negedge 
		assert(q_a=={12'd32,12'd28,12'd46,12'd20,12'd10,12'd59}) $display("Lectura correcta vectorial despues de modificar un componente con escritura escalar");
		else $error("Lectura incorrecta vectorial despues de modificar un componente con escritura escalar");
		
		
		#20; //delay final
		
		
		
		
		
		
		
	end
	
	
endmodule 