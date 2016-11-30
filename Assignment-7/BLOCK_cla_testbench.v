//Assignment 7
//Group 49
//Ravi Bansal 13CS30026
//Sayan Mukhopadhyay 13CS30028
`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   13:41:27 08/28/2015
// Design Name:   blockCLA
// Module Name:   E:/FPGA/ass_7_Group_49/BlockCLA_testbech.v
// Project Name:  ass_7_Group_49
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: blockCLA
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////
//16bit cla adder by using 4 4bit cla
module blockCLA(a,b,cout,cin,PG,GG,sum);
input [15:0] a,b;
input cin;
output cout,PG,GG;
output [15:0] sum;
wire [3:0] p,g,c;
wire c1,c2,c3,c4;
fourbitCLA f1(a[3:0],b[3:0],1'b0,c1,p[0],g[0],sum[3:0]);
fourbitCLA f2(a[7:4],b[7:4],c[0],c2,p[1],g[1],sum[7:4]);
fourbitCLA f3(a[11:8],b[11:8],c[1],c3,p[2],g[2],sum[11:8]);
fourbitCLA f4(a[15:12],b[15:12],c[2],c4,p[3],g[3],sum[15:12]);  //calculating sum bitss 4 bit at a time
assign PG = (p[0]&p[1]&p[2]&p[3]);
assign GG = (g[3]|(p[3]&g[2])|(p[3]&p[2]&g[1])|(p[3]&p[2]&p[1]&g[0])|(p[3]&p[2]&p[1]&p[0]&cin)); //caluclating PG and GG of the final block
assign cout = c[3];
CLUunit cp(p,g,cin,c); //calculating carry
endmodule
//testbench for 16bit cla
module blockCLA_test_bench;

	// Inputs
	reg [15:0] a;
	reg [15:0] b;
	reg cin;

	// Outputs
	wire cout;
	wire PG;
	wire GG;
	wire [15:0] sum;

	// Instantiate the Unit Under Test (UUT)
	blockCLA uut (
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
		a=16'b0111010111001000;
		b=16'b0001001111110011;
		cin = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
   blockCLA f1(a,b,cin,cout,PG,GG,sum);
	initial begin
	$monitor("\ta=%d\tb=%d\tcin=%b\tsum=%d\tPG=%b\tGG=%b\tcout=%b",a,b,cin,sum,PG,GG,cout);
		#20 a=16'b0001000100010001;b=16'b1111000011111111;
		#20 a=16'b1111111111111111;b=16'b0000000000000001;
		#20 a=16'b1010101001010101;b=16'b1100101010111101;
		#20 a=16'b0000000000011111;b=16'b0000000000100010;
		#20 a=16'b0000000001000011;b=16'b0000000000000111;
	end
endmodule
