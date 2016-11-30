`timescale 1ns / 1ps

//Group 49
//Ravi Bansal 13CS30026
//Sayan Mukhopadhyay 13CS30028

//Testbench for the Controller

module testbenchcontroller;

	// Inputs
	reg [3:0] opcode;
	reg reset;
	reg [2:0] mode;
	reg clock;
	reg mfcwait;

	// Outputs
	wire trpc;
	wire trregf;
	wire marw;
	wire regbw;
	wire memread;
	
	wire trmdbus2mdr;
	wire mdrw;
	wire trmdr2bus;
	wire irw;
	wire trbus2mdr;
	wire trconst2;
	wire trconst0;
	wire[1:0] aluop;
	wire aluoutw;
	wire traluout;
	wire pcw;
	wire regwrite;
	wire jumpsignal;
	wire jumppcwrite;
	wire [1:0] readreg;
	wire memw;

	// Instantiate the Unit Under Test (UUT)
	controller uut (
		.opcode(opcode), 
		.reset(reset), 
		.mode(mode), 
		.clock(clock), 
		.trpc(trpc), 
		.trregf(trregf), 
		.marw(marw), 
		.regbw(regbw), 
		.memread(memread), 
		.mfcwait(mfcwait), 
		.irw(irw), 
		.trmdbus2mdr(trmdbus2mdr), 
		.mdrw(mdrw), 
		.trmdr2bus(trmdr2bus), 
		 
		.trbus2mdr(trbus2mdr), 
		.trconst2(trconst2), 
		.trconst0(trconst0), 
		.aluop(aluop), 
		.aluoutw(aluoutw), 
		.traluout(traluout), 
		.pcw(pcw), 
		.regwrite(regwrite), 
		.jumpsignal(jumpsignal), 
		.jumppcwrite(jumppcwrite), 
		.readreg(readreg), 
		.memw(memw)
	);

	initial begin
		// Initialize Inputs
		opcode = 0;
		reset = 0;
		mode = 0;         //load register
		clock = 0;
		mfcwait=0;
		$monitor($time,"trpc=%b,marw=%b,regbw=%b,memread=%b,trmdbus2mdr=%b,mdrw=%b,trmdr2bus=%b,irw=%b,trconst2=%b,aluop=%b,aluoutw=%b,trbus2mdr=%b,traluout=%b,pcw=%b,trregf=%b,trconst0=%b,regwrite=%b,jumpsignal=%b,jumppcwrite=%b,memw=%b,readreg=%b",trpc,marw,regbw,memread,trmdbus2mdr,mdrw,trmdr2bus,irw,trconst2,aluop,aluoutw,trbus2mdr,traluout,pcw,trregf,trconst0,regwrite,jumpsignal,jumppcwrite,memw,readreg);
	#10	opcode = 4'b1000;
		mode = 3'b011;            //and operation with base addressing
		#10 opcode=4'b1010;
			mode=3'b010;
		#10 opcode=4'b0010;      //jump signal
		#10 opcode=4'b0000;
			mode=3'b010;           //load with base indexed addressing
		#10 opcode=4'b0011;      //subcall
		#10 opcode=4'b1010;
				mode=3'b001;        //alu add immediate
		#10 opcode=4'b0001;
			  mode=3'b011;   //store base addressing
	   #10 opcode=4'b1100;
			 mode=3'b100;     //cmp indirect
		#10 opcode=4'b1011;
			 mode=3'b001; //alu sub immediate
		#10 opcode=4'b0100; //subreturn
	end
   always #5 clock=~clock;
		
endmodule

