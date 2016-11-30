//Assignment 7
//Group 49
//Ravi Bansal 13CS30026
//Sayan Mukhopadhyay 13CS30028
`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   13:40:56 08/28/2015
// Design Name:   CLUunit
// Module Name:   E:/FPGA/ass_7_Group_49/CLUnit_testbench.v
// Project Name:  ass_7_Group_49
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: CLUunit
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////
//Carry look ahead unit taking p,g and cin as input and calculating the four carry outputs
module CLUunit(p,g,cin,c);
input [3:0] p,g;
input cin;
output [3:0] c;
//assign the 4 carries to c0,c1,c2,c3
assign c[0]=(g[0]|(p[0]&cin));
assign c[1]=(g[1]|(p[1]&g[0])|(p[1]&p[0]&cin));
assign c[2]=(g[2]|(p[2]&g[1])|(p[2]&p[1]&g[0])|(p[2]&p[1]&p[0]&cin));
assign c[3] = (g[3]|(p[3]&g[2])|(p[3]&p[2]&g[1])|(p[3]&p[2]&p[1]&p[0]&cin));
endmodule
//testbench forCLU
module CLUunit_testbench;

	// Inputs
	reg [3:0] p;
	reg [3:0] g;
	reg cin;

	// Outputs
	wire [3:0] c;

	// Instantiate the Unit Under Test (UUT)
	CLUunit uut (
		.p(p), 
		.g(g), 
		.cin(cin), 
		.c(c)
	);

	initial begin
		// Initialize Inputs
		p = 4'b1001;
		g = 4'b0101;
		cin = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
	CLUunit c1(p,g,cin,c);
	always @ *
	begin
	$monitor("\tp=%b\tg=%b\tcin=%b\tc=%b\t",p,g,cin,c);
	#20
	begin
		p=4'b1000;
		g=4'b0100;
		cin=0;
	end
	#20
	begin
		p=4'b1000;
		g=4'b0100;
		cin=1;
	end
	#20
	begin
		p=4'b1000;
		g=4'b0101;
		cin=0;
	end
	#20
	begin
		p=4'b1111;
		g=4'b0100;
		cin=1;
	end
	end
endmodule
