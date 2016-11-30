/Group No-49
//Sayan Mukhopadhyay(13CS30028)
//Ravi Bansal(13CS30026)

//Behavorial design of detector fsm
//////////////////////////////////////////////
module fsm_module(clk,reset,a,y,x);
	input clk;
	input reset;
	input a;
	output reg y;
	output reg [2:0] x;
	reg [2:0] state;
	
	reg [2:0] nextstate;
	
	parameter S0 = 3'b000;
	parameter S1 = 3'b001;
	parameter S2 = 3'b010;
	parameter S3 = 3'b011;
	parameter S4 = 3'b100;
	parameter S5 = 3'b101;
	
	//State Register
	
	always @ (posedge clk or posedge reset)
		if(reset) state <= S0;
		else		 state <= nextstate;
		
	// Next State Logic
	
	always @ (state or a) begin
		x=state;
		case(state)
			S0: if(a) nextstate <= S1;
				else	 nextstate <= S3;
			S1: if(a) nextstate <= S2;
				else nextstate <= S4;
			S2: if(a) nextstate <= S0;
				else	 nextstate <= S5;
          S3: if(a) nextstate <= S4;
				else	 nextstate <= S0;
			S4: if(a) nextstate <= S5;
				else	 nextstate <= S1;
			S5: if(a) nextstate <= S3;
				else	 nextstate <= S2;
			default: nextstate <= S0;
		endcase
		end
  always @(state or a)
        case (state)
        	S0: begin
        			y <= 0;
        		end
          S1: if (a) begin
        			y <= 0;
        		end else begin
        			y <= 1;
        		end
          S2: if (a) begin
        			y <= 0;
        		end else begin
        			y <= 0;
        		end
          S3: if (a) begin
        			y <= 1;
        		end else begin
        			y <= 0;
        		end
          S4: if (a) begin
        			y <= 0;
		        end else begin
        			y <= 0;
        		end
          S5: if(a) begin
            		y <= 0;
          end else begin
            		y <= 0;
          end
        endcase
endmodule

//Testbench of behavorial verilog of detector
//////////////////////////////////////////////
module testbench;

	// Inputs
	reg clk;
	reg reset;
	reg a;

	// Outputs
	wire y;
	wire [2:0] x;
	initial begin
			reset=1;
			a=0;
			clk=0;
		end
	// Instantiate the Unit Under Test (UUT)
	fsm_module uut (
		.clk(clk), 
		.reset(reset), 
		.a(a), 
		.y(y),
		.x(x)
	);
	initial begin
		#50	            
		reset=0;
		$monitor($time,"\tin=%b\tout=%b\treset=%b\tstate=%b",a,y,reset,x);
		repeat (50) begin
		$monitor($time,"\tin=%b\tout=%b\treset=%b\tstate=%b",a,y,reset,x);
		@(posedge clk);
		@(posedge clk);
		a <=1'b1;
		@(posedge clk);
		a <=1'b0;
		@(posedge clk);
		a <=1'b0;
		@(posedge clk);
		a <=1'b1;
		@(posedge clk);
		a <=1'b0;
		@(posedge clk);
		a <=1'b1;
		@(posedge clk);
		a <=1'b1;
		end
	end
      always #50 clk=~clk;
      
endmodule


//Structural design of detector
//////////////////////////////////////////////
module detector_structural(clk,in,z);
	input in,clk;
	output z;
	reg j1,k1,o1,j2,k2,o2,j3,k3,o3;
	initial begin
		j1=0;
		k1=0;
		j2=0;
		k2=0;
		j3=0;
		k3=0;
		o1=0;
		o2=0;
		o3=0;
	end
	always @(posedge clk)
	begin
		assign z=((~o3 & ~o2 & o1 & ~in) | (~o3 & o2 & o1 & in));
		assign j1=~o2 | ~in;
		assign k1=~in | ~o3;
		assign j2=((~o3 & ~o1 & ~in) | (o1 & in & ~o3));
		assign k2=1;
		assign j3=((o2 & ~o1 & ~in) | (o2 & o1 & in) | (~o2 & o1 & ~in));
		assign k3=(o1 | ~in);
		assign o1=((j1 & (~o1)) | (~k1 & o1));
		assign o2=((j2 & (~o2)) | (~k2 & o2));
		assign o3=((j3 & (~o3)) | (~k3 & o3));
	end
endmodule

//Test bench for structural form of detector
//////////////////////////////////////////////
module testbench_first();

	// Inputs
	reg clk;
	reg x;

	// Outputs
	wire z;
	initial begin
		// Initialize Inputs
		clk = 0;
		x = 0;
	end

	detector_structural(clk,x,z);
	initial
	begin
		@(posedge clk);
		@(posedge clk);     
		x <= 1 ; 
		@(posedge clk);     
		x <= 0 ; 
		@(posedge clk);     
		x <= 0 ; 
		@(posedge clk);     
		x <= 1 ; 
		@(posedge clk);     
		x <= 1 ;
		@(posedge clk);     
		x <= 1 ; 		
		@(posedge clk);     
		x <= 0 ; 	
		@(posedge clk);    
		x <= 0 ;
		@(posedge clk);     
		x <= 0 ;
		@(posedge clk);     
		x <= 1 ;
		@(posedge clk);     
		x <= 1 ; 
		@(posedge clk);     
		x <= 0 ;
		@(posedge clk);     
		x <= 1 ; 
		@(posedge clk);    
		x <= 0 ;

	$finish;

	end
	
	always #100 clk = ~clk;
      
endmodule

//Shift register module
//////////////////////////////
module shiftRegister_module(x,out,load,clock
    );
	 input [4:0]x;
	 input load,clock;
	 output out;

	 reg out;
	 
	 reg [4:0] state;
	 
	 always@(posedge clock) begin
	     if(load) state <= x;
		  else state <= {state[3:0],state[4]};
		  out = state[0];
	end
endmodule
//wrapper module for shift register
//////////////////////////////////////////////
module wrapper_module(x, clock, load, reset, out, state);
	 
	 input [4:0] x;
	 input clock;
	 input load;
	 input reset;
	 output out;
	 output [2:0] state;
	 //reg out;
	 //reg [2:0] state;
	 wire t0;
	 
	 shiftRegister_module srm(
		.x(x),
		.out(t0),
		.load(load),
		.clock(clock)
		);
	 
	 detector_module dm(
	 .z(out),
	 .clock(clock),
	 .x(t0),
	 .reset(reset),
	 .state(state)
	 );
	 
endmodule


