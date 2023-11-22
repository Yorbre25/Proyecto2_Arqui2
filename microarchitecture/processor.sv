parameter RW = 24;
parameter N = 6;
parameter IF_BW = 56;
parameter ID_BW = 581;
parameter EX_BW = 306;
parameter MEM_BW = 302;
module processor(input rst,input clk, input [35:0] gpio1,input [23:0] parallelAddress,input [4:0] switches,output [35:0] gpio2,output [15:0] q);




	logic branchTakenFlag;
	logic rst_pc,rst_if, rst_id, rst_ex, rst_mem;
	logic flush1, flush2, flush3, flush4,flush5;
	logic Fa, Fb,Fc;
	logic [1:0] opType_ex_mem;
	logic [3:0] opCode_ex_mem;
	logic stall,en;
	logic [RW*N-1:0] Forward1,Forward2,Forward3;
	logic [3:0] ra_id_ex,rb_id_ex, rc_id_ex, rd_id_ex;
	logic [31:0] inst;
	logic [RW-1:0] pc;
	logic [IF_BW-1:0] bufferOut_if;
	logic [ID_BW-1:0] bufferOut_id;
	logic [31:0] inst_if_id;
	logic [RW:0] pc_if_id;
	logic [1:0] opType_id_ex;
	logic [3:0] opCode_id_ex;
	logic immSrc_id_ex, branchFlag_id_ex, memWrite_id_ex, memToReg_id_ex, regWrite_id_ex;
	logic [23:0] pc_id_ex;
	logic signed [3:0] aluControl_id_ex, Rc_id_ex;
	logic signed [RW-1:0] rd1_id_ex, rd2_id_ex, rd3_id_ex;
	logic signed [RW*N-1:0] rdv1_id_ex, rdv2_id_ex, rdv3_id_ex;
	logic signed [RW-1:0] extendImm_id_ex;
	logic memWrite_ex_mem,memToReg_ex_mem,regWrite_ex_mem;
	logic regWriteV_id_ex;
	logic modeSel_id_ex;
	
	logic [23:0] address1_ex_mem,address2_ex_mem;
	logic regWriteV_ex_mem;
	logic modeSel_ex_mem;
	logic [3:0] rc_ex_mem,switches_ex_mem;
	logic [23:0] writeData_ex_mem,q_ex_mem;
	logic [35:0] gpio1_ex_mem,gpio2_ex_mem;
	logic [RW*N-1:0] rd3OutFinal_ex_mem;
	logic [RW*N-1:0] aluCurrentResultFinal_ex_mem;
	
	
	
	logic [1:0] flags_ex;
	logic branchFlag_ex;
	logic [23:0] writeData;
	logic [MEM_BW-1:0]bufferOut_mem;
	
	
	logic memToReg_mem_wb;
	logic [3:0] rc_mem_wb;
	logic [1:0] optype_mem_wb;
	logic [3:0] opcode_mem_wb;
	logic regWriteWB;
	logic regWriteVWB;
	logic [RW*N-1:0] addressWB, readMemoryWB;
	logic [RW*N-1:0] resultW;
	logic modeSel_mem_wb;
	logic [EX_BW-1:0]bufferOut_ex;
	
	branchTaken myBranchTakenFlag(
		.opType(opType_ex_mem), 
		.opCode(opCode_ex_mem), 
		.flags(flags_ex),  
		.branchTakenFlag(branchTakenFlag) 
	);
	
	resetModule myResetModule(
		.rst(rst), 
		.flush1(flush1), 
		.flush2(flush2), 
		.flush3(flush3), 
		.flush4(flush4), 
		.flush5(flush5),
		.rst1(rst_pc),
		.rst2(rst_if), 
		.rst3(rst_id), 
		.rst4(rst_ex), 
		.rst5(rst_mem),
		.stall(stall)
);


	
	
	hazardUnit myhazardUnit(
		.Ra(ra_id_ex),.Rb(rb_id_ex),.Rc(rc_id_ex),
		.Rd_EXMEM(rc_ex_mem), 
		.Rd_MEMWB(rc_mem_wb), 
		.opTypeMem(opType_ex_mem), 
		.opTypeWB(optype_mem_wb), 
		.opCodeMem(opCode_ex_mem), 
		.opCodeWB(opcode_mem_wb), 
		.aluResult(aluCurrentResultFinal_ex_mem), 
		.Result(resultW), 
		.branchTakenFlag(branchTakenFlag), 
		.Fa(Fa),.Fb(Fb),.Fc(Fc),
		.stall(stall), 
		.flush1(flush1),.flush2(flush2),.flush3(flush3),.flush4(flush4),.flush5(flush5),
		.Forward1(Forward1),.Forward2(Forward2),.Forward3(Forward3),
		.regWriteMem(regWrite_ex_mem),
		.regWriteWB(regWriteWB),
		.regWriteVMem(regWriteV_ex_mem),
		.regWriteVWB(regWriteVWB),
		.modeSel(modeSel_id_ex),
		.modeSelMem(modeSel_ex_mem),
		.modeSelWB(modeSel_mem_wb)
		
	);
	
	
	assign en=!stall;
	
	
	
	instructionFetch myInstructionFetch(
		.clk(clk),               
		.rst1(rst_pc),
		.rst2(rst_if),
		.en1(en),
		.en2(en),						 
		.branchFlag(branchTakenFlag), 
		.branchAddr(aluCurrentResultFinal_ex_mem[23:0]), 
		.bufferOut(bufferOut_if)
	);
	
	
	
	// Get ID buffer values
	assign inst_if_id = bufferOut_if[55:24];
	assign pc_if_id = bufferOut_if[23:0];
	
	instructionDecode myInstructionDecode(
		.clk(clk),
		.rst(rst_id),
		.rstTotal(rst),
		.en(en),
		.inst(inst_if_id),
		.WE1(regWriteWB),    
		.WE2(regWriteVWB), //Del hazard unit
		.Rd(rc_mem_wb),      
		.WD1(resultW[23:0]),   
		.WD2(resultW), //hazard unit
		.pc(pc_if_id),
		.bufferOut(bufferOut_id)
	);

//	  | modeSel|regWriteV|RDV1	| RDV2  | RDV3	  |pc | opType | opCode |immSrc  |branchFlag| memWrite | memToReg | regWrite | aluControl  | Ra | RD1 | Rb | RD2 | Rc | RD3 | extendImm |
//Size:
//	  |	[1]  | [1]	   |[144]|[144]  |  [144] |[N]|   [2] 	|   [4]  |  [1]   |    [1]   |   [1]    |   [1]	   |    [1]   |     [4]     | [4]| [N] |[4] |[N]  |[4] |  [N]|    [N]    | 
//	----------------------------------------------------------------------------------------------------------------------------------------
//   |	580  |	579   |578	|434	  | 	  |146|122     |120     |116		|115		  |  114	  	 |  113		|   112    |     111     | 107|103  |79  |75   |51  |47   |23        0|
//	assign bufferInput={modeSel,regWriteV,RDV1,RDV2,RDV3,pc,opType,opCode,immSrc,branchFlag,memWrite,memToReg,regWrite,aluControl,Ra,RD1,Rb,RD2,Rc,RD3,extendImm};
	
	
	// Get ID buffer values
	assign modeSel_id_ex = bufferOut_id[580];
	assign regWriteV_id_ex = bufferOut_id[579];
	assign rdv1_id_ex = bufferOut_id[578:435];
	assign rdv2_id_ex = bufferOut_id[434:291];
	assign rdv3_id_ex = bufferOut_id[290:147];
	assign pc_id_ex = bufferOut_id[146:123];
	assign opType_id_ex = bufferOut_id[122:121];
	assign opCode_id_ex = bufferOut_id[120:117];
	assign immSrc_id_ex = bufferOut_id[116];
	assign branchFlag_id_ex = bufferOut_id[115];
	assign memWrite_id_ex = bufferOut_id[114];
	assign memToReg_id_ex = bufferOut_id[113];
	assign regWrite_id_ex = bufferOut_id[112];
	assign aluControl_id_ex = bufferOut_id[111:108];
	assign ra_id_ex =bufferOut_id[107:104];
	assign rd1_id_ex = bufferOut_id[103:80];
	assign rb_id_ex = bufferOut_id[79:76];
	assign rd2_id_ex = bufferOut_id[75:52];
	assign rc_id_ex = bufferOut_id[51:48];
	assign rd3_id_ex = bufferOut_id[47:24];
	assign extendImm_id_ex = bufferOut_id[23:0];  
	
	
	
	exec #(.N(RW), .BW(EX_BW)) myExec(
	.clk(clk), 
	.rst(rst_ex), 
	.en(en),
	.rd1(rd1_id_ex), 
	.rd2(rd2_id_ex),
	.rd3(rd3_id_ex),	
	.pc(pc_id_ex), 
	.imm(extendImm_id_ex), 
	.rdv1(rdv1_id_ex),
	.rdv2(rdv2_id_ex),
	.rdv3(rdv3_id_ex),
	.Forward1(Forward1), 		
	.Forward2(Forward2),
	.Forward3(Forward3),
	.aluControl(aluControl_id_ex),
	.Rc(Rc_id_ex),
	.immSrc(immSrc_id_ex), 
	.branchFlag(branchFlag_id_ex), 
	.memWrite(memWrite_id_ex),
	.memToReg(memToReg_id_ex), 
	.regWrite(regWrite_id_ex),
	.modeSel(modeSel_id_ex),
	.Fa(Fa), 				
	.Fb(Fb),	
	.Fc(Fc),
	.opType(opType_id_ex), 
	.opCode(opCode_id_ex),
	.regWriteV(regWriteV_id_ex),
	.bufferOut(bufferOut_ex)
	);
	
	//	|regWrite | modeSel | opType | opCode | aluCurrentResult | zeroFlag | negFlag | branchFlag | memWrite | memToReg | regWrite | Rc | rd3  |
//Size:
//	|   [1]      | [1]     |   [2]  |   [4]  |       [M*N]	   |  [1]     |   [1]   |    [1]     |   [1]    |    [1]   |   [1]    |[4] | [M*N]| 
//	----------------------------------------------------------------------------------------------------------------
// | 305        |304      |303	  |301	  |297				   |153		  |152	   |151			 |150		   |149		  |148	    |147 |143  0|

//  	assign bufferInput={regWriteV,modeSel,opType,opCode,aluCurrentResultFinal,zeroFlag,negFlag,branchFlag,memWrite,memToReg,regWrite, Rc, RD3OutFinal};
	
	
	// Get exec buffer values
	assign regWriteV_ex_mem = bufferOut_ex[305];
	assign modeSel_ex_mem = bufferOut_ex[304];
	assign opType_ex_mem = bufferOut_ex[303:302];
	assign opCode_ex_mem = bufferOut_ex[301:298];
	assign aluCurrentResultFinal_ex_mem =bufferOut_ex[297:154];
	assign flags_ex = {bufferOut_ex[152],bufferOut_ex[153]}; // neg ,zero
	assign branchFlag_ex =bufferOut_ex[151];
	assign memWrite_ex_mem = bufferOut_ex[150];
	assign memToReg_ex_mem = bufferOut_ex[149];
	assign regWrite_ex_mem = bufferOut_ex[148];
	assign rc_ex_mem = bufferOut_ex[147:144] ;
	assign rd3OutFinal_ex_mem = bufferOut_ex[143:0];
	
	
	
	memoryStage myMemoryStage(
		.clk(clk),
		.rst(rst_mem),
		.en(1'b1),
		.opType(opType_ex_mem),
		.opCode(opCode_ex_mem),
		.address1(aluResult),
		.address2(parallelAddress), //entrada
		.memWrite(memWrite_ex_mem),
		.memToReg(memToReg_ex_mem),
		.regWrite(regWrite_ex_mem),
		.regWriteV(regWriteV_ex_mem),
		.Rc(rc_ex_mem),
		.writeData(rd3OutFinal_ex_mem), //?
		.modeSel(modeSel_ex_mem),
		.switches(switches), //entrada
		.gpio1(gpio1), //entrada
		.gpio2(gpio2),  //salida
		.q(q), //salida
		.bufferOut(bufferOut_mem)
	);
	
//	//                 |  1     |   1    |    2   |  4     |    1   |    1    |4      |144    | 144 |
//	assign bufferInput={regWriteV, modeSel, opType, opCode, memToReg, regWrite,  Rc   , qa, address1};
//	//                 |301     |300     |299:298 |297:294 |293     |292      |291:288|287:144|143:0|
	
	//Get MEM buffer values
	assign addressWB = bufferOut_mem[143:0]; // address1
	assign readMemoryWB = bufferOut_mem[287:144]; // qa
	assign rc_mem_wb = bufferOut_mem[291:288];// Rc
	assign regWriteWB = bufferOut_mem[292]; // regWrite
	assign memToReg_mem_wb = bufferOut_mem[293]; // memToReg
	assign opcode_mem_wb = bufferOut_mem[297:294]; // opCode
	assign optype_mem_wb= bufferOut_mem[299:298]; // opType
	assign modeSel_mem_wb = bufferOut_mem[300];
	assign regWriteVWB = bufferOut_mem[301];
	

	
	
	
	writeBack #(.N(RW*N)) myWriteback(
		.readDataW(readMemoryWB), 
		.aluOutW(addressWB),     
		.memToReg(memToReg_mem_wb),
		.resultW(resultW)     
	);
	



endmodule 