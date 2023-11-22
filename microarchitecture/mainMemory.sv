module mainMemory(input clk,input modeSel,input [18:0] address_a,address_b,input[71:0] data_a,input wren, output logic [71:0] q_a,output [11:0] q_b);


	logic [15:0] address_a_effective, address_b_effective;
	logic [15:0] address_mem1,address_mem2,address_mem3,address_mem4,address_mem5,address_mem6;
	
	logic [2:0] address_module,address_b_module;
	logic wren_a1,wren_a2,wren_a3,wren_a4,wren_a5,wren_a6;
	
	logic [11:0] qa1,qa2,qa3,qa4,qa5,qa6;
	logic [11:0] qb1,qb2,qb3,qb4,qb5,qb6;
	logic [11:0] data_memA,data_memB,data_memC,data_memD,data_memE,data_memF;
	
	logic [11:0] scalarOut;
	
	logic [15:0] address_offset0,address_offset1;
	
	
	
	mainMemorySegment memoryA(
	.address_a(address_mem1),
	.address_b(address_b_effective),
	.clock(clk),
	.data_a(data_memA),
	.data_b(0),
	.wren_a(wren_a1),
	.wren_b(0),
	.q_a(qa1),
	.q_b(qb1));
	
	mainMemorySegment memoryB(
	.address_a(address_mem2),
	.address_b(address_b_effective),
	.clock(clk),
	.data_a(data_memB),
	.data_b(0),
	.wren_a(wren_a2),
	.wren_b(0),
	.q_a(qa2),
	.q_b(qb2));
	
	mainMemorySegment memoryC(
	.address_a(address_mem3),
	.address_b(address_b_effective),
	.clock(clk),
	.data_a(data_memC),
	.data_b(0),
	.wren_a(wren_a3),
	.wren_b(0),
	.q_a(qa3),
	.q_b(qb3));
	
	mainMemorySegment memoryD(
	.address_a(address_mem4),
	.address_b(address_b_effective),
	.clock(clk),
	.data_a(data_memD),
	.data_b(0),
	.wren_a(wren_a4),
	.wren_b(0),
	.q_a(qa4),
	.q_b(qb4));
	
	mainMemorySegment memoryE(
	.address_a(address_mem5),
	.address_b(address_b_effective),
	.clock(clk),
	.data_a(data_memE),
	.data_b(0),
	.wren_a(wren_a5),
	.wren_b(0),
	.q_a(qa5),
	.q_b(qb5));
	
	mainMemorySegment memoryF(
	.address_a(address_mem6),
	.address_b(address_b_effective),
	.clock(clk),
	.data_a(data_memF),
	.data_b(0),
	.wren_a(wren_a6),
	.wren_b(0),
	.q_a(qa6),
	.q_b(qb6));
	
	
	assign address_b_effective= address_b /6;
	assign address_module=address_a % 6;
	assign address_b_module= address_b % 6;
	
	assign address_offset0 = address_a /6;
	assign address_offset1 = address_offset0 +1;
	
	
	assign wren_a1 = (address_module == 3'd0 || modeSel) && wren;
	assign wren_a2 = (address_module == 3'd1 || modeSel) && wren;
	assign wren_a3 = (address_module == 3'd2 || modeSel) && wren;
	assign wren_a4 = (address_module == 3'd3 || modeSel) && wren;
	assign wren_a5 = (address_module == 3'd4 || modeSel) && wren;
	assign wren_a6 = (address_module == 3'd5 || modeSel) && wren;
	
	always_comb begin
		case({modeSel,address_module})
			4'b1000: begin
				{address_mem1,address_mem2,address_mem3,address_mem4,address_mem5,address_mem6}={address_offset0,address_offset0,address_offset0,address_offset0,address_offset0,address_offset0};
				q_a={qa6,qa5,qa4,qa3,qa2,qa1};
				{data_memA,data_memB,data_memC,data_memD,data_memE,data_memF}={data_a[11:0],data_a[23:12],data_a[35:24],data_a[47:36],data_a[59:48],data_a[71:60]};
			end
			4'b1001: begin
				{address_mem1,address_mem2,address_mem3,address_mem4,address_mem5,address_mem6}={address_offset1,address_offset0,address_offset0,address_offset0,address_offset0,address_offset0};
				q_a={qa1,qa6,qa5,qa4,qa3,qa2};
				{data_memA,data_memB,data_memC,data_memD,data_memE,data_memF}={data_a[71:60],data_a[11:0],data_a[23:12],data_a[35:24],data_a[47:36],data_a[59:48]};
			end
			4'b1010: begin
				{address_mem1,address_mem2,address_mem3,address_mem4,address_mem5,address_mem6}={address_offset1,address_offset1,address_offset0,address_offset0,address_offset0,address_offset0};
				q_a={qa2,qa1,qa6,qa5,qa4,qa3};
				{data_memA,data_memB,data_memC,data_memD,data_memE,data_memF}={data_a[59:48],data_a[71:60],data_a[11:0],data_a[23:12],data_a[35:24],data_a[47:36]};
			end
			4'b1011: begin
				{address_mem1,address_mem2,address_mem3,address_mem4,address_mem5,address_mem6}={address_offset1,address_offset1,address_offset1,address_offset0,address_offset0,address_offset0};
				q_a={qa3,qa2,qa1,qa6,qa5,qa4};
				{data_memA,data_memB,data_memC,data_memD,data_memE,data_memF}={data_a[47:36],data_a[59:48],data_a[71:60],data_a[11:0],data_a[23:12],data_a[35:24]};
			end
			4'b1100: begin
				{address_mem1,address_mem2,address_mem3,address_mem4,address_mem5,address_mem6}={address_offset1,address_offset1,address_offset1,address_offset1,address_offset0,address_offset0};
				q_a={qa4,qa3,qa2,qa1,qa6,qa5};
				{data_memA,data_memB,data_memC,data_memD,data_memE,data_memF}={data_a[35:24],data_a[47:36],data_a[59:48],data_a[71:60],data_a[11:0],data_a[23:12]};
			end
			4'b1101: begin
				{address_mem1,address_mem2,address_mem3,address_mem4,address_mem5,address_mem6}={address_offset1,address_offset1,address_offset1,address_offset1,address_offset1,address_offset0};
				q_a={qa5,qa4,qa3,qa2,qa1,qa6};
				{data_memA,data_memB,data_memC,data_memD,data_memE,data_memF}={data_a[23:12],data_a[35:24],data_a[47:36],data_a[59:48],data_a[71:60],data_a[11:0]};
			end
			default: begin
				{address_mem1,address_mem2,address_mem3,address_mem4,address_mem5,address_mem6}={address_offset0,address_offset0,address_offset0,address_offset0,address_offset0,address_offset0};
				q_a={60'b0,scalarOut};
				{data_memA,data_memB,data_memC,data_memD,data_memE,data_memF}={data_a[11:0],data_a[11:0],data_a[11:0],data_a[11:0],data_a[11:0],data_a[11:0]};
			end
		endcase 
	
	
	end
	
	
	
	mux81 #(.N(12)) outputAMux(.a(qa1),.b(qa2),.c(qa3),.d(qa4),.e(qa5),.f(qa6),.g(0),.h(0), .out(scalarOut) ,.sel(address_module));
	mux81 #(.N(12)) outputBMux(.a(qb1),.b(qb2),.c(qb3),.d(qb4),.e(qb5),.f(qb6),.g(0),.h(0), .out(q_b) ,.sel(address_b_module));


endmodule 