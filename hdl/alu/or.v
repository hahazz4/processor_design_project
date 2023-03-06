/* Representation of a 32-bit OR operation in Verilog HDL. */
module or (input wire [31:0] A, B, output wire [31:0] result);
	
	assign result = A | B;

endmodule // or end.