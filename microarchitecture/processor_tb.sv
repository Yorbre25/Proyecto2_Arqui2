`timescale 1ns/1ns
module processor_tb();
		
		logic rst,clk;
		logic [35:0] gpio1,gpio2;
		logic [23:0] parallelAddress;
		logic [15:0] q;
		logic [4:0] switches;
		processor myprocesor(.rst(rst),.clk(clk),.gpio1(gpio1),.parallelAddress(parallelAddress),.switches(switches),.gpio2(gpio2),.q(q));
		
		always begin
			#10;
			clk=!clk;
		end
		
		initial begin
		
			clk=0;
			rst=1;
			gpio1=0;
			parallelAddress=179;
			switches=5'b00001;
			
			#10; //posedge
			
			#10; //negedge (rst)
			
			#10; //posedge
			rst=0;
			
			
			#4010; //negedge
			
			
			switches=5'b10100;
			parallelAddress=4;
			
			#10; //posedge
			
			#10; //negedge
			assert(q==5) $display("Primera Lectura escalar correcta");
			else $error("Primera lectura escalar incorrecta");
			
			parallelAddress=5;
			
			#10; //posedge
			
			
			#10; //negedge
			assert(q==7) $display("Segunda Lectura escalar correcta");
			else $error("Segunda lectura escalar incorrecta");
			
			parallelAddress=6;
			
			
			#10; //posedge
			
			
			#10; //negedge
			assert(q==13) $display("Tercera Lectura escalar correcta");
			else $error("Tercera lectura escalar incorrecta");
			
			parallelAddress=7;
			
			
			
			#10; //posedge
			
			
			#10; //negedge
			assert(q==19) $display("Cuarta Lectura escalar correcta");
			else $error("Cuarta lectura escalar incorrecta");
			
			parallelAddress=8;
			
			
			
			#10; //posedge
			
			
			#10; //negedge
			assert(q==23) $display("Quinta Lectura escalar correcta");
			else $error("Quinta lectura escalar incorrecta");
			
			parallelAddress=9;
			
			
			
			#10; //posedge
			
			
			#10; //negedge
			assert(q==24) $display("Sexta Lectura escalar correcta");
			else $error("Sexta lectura escalar incorrecta");
			
			parallelAddress=10;
			
			
			
			#10; //posedge
			
			
			#10; //negedge
			assert(q==2) $display("Septima Lectura escalar correcta");
			else $error("Septima lectura escalar incorrecta");
			
			parallelAddress=11;
			
			
			
			#10; //posedge
			
			
			#10; //negedge
			assert(q==4) $display("Octava Lectura escalar correcta");
			else $error("Octava lectura escalar incorrecta");
			
			parallelAddress=12;
			
			
			
			#10; //posedge
			
			
			#10; //negedge
			assert(q==6) $display("Novena Lectura escalar correcta");
			else $error("Novena lectura escalar incorrecta");
			
			parallelAddress=13;
			
			
			
			#10; //posedge
			
			
			#10; //negedge
			assert(q==7) $display("Decima Lectura escalar correcta");
			else $error("Decima lectura escalar incorrecta");
			
			parallelAddress=14;
			
			
			
			#10; //posedge
			
			
			#10; //negedge
			assert(q==9) $display("undecima Lectura escalar correcta");
			else $error("undecima lectura escalar incorrecta");
			
			parallelAddress=15;
			
			
			
			
			#10; //posedge
			
			
			#10; //negedge
			assert(q==33) $display("duodecima Lectura escalar correcta");
			else $error("duodecima lectura escalar incorrecta");
			
			parallelAddress=30;
			
			
			
			
			
			
			#10; //posedge
			
			
			#10; //negedge
			assert(q==5+2) $display("Lectura primer componente vectorial correcta");
			else $error("Lectura primer componente vectorial incorrecta");
			
			parallelAddress=31;
			
			
			#10; //posedge
			
			
			#10; //negedge
			assert(q==7+4) $display("Lectura segundo componente vectorial correcta");
			else $error("Lectura segundo componente vectorial incorrecta");
			
			parallelAddress=32;
			
			
			
			#10; //posedge
			
			
			#10; //negedge
			assert(q==13+6) $display("Lectura tercer componente vectorial correcta");
			else $error("Lectura tercer componente vectorial incorrecta");
			
			parallelAddress=33;
			
			
			
			
			#10; //posedge
			
			
			#10; //negedge
			assert(q==19+7) $display("Lectura cuarto componente vectorial correcta");
			else $error("Lectura cuarto componente vectorial incorrecta");
			
			parallelAddress=34;
			
			
			
			#10; //posedge
			
			
			#10; //negedge
			assert(q==23+9) $display("Lectura quinto componente vectorial correcta");
			else $error("Lectura quinto componente vectorial incorrecta");
			
			parallelAddress=35;
			
			
			
			#10; //posedge
			
			
			#10; //negedge
			assert(q==24+33) $display("Lectura sexto componente vectorial correcta");
			else $error("Lectura sexto componente vectorial incorrecta");
			
			parallelAddress=124;
			
			
			#10; //posedge
			
			
			#10; //negedge
			assert(q==2000) $display("Lectura primer componente coseno de 0 multiplicado por dos correcto");
			else $error("Lectura primer componente coseno de 0 multiplicado por dos inccorrecto");
			
			parallelAddress=125;
			
			
			#10; //posedge
			
			
			#10; //negedge
			assert(q==1998) $display("Lectura segundo componente coseno de 0 multiplicado por dos correcto");
			else $error("Lectura segundo componente coseno de 0 multiplicado por dos inccorrecto");
			
			parallelAddress=126;
			
			
			
			#10; //posedge
			
			
			#10; //negedge
			assert(q==1998) $display("Lectura tercero componente coseno de 0 multiplicado por dos correcto");
			else $error("Lectura tercero componente coseno de 0 multiplicado por dos inccorrecto");
			
			parallelAddress=127;
			
			#10; //posedge
			
			
			#10; //negedge
			assert(q==1996) $display("Lectura cuarto componente coseno de 0 multiplicado por dos correcto");
			else $error("Lectura cuarto componente coseno de 0 multiplicado por dos inccorrecto");
			
			parallelAddress=128;
			
			
			#10; //posedge
			
			
			#10; //negedge
			assert(q==1994) $display("Lectura quinto componente coseno de 0 multiplicado por dos correcto");
			else $error("Lectura quinto componente coseno de 0 multiplicado por dos inccorrecto");
			
			parallelAddress=129;
			
			
			#10; //posedge
			
			
			#10; //negedge
			assert(q==1992) $display("Lectura sexto componente coseno de 0 multiplicado por dos correcto");
			else $error("Lectura sexto componente coseno de 0 multiplicado por dos inccorrecto");
			
			parallelAddress=224;
			
			
			
			#10; //posedge
			
			
			#10; //negedge
			assert(q==0) $display("Lectura primer componente seno de 0 multiplicado por dos correcto");
			else $error("Lectura primer componente seno de 0 multiplicado por dos inccorrecto");
			
			parallelAddress=225;
			
			
			
			#10; //posedge
			
			
			#10; //negedge
			assert(q==34) $display("Lectura segundo componente seno de 0 multiplicado por dos correcto");
			else $error("Lectura segundo componente seno de 0 multiplicado por dos inccorrecto");
			
			parallelAddress=226;
			
			#10; //posedge
			
			
			#10; //negedge
			assert(q==68) $display("Lectura tercero componente seno de 0 multiplicado por dos correcto");
			else $error("Lectura tercero componente seno de 0 multiplicado por dos inccorrecto");
			
			parallelAddress=227;
			
			#10; //posedge
			
			
			#10; //negedge
			assert(q==104) $display("Lectura cuarto componente seno de 0 multiplicado por dos correcto");
			else $error("Lectura cuarto componente seno de 0 multiplicado por dos inccorrecto");
			
			parallelAddress=228;
			
			
			#10; //posedge
			
			
			#10; //negedge
			assert(q==138) $display("Lectura quinto componente seno de 0 multiplicado por dos correcto");
			else $error("Lectura quinto componente seno de 0 multiplicado por dos inccorrecto");
			
			parallelAddress=229;
			
			
			#10; //posedge
			
			
			#10; //negedge
			assert(q==174) $display("Lectura sexto componente seno de 0 multiplicado por dos correcto");
			else $error("Lectura sexto componente seno de 0 multiplicado por dos inccorrecto");
			
			parallelAddress=230;
			
			
			
			
			
			
			
			
			#200;
			
			$finish();
			
			
			
			
			
			
		end
endmodule 