//Assignment 7
//Group 49
//Ravi Bansal 13CS30026
//Sayan Mukhopadhyay 13CS30028
`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   13:40:24 08/28/2015
// Design Name:   fourbitCLA
// Module Name:   E:/FPGA/ass_7_Group_49/fourbitCLA.v
// Project Name:  ass_7_Group_49
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: fourbitCLA
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////
//four bit CLA module taking a 4 bit binary string a and b as input and calculating sum bit and carryout bit
module fourbitCLA(a,b,cin,cout,PG,GG,sum);
input [3:0] a,b;
input cin;
output cout,PG,GG;
output [3:0] sum;
wire [3:0] p,g,c;
fulladder f1(a[0],b[0],cin,sum[0],p[0],g[0]);
fulladder f2 (a[1],b[1],c[0],sum[1],p[1],g[1]);
fulladder f3 (a[2],b[2],c[1],sum[2],p[2],g[2]);
fulladder f4 (a[3],b[3],c[2],sum[3],p[3],g[3]);    //calcualting sum bits by full adder implementation
assign PG = (p[0]&p[1]&p[2]&p[3]);
assign GG = (g[3]|(p[3]&g[2])|(p[3]&p[2]&g[1])|(p[3]&p[2]&p[1]&g[0])); //calculating PG and GG
CLUunit c1(p,g,cin,c);
assign cout = c[3];
endmodule
//test bench for 4 bit cla
module test_bench_4cla;

	// Inputs
	reg [3:0] a;
	reg [3:0] b;
	reg cin;

	// Outputs
	wire cout;
	wire PG;
	wire GG;
	wire [3:0] sum;

	// Instantiate the Unit Under Test (UUT)
	fourbitCLA uut (
		.a(a), 
		.b(b), 
		.cin(cin), 
		.cout(cout), 
		.PG(PG), 
		.GG(GG), 
		.sum(sum)
	);

	initial begin
		// Initialize Inputs
		a = 4'b0101;
		b = 4'b1010;
		cin = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
   fourbitCLA f1(a,b,cin,cout,PG,GG,sum);
	always @ *
	begin
	$monitor("\ta=%b\tb=%b\tcin=%b\tsum=%b\tPG=%b\tGG=%b",a,b,cin,sum,PG,GG);
	#20
	begin
		a=4'b1000;
		b=4'b0100;
		cin=0;
	end
	#20
	begin
		a=4'b1000;
		b=4'b0100;
		cin=1;
	end
	#20
	begin
		a=4'b1000;
		b=4'b0101;
		cin=0;
	end
	#20
	begin
		a=4'b1111;
		b=4'b0100;
		cin=1;
	end
	end
endmodule
