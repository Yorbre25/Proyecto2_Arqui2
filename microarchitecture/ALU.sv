module ALU #(parameter N = 4)(
	input [N-1:0] a,
	input [N-1:0] b,
	input [3:0] select,
	output [N-1:0] result,
	output [1:0] flags
);
	
	logic [N:0] r_mov, r_compare, r_add, r_sub, r_mul, r_div, r_xor, r_and, r_not, r_mod;
	logic [N:0] result_temp, carry_temp;
	
	Operator #(.N(N)) operator(a, b, r_mov, r_compare, r_add, r_sub, r_mul, r_div, r_xor, r_and, r_not, r_mod);
	Mux #(.N(N)) mux1(select, r_mov, r_compare, r_add, r_sub, r_mul, r_div, r_xor, r_and, r_not, r_mod, result_temp);
	SetFlags #(.N(N)) set_flags(select, result_temp, flags);
	
	assign result = result_temp;
	

endmodule
