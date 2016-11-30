//Group 49
//Ravi Bansal 13CS30026
//Sayan Mukhopadhyay 13CS30028
// Structural code for datapath (alu is behavorial as said in the lab)
module tristate(a,en,y);
	input [15:0] a;
	input en;
	output [15:0] y;

	assign y = en?a:16'bz;
endmodule

module andgate2(a,b,out);
	input a,b;
	output out;
	assign out = a&b;
endmodule

module orgate2(a,b,out);
	input a,b;
	output out;
	assign out = a|b;
endmodule

module notgate(a,out);
	input a;
	output out;
	assign out = ~a;
endmodule

module flopr(clk,reset,d,q,enable);
	input clk,reset,enable;
	input d;
	output q;

	reg q;

	always@(posedge clk or posedge reset)
		if(reset) q <= 0;
		else if (enable) q <= d;
		else q <= q;
endmodule

module register(clk,reset,d,q,enable);
	input clk,reset,enable;
	input [15:0] d;
	output [15:0] q;
	wire [15:0] q;
	/*always@(*)begin
	$display($time,"d=%d,q=%d",d,q);
	end*/
	flopr flop_1(clk,reset,d[15],q[15],enable);
	flopr flop_2(clk,reset,d[14],q[14],enable);
	flopr flop_3(clk,reset,d[13],q[13],enable);
	flopr flop_4(clk,reset,d[12],q[12],enable);
	flopr flop_5(clk,reset,d[11],q[11],enable);
	flopr flop_6(clk,reset,d[10],q[10],enable);
	flopr flop_7(clk,reset,d[9],q[9],enable);
	flopr flop_8(clk,reset,d[8],q[8],enable);
	flopr flop_9(clk,reset,d[7],q[7],enable);
	flopr flop_10(clk,reset,d[6],q[6],enable);
	flopr flop_11(clk,reset,d[5],q[5],enable);
	flopr flop_12(clk,reset,d[4],q[4],enable);
	flopr flop_13(clk,reset,d[3],q[3],enable);
	flopr flop_14(clk,reset,d[2],q[2],enable);
	flopr flop_15(clk,reset,d[1],q[1],enable);
	flopr flop_16(clk,reset,d[0],q[0],enable);
endmodule

module decoder_3x8(d,p);
	input [2:0] d;
	output [7:0] p;

	assign p[0] = (!d[0]) & (!d[1]) & (!d[2]);
	assign p[1] = (!d[0]) & (!d[1]) & (d[2]);
	assign p[2] = (!d[0]) & (d[1]) & (!d[2]);
	assign p[3] = (!d[0]) & (d[1]) & (d[2]);
	assign p[4] = (d[0]) & (!d[1]) & (!d[2]);
	assign p[5] = (d[0]) & (!d[1]) & (d[2]);
	assign p[6] = (d[0]) & (d[1]) & (!d[2]);
	assign p[7] = (d[0]) & (d[1]) & (d[2]);
endmodule

module regfile(clk,addr,addr_write,trregf,regwrite,reset,bus);
	input [2:0] addr,addr_write;
	input trregf,regwrite,reset,clk;
	inout [15:0] bus;
	
	wire [15:0] local_0;
	wire [15:0] local_1;
	wire [15:0] local_2;
	wire [15:0] local_3;
	wire [15:0] local_4;
	wire [15:0] local_5;
	wire [15:0] local_6;
	wire [15:0] local_7;

	wire [7:0] decoded;
	wire [7:0] decoded_2;
	wire [7:0] write_enabled;
	wire [7:0] write_enabled_2;
	always@(*)begin
	$display($time,"resistor6=%d",local_6);
	end
	decoder_3x8 decode_it(addr,decoded);
	decoder_3x8 decode_it_1(addr_write,decoded_2);

	andgate2 a0(decoded_2[0],regwrite,write_enabled_2[0]);
	andgate2 a1(decoded_2[1],regwrite,write_enabled_2[1]);
	andgate2 a2(decoded_2[2],regwrite,write_enabled_2[2]);
	andgate2 a3(decoded_2[3],regwrite,write_enabled_2[3]);
	andgate2 a4(decoded_2[4],regwrite,write_enabled_2[4]);
	andgate2 a5(decoded_2[5],regwrite,write_enabled_2[5]);
	andgate2 a6(decoded_2[6],regwrite,write_enabled_2[6]);
	andgate2 a7(decoded_2[7],regwrite,write_enabled_2[7]);

	andgate2 b0(decoded[0],trregf,write_enabled[0]);
	andgate2 b1(decoded[1],trregf,write_enabled[1]);
	andgate2 b2(decoded[2],trregf,write_enabled[2]);
	andgate2 b3(decoded[3],trregf,write_enabled[3]);
	andgate2 b4(decoded[4],trregf,write_enabled[4]);
	andgate2 b5(decoded[5],trregf,write_enabled[5]);
	andgate2 b6(decoded[6],trregf,write_enabled[6]);
	andgate2 b7(decoded[7],trregf,write_enabled[7]);

	tristate t0(local_0,write_enabled[0],bus);
	tristate t1(local_1,write_enabled[1],bus);
	tristate t2(local_2,write_enabled[2],bus);
	tristate t3(local_3,write_enabled[3],bus);
	tristate t4(local_4,write_enabled[4],bus);
	tristate t5(local_5,write_enabled[5],bus);
	tristate t6(local_6,write_enabled[6],bus);
	tristate t7(local_7,write_enabled[7],bus);

	register r0(clk,reset,bus,local_0,write_enabled_2[0]);
	register r1(clk,reset,bus,local_1,write_enabled_2[1]);
	register r2(clk,reset,bus,local_2,write_enabled_2[2]);
	register r3(clk,reset,bus,local_3,write_enabled_2[3]);
	register r4(clk,reset,bus,local_4,write_enabled_2[4]);
	register r5(clk,reset,bus,local_5,write_enabled_2[5]);
	register r6(clk,reset,bus,local_6,write_enabled_2[6]);
	register r7(clk,reset,bus,local_7,write_enabled_2[7]);
endmodule

module instruction_reg(clk,reset,irwrite,bus,opcode,mode,r1,r2,r3,statuscode,eqn);
	input irwrite,clk,reset;
	input [15:0] bus;
	output [3:0] opcode;  //15-12
	output [2:0] mode,r1,r2,r3,statuscode; //write reg r3-11-9 , mode 8-6, r2-5-3, r1 2-0 ,status code 8-6
	output eqn;  //6

	wire [15:0] local_s;

	register regf(clk,reset,bus,local_s,irwrite);
	assign opcode = local_s[15:12];
	assign mode = local_s[8:6];
	assign r1 = local_s[2:0];
	assign r2 = local_s[5:3];
	assign r3 = local_s[11:9];
	assign statuscode = local_s[8:6];
	assign eqn = local_s[6];
endmodule

module pcreg(clk,reset,pcwrite,bus,jumppcwrite,trpc);
	inout [15:0] bus;
	input clk,reset,jumppcwrite,pcwrite,trpc;

	wire [15:0] local_s;
	wire enable;
	always@(*)begin
	$display($time,"pc register=%b",local_s);
	end
	orgate2 or_1(pcwrite,jumppcwrite,enable);
	tristate t_pc(local_s,trpc,bus);
	register pc(clk,reset,bus,local_s,enable);
endmodule

module regb(clk,reset,regbwrite,bus,aluopr1);
	input clk,reset,regbwrite;
	input [15:0] bus;
	output [15:0] aluopr1;
	wire [15:0] local_s;
	register r_b(clk,reset,bus,local_s,regbwrite);
	always@(*)begin
	$display($time,"regb (First operand for alu)=%d",local_s);
	end
	assign aluopr1 = local_s;
endmodule

module aluoutpreg(clk,reset,aluoutw,aluoutin,traluout,bus,jumpsignal,d_cond);
	input clk,reset,aluoutw,traluout,jumpsignal,d_cond;
	output [15:0] bus;
	input [15:0] aluoutin;
	wire [15:0] local_s;
	wire enable,enable1;
	andgate2 and_a(jumpsignal,d_cond,enable1);
	orgate2 or_b(enable1,traluout,enable);
	register r_b(clk,reset,aluoutin,local_s,aluoutw);
	tristate t_1(local_s,enable,bus);
	always@(*)begin
	$display($time,"aluout register=%d",local_s);
	end
endmodule

module constreg2(trconst2,bus);
	input trconst2;
	output [15:0] bus;
	wire [15:0] local1;
	parameter S1=16'b10;
	assign local1=S1;
    tristate t_2(local1,trconst2,bus);
endmodule

module constreg0(trconst0,bus);
	input trconst0;
	output [15:0] bus;
	wire [15:0] local1;
	parameter S1=16'b00;
	assign local1=S1;
	tristate t_3(local1,trconst0,bus);
endmodule

module mux16x1(d,q,sl);
	input [8:0] d;
	input [3:0] sl;
	output q;
	reg q;
	always@(sl[0] or sl[1] or sl[2] or d)
		case (sl)
			4'b0000:q<=d[0];
			4'b0001:q<=d[1];
			4'b0010:q<=d[2];
			4'b0011:q<=d[3];
			4'b0100:q<=d[4];
			4'b0101:q<=d[5];
			4'b0110:q<=d[6];
			4'b0111:q<=d[7];
			4'b1000:q<=d[8];
			default: q<=0;
		endcase
endmodule

module flag_reg(clk,reset,z,c,s,v,flagw,sl,d_cond);
	input z,c,s,v,flagw,clk,reset;
	input [3:0] sl;
	output d_cond;
	parameter wone = 1'b1;
	reg [8:0] local_s; 
	wire notz,notc,nots,notv;
	assign notz = ~z;
	assign notc = ~c;
	assign nots = ~s;
	assign notv = ~v;
	always @(*) begin
	$display($time,"zero flag=%b,carry flag=%b,sign flag=%b,overflow flag=%b",z,c,s,v);
	end
	always@(posedge clk) begin
        if(reset) local_s<=9'b0;
        else if (flagw) begin
        /*local_s[0] <= wone;
        local_s[1] <= z;
        local_s[2] <= ~z;
        local_s[3] <= c;
        local_s[4] <= ~c;
        local_s[5] <= s;
        local_s[6] <= ~s;
        local_s[7] <= v;
        local_s[8] <= ~v;*/
        local_s <=  {wone,z,notz,c,notc,s,nots,v,notv};
        end
    end
	mux16x1 mux_1(
	.d(local_s),
	.q(d_cond),
	.sl(sl)
	);
endmodule

module alu(a,b,out,aluop);
	input[15:0] a;
	input[15:0] b;
	input[1:0] aluop;
	output reg[15:0] out;
	parameter S0=2'b00;
	parameter S1=2'b01;
	parameter S2=2'b10;
	parameter S3=2'b11;
	always @(a or b or aluop) begin
		if(aluop==S2) begin
			out=a+b;
		end
		else if(aluop==S1) begin
	    out=a | b;
		end
		else if(aluop==S0) begin
			out=a & b;
		end
		else if(aluop==S3) begin
			out=a-b;
		end
	end
		

endmodule
module orgate(out,a)	;
	input[15:0] a;
	output out;
	assign out=a[0] | a[1] | a[2] | a[3] | a[4] | a[5] | a[6] | a[7] | a[8] | a[9] | a[10] | a[11] | a[12] | a[13] | a[14] | a[15] ;
endmodule
module and2gate(out,a,b);
	input a,b;
	output out;
	assign out=a & b;
endmodule
module or2gate(out,a,b);
	input a,b;
	output out;
	assign out=a | b;
endmodule
module or3gate(out,a,b,c);
	input a,b,c;
	output out;
	wire g;
	or2gate o1(g,a,b);
	or2gate o2(out,g,c);
endmodule
module xor2gate(out,a,b);
	input a,b;
	output out;
	wire g1;
	and2gate a1(g1,~a,b);
	wire g2;
	and2gate a2(g2,a,~b);
	or2gate o1(out,g1,g2);
endmodule
module xor3gate(out,a,b,c);
	input a,b,c;
	output out;
	wire g;
	xor2gate x1(g,a,b);
	xor2gate x2(out,g,c);
endmodule
module carrygate(out,a,b,c);
	input a,b,c;
	output out;
	wire g1,g2,g3;
	and2gate a1(g1,a,b);
	and2gate a2(g2,c,a);
	and2gate a3(g3,c,b);
	or3gate o1(out,g1,g2,g3);
endmodule
module statusdetector(a,b,out,z,c,s,v);
	input[15:0] a,b,out;
	output z,c,s,v;
	wire g;
	orgate o1(g,out);
	assign z=~g;
	wire carry[16:0];
	carrygate c1(carry[0],a[0],b[0],1'b0);
	carrygate c2(carry[1],a[1],b[1],carry[0]);
	carrygate c3(carry[2],a[2],b[2],carry[1]);
	carrygate c4(carry[3],a[3],b[3],carry[2]);
	carrygate c5(carry[4],a[4],b[4],carry[3]);
	carrygate c6(carry[5],a[5],b[5],carry[4]);
	carrygate c7(carry[6],a[6],b[6],carry[5]);
	carrygate c8(carry[7],a[7],b[7],carry[6]);
	carrygate c9(carry[8],a[8],b[8],carry[7]);
	carrygate c10(carry[9],a[9],b[9],carry[8]);
	carrygate c11(carry[10],a[10],b[10],carry[9]);
	carrygate c12(carry[11],a[11],b[11],carry[10]);
	carrygate c13(carry[12],a[12],b[12],carry[11]);
	carrygate c14(carry[13],a[13],b[13],carry[12]);
	carrygate c15(carry[14],a[14],b[14],carry[13]);
	carrygate c16(carry[15],a[15],b[15],carry[14]);
	xor2gate xor_1(v,carry[15],carry[14]);
	assign c=carry[15];
	assign s=out[15];
endmodule

module mareg(clk,reset,bus,mabus,marwrite,trmar2mabus);
	input clk,reset,marwrite,trmar2mabus;
	output [15:0] mabus;
	input [15:0] bus;
	wire[15:0] local_s;
	always@(*)begin
	$display($time,"MAR register=%b",local_s);
	end
	register mar(clk,reset,bus,local_s,marwrite);
	tristate t_mar2mabus(local_s,trmar2mabus,mabus);
endmodule

module mdrreg(clk,reset,bus,mdbus,mdrwrite,trmdr2mdbus,trmdbus2mdr,trmdr2bus,trbus2mdr);
	input clk,reset,mdrwrite,trmdr2mdbus,trmdr2bus,trmdbus2mdr,trbus2mdr;
	inout [15:0] bus,mdbus;
	wire [15:0] local_s;
	wire [15:0] local_2;
	/*always @(*) begin
	$display($time,"trmdbus2mdr=%b,local_2=%d,local_s=%d",trmdbus2mdr,local_2,local_s);
	end*/
	tristate t_bus2mdr(bus,trbus2mdr,local_2);
	tristate t_mdbus2mdr(mdbus,trmdbus2mdr,local_2);
	register mdr(clk,reset,local_2,local_s,mdrwrite);
	tristate t_mdr2bus(local_s,trmdr2bus,bus);
	tristate t_mdr2mdbus(local_s,trmdr2mdbus,mdbus);
endmodule

module mux_r(r1,r2,r3,sr,rout);
	input [2:0] r1,r2,r3;
	input [1:0] sr;
	output [2:0] rout;
	reg [2:0] rout;
	always @(*) begin
	$display($time,"rout (address for read register given inst.) =%d",rout);
	end
	always@(sr or r1 or r2 or r3)
		case(sr)
		0:rout<=r1;
		1:rout<=r2;
		2:rout<=r3;
		default:rout<=3'b0;
		endcase
endmodule

module mainmodule(clk,reset,mabus,mdbus,opcode,mode,marwrite,trmar2mabus,mdrwrite,trmdr2mdbus,trmdr2bus,trmdbus2mdr,trbus2mdr,trconst0,trconst2,traluout,jumpsignal,regbwrite,flagw,pcwrite,jumppcwrite,trpc,irwrite,trregf,regwrite,aluop,sr,aluoutw);
	input clk,reset;
	output [15:0]mabus;
	inout [15:0] mdbus;
	wire [15:0] bus;
	wire z,c,s,v,d_cond;
	wire [15:0] aluoutin,aluopr1;
	output [3:0] opcode;
	output [2:0] mode;
	wire [2:0] r1,r2,r3,statuscode;
	wire eqn;
	wire [3:0] sl;
	wire [2:0] rout;
	input marwrite,trmar2mabus,mdrwrite,trmdr2mdbus,trmdr2bus,trmdbus2mdr,trbus2mdr,trconst0,trconst2,traluout,jumpsignal;
	input regbwrite,flagw,pcwrite,jumppcwrite,trpc,irwrite,trregf,regwrite,aluoutw;
	input [1:0] aluop,sr; //sr=readreg
	assign sl={eqn,statuscode};
	
	mareg mar_1(clk,reset,bus,mabus,marwrite,trmar2mabus);
	mdrreg mdr_1(clk,reset,bus,mdbus,mdrwrite,trmdr2mdbus,trmdbus2mdr,trmdr2bus,trbus2mdr);
	constreg0 ctr0_1(trconst0,bus);
	constreg2 ctr2_1(trconst2,bus);
	aluoutpreg aluoutp_1(clk,reset,aluoutw,aluoutin,traluout,bus,jumpsignal,d_cond);
	regb regb_1(clk,reset,regbwrite,bus,aluopr1);
	statusdetector str_1(aluopr1,bus,aluoutin,z,c,s,v);
	alu alu_1(aluopr1,bus,aluoutin,aluop);
	flag_reg fg_1(clk,reset,z,c,s,v,flagw,sl,d_cond);
	pcreg preg_1(clk,reset,pcwrite,bus,jumppcwrite,trpc);
	instruction_reg ireg_1(clk,reset,irwrite,bus,opcode,mode,r1,r2,r3,statuscode,eqn);
	mux_r m_1(r1,r2,r3,sr,rout);

	regfile rgf_1(clk,rout,r3,trregf,regwrite,reset,bus);
endmodule
