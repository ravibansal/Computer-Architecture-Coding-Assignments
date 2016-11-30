//Assignment 7
//Group 49
//Ravi Bansal 13CS30026
//Sayan Mukhopadhyay 13CS30028
`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   13:39:39 08/28/2015
// Design Name:   fulladder
// Module Name:   E:/FPGA/ass_7_Group_49/FA_testbench.v
// Project Name:  ass_7_Group_49
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: fulladder
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////
//full adder module.Input bits are a and b.Input carry is cin.Output sum bit is s,propagate is p and generate is g
module fulladder(a,b,cin,s,p,g);
input a,b,cin;
output s,p,g;
assign s = a ^ b ^cin;
assign p = a^b;
assign g = a&b;
endmodule
//testbench for full adder
module full_adder_testbench;

	// Inputs
	reg a;
	reg b;
	reg cin;

	// Outputs
	wire s;
	wire p;
	wire g;

	// Instantiate the Unit Under Test (UUT)
	fulladder uut (
		.a(a), 
		.b(b), 
		.cin(cin), 
		.s(s), 
		.p(p), 
		.g(g)
	);

	initial begin
		// Initialize Inputs
		a = 0;
		b = 0;
		cin = 0;

		// Wait 100 ns for global reset to finish
		#100;
		
		// Add stimulus here

	end
	fulladder f1(a,b,cin,s,p,g);
	always #6 a =~a;
   always #3 b =~b;
   always #12 cin = ~cin;
	always @ *
	begin
	$monitor("\ta=%b\tb=%b\tcin=%b\ts=%b\tp=%b\tg=%b",a,b,cin,s,p,g);
	end
endmodule
