`timescale 1ns / 1ps


module alu_tb;

	
	reg [31:0] a;
	reg [31:0] b;
	reg [1:0] ALUControl;

	
	wire [31:0] Result;
	wire [3:0] ALUFlags;

	
	alu uut (
		.a(a), 
		.b(b), 
		.ALUControl(ALUControl), 
		.Result(Result), 
		.ALUFlags(ALUFlags)
	);
	
	logic[31:0] anticipatedResult;
	logic[3:0] anticipatedFlags;
	
	logic[101:0] testvectors[100];
	logic[31:0] x,
	pass, fail;
	reg clk;
	
	always
	begin
		clk <= 1;
		#10;
		clk <= 0;
		#10;
	end
	
	
	initial begin
		$readmemb("alu.tv", testvectors); 
		x = 0;		
		pass = 0; 
		fail = 0; 
	end

	always @(posedge clk)
	begin
		#10
		{a,b,ALUControl,anticipatedResult,anticipatedFlags} = testvectors[i];
	end
	
	always @(negedge clk)
	begin
		if(ALUFlags !== anticipatedFlags)
		begin
			fail = fail + 1;
		end
		if(Result === anticipatedResult & ALUFlags === anticipatedFlags)
		begin
			pass = pass + 1;
		end
		
		x = x + 1;
	end
      
endmodule

