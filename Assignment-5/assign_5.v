`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    02:35:15 08/13/2015 
// Design Name: 
// Module Name:    modules 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
//Group-49.Machine-56
//Name-Sayan Mukhopadhyay(13CS30028)
//Name-Ravi Bansal(13CS30026)
//1 input not gate.
module notgate(out,a);
    output out;
    input a;
    assign out=~a;//complimenting a to input
endmodule
//2 input and gate.inputs are a and b
module and2gate(out,a,b);
    output out;
    input a;
    input b;
    assign out=a & b; //asiginign  out as a and b
endmodule
//2 input or gate.inputs are and b
module or2gate(out,a,b);
	output out;
	input a;
	input b;
	assign out=a | b; //assigning out as a or b
endmodule
// 3 input and gate.inputs are a,b and c
module and3gate(out,a,b,c);
	output out;
	input a;
	input b;
	input c;
	wire a1,a2;
	and2gate and1(a1,a,b);
	and2gate and2(a2,a1,c);
	assign out=a2;    
endmodule
//3input or gate.inputs are a,b and c
module or3gate(out,a,b,c);
	output out;
	input a;
	input b;
	input c;
	wire a1,a2;
 	or2gate or1(a1,a,b);
	or2gate or2(a2,a1,c);
	assign out=a2;
endmodule
//module to display segment 'a'
//out=abc+a'b'd'
module displaya(out,a,b,c,d);
	output out;
	input a;
	input b;
	input c;
	input d;
	wire a1,a2,a3,a4,a5,a6;
	notgate n1(a1,a);
	notgate n2(a2,b);
	notgate n3(a3,d);
	and3gate and1(a4,a1,a2,a3);
	and3gate and2(a5,a,b,c);
	or2gate  or1(out,a4,a5);
	
endmodule
//module to display segment 'b'
//out=b'c'
module displayb(out,b,c);
	output out;input b;input c;
	wire a1,a2;
	notgate not1(a1,b);
	notgate not2(a2,c);
	and2gate and1(out,a1,a2);
	
endmodule
//module to display segment 'c'
//out=ab'c
module displayc(out,a,b,c);
	output out;input a;input b;input c;
	wire a1;
	notgate n1(a1,b);
	and3gate and1(out,a,a1,c);
	
endmodule
//module to display segment 'd'
//out=a'b'd'+abc+a'bd
module displayd(out,a,b,c,d);
	output out;input a;input b;input c;input d;
	wire a1,a2,a3,a4,a5,a6,a7;
	notgate n1(a1,a);
	notgate n2(a2,b);
	notgate n3(a3,d);
	and3gate and1(a4,a1,a2,a3);
	and3gate and2(a5,d,b,a1);
	and3gate and3(a6,a,c,b);
	or3gate o1(out,a4,a5,a6);
	
endmodule
//module to display segment 'e'
//out=a'+bc
module displaye(out,a,b,c);
	output out;input a;input b;input c;
	wire a1,a2;
	notgate n1(a1,a);
	and2gate and1(a2,b,c);
	or2gate o1(out,a1,a2);
	
endmodule
//module to display segment 'f'
//out=a'b +d'b'
module displayf(out,a,b,d);
	output out;input a;input b;input d;
	wire ar1,a2,a3,a4,a5;
	notgate n1(a1,a);
	notgate n2(a2,b);
	notgate n3(a3,d);
	and2gate and1(a4,a2,a3);
	and2gate and2(a5,b,a1);
	or2gate o1(out,a4,a5);
	
endmodule
//module to display segment 'g'
//out=c'd' + d'b'a' + dba'
module displayg(out,a,b,c,d);
	output out;input a;input b;input c;input d;
	wire a1,a2,a3,a4,a5,a6,a7;
	notgate n1(a1,a);
	notgate n2(a2,b);
	notgate n3(a3,c);
	notgate n4(a4,d);
	and2gate and1(a5,a3,a4);
	and3gate and2(a6,a2,a4,a1);
	and3gate and3(a7,d,b,a1);
	or3gate o1(out,a5,a6,a7);
	
endmodule
//wrapper module
//accepets a 4bit input in a,b,c,d and ouputs the value for 7 segments in outa ....... outd
//accepts e as input for enable.
module displayall(enable,outa,outb,outc,outd,oute,outf,outg,a,b,c,d,e);
	input a;
	input b;
	input c;
	input d;
	input e;
	output outa;
	output outb;
	output outc;
	output outd;
	output oute;
	output outf;
	output outg;
	output enable;
	assign enable=e;
	wire a1,a2,a3,a4,a5,a6,a7;
	displaya d1(a1,a,b,c,d);
	displayb d2(a2,b,c);
	displayc d3(a3,a,b,c);
	displayd d4(a4,a,b,c,d);
	displaye d5(a5,a,b,c);
	displayf d6(a6,a,b,d);
	displayg d7(a7,a,b,c,d);
	//compilemting the output because of common cathode
	notgate n1(outa,a1);
	notgate n2(outb,a2);
	notgate n3(outc,a3);
	notgate n4(outd,a4);
	notgate n5(oute,a5);
	notgate n6(outf,a6);
	notgate n7(outg,a7);
endmodule
`timescale 1ns / 1ps



//TESTBENCH
////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   02:04:26 08/14/2015
// Design Name:   displayall
// Module Name:   E:/FPGA/ass5_group49/testbench.v
// Project Name:  ass5_group49
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: displayall
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module testbench;

	// Inputs
	reg a;
	reg b;
	reg c;
	reg d;
	reg e;

	// Outputs
	wire enable;
	wire outa;
	wire outb;
	wire outc;
	wire outd;
	wire oute;
	wire outf;
	wire outg;

	// Instantiate the Unit Under Test (UUT)
	displayall uut (
		.enable(enable), 
		.outa(outa), 
		.outb(outb), 
		.outc(outc), 
		.outd(outd), 
		.oute(oute), 
		.outf(outf), 
		.outg(outg), 
		.a(a), 
		.b(b), 
		.c(c), 
		.d(d), 
		.e(e)
	);

	initial begin
		// Initialize Inputs
		d=0;c=0;b=1;a=1;e=1;
           	#100 d=0;c=1;b=0;a=0;
           	#100 d=0;c=1;b=0;a=1;
           	#100 d=0;c=1;b=1;a=0;
           	#100 d=0;c=1;b=1;a=1;
           	#100 d=1;c=0;b=0;a=0;
           	#100 d=1;c=0;b=0;a=1;
           	#100 d=1;c=0;b=1;a=0;
           	#100 d=1;c=0;b=1;a=1;
           	#100 d=1;c=1;b=0;a=0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
      
endmodule
