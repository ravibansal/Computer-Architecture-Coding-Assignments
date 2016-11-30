`timescale 1ns / 1ps

//Group 49
//Ravi Bansal 13CS30026
//Sayan Mukhopadhyay 13CS30028

//Testbench for the datapath 
//(In some case I have printed the wire connecting to register (this is due to availabilty of registers bit by bit) and that may be tristated
//so they may print garbage at other times so see their value only when you are loading to them and also if you want to
//see correct running of the program then you can see that i am using the store register value to give input to other registers)

module datapath_testbench;

	// Inputs
	reg clk;
	reg reset;
	reg marwrite;
	reg trmar2mabus;
	reg mdrwrite;
	reg trmdr2mdbus;
	reg trmdr2bus;
	reg trmdbus2mdr;
	reg trbus2mdr;
	reg trconst0;
	reg trconst2;
	reg traluout;
	reg jumpsignal;
	reg regbwrite;
	reg flagw;
	reg pcwrite;
	reg jumppcwrite;
	reg trpc;
	reg irwrite;
	reg trregf;
	reg regwrite;
	reg [1:0] aluop;
	reg [1:0] sr;
	reg aluoutw;
	reg [15:0] local_1;
	// Outputs
	wire [15:0] mabus;
	wire [3:0] opcode;
	wire [2:0] mode;

	// Bidirs
	wire [15:0] mdbus;

	// Instantiate the Unit Under Test (UUT)
	mainmodule uut (
		.clk(clk), 
		.reset(reset), 
		.mabus(mabus), 
		.mdbus(mdbus), 
		.opcode(opcode), 
		.mode(mode), 
		.marwrite(marwrite), 
		.trmar2mabus(trmar2mabus), 
		.mdrwrite(mdrwrite), 
		.trmdr2mdbus(trmdr2mdbus), 
		.trmdr2bus(trmdr2bus), 
		.trmdbus2mdr(trmdbus2mdr), 
		.trbus2mdr(trbus2mdr), 
		.trconst0(trconst0), 
		.trconst2(trconst2), 
		.traluout(traluout), 
		.jumpsignal(jumpsignal), 
		.regbwrite(regbwrite), 
		.flagw(flagw), 
		.pcwrite(pcwrite), 
		.jumppcwrite(jumppcwrite), 
		.trpc(trpc), 
		.irwrite(irwrite), 
		.trregf(trregf), 
		.regwrite(regwrite), 
		.aluop(aluop), 
		.sr(sr), 
		.aluoutw(aluoutw)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		reset = 0;
		marwrite = 0;
		trmar2mabus = 0;
		mdrwrite = 0;
		trmdr2mdbus = 0;
		trmdr2bus = 0;
		trmdbus2mdr = 0;
		trbus2mdr = 0;
		trconst0 = 0;
		trconst2 = 0;
		traluout = 0;
		jumpsignal = 0;
		regbwrite = 0;
		flagw = 0;
		pcwrite = 0;
		jumppcwrite = 0;
		trpc = 0;
		irwrite = 0;
		trregf = 0;
		regwrite = 0;
		aluop = 0;
		sr = 0;
		aluoutw = 0;

		// Wait 100 ns for global reset to finish
		
		//Wee have checked all the operations and they working correct so only check the value of particular signal infront
		//of the their time where it is expected to be changed otherwise garbage will be there in it if its not a register
		//which can be get from the adding the total time given here, it is also given in the display
		
		//Checking whether mdbus to mdr is working
      #55 local_1<=16'b10;  //Give the data to mdbus
			 trmdbus2mdr<=1;  //Turn on the tristate connecting mdbus2mdr  
			 mdrwrite<=1;    // to write the data to mdr
		//Checking regb
		#10 
			trmdbus2mdr<=0;  //deassert signal
			mdrwrite<=0;     //deassert signal
			trmdr2bus<=1;    //Turn on the tristate connecting mdr2bus  to insternal bus
			regbwrite<=1;	  //Turn on the regbwrite 
		#10
			regbwrite<=0;    //deassert signal
			trmdr2bus<=0;	  //deassert signal
		//Checking alu unit and aluout resiter
		#10
			trconst2<=1;		//Turn on the tristate connecting const2 to internal bus
			aluop <=2'b10;    //aluop for add
			aluoutw<=1;       //give the aluout write signal
		//checking if an instrunction is given whether it takes it properly
		#10
			trconst2<=0;      //deassert signal
			aluoutw<=0;			//deassert signal
			local_1<=16'b0000110000000000;  //instruction where it is specified that about r3 to be register6
			trmdbus2mdr<=1;   //Turn on the tristate connecting mdbus to mdr
			mdrwrite<=1;		//Assert the mdrwrite signal
		// checking the functionality instruction register
		#10
			trmdbus2mdr<=0;   //deassert signal
			mdrwrite<=0;		//deassert signal
			trmdr2bus<=1;		//Turn on the tristate connecting mdr to internal bus
			irwrite<=1;			//assert the irwrite signal to write to instruction register
		//Reading register
		#10
			irwrite<=0;			//deassert signal
			trmdr2bus<=0;		//deassert signal
			sr<=2'b10;			//sr as a mux signal to select the third register to be as read register i.e. r3 whose value is register 6 from the instruction
			local_1<=16'b11;  //dump value 3 to mdbus
			trmdbus2mdr<=1; 	//Turn on the tristate connecting mdbus to mdr
			mdrwrite<=1;		//Assert the mdrwrite signal to write to mdr register
		//Checking regwrite i.e. write 3 to register 6 as given by instruction
		#10
			trmdbus2mdr<=0; 	//deassert signal
			mdrwrite<=0;		//deassert signal
			trmdr2bus<=1;		//Turn on the tristate connecting mdr to internal bus
			regwrite<=1;		//Assert the regwrite signal to write to register as specified in opcode i.e. register 6
		//Writing the value 3 regb from register 6
		#10
			trmdr2bus<=0;		//deassert signal
			regwrite<=0;		//deassert signal
			trregf<=1;			//Turn on the tristate connecting register file to internal bus
			regbwrite<=1;		//assert the regbwrite signal to write to the register which will be first operand to the alu unit
			aluoutw<=1;			//As we have not changed the aluop signal it will reamain as add signal
		#10				
			trregf<=0;			//deassert signal
			regbwrite<=0;		//deassert signal
			aluoutw<=0;			//deassert signal
		//Checking whether the value is written to register 6 by subtracting its value with 2 which should give 1 in aluout register
		#10
			trconst2<=1;		//Turn on the tristate connecting constant register of value 2 to internal bus
			aluop<=2'b11;		//Now change the aluop to subtract signal
			aluoutw<=1;			//Save the output of (regb-2) to aluout register
		#10
			aluoutw<=0;
			regbwrite<=1;		//assert the regbwrite signal to write to the fisrt operand of the alu 
		//Checking the flag vaiable zero for flag
		#10
			regbwrite<=0;		//deassert signal
			aluop<=2'b11;		//subtract as aluoperation
			aluoutw<=1;			// 2-2 = 0 
			flagw<=1;			// to write the flag bits to the registers (clearly you can see in the output the z value to be 1)
		//To check for the pcregister and mar register
		#10
			trconst2<=0;
			aluoutw<=0;			//deassert signal
			flagw<=0;
			local_1<=16'b1111110001100011;  //instruction where it is specified that about r3 to be register6
			trmdbus2mdr<=1;   //Turn on the tristate connecting mdbus to mdr
			mdrwrite<=1;		//Assert the mdrwrite signal
		//Write the above said value of instruction to pcregiter
		#10
			trmdbus2mdr<=0;   //deassert signal
			mdrwrite<=0;		//deassert signal
			trmdr2bus<=1;		//Turn on the tristate connecting mdr to internal bus
			pcwrite<=1;			//assert the pcwrite signal to wrie to pc
		//Write the above said value of pc register to mar register
		#10
			trmdr2bus<=0;	//deassert signal
			pcwrite<=0;		//deassert signal
			trpc<=1;			//Turn on the tristate connecting pc to internal bus
			marwrite<=1;
		#10
			trpc<=0;			//deassert signal
			marwrite<=0;	//deassert signal
			
		// Add stimulus here	

	end
		assign mdbus=local_1;
		always #5 clk=~clk;
endmodule

