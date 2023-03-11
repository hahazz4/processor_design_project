module pc_increment(input wire [31:0] PC_Data_IN, input enable, output wire [31:0] PC_Data_OUT);
    
    wire carryOut;
    wire increment = 1;
	 
	adder adderIncrement(.A(PC_Data_IN), .B(increment), .sum(PC_Data_OUT), .carryOut(carryOut));
	 
endmodule
