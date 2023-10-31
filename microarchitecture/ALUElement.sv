module ALUElement #(parameter N=24)(
	input [N-1:0] a,b,
	input [3:0] opCode,
	input [N-1:0] sinRead,cosRead,
	output [N-1:0] out


);
	
	logic [N-1:0] res_mov,res_sin,res_cos,res_add,res_mult,res_div;
	
	
	always_comb begin
		case(opCode)
			4'b1010:out=res_mov;
			4'b1011:out=res_sin;
			4'b1100:out=res_cos;
			4'b1101:out=res_add;
			4'b1110:out=res_mult;
			4'b1111:out=res_div;
			default:out=0;
		
		
		endcase
	
	end
	 
	 
	 assign res_mov=b;
	 assign res_sin=sinRead;
	 assign res_cos=cosRead;
	 assign res_add=a+b;
	 assign res_mult=a*b;
	 assign res_div=a/b;
endmodule 