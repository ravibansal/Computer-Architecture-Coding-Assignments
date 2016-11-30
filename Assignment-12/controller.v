`timescale 1ns / 1ps
//Group 49
//Ravi Bansal 13CS30026
//Sayan Mukhopadhyay 13CS30028
// Behavorial code for Controller 
module controller(opcode,reset,mode,clock,trpc,trregf,marw,regbw,memread,mfcwait,irw,trmdbus2mdr,mdrw,trmdr2bus,trbus2mdr,trconst2,trconst0,aluop,aluoutw,traluout,pcw,regwrite,jumpsignal,jumppcwrite,readreg,memw);
	input [3:0] opcode;
	input [2:0] mode;
	input clock,mfcwait,reset;
	output reg trpc,marw,regbw,memread,trmdbus2mdr,mdrw,trmdr2bus,irw,trconst2,aluoutw,trbus2mdr,traluout,pcw,trregf,trconst0,regwrite,jumpsignal,jumppcwrite,memw;
	output reg[1:0] readreg;
	output reg[1:0] aluop;
	parameter S0=7'b0000000;
	parameter S1=7'b0000001;
	//parameter S2=7'b0000010;
	parameter S3=7'b0000011;
	parameter S4=7'b0000100;
	parameter S5=7'b0000101;
	parameter A0=7'b0000110;
	parameter S7=7'b0000111;
	parameter S8=7'b0001000;
	parameter S9=7'b0001001;
	parameter S10=7'b0001010;
	parameter S11=7'b0001011;
	parameter AC1=7'b0001100;
	parameter AR1=7'b0001101;
	parameter AR2=7'b0001110;
	parameter AI1=7'b0001111;
	parameter AI2=7'b0010000;
	parameter AI3=7'b0010001;
	parameter AI4=7'b0010010;
	parameter ABI1=7'b0010011;
	parameter ABI2=7'b0010100;
	parameter ABI3=7'b0010101;
	parameter ABI4=7'b0010110;
	parameter ABI5=7'b0010111;
	parameter ABI6=7'b0011000;
	parameter ABI7=7'b0011001;
	parameter ABI8=7'b0011010;
	parameter ABI9=7'b0011011;
	parameter ABI10=7'b0011100;
	parameter ABA1=7'b0011101;
	parameter ABA2=7'b0011110;
	parameter ABA3=7'b0011111;
	parameter AIND1=7'b0100000;
	parameter AIND2=7'b0100001;
	parameter AIND3=7'b0100010;
	parameter AIND4=7'b0100011;
	parameter AIND5=7'b0100100;
	parameter AIND6=7'b0100101;
	parameter AIND7=7'b0100110;
	parameter AIND8=7'b0100111;
	parameter AIND9=7'b0101000;
	parameter J1=7'b0101001;
	parameter J2=7'b0101010;
	parameter J3=7'b0101011;
	parameter SUB1=7'b0101100;
	parameter SUB2=7'b0101101;
	parameter SUB3=7'b0101110;
	parameter SUB4=7'b0101111;
	parameter LR1=7'b0110000;
	parameter LI1=7'b0110001;
	parameter LI2=7'b0110010;
	parameter LI3=7'b0110011;
	parameter LBI1=7'b0110100;
	parameter LBI2=7'b0110101;
	parameter LBI3=7'b0110110;
	parameter LBI4=7'b0110111;
	parameter LBI5=7'b0111000;
	parameter LBI6=7'b0111001;
	parameter LBI7=7'b0111010;
	parameter LBI8=7'b0111011;
	parameter LBI9=7'b0111100;
	parameter LBA1=7'b0111101;
	parameter LBA2=7'b0111110;
	parameter LBA3=7'b0111111;
	parameter LBA5=7'b1000001;
	parameter LBA6=7'b1000010;
	parameter LBA7=7'b1000011;
	parameter LBA8=7'b1000100;
	parameter LID1=7'b1000101;
	parameter LID2=7'b1000110;
	parameter LID3=7'b1000111;
	parameter LID4=7'b1001000;
	parameter LID5=7'b1001001;
	parameter LID6=7'b1001010;
	parameter LID7=7'b1001011;
	parameter LID8=7'b1001100;
	parameter LID9=7'b1001101;
	parameter LID10=7'b1001110;
	parameter LID11=7'b1001111;
	parameter SB1=7'b1010000;
	parameter SB2=7'b1010001;
	parameter SB3=7'b1010010;
	parameter SB4=7'b1010011;
	parameter SB5=7'b1010100;
	parameter SB6=7'b1010101;
	parameter SB7=7'b1010110;
	parameter SI1=7'b1010111;
	parameter SI2=7'b1011000;
	parameter SI3=7'b1011001;
	parameter SI4=7'b1011010;
	parameter SI5=7'b1011011;
	parameter SI6=7'b1011100;
	parameter SI7=7'b1011101;
	parameter SI8=7'b1011110;
	parameter SI9=7'b1011111;
	parameter WRITEREG=7'b1100000;
	parameter PC2=7'b1100001;
	parameter PC21=7'b1100010;
	parameter PC22=7'b1100011;
	parameter R0=7'b1100100;
	reg[6:0] cur_state,next_state;
	initial begin
		 cur_state = R0;
		 next_state = R0;
	end
	always @(posedge clock) begin
		$display("state=%b",cur_state);
	  cur_state=next_state;
	  trpc<=1'b0;marw<=1'b0;regbw<=1'b0;memread<=1'b0;trmdbus2mdr<=1'b0;
	  mdrw<=1'b0;trmdr2bus<=1'b0;irw<=1'b0;trconst2<=1'b0;aluop<=2'b00;aluoutw<=1'b0;
	  trbus2mdr<=1'b0;traluout<=1'b0;pcw<=1'b0;trregf<=1'b0;trconst0<=1'b0;
	  regwrite<=1'b0;jumpsignal<=1'b0;jumppcwrite<=1'b0;memw<=1'b0;
	  readreg<=2'b00;
	  if(cur_state==R0) begin
		  if(reset) begin
					next_state=R0;
		  end
		  else begin
				next_state=S0;
		  end
	  end
		//INSTRUCTION FETCH
		if(cur_state==S0) begin
		  trpc <= 1'b1;
		  marw <= 1'b1;
		  regbw <= 1'b1;
		  next_state = S1;
		end
		else if(cur_state == S1) begin
		 	memread <= 1'b1;
			trmdbus2mdr <=1'b1;
			mdrw <=1'b1;
			if(mfcwait == 1'b1) begin
			 next_state = S1;
			end
			else begin
			  next_state = S3;
			end
		end
		else if(cur_state == S3) begin
		    trmdr2bus <= 1'b1;
			irw <= 1'b1;
			next_state = S4;
		end
		else if(cur_state == S4) begin
			trconst2 <= 1'b1;
			aluop <=2'b10;
			aluoutw <= 1'b1;
			next_state = S5;
		end
		else if(cur_state == S5) begin
			traluout <= 1'b1;
			pcw <= 1'b1;
			if(opcode[3] == 1'b1) begin 
				next_state = A0; // ALU
			end
			else if(opcode == 4'b0000) begin
				next_state = S7;  //load
			end
			else if(opcode == 4'b0001) begin
				next_state = S8; //store
			end
			else if(opcode == 4'b0010) begin
				next_state = S9;  //jump
			end
			else if(opcode == 4'b0011) begin
				next_state = S10; //subcall
			end
			else if(opcode==4'b0100) begin
				next_state = S11;  //subreturn
			end
		end
	   else if(cur_state == A0) begin
	   		if(opcode==4'b1100) begin
	   			trconst0 <= 1'b1;
	   			regbw <= 1'b1;
	   			next_state = AC1; //compliment
	   		end
            else if(mode==3'b000) begin //register
           	
           		readreg <= 2'b10 ;
           		trregf <= 1'b1;
           		regbw <= 1'b1;
           		next_state = AR1;
           	end
           	else if(mode==3'b001) begin // immediate
           		readreg <= 2'b10 ;
           		trregf <= 1'b1;
           		regbw <= 1'b1;
           		next_state = AI1;
           	end
           	else if(mode==3'b010) begin //base indexed
           		readreg <= 2'b1 ;
           		trregf <= 1'b1;
           		regbw <= 1'b1;
           		next_state = ABI1;
           	end
           	else if(mode==3'b011) begin // base address
           		readreg <= 2'b1 ;
           		trregf <= 1'b1;
           		regbw <= 1'b1;
           		next_state = ABA1;
           	end
           	else if(mode == 3'b100) begin //indirect
					//$display($time,"INDI");
           		readreg <= 2'b01;
           		trregf <=  1'b1;
           		regbw <= 1'b1;
           		next_state = AIND1;
           	end
	   end
	  /* 	else if(cur_state==AR1) begin
		   		readreg <= 2'b00;
		   		trregf <= 1'b001;
		   		aluop =opcode[1:0];  //nextsate fill     //will come from alu control to do
	   	end*/
	else if(cur_state==AC1) begin
			readreg <= 2'b10;
			trregf <= 1'b1;
			aluop <= 2'b11;
			aluoutw <= 1'b1;
			next_state = WRITEREG;
	end
	else if(cur_state == WRITEREG) begin
			traluout <= 1'b1;
			regbw <= 1'b1;
			next_state = S0;
	end
	else if(cur_state == AR1) begin
			readreg <= 2'b01;
			trregf <= 1'b1;
			aluop <= opcode[1:0];
			aluoutw <= 1'b1;
			next_state = AR2;
	end
	else if(cur_state == AR2) begin
			traluout <= 1'b1;
			regwrite <= 1'b1;
			next_state = S0;
	end
	else if(cur_state == AI1) begin
			trpc <= 1'b1;
			marw <= 1'b1;
			next_state=PC2;
	end
	else if(cur_state == AI2) begin   
		memread <= 1'b1;
		trmdbus2mdr <= 1'b1;
		mdrw <= 1'b1;
		if(mfcwait == 1'b1) begin
			 next_state = AI2;
		end
		else begin
		  next_state = AI3;
		end
		
	end
	else if(cur_state == AI3) begin
		trmdr2bus <= 1'b1;
		aluop <=opcode[1:0]; //todo alu
		aluoutw <= 1'b1;
		next_state = AI4 ;
	end
	else if(cur_state == AI4) begin
			traluout <= 1'b1;
			regbw <= 1'b1;
			next_state = PC2;
	end
	else if(cur_state==ABI1) begin
		 readreg <= 2'b00;
		 trregf <= 1'b1;
		 aluop <= 2'b10;
		 aluoutw <= 1'b1;
		 next_state = ABI2;
	end
	else if(cur_state == ABI2) begin
		 trpc <= 1'b1;
		 marw <= 1'b1;
		 next_state = ABI3;
	end
	else if(cur_state ==ABI3) begin
		 memread <= 1'b1;
		 trmdbus2mdr <= 1'b1;
		 mdrw <= 1'b1;
		 if(mfcwait == 1'b1) begin
			 next_state = ABI3;
		end
		else begin
		  next_state = ABI4;
		end
	
	end
	else if(cur_state == ABI4) begin
		 trmdr2bus <= 1'b1;
		 regbw <= 1'b1;
		 next_state = ABI5;
	end
	else if(cur_state == ABI5) begin
		 traluout <= 1'b1;
		 aluop <= opcode[1:0];
		 aluoutw <= 1'b1;
		 next_state = ABI6;
	end
	else if(cur_state == ABI6) begin
		 traluout <= 1'b1;
		 marw <= 1'b1;
		 next_state = ABI7;
	end
	else if(cur_state == ABI7) begin
		 memread <= 1'b1;
		 trmdbus2mdr <= 1'b1;
		 mdrw <= 1'b1;
		 if(mfcwait == 1'b1) begin
			 next_state = ABI7;
		end
		else begin
		  next_state = ABI8;
		end
	end
	else if(cur_state == ABI8) begin
		 trmdr2bus <= 1'b1;
		 regbw <= 1'b1;
		 next_state = ABI9;
	end
	else if(cur_state == ABI9) begin
		 readreg <= 2'b10;
		 trregf <=1'b1;
		 aluop <= opcode[1:0];
		 aluoutw <= 1'b1;
		 next_state = ABI10;
	end
	else if(cur_state == ABI10) begin
		 traluout <= 1'b1;
		 regwrite <= 1'b1;
		 next_state = PC2;
	end
	else if(cur_state == ABA1) begin
		trpc <= 1'b1;
		marw <= 1'b1;
		next_state = ABA2;
	end
	else if(cur_state == ABA2) begin
		memread <= 1'b1;
		trmdbus2mdr <= 1'b1;
		mdrw <= 1'b1;
		if(mfcwait == 1'b1) begin
			 next_state = ABA2;
		end
		else begin
		  next_state = ABA3;
		end
		
	end
	else if(cur_state == ABA3) begin
		trmdr2bus <= 1'b1;
		aluop <= opcode[1:0];
		aluoutw <= 1'b1;
		next_state = ABI6;
	end
	else if(cur_state==AIND1) begin
		 readreg <= 2'b00;
		 trregf <= 1'b1;
		 aluop <= 2'b10;
		 aluoutw <= 1'b1;
		 next_state = AIND2;
	end
	else if(cur_state == AIND2) begin
		 trpc <= 1'b1;
		 marw <= 1'b1;
		 next_state = ABI3;
	end
	else if(cur_state ==AIND3) begin
		 memread <= 1'b1;
		 trmdbus2mdr <= 1'b1;
		 mdrw <= 1'b1;
		 if(mfcwait == 1'b1) begin
			 next_state = AIND3;
		end
		else begin
		  next_state = AIND4;
		end
		
	end
	else if(cur_state == AIND4) begin
		 trmdr2bus <= 1'b1;
		 regbw <= 1'b1;
		 next_state = AIND5;
	end
	else if(cur_state == AIND5) begin
		 traluout <= 1'b1;
		 aluop <= opcode[1:0];
		 aluoutw <= 1'b1;
		 next_state = AIND6;
	end
	else if(cur_state == AIND6) begin
		 traluout <= 1'b1;
		 marw <= 1'b1;
		 next_state = AIND7;
	end
	else if(cur_state == AIND7) begin
		 memread <= 1'b1;
		 trmdbus2mdr <= 1'b1;
		 mdrw <= 1'b1;
		 if(mfcwait == 1'b1) begin
			 next_state = AIND7;
		end
		else begin
		  next_state = AIND8;
		end
		
	end
	else if(cur_state == AIND8) begin
		trmdr2bus <= 1'b1;
		marw <=1'b1;
		next_state = AIND9;
	end
	else if(cur_state == AIND9) begin
		memread <= 1'b1;
		trmdbus2mdr <= 1'b1;
		mdrw <= 1'b1;
		if(mfcwait == 1'b1) begin
			 next_state = AIND9;
		end
		else begin
		  next_state = ABI8;
		end
		      //reusing states
	end
	else if(cur_state==PC2) begin
		trpc<=1'b1;
		regbw<=1'b1;
		next_state=PC21;
	end
	else if(cur_state==PC21) begin
		trconst2<=1'b1;
		aluoutw<=1'b1;
		next_state=PC22;
	end
	else if(cur_state==PC22) begin
		traluout <= 1'b1;
		pcw <= 1'b1;
		next_state = S0;
	end
	else if(cur_state==S9) begin   //S9 is jump
		trpc<=1'b1;
		marw <= 1'b1;
		next_state = J1;
	end
	else if(cur_state == J1) begin
		memread <= 1'b1;
		trmdbus2mdr<= 1'b1;
		mdrw<=1'b1;
		if(mfcwait == 1'b1) begin
			 next_state = J1;
		end
		else begin
		  next_state = J2;
		end
	end
	else if(cur_state == J2) begin
		trmdr2bus <= 1'b1;
		aluop <= 2'b10;
		aluoutw <= 1'b1;
		next_state = J3;
	end
	else if(cur_state == J3) begin
		jumpsignal <= 1'b1;
		jumppcwrite <=1'b1;
		next_state=PC2;
	end
	else if(cur_state==S10) begin
		trpc<=1'b1;
		marw <= 1'b1;
		next_state=SUB1;
	end
	else if(cur_state==SUB1) begin
		memread <= 1'b1;
		trmdbus2mdr<= 1'b1;
		mdrw<=1'b1;
		next_state = SUB2;
		if(mfcwait == 1'b1) begin
			 next_state = SUB1;
		end
		else begin
		  next_state = SUB2;
		end
	end
	else if(cur_state==SUB2) begin
		trmdr2bus <= 1'b1;
		aluop <= 2'b10;
		aluoutw <= 1'b1;
		next_state = SUB3;
	end
	else if(cur_state==SUB3) begin
		trpc <= 1'b1;
		regwrite <= 1'b1;
		next_state = SUB4;
	end
	else if(cur_state==SUB4) begin
		traluout <= 1'b1;
		pcw <= 1'b1;
		next_state = S0;
	end
	else if(cur_state==S11) begin
		readreg <= 2'b10;
		trregf <= 1'b1;
		pcw <= 1'b1;
		next_state = S0;
	end
	else if(cur_state == S7) begin //LOAD 
		//$display("mode=%b",mode);
			if(mode == 3'b000)begin
				next_state = LR1;
			end
			else if(mode == 3'b001) begin
				next_state = LI1;
			end
			else if(mode == 3'b010) begin
				next_state = LBI1;
			end
			else if(mode == 3'b011) begin
				next_state = LBA1;
			end
			else if(mode == 3'b100) begin
				next_state = LID1;
			end
	end
		else if(cur_state == LI1)  begin //Load Immediate-1
			trpc <= 1'b1;
			marw <= 1'b1;
			next_state = LI2;
		end
		else if(cur_state ==LI2) begin //Load Immediate-2
	   		memread <= 1'b1;
	   		trmdbus2mdr <= 1'b1;
	   		mdrw <= 1'b1;
	   		if(mfcwait == 1'b1) begin
				next_state = LI2;
			end
			else begin
				next_state = LI3;
			end
		end
		else if(cur_state == LI3) begin
			trmdr2bus <= 1'b1;
			regwrite <= 1'b1;
			next_state = PC2;
		end
		
		else if(cur_state == LR1) begin
			
			//	$display("HHHUUUU=%b",regwrite);
		
			readreg <= 2'b01;
			trregf <= 1'b1;
			regwrite <= 1'b1;
			next_state = S0;
		end
		else if(cur_state == LBI1) begin
				//	$display($time,"L!");
			readreg <= 2'b01;
			trregf <= 1'b1;
			regbw <= 1'b1;
			next_state = LBI2;
		end 
		else if(cur_state == LBI2) begin
			readreg <= 2'b00;
			trregf <= 1'b1;
			aluop <= 2'b10;
			aluoutw <= 1'b1;
			next_state = LBI3;
		end
		else if(cur_state == LBI3) begin
			trpc <= 1'b1;
			marw <= 1'b1;
			next_state = LBI4;
		end
		else if(cur_state == LBI4) begin
			memread <= 1'b1;
			trmdbus2mdr <= 1'b1;
			mdrw <= 1'b1;
			next_state = LBI5;
		end
		else if(cur_state == LBI5) begin
			trmdr2bus <= 1'b1;
			regbw <= 1'b1;
			next_state = LBI6;
		end
		else if(cur_state == LBI6) begin
			aluop <= 2'b10;
			traluout <= 1'b1;
			aluoutw<=1'b1;
			next_state = LBI7;
		end
		else if(cur_state == LBI7) begin
			traluout <= 1'b1;
			marw <= 1'b1;
			next_state = LBI8;
		end
		else if(cur_state == LBI8) begin
			memread <= 1'b1;
			trmdbus2mdr <=1'b1;
			mdrw <= 1'b1;
			if(mfcwait==1'b1) begin
				next_state=LBI8;
			end
			else begin
				next_state = LBI9;
			end
		end
		else if(cur_state==LBI9) begin
			trmdr2bus <= 1'b1;
			regwrite <= 1'b1;
			next_state = PC2;
		end
		else if(cur_state == LBA1) begin
	//	$display($time,"LBA");
			readreg <= 2'b01;
			trregf <= 1'b1;
			regbw <= 1'b1;
			next_state = LBA2;
		end
		else if(cur_state == LBA2) begin
			trpc <= 1'b1;
			marw <= 1'b1;
			next_state = LBA3;
		end
		else if(cur_state == LBA3) begin
			memread <=1'b1;
			trmdbus2mdr <= 1'b1;
			mdrw <= 1'b1;
			if(mfcwait ==1'b1) begin
				next_state = LBA3;
			end
			else begin
				next_state = LBA5; //remove state LBA4
			end
		end
		
		else if(cur_state==LBA5) begin
			aluop <= 2'b10;
			trmdr2bus <= 1'b1;
			aluoutw <=1'b1;
			next_state = LBA6;
		end
		else if(cur_state==LBA6) begin
			traluout <= 1'b1;
			marw <= 1'b1;
			next_state = LBA7;
		end
		else if(cur_state==LBA7) begin
			memread <= 1'b1;
			trmdbus2mdr <= 1'b1;
			mdrw <= 1'b1;
			if(mfcwait==1'b1) begin
				next_state=LBA7;
			end
			else begin
				next_state = LBA8;
			end
		end
		else if(cur_state==LBA8) begin
			trmdr2bus <= 1'b1;
			regwrite <= 1'b1;
			next_state = PC2;
		end
		else if(cur_state == LID1) begin
	//	$display($time,"LID");
			readreg <= 2'b01;
			trregf <= 1'b1;
			regbw <= 1'b1;
			next_state = LID2;
		end 
		else if(cur_state == LID2) begin
			readreg <= 2'b00;
			trregf <= 1'b1;
			aluop <= 2'b10;
			aluoutw <= 1'b1;
			next_state = LID3;
		end
		else if(cur_state == LID3) begin
			trpc <= 1'b1;
			marw <= 1'b1;
			next_state = LID4;
		end
		else if(cur_state == LID4) begin
			memread <= 1'b1;
			trmdbus2mdr <= 1'b1;
			mdrw <= 1'b1;
			next_state = LID5;
		end
		else if(cur_state == LID5) begin
			trmdr2bus <= 1'b1;
			regbw <= 1'b1;
			next_state = LID6;
		end
		else if(cur_state == LID6) begin
			aluop <= 2'b10;
			traluout <= 1'b1;
			aluoutw<=1'b1;
			next_state = LID7;
		end
		else if(cur_state == LID7) begin
			traluout <= 1'b1;
			marw <= 1'b1;
			next_state = LID8;
		end
		else if(cur_state == LID8) begin
			memread <= 1'b1;
			trmdbus2mdr <=1'b1;
			mdrw <= 1'b1;
			if(mfcwait==1'b1) begin
				next_state=LID8;
			end
			else begin
				next_state = LID9;
			end
		end
		else if(cur_state==LID9) begin
			trmdr2bus <= 1'b1;
			marw <=1'b1;
			next_state = LID10;
		end
		else if(cur_state==LID10) begin
			memread <= 1'b1;
			trmdbus2mdr <= 1'b1;
			mdrw <= 1'b1;
			if(mfcwait==1'b1) begin
				next_state=LID10;
			end
			else begin
				next_state = LID11;
			end
		end
		else if(cur_state==LID11) begin
			trmdr2bus <= 1'b1;
			regwrite <= 1'b1;
			next_state = PC2;
		end
		else if(cur_state == S8) begin
			if(mode==3'b011) begin
				next_state=SB1;
			end
			else if(mode==3'b100) begin
				next_state = SI1;
			end
		end
		else if(cur_state == SB1) begin
			readreg <= 2'b10;
			trregf <= 1'b1;
			regbw <= 1'b1;
			next_state = SB2;
		end
		else if(cur_state == SB2) begin
			trpc <= 1'b1;
			marw <= 1'b1;
			next_state = SB3;
		end
		else if(cur_state == SB3) begin
			memread <= 1'b1;
			trmdbus2mdr <=1'b1;
			mdrw <= 1'b1;
			if(mfcwait==1'b1) begin
				next_state = SB3;
			end
			else begin
				next_state = SB4;
			end
			
		end
		else if(cur_state==SB4) begin
			trmdr2bus <= 1'b1;
			aluop <= 2'b10;
			aluoutw<=1'b1;
			next_state = SB5;
		end
		else if(cur_state == SB5) begin
			traluout <= 1'b1;
			marw <= 1'b1;
			next_state = SB6;
		end
		else if(cur_state == SB6) begin
			readreg <= 2'b01;
			trregf <= 1'b1;
			trbus2mdr <= 1'b1;
			mdrw <= 1'b1;
			next_state = SB7;
		end
		else if(cur_state == SB7) begin
			memw <= 1'b1;
			next_state = PC2;
		end
		else if(cur_state == SI1) begin
			readreg <= 2'b10;
			trregf <= 1'b1;
			regbw <= 1'b1;
			next_state = SI2;
		end
		else if(cur_state == SI2) begin
			trpc <= 1'b1;
			marw <= 1'b1;
			next_state = SI3;
		end
		else if(cur_state == SI3) begin
			memread <= 1'b1;
			trmdbus2mdr <=1'b1;
			mdrw <= 1'b1;
			if(mfcwait==1'b1) begin
				next_state = SI3;
			end
			else begin
				next_state = SI4;
			end
			
		end
		else if(cur_state==SI4) begin
			trmdr2bus <= 1'b1;
			aluop <= 2'b10;
			aluoutw<=1'b1;
			next_state = SI5;
		end
		else if(cur_state == SI5) begin
			traluout <= 1'b1;
			marw <= 1'b1;
			next_state = SI6;
		end
		else if(cur_state==SI6) begin
			memread <= 1'b1;
			trmdbus2mdr <= 1'b1;
			mdrw <= 1'b1;
			if(mfcwait==1'b1) begin
				next_state = SI6;
			end
			else begin
				next_state = SI7;
			end
		end
		else if(cur_state == SI7) begin
			trmdr2bus <= 1'b1;
			marw <= 1'b1;
			next_state = SI8;
		end
		else if(cur_state == SI8) begin
			readreg <= 2'b01;
			trregf <= 1'b1;
			trbus2mdr <= 1'b1;
			mdrw <= 1'b1;
			next_state = SI9;
		end
		else if(cur_state == SI9) begin
			memw <= 1'b1;
			next_state = PC2;
		end
	end
	
endmodule
